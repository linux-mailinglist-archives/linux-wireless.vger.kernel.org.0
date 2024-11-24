Return-Path: <linux-wireless+bounces-15624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C19D9D75C8
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 17:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4413B4311D
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADE1D7995;
	Sun, 24 Nov 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9wEonEo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47A1D79B6;
	Sun, 24 Nov 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455330; cv=none; b=NhxPuzhzQjc0QWpK8U9eDkS/DxdnrkjeWUkjka666Lyix+4dpzIxB1RF/kAextKlwekiURuLFrAYYC69J3Rp3pLjce2httXRJSoOljzZmJEaN9YbriwhP2Tt54HS4lSbBsc/tcSRejRuLn9CTZnTzLKwTGOgsFrTrZrR6hkOXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455330; c=relaxed/simple;
	bh=8oreY0imW4H/APsYD40vBOOhKAUrw0TwBDohPYNmXws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQSfdBak4owX3kPr1frKGGmRck/1jcnj9LULBw8kVx4mjtJ8TJjVEIBCUufIg+emkX3MStEzYjWzU8JEdzZjUNzgOhXc5U8QOcb4ra0ewsJd/jNzBv5W8knhqMBb34fJhYRTbktaQLOFa/vJODuUJ0MIYSuULVJFyxapqkM19PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9wEonEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CFDC4CED3;
	Sun, 24 Nov 2024 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455329;
	bh=8oreY0imW4H/APsYD40vBOOhKAUrw0TwBDohPYNmXws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9wEonEox/vW3tQWx2ww8zNysoQa4tirHcGmlfRoYuAkYtF2Or9crmF+xeJwcjHB3
	 StF9Qm7ck0BCznKGrVOS74/S3N00KHwj/mmInjia8q8xEsiFleZjkuqz0xQni9sAJ3
	 KRg2AEXw7cipVWVGGLLvIazX9oTMOjl8kvhR29JOHfdpX/QXOngXE49r25cRsUqSkr
	 QVSB8W9hORgJrzPq2l/MIFRrNjeCEUt/PMhhrzyqpGTWm4EVqArACF2Wu6MjNOcHcT
	 +prC1OSLe8ZQELRYzyH3ds/MlLO0pB9vhwElHfXyR7AIlfhfyOfGZDe+kQ30lD/0jS
	 NK0Yf+zIDAJOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kang Yang <quic_kangyang@quicinc.com>,
	David Ruth <druth@chromium.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 045/107] wifi: ath10k: avoid NULL pointer error during sdio remove
Date: Sun, 24 Nov 2024 08:29:05 -0500
Message-ID: <20241124133301.3341829-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Kang Yang <quic_kangyang@quicinc.com>

[ Upstream commit 95c38953cb1ecf40399a676a1f85dfe2b5780a9a ]

When running 'rmmod ath10k', ath10k_sdio_remove() will free sdio
workqueue by destroy_workqueue(). But if CONFIG_INIT_ON_FREE_DEFAULT_ON
is set to yes, kernel panic will happen:
Call trace:
 destroy_workqueue+0x1c/0x258
 ath10k_sdio_remove+0x84/0x94
 sdio_bus_remove+0x50/0x16c
 device_release_driver_internal+0x188/0x25c
 device_driver_detach+0x20/0x2c

This is because during 'rmmod ath10k', ath10k_sdio_remove() will call
ath10k_core_destroy() before destroy_workqueue(). wiphy_dev_release()
will finally be called in ath10k_core_destroy(). This function will free
struct cfg80211_registered_device *rdev and all its members, including
wiphy, dev and the pointer of sdio workqueue. Then the pointer of sdio
workqueue will be set to NULL due to CONFIG_INIT_ON_FREE_DEFAULT_ON.

After device release, destroy_workqueue() will use NULL pointer then the
kernel panic happen.

Call trace:
ath10k_sdio_remove
  ->ath10k_core_unregister
    ……
    ->ath10k_core_stop
      ->ath10k_hif_stop
        ->ath10k_sdio_irq_disable
    ->ath10k_hif_power_down
      ->del_timer_sync(&ar_sdio->sleep_timer)
  ->ath10k_core_destroy
    ->ath10k_mac_destroy
      ->ieee80211_free_hw
        ->wiphy_free
    ……
          ->wiphy_dev_release
  ->destroy_workqueue

Need to call destroy_workqueue() before ath10k_core_destroy(), free
the work queue buffer first and then free pointer of work queue by
ath10k_core_destroy(). This order matches the error path order in
ath10k_sdio_probe().

No work will be queued on sdio workqueue between it is destroyed and
ath10k_core_destroy() is called. Based on the call_stack above, the
reason is:
Only ath10k_sdio_sleep_timer_handler(), ath10k_sdio_hif_tx_sg() and
ath10k_sdio_irq_disable() will queue work on sdio workqueue.
Sleep timer will be deleted before ath10k_core_destroy() in
ath10k_hif_power_down().
ath10k_sdio_irq_disable() only be called in ath10k_hif_stop().
ath10k_core_unregister() will call ath10k_hif_power_down() to stop hif
bus, so ath10k_sdio_hif_tx_sg() won't be called anymore.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Tested-by: David Ruth <druth@chromium.org>
Reviewed-by: David Ruth <druth@chromium.org>
Link: https://patch.msgid.link/20241008022246.1010-1-quic_kangyang@quicinc.com
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 08a6f36a6be9c..6805357ee29e6 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2004-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2012,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2016-2017 Erik Stromdahl <erik.stromdahl@gmail.com>
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -2648,9 +2648,9 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
 	netif_napi_del(&ar->napi);
 
-	ath10k_core_destroy(ar);
-
 	destroy_workqueue(ar_sdio->workqueue);
+
+	ath10k_core_destroy(ar);
 }
 
 static const struct sdio_device_id ath10k_sdio_devices[] = {
-- 
2.43.0


