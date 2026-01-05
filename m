Return-Path: <linux-wireless+bounces-30357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E26ACF340F
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 12:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2223031D75
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA221329C69;
	Mon,  5 Jan 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Lc5u1S3S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEF328B49
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612403; cv=none; b=TUYc3pxCrpQ++lRVClVA9aPVkbj6B/bW7hYVMOzNlsg27TP9XcR55Yer7jRdrkcDfzNTcex1kKV2jfrTrvQpuR9N8m2B+WFY74KimGMv+j8siB5qpB2La2orWEUKY+aNYrqi9tG+BE+/mAR6qNb/m8KPmOjwIvtI/9ixkSy3iVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612403; c=relaxed/simple;
	bh=sYAc5sJMvWC9oDaPnHwBYuQePNcpLRGmQZH6K59uCWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSoR7TRUC9NV9EWU9G6ILZ8vR0XBv0/ikuHzuTBYylJp8iPREgLUqfpOTp6ADBZK1DlFKkfljkFV7mnrugx8YDwM8Htj+O531py058auym0ZLXCM3+RqejmnWDqwiKDmwDyR8B+gTT4RiYC4ZYFVCGvuxjsPp9EJsgvddnJ45ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Lc5u1S3S; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202601051116302f85463455000207cb
        for <linux-wireless@vger.kernel.org>;
        Mon, 05 Jan 2026 12:16:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Y8UnCmSoxoSlYOsxJheKmv0QIG0V+9stYWQiOEAOZyg=;
 b=Lc5u1S3SZsy6DnmEZvJfBUMXUnw13TznibXwTKuYhZiwwnQ7xGYYyCGtooDnf7yK2IO0xC
 mIPzoEkgmL8q7Uc1fGiXsIHoruzaEIpVTMuh02LpmDGAVGycP9Xeuehqcp/B1yGsz17HJRAn
 tRKcZW5KMDpnovC00paTzBlv4mq03QdLeNISvV7lHmRMXCfmoT7Qh9kI1l56z0ttYZVO9xSX
 PL9eJTQCQmD6+cs7fA+lKM9h4scNYQ1sdyK+HUkRO1qJcohfndjY8X/AI+okQEFn8cnDoSuM
 LrqGCHhiKspFKq+akzeqmxMGlzWokMBzIvVJG8xKScYf4DmNWhCWrX1g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Fietkau <nbd@nbd.name>,
	Quan Zhou <quan.zhou@mediatek.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6.12 1/3] wifi: mt76: mt7925: fix the unfinished command of regd_notifier before suspend
Date: Mon,  5 Jan 2026 12:16:26 +0100
Message-ID: <9b06a0703d4a825b1db17f3213814ddc42644a5b.1767611788.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1767611788.git.jan.kiszka@siemens.com>
References: <cover.1767611788.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Quan Zhou <quan.zhou@mediatek.com>

[ Upstream commit 1b97fc8443aea01922560de9f24a6383e6eb6ae8 ]

Before entering suspend, we need to ensure that all MCU command are
completed. In some cases, such as with regd_notifier, there is a
chance that CLC commands, will be executed before suspend.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Link: https://patch.msgid.link/3af7b4e5bf7437832b016e32743657d1d55b1f9d.1735910288.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 5123a720413f..3f48ae80aed4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -81,11 +81,14 @@ mt7925_regd_notifier(struct wiphy *wiphy,
 	mdev->region = req->dfs_region;
 	dev->country_ie_env = req->country_ie_env;
 
+	dev->regd_in_progress = true;
 	mt792x_mutex_acquire(dev);
 	mt7925_mcu_set_clc(dev, req->alpha2, req->country_ie_env);
 	mt7925_mcu_set_channel_domain(hw->priv);
 	mt7925_set_tx_sar_pwr(hw, NULL);
 	mt792x_mutex_release(dev);
+	dev->regd_in_progress = false;
+	wake_up(&dev->wait);
 }
 
 static void mt7925_mac_init_basic_rates(struct mt792x_dev *dev)
@@ -235,6 +238,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
 	init_waitqueue_head(&dev->pm.wait);
+	init_waitqueue_head(&dev->wait);
 	spin_lock_init(&dev->pm.txq_lock);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt792x_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7925_scan_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 5e428f19f972..b4cc5607e0d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -455,6 +455,9 @@ static int mt7925_pci_suspend(struct device *device)
 	if (err < 0)
 		goto restore_suspend;
 
+	wait_event_timeout(dev->wait,
+			   !dev->regd_in_progress, 5 * HZ);
+
 	/* always enable deep sleep during suspend to reduce
 	 * power consumption
 	 */
-- 
2.51.0


