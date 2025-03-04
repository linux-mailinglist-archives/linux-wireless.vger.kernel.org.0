Return-Path: <linux-wireless+bounces-19738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F79A4D3E0
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 07:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7250718942B3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 06:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAF1F5424;
	Tue,  4 Mar 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NIYnj+H+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED441F4CA2
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069767; cv=none; b=AOUORDFL60QN3xPue3iVjBwDQku8tyrwJk/EtZHuVzsyUwPm09C2PQfU38hyJSzWNkNXQ0ELeTXRXTeWywgoPBocN+Ui1f9YjEwXqKSkCtkG7pcWqX1r+q/QvG7uuIka3JuOtH3PwJaGKuLeXS7H4+al0rmOvjU09EWANz6K444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069767; c=relaxed/simple;
	bh=8gldDFQ/10N/C8mqj9xFISn4aRowSxmxy7v2YGLvYTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9BHYq7IR7E9MltHORcESMm3RUPqG+9o1dgUCCsrPLllmrlZrjU/S+NLmwot1MA9cAIuNPKZa3bjQkf9gL71GBRtJkSCsY35ZWwDX0I4mevmd3YgE4ffgYpmYEChwbqvoccERJI6EUoyRZV4Bo6jgkHVnEt+8DLBHqjn5V5+5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NIYnj+H+; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ffa8b8b6f8c111efaae1fd9735fae912-20250304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=j/HVpDGzBXQjJv2bGOxwfmi6+FyWhwo+vM7BJywrBb0=;
	b=NIYnj+H+0Sf4r5gnE3cEex7qZVWuCLvrqFS6tnxV3cQjtaLzWjakjp4K0HjyymNYX3KUvu401TCsWSx1Z15qA/kt+vH2TWYhsYTyUAniH09hSBwQ8OM3E1vYiOQXMlOBqTuoPFtNScK4knbxY+DfvOGsC0kEDLXBhryNiyWpgnM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:9029db37-6d13-480c-9229-3083e9ea762c,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:cfa11e03-a373-400e-87fc-32443f153737,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ffa8b8b6f8c111efaae1fd9735fae912-20250304
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1702792017; Tue, 04 Mar 2025 14:29:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Mar 2025 14:29:16 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 4 Mar 2025 14:29:16 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH v2 3/6] wifi: mt76: mt7925: update the channel usage when the regd domain changed
Date: Tue, 4 Mar 2025 14:28:51 +0800
Message-ID: <20250304062854.829194-3-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The 5.9/6GHz channel license of a certain platform device has been
regulated in various countries. That may be difference with standard Liunx
regulatory domain settings. In this case, when .reg_notifier() called for
regulatory change, mt7925 chipset should update the channel usage based on
CLC data.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2: no change
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 42 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  7 +++-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  3 +-
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 94d7b762fe40..8561ab310f16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -96,15 +96,57 @@ void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2)
 	mt7925_set_stream_he_eht_caps(phy);
 }
 
+static void
+mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
+{
+#define IS_UNII_INVALID(idx, sfreq, efreq) \
+	(!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >= (sfreq) && (cfreq) <= (efreq))
+	struct ieee80211_supported_band *sband;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_channel *ch;
+	int i, cfreq;
+
+	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	if (!sband)
+		return;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+		cfreq = ch->center_freq;
+
+		/* UNII-4 */
+		if (IS_UNII_INVALID(0, 5845, 5925))
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+	}
+
+	sband = wiphy->bands[NL80211_BAND_6GHZ];
+	if (!sband)
+		return;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+		cfreq = ch->center_freq;
+
+		/* UNII-5/6/7/8 */
+		if (IS_UNII_INVALID(1, 5925, 6425) ||
+		    IS_UNII_INVALID(2, 6425, 6525) ||
+		    IS_UNII_INVALID(3, 6525, 6875) ||
+		    IS_UNII_INVALID(4, 6875, 7125))
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+	}
+}
+
 void mt7925_regd_update(struct mt792x_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	struct ieee80211_hw *hw = mdev->hw;
+	struct wiphy *wiphy = hw->wiphy;
 
 	if (!dev->regd_change)
 		return;
 
 	mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
+	mt7925_regd_channel_update(wiphy, dev);
 	mt7925_mcu_set_channel_domain(hw->priv);
 	mt7925_set_tx_sar_pwr(hw, NULL);
 	dev->regd_change = false;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index e73320c5d8c0..602ac3c31976 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -859,6 +859,7 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	int ret, i, len, offset = 0;
 	u8 *clc_base = NULL, hw_encap = 0;
 
+	dev->phy.clc_chan_conf = 0xff;
 	if (mt7925_disable_clc ||
 	    mt76_is_usb(&dev->mt76))
 		return 0;
@@ -3428,6 +3429,7 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 	if (!clc)
 		return 0;
 
+	req.ver = clc->ver;
 	pos = clc->data + sizeof(*seg) * clc->t0.nr_seg;
 	last_pos = clc->data + le32_to_cpu(*(__le32 *)(clc->data + 4));
 	while (pos < last_pos) {
@@ -3445,6 +3447,7 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		memcpy(req.type, rule->type, 2);
 
 		req.size = cpu_to_le16(seg->len);
+		dev->phy.clc_chan_conf = clc->ver == 1 ? 0xff : rule->flag;
 		skb = __mt76_mcu_msg_alloc(&dev->mt76, &req,
 					   le16_to_cpu(req.size) + sizeof(req),
 					   sizeof(req), GFP_KERNEL);
@@ -3460,8 +3463,10 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		valid_cnt++;
 	}
 
-	if (!valid_cnt)
+	if (!valid_cnt) {
+		dev->phy.clc_chan_conf = 0xff;
 		return -ENOENT;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index e6ca9021f487..71811734592c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -147,7 +147,8 @@ struct mt7925_clc_rule {
 	u8 alpha2[2];
 	u8 type[2];
 	u8 seg_idx;
-	u8 rsv[3];
+	u8 flag; /* UNII4~8 ctrl flag */
+	u8 rsv[2];
 } __packed;
 
 struct mt7925_clc_segment {
-- 
2.34.1


