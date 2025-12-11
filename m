Return-Path: <linux-wireless+bounces-29670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2ACCB5EB5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 782D73004F4F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF43101A0;
	Thu, 11 Dec 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fD+FcIuI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7C3101AB
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457037; cv=none; b=heOXTNKjW8VdLpmgzoTeMJeawfl7P9K/rbBp78fbqXYK0G1/OeTgsbq7kUDUFJGidC5FQ26ZTRlojpAvu48ypfOZHgo4C2ca12eGEGjUJgJmdG6KMSqKpmJavhDQyIDIi6SMa63lUXRj3+n4sGx2EH9b0H/3xk9BzW/9FYHho+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457037; c=relaxed/simple;
	bh=BvRmvmGP+o5Fto72f5JjXTz1UILqb4/iDYHNPJnfAe4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=megO6jAW9+p8ZwI/Bxg9zkwKxzw9iiKlD8l2rphsiheVg4R6i8CiK2Eggb31sYEGDG1EzBuQJXMPCEtuE/eI8ZBqKUQ9jbWHAkRklAjSOlw+Avt8A66Wg4BJ4gMaK2hD3MT6SN0rnc1Jgm6KjXUknacyPIx6Kj3wHduKnOTq9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fD+FcIuI; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0b7194c8d68f11f0b2bf0b349165d6e0-20251211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NDkXuxIY36/CsPMFsGbOXVis7R+vQmC24CWTXr3hcVw=;
	b=fD+FcIuI35Jcbk8gThEhvllAfwwt4JoGeVq9b/wq8iMYXkd6EQMoMJplsC4iBFprvNO11mXkfNHvAUMOTDm12OAHGAJZHGjk9fuBbDEu77ilrLphufkJ1CYaKqbmdjmqzMrWXjk/aMWQFdF1xbHt4uK1WRqrzdO6M9LS+Bjpl9M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6826a941-34da-4df4-b802-930bb55c8fb7,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:7a75a902-1fa9-44eb-b231-4afc61466396,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0b7194c8d68f11f0b2bf0b349165d6e0-20251211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <leon.yen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1975627448; Thu, 11 Dec 2025 20:43:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 11 Dec 2025 20:43:49 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 11 Dec 2025 20:43:49 +0800
From: Leon Yen <leon.yen@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<mingyen.hsieh@mediatek.com>, <michael.lo@mediatek.com>,
	<allan.wang@mediatek.com>, <quan.zhou@mediatek.com>,
	<sarick.jiang@mediatek.com>, <ryder.lee@mediatek.com>,
	<shayne.chen@mediatek.com>, <leon.yen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt792x: Fix a potential deadlock in high-load situations
Date: Thu, 11 Dec 2025 20:43:44 +0800
Message-ID: <20251211124344.4172470-1-leon.yen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

A deadlock may occur between two works, ps_work and mac_work, if their work
functions run simultaneously as they attempt to cancel each other by
calling cancel_delayed_work_sync().

mt792x_mac_work() ->   ...  -> cancel_delayed_work_sync(&pm->ps_work);
mt792x_pm_power_save_work() -> cancel_delayed_work_sync(&mphy->mac_work);

In high-load situations, they are queued but may not have chance to be
executed until the CPUs are released. Once the CPUs are available, there
is a high possibility that the ps_work function and mac_work function will
be executed simultaneously, resulting in a deadlock.

This patch ensures that the ps_work function and mac_work function can run
exclusively by adding two flags to indicate their running status.The work
function will reschedule itself if the opposite is currently running.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
 drivers/net/wireless/mediatek/mt76/mt76_connac.h |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c  | 13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d05e83ea1cac..0414a4898d80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -892,6 +892,7 @@ struct mt76_phy {
 #endif
 
 	struct delayed_work mac_work;
+	atomic_t mac_work_running;
 	u8 mac_work_count;
 
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 813d61bffc2c..eefa0147f883 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -107,6 +107,7 @@ struct mt76_connac_pm {
 	struct mutex mutex;
 
 	struct delayed_work ps_work;
+	atomic_t ps_work_running;
 	unsigned long last_activity;
 	unsigned long idle_timeout;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 71dec93094eb..22345031e262 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -15,6 +15,10 @@ void mt792x_mac_work(struct work_struct *work)
 					       mac_work.work);
 	phy = mphy->priv;
 
+	if (atomic_read(&phy->dev->pm.ps_work_running))
+		goto out;
+	atomic_set(&mphy->mac_work_running, 1);
+
 	mt792x_mutex_acquire(phy->dev);
 
 	mt76_update_survey(mphy);
@@ -27,8 +31,10 @@ void mt792x_mac_work(struct work_struct *work)
 	mt792x_mutex_release(phy->dev);
 
 	mt76_tx_status_check(mphy->dev, false);
+out:
 	ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
 				     MT792x_WATCHDOG_TIME);
+	atomic_set(&mphy->mac_work_running, 0);
 }
 EXPORT_SYMBOL_GPL(mt792x_mac_work);
 
@@ -356,6 +362,11 @@ void mt792x_pm_power_save_work(struct work_struct *work)
 	mphy = dev->phy.mt76;
 
 	delta = dev->pm.idle_timeout;
+
+	if (atomic_read(&mphy->mac_work_running))
+		goto out;
+	atomic_set(&dev->pm.ps_work_running, 1);
+
 	if (test_bit(MT76_HW_SCANNING, &mphy->state) ||
 	    test_bit(MT76_HW_SCHED_SCANNING, &mphy->state) ||
 	    dev->fw_assert)
@@ -376,9 +387,11 @@ void mt792x_pm_power_save_work(struct work_struct *work)
 
 	if (!mt792x_mcu_fw_pmctrl(dev)) {
 		cancel_delayed_work_sync(&mphy->mac_work);
+		atomic_set(&dev->pm.ps_work_running, 0);
 		return;
 	}
 out:
 	queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work, delta);
+	atomic_set(&dev->pm.ps_work_running, 0);
 }
 EXPORT_SYMBOL_GPL(mt792x_pm_power_save_work);
-- 
2.45.2


