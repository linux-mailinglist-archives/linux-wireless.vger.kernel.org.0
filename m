Return-Path: <linux-wireless+bounces-28969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD0EC5CA56
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 050B7342B60
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B461F22258C;
	Fri, 14 Nov 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NlCTrf/P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A70305061
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116691; cv=none; b=cZbynONzlEeBVOyGExH3Z+TBGhjzlCGt+giJq3mzKG9RNWAfebh2VRq2KEwasgm27dhd6MsuwTun3t26YaV/hiC7a1oVPHWgzMdB0pTzVXu+GU/cfYYm+fM2UYgRPFTKU6ocRvejE/ac/hFBrU35eWQ+aUwBn/v2mUkdGjNYiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116691; c=relaxed/simple;
	bh=3lT4vK9gmvPbuVz3poNnD+6fcnFXF1JijeA9v3V5c2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tic+RrgmEqNM4wLbByCp72F2eI8ncPeuTPHgVZtRT2FiT5po9PvN6wUVp50tBh8P8hUBXChyiQ6Yoi0lE9gdw4TCi7MuoFVAzG6bkYVDQDzJvBv2kAlVbQ7fRoW++aDdR6cZJWyPF6LGN9sN6q5EmxKR3Wt2xu/lQFZW88PxLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NlCTrf/P; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b72cbc24637so317144666b.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 02:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763116688; x=1763721488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccbkvu/InVNISjRfGYZ2/Lf01W01N2nlXo2U2vxgieQ=;
        b=NlCTrf/PTyctKNgy+VLKqgnHk3fmTuSh/FJyRLgXaW79Q9O/aXsAodqlaAMXWc4shj
         0reFtQPIcynzDAL4sl9Nh4Hi4Xsg0NdIppkeIFKKrHCXfrUe/xuAOjdUiMvM2hqJJ9PF
         FUCm/Tfnq+4T3Fh2T9A6tRa3oi54mWrjJfQc1x1j92HQpwW+L1ACU25cqE1ktx/V5naJ
         CDj7WZwQehJxvl/3NBakC2l0ARxMGhies45F7s6eyS3lFJlgR+LeOuxo2YC6Vu0CzJij
         YmHyM9cHJiBQL1/2l7AQne3V66HamJ1n5OyL0MjTguJDjrZ1Rcosms9iDWWe+9UujQIr
         AlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763116688; x=1763721488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccbkvu/InVNISjRfGYZ2/Lf01W01N2nlXo2U2vxgieQ=;
        b=tvWdGnWaieTvc+rADxmxRJuSYVYU3EDrSeTVEN9XHahVfCagCPfntwsewAneS0L6V5
         YX8rCsM2N/EZnIT09jG9vmNolEfo0rXtJIR0uE+KwJ2CBmvqu1RN4OFbFD+SF65MIsEg
         rIRetDVTb9kgOg6g1fBUrVxlj2yAne77YFg8cqxsN3bApUzbWqFCO9mA8nLPyVtCw8L3
         EvnTLOnfZVKcyTHlgIg4awQNhmAx6j+bJY8WLrtYbn+tunXoU9LBHaLsNUst28EVQZij
         kksRdOjr4SE0WrLmt5rdvJjtKJUIingoQKSKmuY2K1I+s6mP7PjisRqwJYH8Ws+jYRbm
         cAXA==
X-Forwarded-Encrypted: i=1; AJvYcCWRKrpOEAuIF9vYd9E0FgqiwEISYy47SYMzoaHrASHUOfLmkYzRZ4EpvCHrSWDiUq1R6OhmxeWV2a67BTwc0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4BIXlapuUFR+e/KvMQ8630zxzj6g1dhWZZNBKpyzPl53fFKoT
	7VCNFDxu0G8Y6pFOTrQCrnxlMMUiLl8TmIehgS9emfu1V618/sj5DbM/JO5Wjr+tcxA=
X-Gm-Gg: ASbGncse0jyOgI/XzxRkcclOU4GfcjEPBUIWOb0inIr/PQPMjT1WiCLDGWDTfiykHMR
	XudgOrsU9f/5S1lU3tl4ki5/zxOXtPzTG95Am3Iq45oSS/dwumU0Ri0W5RwBMou5UcR/64hJ4sL
	ZqY6Ro5JHnl0Raj/yjTtpq/jyp79wt6IFHdJBLmiA25pfBLuY1bOtb2jxH1YI8CfVAN3EkKSq3P
	ATS9UrPRfGWGaJr9asDYJNGOFVzLqFCpCzF9AgFt9/W7VUXRe0vNNo7Hji9VU/fK5YKoMeVFueX
	Zuli2BCGqGrr/9yGX1zyFFko19aZks646m6h+hG6GgQIHjNJZtsRiY1X8UKYHJ/Q/gwWee8aqPS
	PWWvLdiHYS+AD+NAyxi4luISrtCGTQBSm0ZiKoVWmLaR9x0dx5ewoDXuN4Gf8XLK7uxAIoKVYB7
	RHvBz0mXYnyxfaTw==
X-Google-Smtp-Source: AGHT+IHGHYcW+Rm6uVKApRZytq0DVdkINzrNChVAGNUZ/4QxHlW2uVU9eXIoRjTSGdOWmBIEbBs3eA==
X-Received: by 2002:a17:907:1b2a:b0:b73:4b22:19cc with SMTP id a640c23a62f3a-b736786971emr177858266b.5.1763116687717;
        Fri, 14 Nov 2025 02:38:07 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80a3asm360276766b.37.2025.11.14.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:38:07 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 0/3] replace system_unbound_wq with system_dfl_wq
Date: Fri, 14 Nov 2025 11:37:54 +0100
Message-ID: <20251114103757.111652-1-marco.crivellari@suse.com>
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

1) [P 1-2-3]  Replace uses of system_unbound_wq

    system_unbound_wq is to be used when locality is not required.

	Switch to using system_dfl_wq because system_unbound_wq is going away
	as part of a workqueue restructuring.

Thanks!


Marco Crivellari (3):
  wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
  wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
  wifi: iwlwifi: nvm: replace use of system_unbound_wq with
    system_dfl_wq

 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.51.1


