Return-Path: <linux-wireless+bounces-29090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B21C68D77
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EFFD380906
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E322434DCCF;
	Tue, 18 Nov 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="THTaiYGP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628ED34DCC1
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461252; cv=none; b=Tv84gjwKIPqXa7WJTh1YD4mv2siG7OO3ikxwQOOH3uAk1BVQN1p2lEhSeKVtEzKxdKQsJoUEIiSzkLLqOu7mZ0p5aEuI2dWStTQob9Hz2UELXM5bApuhLVG4jIMkvdo8xxdbA6UnO+ENGKhbBEFUaWTuXBp0/BszwubjIC5Q8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461252; c=relaxed/simple;
	bh=VRCU+BJ8/NK/EQuiSKud0ApLPLbkLGrtdrkGSCQa8I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EG9XbvWEgxnCwvmmhKjy72yWwHqPFLllG9t4lPP15Z1/Z9jhCO3ViNFembc7I4lBA4OT/c6Up/N5ZK6sh0RvvwCHARvIKuIFtGgtCOP5nyFXZtjGFMUWz5iuDu3HQ6UF0exgLV0h15anl6SWUaLFNADBQjvEuvdzWrZjFIN4VQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=THTaiYGP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b38de7940so2992626f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763461245; x=1764066045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86OsQ8O4igE3G8VqFSqrPCkuxw0MHAvsJzuy/VvzkP4=;
        b=THTaiYGPlS48MAyQcKyteWWWUGzxBTgXpCssn2PljYyNa4qbEffMot9uqp0GGrC+W7
         wkLerNg7e+ahEjglv3wsZ4w+d7BSON1lE0SONS24GLFmuBFiermr3cG0j2UBN4NMkao9
         rQSmCpXxUCzZArc3EK4rkJPS6DtbvU7QSxKtLSD4DroY7mwCB9Lb5SSAk5FAemN6jDyT
         WMV9Z+p+wd5rs34/q91mYOFgVEt0wyauH/hfOSteM+XatWWclcbL2E/mTa6cqxM9j5M5
         5H05D/u2WfInd69gAJW5EC/4bVZy+Q2rNhRvc9AOTP3X2XB61t3huxZVtQpuGBzLxrII
         gePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461245; x=1764066045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86OsQ8O4igE3G8VqFSqrPCkuxw0MHAvsJzuy/VvzkP4=;
        b=YVPgaafdyq7DceR6YdDFV85Ccs8/6P2GakwCMsppCj0zx5AEVl1VReGnC+NVtdIRoR
         EsY/EChg6K/QBLZmHzuSEsG0zlH3yzolsEAs+AdBb8xJvD6rP+4WoPzGS0tFGfoY/Ltl
         T/I08SbRRgvbO24U04JT4DKpUQZwpFykPqqjD8g20K3MnsP4JXko/wIVS2QdwL6F1CQv
         TLLc9fjRIf+uxo2MxoU+ggetEvSkisEBOyat0vAWGusKH+D99Mlj/4CnblgB2pgoaxmU
         cV/lr1M+W2W0ezjgJv2dobmesXktefKbm2Shlk+Or5WRAm+jY4M4Lg+69H4GK5LiOQ79
         3WeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl0ywXxgF1d8Tx5XujBFOLGlFFT19MktE/7Q247qMJsbTvk6mXpHNq4HRgNIsWFL+Flmg0Hg0Ap8Kxu9UPzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFz6YlvCxbHreesH7tu3QCyBpHVTpH9dxqX2xuZN3xOzu8CE/
	2chUGUb9q5jrfT+3L8ITgD13P/EVwow1d29FlgDq7X3mzJgTVoVovYO2MEy2NjnMpvw=
X-Gm-Gg: ASbGnct6eBcAdiTvM+xSn9qtatY1EA8g5YmsGIYS3/VHC/JeGBOtdrL13a18d0RmGVl
	xi35GMzhodaqGZbJM35m7+YbEXH6/UbDv2qr4NNo0zBM1tC8243qjCBUWYlw5w6mThiMwd6Fzro
	hGepsFGV2+X6/CBcWqQhuGOSzgOEAk/Lp/cQ7K90hDwCl7xzd102kdYLz62s9i5xZPODS6NwmUt
	HzU82if5Bj9oreC6Mog8vgy3V4JEg1vV4wyIp049oTKbv1DQxxAXhKChYw8+Zuy21XA3WJE70Kh
	EBsMHlUzgb7/3Oy65NveVMKRstvz4mAj4683Q6ZNy4iP1aQxyUxQz8yYfKhR6Yi6+l/4ZqPEtBA
	n8prpHOb7TlYKq9p92n8lCpy1uQlWBbILW6TKIaR2SPEIpdIhRE2EcX7mo3jqTXbbsTR3EeBqpn
	YsM0WF3+hipN+aVw6CUL7ZPlv3LBD1btxyBHQ=
X-Google-Smtp-Source: AGHT+IFozv20m/vPtWmuTbUfLoHdmLih4UWquhWYCvwzAinCNYqlglildbIJq9MpgoiBlmIq42A7wg==
X-Received: by 2002:a05:6000:2f83:b0:429:ed90:91dd with SMTP id ffacd0b85a97d-42b59323370mr13864071f8f.6.1763461244827;
        Tue, 18 Nov 2025 02:20:44 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm32147587f8f.26.2025.11.18.02.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:20:44 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v2 0/2] add WQ_UNBOUND to alloc_workqueue users
Date: Tue, 18 Nov 2025 11:20:30 +0100
Message-ID: <20251118102032.54375-1-marco.crivellari@suse.com>
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

1) [P 1-2] add WQ_UNBOUND to alloc_workqueue()

	This explicitly adds WQ_UNBOUND because this workload has no benefit
	from being per-cpu.


Thanks!

---
Changes in v2:
- Switch from WQ_PERCPU to WQ_UNBOUND: this workload benefits from an
  unbound workqueue.

- Rebased on 6.18-rc6


Marco Crivellari (2):
  wifi: rtlwifi: add WQ_UNBOUND to alloc_workqueue users
  wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users

 drivers/net/wireless/realtek/rtlwifi/base.c | 2 +-
 drivers/net/wireless/realtek/rtw88/usb.c    | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.51.1


