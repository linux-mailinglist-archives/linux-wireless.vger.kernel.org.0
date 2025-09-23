Return-Path: <linux-wireless+bounces-27616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67EB967B0
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB7C168D49
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB9246BA4;
	Tue, 23 Sep 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HZlNjRCd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA63223707
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639561; cv=none; b=QMn9ffivH8OkG5n14jMpnYR/vnLIfanhNIw32lL5tc3FRlY+MXIJgNIC+N8OYWqbdqmghRsNbOrUSXwMnX6CWlpaVubWDpVHFZNrSm/xh3PLLJJAJScp8+3z74yLkuzHN6mA1UYSG4myK871xpu5uOVuTAChBE4480OEvF3ZXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639561; c=relaxed/simple;
	bh=Nna1OdZOe0nnkKJ63oIewBWoT3so1EcPEublReL//R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjNArwrK54lgIh9TrPBbOoFUK6BwT2XWDaIvyd60VMZq7niEaM47cq6/DvRDnM6wLviz2WtAXqYnbGgwN1gSu0w8hHaRhs8Qnq0yPpKWmI18cx7R6mLJwhd7LBSMUXDpCocUcz54ATYZW/pfByRsjiAm2vhMe3cXUR3+IzjtDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HZlNjRCd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45ed646b656so50033995e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758639557; x=1759244357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOCISoePciLIeXeBbO4+qiMsX57pWEvn9G5NpvhqgC8=;
        b=HZlNjRCd1VvelEJ0VPpHPx0naAQFT6PUofEKLgCLn/5ixHoBDkueU9ZKncN4LWUsoy
         fWcxa+XJ8PZZlW1D9cyi7PUCVKOoP+zjWSj0VD++NXWRlsBv4vQcCttiLwLrSnP1Ucom
         u5ymCPMVx6m22IEtUQI201wy1c8nPkIqtajygIHCzyQxCImRvR93pO7FMBTSZKwNHZG9
         fljexQCx9hYkDXCBMKY5zngFrF9WTsGqEqGCzdyKBXTiQVSsqg5gR6PJjdqcIpq1RWUk
         OtI8Lg3sl10j0tfZJpX3pM9K0GEm2FaPpXbswd2E0L9YOmc6tjFHRuRmoyI1fGNAIMjL
         2lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639557; x=1759244357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOCISoePciLIeXeBbO4+qiMsX57pWEvn9G5NpvhqgC8=;
        b=EAL3+Xz+tWX6epm6VuPzgYRHjOcgz1CkY/FOL/BPUdPYdtSE71dlPmftKoyY76av9B
         /QFELjJ5mhTv11WxQP6kROH436upAjyFNYdX96iRBLbrvx3sBtsgqIGyTyBpPh5khZTR
         O5fIgfA26clNj6aXKo9TgZQZCa9K/qrVUFdoJpfAwD+avsR8NWL1dPOfSrj4AJi2xs+R
         6AlAbvnILe5Hfb9vEqqKxi4mhY5QBtBKUKuTIdXDcRo+heKBkh1CsF+MyxP36DPZQVB2
         UvXC+X2vOhag5zskDiAsovhrBI/K4GFSsuFyu9yXd2J3zaPgI/oOu6pYx9uNHXsat8Ry
         tcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6AiasNKrH/DEmWbtGO/f7IZBCPhVfXAe3lNsDHWZNJWUXn4hY42lwBKdixIrGw1Bo0+epm2hgUoKgAxdlvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLFNSEVBGKPNLw6Pa2yHoNEF+U8CAmzm4elfqUmagOvzEWHip
	4Uv9USrMc00zNdMpTtfxjBxoLDR+vTxvvYerIJNLN3DDMI3IRtWVvOGHXHL4nNBYo3mbhJtOWFP
	Bua0VdHQ=
X-Gm-Gg: ASbGncvNnzqhrWmZdL8Gym30K0Xk8eDDoBjhWnZDB3beybF/8bkAt8gbN6WscfZOMJp
	iT5u1Kfopu90tj+Am4t1MMENwP5PYUIKsqo05Wd90CVZ2b1zYQDQ/y1HZAbV26mcgCEDyLF6kP6
	aTMOQ+8qWamTa1NjNmHvpsfm+0FKFdWyDQ1L4DU0V6TajUmbkmCbNB1G2V7CQWvn1fB6Li2Azbl
	YqGPQe9H53Icj7M11O16tYKUFklgXyv1LooWJMAxlSID5gwmn2gqIEJn12yLy3D8SSF3muupW2x
	opQwK6bpkCqeeY5fMUtNDFMNqEMq5sEZmibb5ScT+4fOkhvHT+0yJLZDUzYyDKKnlBLtpEfJxYp
	VEka+QVDaPCfcbQsjk+lDt+ZMrCfsCvu3X43ON/2KOR9fbCk=
X-Google-Smtp-Source: AGHT+IEIPtbSsWo6dVRsAMW229x4yzJgJx4HgWpoTAGkn3ab8jiwD4vY2vOQDp1TwA/CSqTehMF3Mw==
X-Received: by 2002:a05:600c:470e:b0:45d:f650:376f with SMTP id 5b1f17b1804b1-46e1dab50f9mr31786745e9.23.1758639557483;
        Tue, 23 Sep 2025 07:59:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46de4d67625sm76708005e9.16.2025.09.23.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:59:17 -0700 (PDT)
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
Subject: [PATCH v2 1/1] wifi: libertas: WQ_UNBOUND added to alloc_workqueue users
Date: Tue, 23 Sep 2025 16:59:05 +0200
Message-ID: <20250923145905.327269-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923145905.327269-1-marco.crivellari@suse.com>
References: <20250923145905.327269-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This change explicitly add the WQ_UNBOUND flag to alloc_workqueue() users,
to mark the workqueue unbound.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/marvell/libertas/if_sdio.c | 3 ++-
 drivers/net/wireless/marvell/libertas/if_spi.c  | 3 ++-
 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index 524034699972..fc5318035822 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -1181,7 +1181,8 @@ static int if_sdio_probe(struct sdio_func *func,
 	spin_lock_init(&card->lock);
 	INIT_LIST_HEAD(&card->packets);
 
-	card->workqueue = alloc_workqueue("libertas_sdio", WQ_MEM_RECLAIM, 0);
+	card->workqueue = alloc_workqueue("libertas_sdio",
+					  WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (unlikely(!card->workqueue)) {
 		ret = -ENOMEM;
 		goto err_queue;
diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index b722a6587fd3..8a2504a62840 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -1153,7 +1153,8 @@ static int if_spi_probe(struct spi_device *spi)
 	priv->fw_ready = 1;
 
 	/* Initialize interrupt handling stuff. */
-	card->workqueue = alloc_workqueue("libertas_spi", WQ_MEM_RECLAIM, 0);
+	card->workqueue = alloc_workqueue("libertas_spi",
+					  WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!card->workqueue) {
 		err = -ENOMEM;
 		goto remove_card;
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index d1067874428f..fb20fe31cd36 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -708,7 +708,7 @@ EXPORT_SYMBOL_GPL(lbtf_bcn_sent);
 static int __init lbtf_init_module(void)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
-	lbtf_wq = alloc_workqueue("libertastf", WQ_MEM_RECLAIM, 0);
+	lbtf_wq = alloc_workqueue("libertastf", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (lbtf_wq == NULL) {
 		printk(KERN_ERR "libertastf: couldn't create workqueue\n");
 		return -ENOMEM;
-- 
2.51.0


