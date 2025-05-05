Return-Path: <linux-wireless+bounces-22643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDD6AAB788
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 08:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D11A3A6989
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2548350D;
	Tue,  6 May 2025 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIk16YJs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66C39B0BE;
	Mon,  5 May 2025 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486848; cv=none; b=Dzi/oL0+sLIx7EJcFMggS24Ft+fNpu2SeEAhscsqtiubV0wn3wREubtlwRdlqsdrdsFyI43rURWLtsnaiK52PgXEQqSj49ZmmpMXwApLYLJaKYEsBnecHIuOO6ww+4LN5Lv80K00IMdQIoey/GN4G/xRy7VJdXZQQBsGzFyoDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486848; c=relaxed/simple;
	bh=rH6Xn0SJcQS1MM/vS4ASPbuFDq59MeY/FWg+wOEC1RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRbApnfZGnW1muRW0WfNr55CqGaJXO2/HWDOrHQCobv1rRNxp+AqQ22Dk/DiBFNWkZ0/06TkrIDXm6krNQjsSqmCFr7R3QvLO8p9M3eo7ZfM/R/wq/dOvRyCS6DdH1Ea6EMTdRcY0fedDy9gkRky8xb6dbl4eqHS7QK9qQVXI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIk16YJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74B2C4CEE4;
	Mon,  5 May 2025 23:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486848;
	bh=rH6Xn0SJcQS1MM/vS4ASPbuFDq59MeY/FWg+wOEC1RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIk16YJswGjq1qMnjHdWrN2xOq2mqN9d7U2mcmuWcmxeWVwSiyCQEeozFhp12A1Fb
	 5Amj0UBnimpgbzpgIh9Z5mP1Ww4jfGUnUn4f9gSycpuk1ED6LMlRbdvrb0AyF2Wdwu
	 /9Un/9K0fskxMvrkJIztmRPKFUkWCXMhsphegKiFZ1CbdKMa1Bzt3wRN/BCybiWceO
	 +CzPVkVlXEGtRrm04zAxFzF21fko7EUK5UTqqVeO0ii3nBzjwHolIxX029sa+OSrF/
	 3wbzp9tbbzrgSpSbkbRRl6Ca6RVnqzpc/J7KwHlZXCynUAUmUbPjJhrs5VxCxbieCp
	 ezcniWV/rJptQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	edumazet@google.com,
	kuba@kernel.org,
	johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	miriam.rachel.korenblit@intel.com,
	uwu@icenowy.me,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 021/153] wifi: mt76: only mark tx-status-failed frames as ACKed on mt76x0/2
Date: Mon,  5 May 2025 19:11:08 -0400
Message-Id: <20250505231320.2695319-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 0c5a89ceddc1728a40cb3313948401dd70e3c649 ]

The interrupt status polling is unreliable, which can cause status events
to get lost. On all newer chips, txs-timeout is an indication that the
packet was either never sent, or never acked.
Fixes issues with inactivity polling.

Link: https://patch.msgid.link/20250311103646.43346-6-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h       | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/tx.c         | 3 ++-
 6 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 27f04fb2796d7..5a90fa556203f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -345,6 +345,7 @@ struct mt76_hw_cap {
 #define MT_DRV_RX_DMA_HDR		BIT(3)
 #define MT_DRV_HW_MGMT_TXQ		BIT(4)
 #define MT_DRV_AMSDU_OFFLOAD		BIT(5)
+#define MT_DRV_IGNORE_TXS_FAILED	BIT(6)
 
 struct mt76_driver_ops {
 	u32 drv_flags;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index b795e7245c075..3255f9c0ef71f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -151,7 +151,8 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = sizeof(struct mt76x02_txwi),
 		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS |
-			     MT_DRV_SW_RX_AIRTIME,
+			     MT_DRV_SW_RX_AIRTIME |
+			     MT_DRV_IGNORE_TXS_FAILED,
 		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index f2b2fa7338457..7a4d62bff28ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -209,7 +209,8 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 			 const struct usb_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
-		.drv_flags = MT_DRV_SW_RX_AIRTIME,
+		.drv_flags = MT_DRV_SW_RX_AIRTIME |
+			     MT_DRV_IGNORE_TXS_FAILED,
 		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 5cd0379d86de8..4e369bd87c900 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -22,7 +22,8 @@ mt76x2e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = sizeof(struct mt76x02_txwi),
 		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS |
-			     MT_DRV_SW_RX_AIRTIME,
+			     MT_DRV_SW_RX_AIRTIME |
+			     MT_DRV_IGNORE_TXS_FAILED,
 		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 9369515f36a3a..09b01e09bcfe0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -29,7 +29,8 @@ static int mt76x2u_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
-		.drv_flags = MT_DRV_SW_RX_AIRTIME,
+		.drv_flags = MT_DRV_SW_RX_AIRTIME |
+			     MT_DRV_IGNORE_TXS_FAILED,
 		.survey_flags = SURVEY_INFO_TIME_TX,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 134a735a06329..3fbf0153d13ca 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -93,7 +93,8 @@ __mt76_tx_status_skb_done(struct mt76_dev *dev, struct sk_buff *skb, u8 flags,
 	__skb_unlink(skb, &dev->status_list);
 
 	/* Tx status can be unreliable. if it fails, mark the frame as ACKed */
-	if (flags & MT_TX_CB_TXS_FAILED) {
+	if (flags & MT_TX_CB_TXS_FAILED &&
+	    (dev->drv->drv_flags & MT_DRV_IGNORE_TXS_FAILED)) {
 		info->status.rates[0].count = 0;
 		info->status.rates[0].idx = -1;
 		info->flags |= IEEE80211_TX_STAT_ACK;
-- 
2.39.5


