Return-Path: <linux-wireless+bounces-28925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95AC58D6D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03A0E3660DE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC6D35C199;
	Thu, 13 Nov 2025 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J7WQU/bZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005B35292E
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050380; cv=none; b=Itd3Gc99PMANE0eLX8mbz7Y3BPowetv8Fw6ffVxLxvSG+UGTgBvMzaW/dm1qnXzVH1HJLm/+dak/7sBjcRRLIckjdaoOQEXN2D/0xP3wcs0cx5V9QIDQK2uINljoJKu5fojgX5H0mD1fmdjCXUD3+0c2uenqeXbIXi+pp2WILeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050380; c=relaxed/simple;
	bh=42xJSif+pmctYjHuGtfJDdWLcqKYQ+aUoY/Bqcow8CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d4myYdPiuto+Vno1elf67NljhGP+J9HIUuOHGXyI0OYwavrvmepOYXcpdZTsrV0aMw6OnoNRuf4Jmu1qGnwHOfBV5zOkbdx1n+RfKxaN48tCpuJFR/3UtTKdxNf8aaZPK9CClwDL8O7NbKdzuFBOvCuZeUNnf3SeaqbFLJoNEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J7WQU/bZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so7960435e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050376; x=1763655176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4P1naAhoro6awNrxaSVBn3BybkUtsIgcyUewhj0B5cg=;
        b=J7WQU/bZtLmjW1XxGS/k99Z1cO+I8VOn8vA2jB0UWSQNzSx0c1P1z8A+flldJ3yw3k
         J0BkctrSirB/kjQNg0mabGeLWj7Dao6iI8/U6UvsjHR2CG7xA9LbEGEg+oP+AXQOnFAb
         C1TZYmeJ/33bGaIfZRHXdm91HeqJ53eQaTcle3Ibxq38TMRear+zVm6sRb8d7fE+MKL/
         B290ed6tgSYbKfJSbvqcczKrTqBm2fo/vKsU2orVL+1FNcSncPH+7L+VX+2ih5nGU9JM
         J611Y0k5NQBUZ4MnlMS/NB7+1VG+qv/mjh0gS/TyVf1569jLQYTyd2IsgvTRHZGdH8OR
         bCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050376; x=1763655176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P1naAhoro6awNrxaSVBn3BybkUtsIgcyUewhj0B5cg=;
        b=cclwHUQi6YPDjFKx8zwbyUmZcj3RlW8j/YNIubz80OxdRA7tCJjAibsJe82WILa++9
         asifIJN7xn1/b176NbZ7AUFaz62ILuS5E9HBjt9aOg+84o+mKBygPI5NDFftqQEMsrVR
         gLE+NuQky37vNsrQwRqI1ACWsLdurL8GyTBcEbIHnld0hAu+x7FED2EmfNwqBtq6muPz
         WfbZAt+2DkVb/2WUsRDKUmaVzLImgwriBYjYElza5dmpUL3qDDrGRevYXO7hipurRyjr
         SqCyveslg/8VddLHSCUk0pF6uQN6l1nNLhas+HNBg0UssZyntv0hAyYnp4h7q0bJNscR
         DUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSifOB+W5SvY3M01rtGVpDxUReCrGaEINCS77mTzmqGuTmEHhQfEUo7BMA1FgIAnkaIJQc2jlSsSIzT3uCNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+BzXXt/9fgMIlg9w1m1/GxK6kdPfqReRVJj8S9HhzGaukz6HQ
	+wUO3M3m5ndY7p8xlh3mLni+RkB6O9YRoPKhDEMPx2oy5Q9ofmdhi6qO7YrtY6wS+IA=
X-Gm-Gg: ASbGncsBfFa7yiZn3YZC4dNL4lnZF+anpQe4s0fTaZJDNgAieTVxbD9LTi5YtHv4qdj
	Lw+0z1U8KoLkye+AGwM9wUk5I56V+KXRN88sWOmWoVGyM04L9wd6iULF4CR3EZr43xJYGa0e+p8
	Cep8DzpgJvIi2AY2iC1sfHYUX8qHlVTsoKFc7LKWOxJXJWs9vOsTk6jmum23/RblT5oZ0fNE/wC
	dKib4cBMIzwoZ6jG1RcjXIpmyPjmfBQvEjDEk8cdoSAJm0DATaKJq1StYCXhs75WwBTmzYqPT+v
	U28t4MqhzwJUcNTrlGNQRQ0yoec2FSgLxl+Q1TdhrqQ+1C1sQHlT1V2GjjljxFXlNtyP5JOE4dz
	/YAAaJdBqBVm9lEG9e2xsjTp+ZLt53pcUBAaxpsT/XRFMN8PSeuGgSQhp4uLpETpjA2ESYYngXT
	MhiA7/+b7ir9I4OAwUSYKhG3jU
X-Google-Smtp-Source: AGHT+IEd0JcdC98u3Fx/TXg1DQ2U+YBJI/MM71iHZiF0ptfCzqL+gsUNk7VTCxQtrOq0IUEgFyyVQA==
X-Received: by 2002:a05:600c:4585:b0:477:63dc:be00 with SMTP id 5b1f17b1804b1-4778feaa7f5mr66485e9.25.1763050375564;
        Thu, 13 Nov 2025 08:12:55 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c850000sm41700085e9.4.2025.11.13.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:12:55 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue
Date: Thu, 13 Nov 2025 17:12:46 +0100
Message-ID: <20251113161248.387964-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
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

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2] add WQ_PERCPU to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (2):
  ath6kl: add WQ_PERCPU to alloc_workqueue users
  cw1200: add WQ_PERCPU to alloc_workqueue users

 drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
 drivers/net/wireless/st/cw1200/bh.c   | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.51.1


