Return-Path: <linux-wireless+bounces-2241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA84F83260F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1ECB221FD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E13928E0A;
	Fri, 19 Jan 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Uut1uEWH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946B23776
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654667; cv=none; b=i3e9JbytiaDn3s80xq29qNRxYfZjIluKIOr99DQ1688MXt4w1QlDNWnwod1XaT6Sxc7Q9sh7qtPo6VphOUqiiyidi2g/OyG9QvHINWAZmu31wYXasCTSs+JZa6uydAMenGFaz9AqDG/Zw9925Hyg2SpRLtFw5jjaF1gZ0CEiI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654667; c=relaxed/simple;
	bh=6138irgpa4o4kmzoz9y2IFLVRkBSqve99R2TqzlX/fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLKcOG4KIdkRwFAL6k/CdetwDUvvG5W9uxfYjIgFJokQgul/9iFQP9DzaNNw28e4ckwcUrsMMjIRy1bugbmL/w87NfmOb/O+PXFToU+kxAfQeKw0g/sxAqtDBGLE/xCLMuI9E9EGKd+U1Yi/ak+0+jR+xGspHIv/VQJo2M2fBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Uut1uEWH; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cacb57a4b6a811eea2298b7352fd921d-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TvxIW4C14aJXWPt/ZgsY7E7tG7QflT4efJyySE1EjY0=;
	b=Uut1uEWH/T7I5LYe4lqM0g4ug1ttTcInejz42fqqZZJeZYiuLv6nq9e0utAgvCejLXKob39gkqdaEwj+HghqfgsUFhGmEeT/ok3QaU7cm/xOyKzOCOgL4+mtAG/fLNbjWcOSRx7cOFMiZJLh67oqPU8QjI/v8ht6gNtWEBAC6d8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:a33f8920-1b80-4635-84a1-21e8880e9b00,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:49bd582f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cacb57a4b6a811eea2298b7352fd921d-20240119
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 154672047; Fri, 19 Jan 2024 16:57:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jan 2024 16:57:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jan 2024 16:57:35 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 02/12] wifi: mt76: mt7996: fix TWT issues
Date: Fri, 19 Jan 2024 16:56:58 +0800
Message-ID: <20240119085708.23592-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240119085708.23592-1-shayne.chen@mediatek.com>
References: <20240119085708.23592-1-shayne.chen@mediatek.com>
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


