Return-Path: <linux-wireless+bounces-27581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7E1B8FFC9
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 12:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC842A1567
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 10:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09AF2FE569;
	Mon, 22 Sep 2025 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZFR+mn7/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C6285045
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536661; cv=none; b=SOni8oVgW5LtMa6ISPUOvpBbi3xR5IblNqD+JLrDEgywVBi6/9rPntzy6UQDIVHYLPIObr8Saqai2XLEwVRxb15Ux4szo2Bywvk4+XVsROxcg4chCuUeWv18fcTckFO4QTUn1UcPAxMDgyY7ZwcLOm5ONUrk7QsKWf35kPUjCiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536661; c=relaxed/simple;
	bh=mjmDxeFm4ivEKtiuc70Fa2u1N2lU2/4nYzKVIqzkgks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1hTz/Z6ovjCM3Vz1xS+W+US2e4w4vyQxy+WdCELiYDfEAFrRTVljah5BOmoquwE1ovg5KtRCTxxNilqm0nVf954SCR+57idoN9sh84MQ01YS7WDsxn4KDdNrCxfKBC0znFVNjZ7dB/URBQ3rmAVPB1IrZ7Y1pJ7D0ak4tqD0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZFR+mn7/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso2373322f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 03:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758536658; x=1759141458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umA1vIerCRk0pXVnB2+DctUQUhZAfzJTqLbmXpMD4bU=;
        b=ZFR+mn7/nzgyeV/hTzn2zjFPUvN3/JmMwbiw3oKpg5ry+XlJ9zW8rGxq7YTNzwji4S
         VHcr+71LviHEBw06VA/RIQ65xqOnnQQOxAjSuS9x2U8zCMfEG6UXXOPWYQeU9FayasK5
         3TNpfL1xQyNAn6qoxh6l7EubRgv74yiUr6dDd5JPcT8mK4mUOg3Ng4idYtPYjTH8Z65W
         XMTRNqaRSxxu203IPLPveN+iuNvt+mkZcv3hCraS7MEDp9SsY6nH97LfCyVIifIhUS8G
         XnL46ys4skY7lZI0gnrtaBMqE18cYnq2Ce+uFmMZDE86FD1M/pefC+geyIDL9HK6lu22
         punA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758536658; x=1759141458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umA1vIerCRk0pXVnB2+DctUQUhZAfzJTqLbmXpMD4bU=;
        b=PRQfuNuPFQdYa/vIMRCD4vbzUHr5yZFij8W4l6DsQSVDUQawicA4c7QyGo6aSpFhut
         chaWaHt73SNc0b4NXCRgc+egg6MxINLYbcN5TZbbDi88KlKpkHlvZNtofmZiLTapQwtl
         C6sf4SLe6IjQdugjwQW6pcjcfgGyFFo4aCNqx28sCuAneMJOKtib+9L11ttaEHwFOkVE
         xnzj9ThSq+hNk4cdFIhrN8PlyAbo8u/oHmW72vZv5Vl6OXbDUINMEX0ISR8sM7BzwwnM
         P8HY7UAlETijoImEDLJNhPWVY6I+VtN2iy5KQueyC2yRgaKoHVkgtMcabw9pqP2xytTN
         dJmg==
X-Forwarded-Encrypted: i=1; AJvYcCUzaGg/2Mv3RdrZn0OaqVYqQjcGIupICRYLHuu1xhcl5VbUV9qm6rfH6aUEcKGEFyrod4rNaGydI7dR4a1Fjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcEpuHlsQknHxElAR3hlbEwfGD5WuSX9kTV5ryTRZZ+hc9n1pa
	ytl+Fi8yhAT70xdZsIJMiR1QqQhSBGMhpFzMr1B6EMxs4HlFB9IdWH7dAPw/zirJZh8=
X-Gm-Gg: ASbGncu87GFy6k2V+7qXKz0VGqHKcPYUu9FfFQPM1IfZexwIjQ7LJv4erK3MH4ymX5D
	SblXHYbZr3rTu3NmdBEXLkH6+0q+HC3HS7OReaFLrIJ9/ecuQL1gsg7WDlT3xYBWXa5vpkOM4Oo
	SmcAyR4IcUJjKTot+u1NRFFihD4U3vx6VdAzGLKLYAOTW2qT48FXP8LQ1lUDY9QBiL218R4lqFT
	uR9gI4BOQgT5TksOqLTInKO7JsmwHyjcJoGOyYNSeMSG3mnzdCzmE0+xOodmP9qrqiE4PUgW95R
	KXTR5kqvK9qz5kfnSCsuT/TQyo3dBIKtikrnh9x+dZ1woWC6vmTg9S4nm95QVNTr29TYZg25fdS
	hk5prW4BtPh2okWdmVz33KEX8WOJZasUUy/kFd5gJIP0ROgI=
X-Google-Smtp-Source: AGHT+IErikI5V8i9nOdU/HqH+vwUjdrAqRhxahFz4j7FUkqJbloiiigdONdwoWf0lQ4Vrh8/CHc7OQ==
X-Received: by 2002:a5d:5f95:0:b0:3ea:71c4:8e1b with SMTP id ffacd0b85a97d-3ee86d6cf37mr9253783f8f.63.1758536657829;
        Mon, 22 Sep 2025 03:24:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f41csm218613625e9.15.2025.09.22.03.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:24:17 -0700 (PDT)
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
Subject: [PATCH 1/1] wifi: libertas: WQ_PERCPU added to alloc_workqueue users
Date: Mon, 22 Sep 2025 12:24:07 +0200
Message-ID: <20250922102407.186660-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922102407.186660-1-marco.crivellari@suse.com>
References: <20250922102407.186660-1-marco.crivellari@suse.com>
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

This change add a new WQ_PERCPU flag, to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/marvell/libertas/if_sdio.c | 3 ++-
 drivers/net/wireless/marvell/libertas/if_spi.c  | 3 ++-
 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index 524034699972..1e29e80cad61 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -1181,7 +1181,8 @@ static int if_sdio_probe(struct sdio_func *func,
 	spin_lock_init(&card->lock);
 	INIT_LIST_HEAD(&card->packets);
 
-	card->workqueue = alloc_workqueue("libertas_sdio", WQ_MEM_RECLAIM, 0);
+	card->workqueue = alloc_workqueue("libertas_sdio",
+					  WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (unlikely(!card->workqueue)) {
 		ret = -ENOMEM;
 		goto err_queue;
diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index b722a6587fd3..699bae8971f8 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -1153,7 +1153,8 @@ static int if_spi_probe(struct spi_device *spi)
 	priv->fw_ready = 1;
 
 	/* Initialize interrupt handling stuff. */
-	card->workqueue = alloc_workqueue("libertas_spi", WQ_MEM_RECLAIM, 0);
+	card->workqueue = alloc_workqueue("libertas_spi",
+					  WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!card->workqueue) {
 		err = -ENOMEM;
 		goto remove_card;
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index d1067874428f..c51091e7c6c6 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -708,7 +708,7 @@ EXPORT_SYMBOL_GPL(lbtf_bcn_sent);
 static int __init lbtf_init_module(void)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
-	lbtf_wq = alloc_workqueue("libertastf", WQ_MEM_RECLAIM, 0);
+	lbtf_wq = alloc_workqueue("libertastf", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (lbtf_wq == NULL) {
 		printk(KERN_ERR "libertastf: couldn't create workqueue\n");
 		return -ENOMEM;
-- 
2.51.0


