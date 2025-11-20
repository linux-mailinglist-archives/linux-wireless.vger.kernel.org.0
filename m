Return-Path: <linux-wireless+bounces-29162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB6C7367B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 11:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08FA83421EA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34DF30E0F2;
	Thu, 20 Nov 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fsVFKf4p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3525B1D2
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633343; cv=none; b=AWi4M5AxTaBd0guLxlN8BQgJ2OLEn7JvAt29FO87tlFabHWPDvBT59hImoud8QPyytmcu7FzEDBB8nQ5/guWJBSaZc/gO6R82fOPtqgX0uKOG1DV3wq/ltmnpPRPgHScoKtSoTJ3B0hXe2DI5esbJSaLc5MXPSHr0qp0W7Wr7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633343; c=relaxed/simple;
	bh=P34/dtWZ85iwYvVzb40ddAYrunxyeUYqmW3I8Ge+J54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkRIwSOF5vVFgPc7HETRWle8J7X6SQfVQA7guIVT3oNovJ/N+veznkkRN8Rfk3hnz20ieUaJN3mZnYtjAFAaYOO3DK99YKJughlgbaQvCeUzcUaxhhLKs8j655rbxMfbXjQocMHIL/EJecKewBAmkbJyRmazCoVr0eXJhV8IqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fsVFKf4p; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so4558025e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 02:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763633339; x=1764238139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGzgvPUJB5ULEnTHX9VsC7izg1nrPGM6c7p2oBs+2LE=;
        b=fsVFKf4pPJWlVszSY/dq9R6WbyFVPT0+tt3G3W3+v2ItVjwjmI8rYZK7l3p3X2erYs
         dfUak/MEWgQvjxueD/b73ehNpczQAK6abTyx0W2DdsMfXf4ndGpifaIXLDMIWfbYae+v
         GPXOxKCeZP3SBPlBpefZgoZNnq0CDA4unSdk6NFYxPenK/WI0DlpiCU4yWHnpBnrXoGp
         iY9S9zFJ7ORumS5D/Lq23Nyj3uUyGae2IzSra3WxA6ocfOLvc1weFwTjQB3SM+zbTtXE
         H0xgCStLe5yyo5+zLykZnSCqOdymkjN0moxZ5Ka4dMi4o4xXJLOGo1fjz7Dcv/txcvsQ
         g3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763633339; x=1764238139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGzgvPUJB5ULEnTHX9VsC7izg1nrPGM6c7p2oBs+2LE=;
        b=Egu+Cr1/3Lkq5Mt8JW3J32xwVBdGDjSusMnGuk8Y97AE0uMQgT1q/W+OxVynwCeGVv
         F5Evstd7DSB2A9jMQXyMXXMF/sveL1dct4hobmZY+zSG/mjRSNBm/i2PPnaA31DVoWI7
         Myhlf5OAAPEGzNImt6YrjaHz6tNtBmjBO62kC2zeEkeODs/JGtriZ+VtjMgI5Mbtg5zx
         YTb2ec5lQXIflKWbs5jQ+SVpSt7gnXoNJaTvqfpsolxuEFL09lo/13yXVfmOVvp1LHOZ
         DGYF+c2xEXYO8rofkzdj3uNpCfW7vOejSKw/P91XVenMFpv5iUXWg/kYKJUIEWWrEYnC
         Wnvw==
X-Forwarded-Encrypted: i=1; AJvYcCUr8ZfMncHtDD+po60p9KxUiVGxoo+EWEYnFuQOL9h2eHUOW3smIrvFrPsM8Sg7kFlbBbsQWkoqTJQdRVQmFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSQ9tzZgnaYAk+jbE6OA32J8opk5rPGJ3EXWYnj9Zou5H8f9k
	dX5X/GO22t+G//lRhWne9ftWfjG88/EK3sXYk8UxqqVfigcZ5+vIIEg8Reu6dgl9ozH7sQ9S+bl
	3jOg6
X-Gm-Gg: ASbGncuEiQG0g8fswzKsUHc2qvVLMEJlHUGXb64YNzWH2DRLLhibZgYMGm5IMv5rCpO
	LPlPQfrwunrKjIherik2IzGzGbx+uQ2YsNzSSFkHAxxf3B5KAazWVseXr1armF8YQ6MxSQN+7A9
	7ztX14yeB+F6187enWK8CEP09Lao0iotCtgApqEyN6mMUbl2IsdvFRt7+7kYKlfeAgvtNLMsTSe
	RsV0WE+OJ3TjJfgC0S+0KbXaix0gynDLou+wMExj0/Ib3W0oIcXxiPiSjDBigXvUNmBENkuNWgU
	N2V+mDd0QhyKWgUIa+S3hShiCwb4u/0nj07Jp6Akujc5Valn2HzYgUTT/50QjLyBaAgevRtYKby
	CnIWfGXkie6L9kcHaX06AHpeuIoHd7RC2DCo4Tu6hTkkqtZ+JWHakZuV4wuejWf08eHW7muuDiQ
	Txvs+zjGzz+uEqqdMCLtQ/qu6ws4RAAEaCkJ8=
X-Google-Smtp-Source: AGHT+IEIVsuwz31m+0qVQUSp4S609vYuCx16nlGVCdMnWLwnl/vHpXtGGdF6J1wnoMqJbxxq54IzPg==
X-Received: by 2002:a05:600c:474c:b0:477:7b16:5fa6 with SMTP id 5b1f17b1804b1-477babc2044mr13065855e9.3.1763633339350;
        Thu, 20 Nov 2025 02:08:59 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9de46cdsm58914125e9.8.2025.11.20.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 02:08:58 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 0/3] Replace uses of system_wq and system_unbound_wq
Date: Thu, 20 Nov 2025 11:08:47 +0100
Message-ID: <20251120100850.66192-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

1) [P 1-2-3]  Replace uses of system_unbound_wq and system_wq

    Switch to using system_dfl_wq and system_percpu_wq  because
    system_unbound_wq and system_wq are going away
    as part of a workqueue restructuring.

    No intended behavior changes:
       system_wq -> system_percpu_wq
       system_unbound_wq -> system_dfl_wq

Thanks!

---
Changes in v2:
- improved commit logs

- P3: wrong commit log was about system_unbound_wq; subject changed with
  system_wq.


Marco Crivellari (3):
  wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
  wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
  wifi: iwlwifi: nvm: replace use of system_wq with system_percpu_wq

 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.51.1


