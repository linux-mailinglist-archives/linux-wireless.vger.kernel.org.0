Return-Path: <linux-wireless+bounces-2532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD1283D8D1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F9AB33172
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A1914AA8;
	Fri, 26 Jan 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LqOc2grm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926D6310F
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260201; cv=none; b=WJJKdrjL+GzKCBFGHYpxE9yScOffptHg+zdXxlYVxiF0/90jAyqFkCUM6NA3DE3G9s//mgjTvpIeWJkwDljxjJ8jTVISkjzO+AibRqusgJpuANi/c11xui0w14/xdfuUmUz5Uft+pKGDwQ8dJpFGSCfigYhl83Ro3ETNEuFq8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260201; c=relaxed/simple;
	bh=6138irgpa4o4kmzoz9y2IFLVRkBSqve99R2TqzlX/fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx6vXhH6HEWaT9o6p8ZnNpa56l0FRQvVoUw4zhMn9Hd8WJXmlh5KQ10U9R7cAF8Mhj7L2u6sPyy3yDzeN9IWAw/dNR/LHz3nXeuUz2rorfbLB/6jsFT1QQUicKfksj4E1aIupQyHrR44+Pte6OwNu+ygh6itpg5vL/AvPohBvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LqOc2grm; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a8976ce0bc2a11ee9e680517dc993faa-20240126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TvxIW4C14aJXWPt/ZgsY7E7tG7QflT4efJyySE1EjY0=;
	b=LqOc2grmVNfpM9jlygrQQbmqRD8Mh9N8SZMm1crqlndynqvwVtCAH549f7zcU47kzxdvTnBlghH3ZHN/egAVD8TLHyA96dKs781Kpl/TKEPW2MAQrDlKAqOlqZgAabP+jhJ0v2T+xV/4uMLGDGEZnppXb0Z/MjRvPcB7B+7MAdE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:fb58e67b-4b1e-4507-bd6d-97e9317ec50e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:146f2efe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8976ce0bc2a11ee9e680517dc993faa-20240126
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1846573432; Fri, 26 Jan 2024 17:09:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 Jan 2024 17:09:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Jan 2024 17:09:49 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 02/12] wifi: mt76: mt7996: fix TWT issues
Date: Fri, 26 Jan 2024 17:09:13 +0800
Message-ID: <20240126090923.6357-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240126090923.6357-1-shayne.chen@mediatek.com>
References: <20240126090923.6357-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

This patch fixes the following TWT issues:
- Change table_mask to u16 to support up to 16 TWT stations
- Reject TWT flows for duplicated establishment
- Fix possible unaligned pointer
- Remove unsupported TWT_CONTROL_WAKE_DUR_UNIT flag
- The minimum TWT duration supported by mt7996 chipsets is 64. Reply
  with TWT_SETUP_CMD_DICTATE if the min_twt_dur is smaller than 64

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 53 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +-
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index a8414fbb07c8..63d34844c122 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2530,6 +2530,34 @@ static int mt7996_mac_check_twt_req(struct ieee80211_twt_setup *twt)
 	return 0;
 }
 
+static bool
+mt7996_mac_twt_param_equal(struct mt7996_sta *msta,
+			   struct ieee80211_twt_params *twt_agrt)
+{
+	u16 type = le16_to_cpu(twt_agrt->req_type);
+	u8 exp;
+	int i;
+
+	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, type);
+	for (i = 0; i < MT7996_MAX_STA_TWT_AGRT; i++) {
+		struct mt7996_twt_flow *f;
+
+		if (!(msta->twt.flowid_mask & BIT(i)))
+			continue;
+
+		f = &msta->twt.flow[i];
+		if (f->duration == twt_agrt->min_twt_dur &&
+		    f->mantissa == twt_agrt->mantissa &&
+		    f->exp == exp &&
+		    f->protection == !!(type & IEEE80211_TWT_REQTYPE_PROTECTION) &&
+		    f->flowtype == !!(type & IEEE80211_TWT_REQTYPE_FLOWTYPE) &&
+		    f->trigger == !!(type & IEEE80211_TWT_REQTYPE_TRIGGER))
+			return true;
+	}
+
+	return false;
+}
+
 void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 			      struct ieee80211_sta *sta,
 			      struct ieee80211_twt_setup *twt)
@@ -2541,8 +2569,7 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	enum ieee80211_twt_setup_cmd sta_setup_cmd;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_twt_flow *flow;
-	int flowid, table_id;
-	u8 exp;
+	u8 flowid, table_id, exp;
 
 	if (mt7996_mac_check_twt_req(twt))
 		goto out;
@@ -2555,9 +2582,19 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	if (hweight8(msta->twt.flowid_mask) == ARRAY_SIZE(msta->twt.flow))
 		goto unlock;
 
+	if (twt_agrt->min_twt_dur < MT7996_MIN_TWT_DUR) {
+		setup_cmd = TWT_SETUP_CMD_DICTATE;
+		twt_agrt->min_twt_dur = MT7996_MIN_TWT_DUR;
+		goto unlock;
+	}
+
+	if (mt7996_mac_twt_param_equal(msta, twt_agrt))
+		goto unlock;
+
 	flowid = ffs(~msta->twt.flowid_mask) - 1;
-	le16p_replace_bits(&twt_agrt->req_type, flowid,
-			   IEEE80211_TWT_REQTYPE_FLOWID);
+	twt_agrt->req_type &= ~cpu_to_le16(IEEE80211_TWT_REQTYPE_FLOWID);
+	twt_agrt->req_type |= le16_encode_bits(flowid,
+					       IEEE80211_TWT_REQTYPE_FLOWID);
 
 	table_id = ffs(~dev->twt.table_mask) - 1;
 	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, req_type);
@@ -2604,10 +2641,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 unlock:
 	mutex_unlock(&dev->mt76.mutex);
 out:
-	le16p_replace_bits(&twt_agrt->req_type, setup_cmd,
-			   IEEE80211_TWT_REQTYPE_SETUP_CMD);
-	twt->control = (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT) |
-		       (twt->control & IEEE80211_TWT_CONTROL_RX_DISABLED);
+	twt_agrt->req_type &= ~cpu_to_le16(IEEE80211_TWT_REQTYPE_SETUP_CMD);
+	twt_agrt->req_type |=
+		le16_encode_bits(setup_cmd, IEEE80211_TWT_REQTYPE_SETUP_CMD);
+	twt->control = twt->control & IEEE80211_TWT_CONTROL_RX_DISABLED;
 }
 
 void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index bc73bcb47bf0..8154ad37827f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -53,6 +53,7 @@
 
 #define MT7996_MAX_TWT_AGRT		16
 #define MT7996_MAX_STA_TWT_AGRT		8
+#define MT7996_MIN_TWT_DUR		64
 #define MT7996_MAX_QUEUE		(__MT_RXQ_MAX +	__MT_MCUQ_MAX + 3)
 
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
@@ -320,7 +321,7 @@ struct mt7996_dev {
 	struct rchan *relay_fwlog;
 
 	struct {
-		u8 table_mask;
+		u16 table_mask;
 		u8 n_agrt;
 	} twt;
 
-- 
2.39.2


