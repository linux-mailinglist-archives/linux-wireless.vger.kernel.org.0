Return-Path: <linux-wireless+bounces-12330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ADE96829A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 11:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960931F210DF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7671547D2;
	Mon,  2 Sep 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GfezLxj1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF8DF71;
	Mon,  2 Sep 2024 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267668; cv=none; b=k4Q7LXZ1UY5X8rti4o9/t5+5XN89ya598MGzuam87DTuucqDaUaBi7hnmIr1lwVg+q6xGwr7lQBRXXPAPprPtMyHzr6gTmihRaMONr05qiv7D+TrjqjdQ/aM1g9QELgFm02RMPtdPtTWanQ4YKYViBYn9mGxkV3xOtEMm08AnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267668; c=relaxed/simple;
	bh=DeE2ACGbq72KzqysLxPXuHQEe4//m6Oifjw5h6reQeE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NTJCBAG3C4MQoxYPcbB8PcA6Cxl3X2DtLFIo42EOhQPjcoaSLAY2LEHwb9DxNdzb4h1HSxMF/Lcbkynws2s8Eu1Eu9Q6IRqqhcJVkdigASh1zTx7dWFjpyQTZj9j7Pci9QcubYYA7IC7rHmmxFr/L0z7VfjKaYCZUtI4s1p6WWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GfezLxj1; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: def011d4690911ef8b96093e013ec31c-20240902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=a8pwBEAn/PiKve4MsqUFcYOogJa73FkNa5F6NZMlHrI=;
	b=GfezLxj1BLhQFL8Tq+kgY1nedV0f5Xpz0ZUqX2339mCdYdchpswcFZziRRnzBDdC9DVNZdWNQS9680FAzoxcSF27IDQEx1hC/aJ4s1SAtWKFQFe+k+fcKOGMpYAz6bHghgixYTUflGFg+8lQ1vdT7OiTenuKF+D82V4YsZltSV0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ecd700e6-745f-42d3-a8a0-a792a504965e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:38db8dcf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: def011d4690911ef8b96093e013ec31c-20240902
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1685570361; Mon, 02 Sep 2024 17:00:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Sep 2024 17:00:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Sep 2024 17:00:58 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	<stable@vger.kernel.org>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: fix a potential association failure upon resuming
Date: Mon, 2 Sep 2024 17:00:54 +0800
Message-ID: <20240902090054.15806-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Michael Lo <michael.lo@mediatek.com>

In multi-channel scenarios, the granted channel must be aborted before
suspending. Otherwise, the firmware will be put into a wrong state,
resulting in an association failure after resuming.

With this patch, the granted channel will be aborted before suspending
if necessary.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c  | 15 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mt7925.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c   |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 8c0768bf9343..7c05aebd3c20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -439,6 +439,19 @@ static void mt7925_roc_iter(void *priv, u8 *mac,
 	mt7925_mcu_abort_roc(phy, &mvif->bss_conf, phy->roc_token_id);
 }
 
+void mt7925_roc_abort_sync(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		ieee80211_iterate_interfaces(mt76_hw(dev),
+					     IEEE80211_IFACE_ITER_RESUME_ALL,
+					     mt7925_roc_iter, (void *)phy);
+}
+EXPORT_SYMBOL_GPL(mt7925_roc_abort_sync);
+
 void mt7925_roc_work(struct work_struct *work)
 {
 	struct mt792x_phy *phy;
@@ -1109,6 +1122,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
 
+	mt7925_roc_abort_sync(dev);
+
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 669f3a079d04..c5ea431998e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -307,6 +307,7 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 		       enum mt7925_roc_req type, u8 token_id);
 int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 			 u8 token_id);
+void mt7925_roc_abort_sync(struct mt792x_dev *dev);
 int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			    int cmd, int *wait_seq);
 int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 6e4f4e78c350..39305c39362f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -449,6 +449,8 @@ static int mt7925_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt7925_roc_abort_sync(dev);
+
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
 		goto restore_suspend;
-- 
2.45.2


