(() => {
  const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)");
  const ink = "#a51c30";
  const paper = "#f5f5f0";

  const menuButton = document.querySelector(".menu-button");
  const mobileOutline = document.querySelector(".mobile-outline");
  const closeMenuButton = document.querySelector("[data-close-menu]");

  const setMenu = (open) => {
    if (!menuButton || !mobileOutline) return;
    mobileOutline.classList.toggle("is-open", open);
    menuButton.setAttribute("aria-expanded", String(open));
    document.body.classList.toggle("menu-open", open);
  };

  menuButton?.addEventListener("click", () => {
    setMenu(menuButton.getAttribute("aria-expanded") !== "true");
  });

  closeMenuButton?.addEventListener("click", () => setMenu(false));
  mobileOutline?.querySelectorAll("a").forEach((link) => {
    link.addEventListener("click", () => setMenu(false));
  });

  const revealItems = [...document.querySelectorAll(".reveal")];
  const hashTarget = window.location.hash ? document.querySelector(window.location.hash) : null;

  if (hashTarget?.classList.contains("reveal")) {
    hashTarget.classList.add("is-visible");
  }

  if (hashTarget) {
    const fontsReady = document.fonts?.ready ?? Promise.resolve();
    fontsReady.then(() => {
      window.requestAnimationFrame(() => {
        hashTarget.scrollIntoView({ block: "start" });
      });
    });
  }

  if (reduceMotion.matches || !("IntersectionObserver" in window)) {
    revealItems.forEach((item) => item.classList.add("is-visible"));
  } else {
    const revealObserver = new IntersectionObserver(
      (entries, observer) => {
        entries.forEach((entry) => {
          if (!entry.isIntersecting) return;
          entry.target.classList.add("is-visible");
          observer.unobserve(entry.target);
        });
      },
      { threshold: 0.1 }
    );

    revealItems.forEach((item) => revealObserver.observe(item));
  }

  const sections = [...document.querySelectorAll(".chapter-section[id], .article-section[id]")];
  const outlineLinks = [...document.querySelectorAll(".chapter-outline a, .article-nav a")];
  const outlineMeter = document.querySelector(".outline-meter span");

  if ("IntersectionObserver" in window && sections.length) {
    const sectionObserver = new IntersectionObserver(
      (entries) => {
        const visible = entries
          .filter((entry) => entry.isIntersecting)
          .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];

        if (!visible) return;
        const activeIndex = sections.indexOf(visible.target);

        outlineLinks.forEach((link) => {
          link.classList.toggle(
            "is-active",
            link.getAttribute("href") === `#${visible.target.id}`
          );
        });

        if (outlineMeter && activeIndex >= 0) {
          outlineMeter.style.transform = `scaleY(${activeIndex + 1})`;
        }
      },
      {
        rootMargin: "-18% 0px -62% 0px",
        threshold: [0.1, 0.35, 0.7]
      }
    );

    sections.forEach((section) => sectionObserver.observe(section));
  }

  const progress = document.querySelector(".page-progress span");
  if (progress && "ScrollTimeline" in window && !reduceMotion.matches) {
    progress.animate(
      { transform: ["scaleX(0)", "scaleX(1)"] },
      {
        timeline: new ScrollTimeline({
          source: document.documentElement,
          axis: "block"
        })
      }
    );
  } else if (progress) {
    const progressObserver = new IntersectionObserver(
      (entries) => {
        const lastVisible = entries.filter((entry) => entry.isIntersecting).at(-1);
        if (!lastVisible) return;
        const index = sections.indexOf(lastVisible.target);
        const amount = sections.length ? (index + 1) / sections.length : 0;
        progress.style.transform = `scaleX(${amount})`;
      },
      { rootMargin: "-10% 0px -70% 0px", threshold: 0 }
    );

    sections.forEach((section) => progressObserver.observe(section));
  }

  const animatedGrid = document.querySelector("[data-animate-grid]");
  if (animatedGrid && "IntersectionObserver" in window && !reduceMotion.matches) {
    const gridObserver = new IntersectionObserver(
      (entries, observer) => {
        if (!entries[0]?.isIntersecting) return;
        animatedGrid.classList.add("is-animated");
        observer.disconnect();
      },
      { threshold: 0.35 }
    );
    gridObserver.observe(animatedGrid);
  }

  const makeCanvas = (canvas, drawer) => {
    if (!canvas) return null;
    const context = canvas.getContext("2d");
    const parent = canvas.parentElement;
    let width = 0;
    let height = 0;

    const resize = () => {
      const rect = parent.getBoundingClientRect();
      const ratio = Math.min(window.devicePixelRatio || 1, 2);
      width = Math.max(1, rect.width);
      height = Math.max(1, rect.height);
      canvas.width = Math.round(width * ratio);
      canvas.height = Math.round(height * ratio);
      canvas.style.width = `${width}px`;
      canvas.style.height = `${height}px`;
      context.setTransform(ratio, 0, 0, ratio, 0, 0);
      drawer(context, width, height, performance.now());
    };

    const observer = new ResizeObserver(resize);
    observer.observe(parent);

    return {
      draw: (time) => drawer(context, width, height, time),
      destroy: () => observer.disconnect()
    };
  };

  const heroCanvas = document.getElementById("hero-plot");
  const heroClock = document.getElementById("figure-clock");
  const heroControl = document.getElementById("plot-control");
  let heroPaused = reduceMotion.matches;
  let heroVisible = true;
  let heroFrame = 0;
  let heroStart = performance.now();

  const heroPoints = Array.from({ length: 62 }, (_, index) => {
    const x = (index + 1) / 63;
    const seeded = Math.sin((index + 7) * 91.733) * 19471.318;
    const noise = (seeded - Math.floor(seeded) - 0.5) * 0.39;
    return { x, noise };
  });

  const drawHero = (context, width, height, time) => {
    if (!width || !height) return;
    const phase = reduceMotion.matches ? 0 : (time - heroStart) / 1400;
    const padX = Math.max(48, width * 0.075);
    const padY = Math.max(48, height * 0.11);
    const plotWidth = width - padX * 2;
    const plotHeight = height - padY * 2;

    context.clearRect(0, 0, width, height);
    context.strokeStyle = ink;
    context.fillStyle = ink;
    context.lineWidth = 1;

    context.beginPath();
    context.moveTo(padX, padY);
    context.lineTo(padX, height - padY);
    context.lineTo(width - padX, height - padY);
    context.stroke();

    heroPoints.forEach((point, index) => {
      const drift = Math.sin(phase + index * 0.77) * 0.013;
      const y = Math.min(0.94, Math.max(0.06, 0.17 + 0.66 * point.x + point.noise + drift));
      const px = padX + point.x * plotWidth;
      const py = height - padY - y * plotHeight;
      const major = index % 13 === 0;

      context.beginPath();
      context.rect(px - (major ? 4 : 3), py - (major ? 4 : 3), major ? 8 : 6, major ? 8 : 6);
      context.fillStyle = major ? ink : paper;
      context.strokeStyle = ink;
      context.fill();
      context.stroke();
    });

    context.strokeStyle = ink;
    context.lineWidth = 2;
    context.beginPath();
    context.moveTo(padX, height - padY - 0.17 * plotHeight);
    context.lineTo(width - padX, height - padY - 0.83 * plotHeight);
    context.stroke();

    context.lineWidth = 1;
    context.setLineDash([5, 7]);
    const markerX = padX + ((phase * 0.08) % 1) * plotWidth;
    context.beginPath();
    context.moveTo(markerX, padY);
    context.lineTo(markerX, height - padY);
    context.stroke();
    context.setLineDash([]);

    context.font = '11px "Departure Mono", monospace';
    context.fillStyle = ink;
    context.fillText("0", padX - 4, height - padY + 20);
    context.fillText("1", width - padX - 5, height - padY + 20);

    if (heroClock) {
      heroClock.textContent = `t = ${phase.toFixed(2)}`;
    }
  };

  const heroPlot = makeCanvas(heroCanvas, drawHero);

  const animateHero = (time) => {
    if (!heroPaused && heroVisible) {
      heroPlot?.draw(time);
    }
    heroFrame = requestAnimationFrame(animateHero);
  };

  if (!reduceMotion.matches) {
    heroFrame = requestAnimationFrame(animateHero);
  } else {
    heroPlot?.draw(performance.now());
  }

  heroControl?.addEventListener("click", () => {
    heroPaused = !heroPaused;
    heroControl.setAttribute("aria-pressed", String(heroPaused));
    heroControl.textContent = heroPaused ? "PLAY_ANIMATION" : "PAUSE_ANIMATION";
    if (!heroPaused) heroStart = performance.now();
  });

  if (heroCanvas && "IntersectionObserver" in window) {
    const visibilityObserver = new IntersectionObserver(
      (entries) => {
        const nextVisible = entries[0]?.isIntersecting ?? true;
        if (nextVisible === heroVisible) return;
        heroVisible = nextVisible;

        if (heroVisible && !heroPaused) {
          cancelAnimationFrame(heroFrame);
          heroFrame = requestAnimationFrame(animateHero);
        } else if (!heroVisible) {
          cancelAnimationFrame(heroFrame);
        }
      },
      { threshold: 0.01 }
    );
    visibilityObserver.observe(heroCanvas);
  }

  const residualCanvas = document.getElementById("residual-plot");
  const residualPoints = [
    [0.08, 0.21],
    [0.16, 0.34],
    [0.24, 0.26],
    [0.32, 0.46],
    [0.41, 0.39],
    [0.49, 0.59],
    [0.58, 0.51],
    [0.66, 0.72],
    [0.74, 0.63],
    [0.83, 0.81],
    [0.91, 0.74]
  ];

  const drawResidual = (context, width, height) => {
    if (!width || !height) return;
    const padX = Math.max(42, width * 0.075);
    const padY = Math.max(42, height * 0.1);
    const plotWidth = width - padX * 2;
    const plotHeight = height - padY * 2;
    const lineValue = (x) => 0.16 + 0.68 * x;

    context.clearRect(0, 0, width, height);
    context.strokeStyle = ink;
    context.fillStyle = ink;
    context.lineWidth = 1;

    context.beginPath();
    context.moveTo(padX, height - padY - lineValue(0) * plotHeight);
    context.lineTo(width - padX, height - padY - lineValue(1) * plotHeight);
    context.stroke();

    residualPoints.forEach(([x, y], index) => {
      const px = padX + x * plotWidth;
      const py = height - padY - y * plotHeight;
      const fittedY = height - padY - lineValue(x) * plotHeight;

      context.save();
      context.setLineDash([4, 5]);
      context.beginPath();
      context.moveTo(px, py);
      context.lineTo(px, fittedY);
      context.stroke();
      context.restore();

      context.beginPath();
      context.rect(px - 4, py - 4, 8, 8);
      context.fillStyle = index % 4 === 0 ? ink : paper;
      context.fill();
      context.stroke();
    });
  };

  const residualPlot = makeCanvas(residualCanvas, drawResidual);
  residualPlot?.draw(performance.now());

  reduceMotion.addEventListener("change", () => {
    heroPaused = reduceMotion.matches;
    heroControl?.setAttribute("aria-pressed", String(heroPaused));
    if (heroControl) {
      heroControl.textContent = heroPaused ? "PLAY_ANIMATION" : "PAUSE_ANIMATION";
    }

    cancelAnimationFrame(heroFrame);
    if (!reduceMotion.matches) {
      heroStart = performance.now();
      heroFrame = requestAnimationFrame(animateHero);
    } else {
      heroPlot?.draw(performance.now());
    }
  });
})();
