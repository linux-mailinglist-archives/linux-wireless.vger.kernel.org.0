Return-Path: <linux-wireless+bounces-19756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D4A4DCB9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 12:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6371888D66
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 11:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713982010F2;
	Tue,  4 Mar 2025 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EGc77Gjm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840101FF5FB
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088223; cv=none; b=SwagHTVJ32RwdPCJZcOzmUwYd8E1jFiR5UPr5CQe+wkkYLtZDcBFw/IDOj0ZhIOvP3l4WBkAwEA7ULTmAJXbuvzQ9ykbdidprNAIsR/uZvkpDIo2rPkLEMG3dDnMlJYr6YKBPSCGnKGqeJEO7sx1rkfuLu0FlvbC2p4H1WckJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088223; c=relaxed/simple;
	bh=LUL+zi1e+DHyh6WIspClWRdPdMyKUqzp00002cyQr5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1V+8TPGckjWLjb+rdCCr8j4bhtwxzPv1lcUP39abGdUaKWtLBaWoxRegIixRkvYbAoZ6A3PtUtcWTPN/q7jQ/xK4MpsHfHc4NXXKecbSYRd5IzraAcGHcPeyNpwPW0gJfytgGYiTkZXxki6xDPQ8GaOFtjty+ZhIpdlNEhmpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EGc77Gjm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f90e0e0ef8ec11ef8eb9c36241bbb6fb-20250304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ycXlnJNZ+hOskg077ndwabkHrdXAdladLvcHCUqIBI8=;
	b=EGc77GjmUYcgIJUMwe3qtk46jQvqWKrhbEgCqb3gkAyjCPkT8QPTYA6nD891Rh+P0ytafJ7IMXhjD9uTjQIxipugEa7/PyNg8nwjvvmPpeCTD/brSCZs+cs92k2C4N6Z4uspbLbCiKU9ThHKJwLYJInXn8mUvcp3IujKReu6HqI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:bf22acba-c438-4202-ba6f-dc9d95bc0136,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:ab2a2203-a373-400e-87fc-32443f153737,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f90e0e0ef8ec11ef8eb9c36241bbb6fb-20250304
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 866516628; Tue, 04 Mar 2025 19:36:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Mar 2025 19:36:53 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 4 Mar 2025 19:36:53 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH v3 3/6] wifi: mt76: mt7925: update the channel usage when the regd domain changed
Date: Tue, 4 Mar 2025 19:36:46 +0800
Message-ID: <20250304113649.867387-3-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304113649.867387-1-mingyen.hsieh@mediatek.com>
References: <20250304113649.867387-1-mingyen.hsieh@mediatek.com>
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
v3: add the cfreg as an argument of macro
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 40 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  7 +++-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  3 +-
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 94d7b762fe40..fa8d051a66d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -96,15 +96,55 @@ void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2)
 	mt7925_set_stream_he_eht_caps(phy);
 }
 
+static void
+mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
+{
+#define IS_UNII_INVALID(idx, sfreq, efreq, cfreq) \
+	(!(dev->phy.clc_chan_conf & BIT(idx)) && (cfreq) >= (sfreq) && (cfreq) <= (efreq))
+	struct ieee80211_supported_band *sband;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_channel *ch;
+	int i;
+
+	sband = wiphy->bands[NL80211_BAND_5GHZ];
+	if (!sband)
+		return;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		/* UNII-4 */
+		if (IS_UNII_INVALID(0, 5845, 5925, ch->center_freq))
+			ch->flags |= IEEE80211_CHAN_DISABLED;
+	}
+
+	sband = wiphy->bands[NL80211_BAND_6GHZ];
+	if (!sband)
+		return;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		/* UNII-5/6/7/8 */
+		if (IS_UNII_INVALID(1, 5925, 6425, ch->center_freq) ||
+		    IS_UNII_INVALID(2, 6425, 6525, ch->center_freq) ||
+		    IS_UNII_INVALID(3, 6525, 6875, ch->center_freq) ||
+		    IS_UNII_INVALID(4, 6875, 7125, ch->center_freq))
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
index cc71a6b722f4..53c67364fac6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -859,6 +859,7 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	u8 *clc_base = NULL, hw_encap = 0;
 	int ret, i, len, offset = 0;
 
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


