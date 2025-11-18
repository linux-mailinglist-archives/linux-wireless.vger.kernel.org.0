Return-Path: <linux-wireless+bounces-29092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF52C68D2C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 983F24F3849
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3516934F24F;
	Tue, 18 Nov 2025 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WJaJF4Z3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017334EEE0
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461254; cv=none; b=AONqPhYWTXf4qnluz0oUm2F+iMtaMMO+H/h73BIjtKV/7hVB6hB4gquSqFC5adADwQS027o78bzQQsB8QkPDHawSS4g4W57dguO2H0a2j8lOptUiL4oPpteno/yBGi7kULu2bIGM49d0cQHu8x86Zh01GjHjWncYpnGRo4o28V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461254; c=relaxed/simple;
	bh=GEVpPGRVeFN0IJ+S9fxq6FovcATwQ/QwDVCZ5fl5Kx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0zndzb9Nx7e4ubSEdX/sNyYLFOT4eZlu8bHYcUJ3JkZ/iBgTEOwGN/Qslujol0me54kSZ9PR3sfocdw21/pAH9W/RdChpclvK9xCZ1Ea47rly7hnFiVhJ03iEo1JvpI8vyAA6VYVJS7+xQRtHoxQsVzcGwzS/kwJdCVipA4lT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WJaJF4Z3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c8632fcbso3748869f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763461247; x=1764066047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbBTDMN3+ZEqQ0u49htO9gJAirx33h7wnVKphKwscK0=;
        b=WJaJF4Z3sgWQtKRX83UTfv6V19jnuA4Dxr0kjUYadnxpXhhzPSMpD807jY2eio88AN
         7/gpRq6jB3YSHJMCps/JhV132vhKJt3mxbnXDlfqfcKlVgZe6f7g/5gyQdHPrMi3OFKE
         hp2H2Ci1XqS9q8dlLCVz30fcaxNTYyVtWasWFydR+nPP1AO3T7DBHmjL+heqF8TUaqFV
         vUC8ccZDftS2mH/Ryw9QF7KXTRekt4cfmjnBg+vrIju+qynFa2c/PG4rUZDu3TxuZoDF
         aDjYb8hnLPSzu2TFuoRxyyIERNF3XZPROoubrKXvFt8bWuWvbS9zPv+g3Ie4HrX2ODeA
         +KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461247; x=1764066047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbBTDMN3+ZEqQ0u49htO9gJAirx33h7wnVKphKwscK0=;
        b=iJAFxyvFWKzCeKWB+VsiAz7LMnawVF+K/ckYH8xi3jJQlVxQA/RqQ8A9OZnnFME8gD
         b1698kh8WrK1M1/YERJNvqrIj4d68zwLewrJUWXzCZ6VBsqfwRYdP8xSIftgA8HrD2uM
         2QcFMWe0ye6V14YlBIncgYBGAfQhujOxzVjuYzseLNN4gfHkPLVFidHoY4rM+SSrvB5B
         h4+68v50tURGOHEnK3/J6NmBrMwvnnsP/2E/3cT2OW+3pVafqt9yPIlV1Q5bcfU+p+l2
         h1yWzAsX6bGYnqS5veyr6YprTJWLmJdESp9h3pKV7sjHaSjLVpY5giyRe8FaZcZ2ZhXd
         Nbrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+oGJPS8JggSWGlZ6crrC/VREggxS0ZhzM3mpgUbuBWPCs04F0Xkd/3jQcv4E7uBqFiXDAJCac1Y2zjVs5wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/awTIXCZ693IicpoyHG1RZW8JqOC0XtsiDr+RPx9NaHQYr8pF
	1/46meO04dLhbDTc0UeYSO56t+IDICdwNNopBfiajeQ+gFaCXbZFyubUF4WF+tultL7A+qVm1DH
	apI75
X-Gm-Gg: ASbGncv1ZtsnytxmfeXSxBWfH86aah9eTl28Zig8FYZTCuGbRku2+b40pHApHOypt33
	Huf0s4BiqZBsujjQqHNN7kKG9sCnTvalID0yGFfX2pLP2BZwWEQZs3u5WiBWlWNhmVoNEiJrB2A
	M9iP3Uk9HuQOVwK9wLmLYbOqMZp7GOrXytlMfXGeRcopgbFhDF2TBVTSZUXqLtGRUZuAmBB7wou
	6rBi4M2llLhDF3TCNFgBzkurVHAYH/mRRvc6qIotZzc/W8fiQ01XFg7FCKS3KXI5v9bsxmSV+1e
	8t5+lf3o+mdASXqZsOnR79q/3HCkSzxNuN0kn1bZcIA8lv7Z/dEsdFx6aNsCRQN/rTrtOr0w56Z
	RxR7AykvE1EIOsFL0CB8DA1lpoL08MHuWcLp/hGrqoHPpYwRKEdin1rPDze9XTTwW7gtlCmNSVe
	gpH0Ta8CMCCDAdiKGl+gDUDXVq
X-Google-Smtp-Source: AGHT+IGPcKR/wlZP0UldFikZNR1qvyTXS05hdw1j6Pn0ZSb6p7TS4PXtopCsP93ig0mpQ/gP2QP65Q==
X-Received: by 2002:a05:6000:4285:b0:429:d0b8:3850 with SMTP id ffacd0b85a97d-42b59373560mr13427757f8f.48.1763461246876;
        Tue, 18 Nov 2025 02:20:46 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm32147587f8f.26.2025.11.18.02.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:20:46 -0800 (PST)
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
Subject: [PATCH v2 2/2] wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users
Date: Tue, 18 Nov 2025 11:20:32 +0100
Message-ID: <20251118102032.54375-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118102032.54375-1-marco.crivellari@suse.com>
References: <20251118102032.54375-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds the WQ_UNBOUND flag to explicitly request
alloc_workqueue() to be unbound, because this specific workload has no
benefit being per-cpu.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 drivers/net/wireless/realtek/rtw88/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 3b5126ffc81a..009202c627d2 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -965,7 +965,8 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 	struct sk_buff *rx_skb;
 	int i;
 
-	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH, 0);
+	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH | WQ_UNBOUND,
+				       0);
 	if (!rtwusb->rxwq) {
 		rtw_err(rtwdev, "failed to create RX work queue\n");
 		return -ENOMEM;
-- 
2.51.1


