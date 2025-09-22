Return-Path: <linux-wireless+bounces-27580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3065B8FFC3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 12:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F71895E06
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B302874F6;
	Mon, 22 Sep 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uf7ofyBF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AED54758
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536660; cv=none; b=rwk1jhVnTHqsARcA+fMR2IWXpmqkHiC6vwSjVtPZtnfUYCOzNaTGmpSEAXKOr9b5LM5aDllAIvuenW8CuWXJAXM+3RI3d/6tlbcvWHaNlEqa5p3sdAC43joBhvElqNGICWjS9YDcqQTfQFPFbeXg6tzdQAqGLLzhasRAPfdRDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536660; c=relaxed/simple;
	bh=WeCgHLtnSgNpZ7gn36nF7rz1YE2rl4o0+q2+1VO9gL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KtFABQ2SaUJPTA/hW9szZdZbVk6IsX00fz0pp1wEwxxZqQlf8yVE5e4QgtcLS8wTpZ1e1gxFdxtneL9ixxP+YxbHn6L5S9Dy/1GPjYDtkzDN86JPg4MGt87XeuucIWUO8A4utlD9pWGZjnU19PDWMMGh5GiC5qv0ZDMdcPPRWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uf7ofyBF; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so40614985e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758536657; x=1759141457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLMVfYX+Ed+WkB440q1jx27jrFMxDy/tvf6qzWMnybQ=;
        b=Uf7ofyBF0Bzt4XZLo786kh749jHm0tjXuIgQd3AFImuNRHWH+LWX+RSiyM/BhhGChx
         27sM+I2NKAoCfQZhGC23HXIdt8p32tnhspMD71eQcpepjeBq/66THVsOSE8VF9U/bBIr
         jPes1IXA4win1e8/LhUlTRoNP/0oyQI6/MxFIoMXIHAsQ/v7wLeclgWmebRQYtkfwyA1
         N2tX33ennHQTnThz+W4WQ5VsraNnGnqoN+PoyGZ1KHpxEDkS3QkRYDgHxhEalSLGqoPa
         hDuZv+IreoOpM6LhVIdzKy0ztqOlulxfzjyHiCwWihzXdxM5C0oxmNIZBdcY96TkOHg0
         3Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758536657; x=1759141457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLMVfYX+Ed+WkB440q1jx27jrFMxDy/tvf6qzWMnybQ=;
        b=UN1wmoGsIjfcEc42GTZDWvmyB/ufpLpKAmCGH/BoJKwcOIbEqLms8H6Hce7YqEnQYz
         XgXNl+u5lgr/HH2TkZjnfaFSwzlYrZvf6nNJvodt2wQlLCIRzhUYkUn6aKyRgPDN5rfc
         coeDr5sY1TzFrMkeVelJ0afZktyyb9g41IcNVP/WanT7U8CfnvM3gMir8hjeCaw1iKAu
         htvoXDctUiuFJafvKWfcoPVDBMVv9YGYGclJWjKbSffQmRbpAfU7+IKVa15QUlZZbK2h
         E7LOlRa/ZaYD3MrTCb3wDMaflvvppr0HAbcU2xYPBdJl/5134xeTUxEfaK9HFnV1MXF2
         Eatw==
X-Forwarded-Encrypted: i=1; AJvYcCX83yI4bfKsVMV0rKqQj69MRIFllGVwgycsFHmODzSDbw7AMa+o64Wx6eBMpBUaZWCKccqZN9e5VGfm/uiZ7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6wmchgLHLqjHxWJZ7INcbkIxqFsUEyk4BLq273p5LR30Dsy4
	Yjkq+6CMAU3tn4z9QGQbur/zzZADv2b1050jJ6jQtk05h1GiA/6WPOxXzt5ZG3oYvP8=
X-Gm-Gg: ASbGncuFoanYwugUBgghQM8y1Mpo43CirvNlnTEnwASheTfU8VqWOvmDNtFya+utO4M
	M3HcNydNf/1KHOQA//U96gdIKWpEweOv0cRArXUXu8Gp3s/nQ+gJPSFE9VtYToySNnTJSQrSpYK
	3dXS1+Vs4uhMJdX2LoqcEHnGu4B/0AZcovk2YC0JlpTz0OZMfbgAykfOfRk82WYPSM28KIDHIf/
	Jzp26q9NBEczNaI4JIDG5PIGJUz+O+yDwopu/sdHOx1mVg0pzraP6nZeMgiXYOislxndZjkJBr1
	V6dv4rDp9oMk1xjebBFm4w0oeGDHeWfiJanOt7VhWwmftPNoNZy4+9xbwl4CM1QcwphxcAt8l+X
	Qzni/ACWzyGEwf9JtI0+aWj+t7c7SjR+qpEWwh+UGm1hDxGw=
X-Google-Smtp-Source: AGHT+IGv7BD/KGw2dPm5H7KTTZtP4TTXvAHrXkuN0W6sv8PTNay36d6Kg+AK+ZE5blJMp+jSnKWPJQ==
X-Received: by 2002:a05:600c:1f90:b0:46b:9ab2:38d5 with SMTP id 5b1f17b1804b1-46b9ab23ac7mr54954705e9.31.1758536656657;
        Mon, 22 Sep 2025 03:24:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f41csm218613625e9.15.2025.09.22.03.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:24:16 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Brian Norris <briannorris@chromium.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	"Dr . David Alan Gilbert" <linux@treblig.org>,
	Jeff Chen <jeff.chen_1@nxp.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Subject: [PATCH 0/1] wifi: libertas: add WQ_PERCPU to alloc_workqueue users
Date: Mon, 22 Sep 2025 12:24:06 +0200
Message-ID: <20250922102407.186660-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] add WQ_PERCPU to alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND.

        WQ_UNBOUND will be removed in a next release cycle.

Thanks!

Marco Crivellari (1):
  wifi: libertas: WQ_PERCPU added to alloc_workqueue users

 drivers/net/wireless/marvell/libertas/if_sdio.c | 3 ++-
 drivers/net/wireless/marvell/libertas/if_spi.c  | 3 ++-
 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.51.0


