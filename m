Return-Path: <linux-wireless+bounces-4973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6688107E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5F61C22F12
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062CD3EA92;
	Wed, 20 Mar 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WVf+LinY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3EB3BBFA
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932975; cv=none; b=JvXemuWY1sUP24V4zwmr4Aw6jgN5oY/1D2GLedJBfmxxjWSmGHxA1rbmBJT0d+FvVz1SpEDs+sRS7oPBvGFQD/rpGq15+vTBL9h1fTciNXpUc9Eokn3pfDCDlG2BaI0w1GInFtJ3+8+jwDfVtAGIJLwumsQJkSyUENobwS+T+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932975; c=relaxed/simple;
	bh=pxn2JpJZjfmANqpg3qK4e6ve75fqii7e0BwVqLpfejg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2lnBv1qljFS/dw3Y7bp0r8k+Tp5SAP7HgfHFMx1cjnUUfOyR5n41yE7xyNAvGBeQbBo05ocVw0suVY3pHFHBTwVkw2k9egnEKQOjql9Nd37A/W3XuZWwAht8EvppTO6RnhQJNxfBR7KfzXPVI5NZPvfPzjYR4czepaiKDtattA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WVf+LinY; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4fbdf44ae6aa11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hBbJ7twBVAqDbUxIxah5SvIfVEI2z/dsLfJesl39ads=;
	b=WVf+LinYEL+VTwSien4xazawy/t+5zq9RanIL8lldCH6bd9CC5dTsrT1k4Fbyz78m+EcJedQFdrnOhgKYtTBPrpCvXZPpb5NPjr8U1/mUZ/c3F/p3guc6Fb+SrthKpjevyrFNCz7tuEK4VZeRKKTK1Lf8YkCTz3axAmrFQx6PHE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f09fc1ae-39f1-4fc9-a12e-b22d5ca56645,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:da05a090-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4fbdf44ae6aa11eeb8927bc1f75efef4-20240320
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 198148398; Wed, 20 Mar 2024 19:09:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 19:09:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 19:09:23 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 04/10] wifi: mt76: connac: enable HW CSO module for mt7996
Date: Wed, 20 Mar 2024 19:09:12 +0800
Message-ID: <20240320110918.3488-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240320110918.3488-1-shayne.chen@mediatek.com>
References: <20240320110918.3488-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.826000-8.000000
X-TMASE-MatchedRID: k3uTSxq8mZ/Lqx3pQDUvTnGBmLio+mJgrXeN27EOXQLfUZT83lbkEPq+
	JLKFEPMF4ZQqYHZtqxhXRv7QPop4cPfA/LmKnHFmogGd8wIUGILUrb18dSl4GPYpl5XkgVFjIub
	j9bOa7MttwxAO+W1YhBIuFMMW4kD5GexLvU6j8fCeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hfNj
	F5BHUO+0AQcGZiE5uGmInxkPkOlrp5XdcgEikaW7sy7EGOvZXM/bACiyJkTD8=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.826000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AE94E37B5F1E38F048B009B9F97E07BED01A57256AE23C62365BE3C61A356AB72000:8
X-MTK: N

From: Howard Hsu <howard-yh.hsu@mediatek.com>

For mt7996 chipsets, the HW CSO module can help to identify TCP traffic,
which assists the firmware in adjusting algorithms to improve overall
performance.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 657a4d1f856b..608deb47dada 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -610,6 +610,12 @@ struct sta_rec_ra_fixed {
 	u8 mmps_mode;
 } __packed;
 
+struct sta_rec_tx_proc {
+	__le16 tag;
+	__le16 len;
+	__le32 flag;
+} __packed;
+
 /* wtbl_rec */
 
 struct wtbl_req_hdr {
@@ -777,6 +783,7 @@ struct wtbl_raw {
 					 sizeof(struct sta_rec_ra_fixed) + \
 					 sizeof(struct sta_rec_he_6g_capa) + \
 					 sizeof(struct sta_rec_pn_info) + \
+					 sizeof(struct sta_rec_tx_proc) + \
 					 sizeof(struct tlv) +		\
 					 MT76_CONNAC_WTBL_UPDATE_MAX_SIZE)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ddd93ec1dddd..744156655d9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1748,6 +1748,18 @@ mt7996_mcu_sta_bfee_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	bfee->fb_identity_matrix = (nrow == 1 && tx_ant == 2);
 }
 
+static void
+mt7996_mcu_sta_tx_proc_tlv(struct sk_buff *skb)
+{
+	struct sta_rec_tx_proc *tx_proc;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_TX_PROC, sizeof(*tx_proc));
+
+	tx_proc = (struct sta_rec_tx_proc *)tlv;
+	tx_proc->flag = cpu_to_le32(0);
+}
+
 static void
 mt7996_mcu_sta_hdrt_tlv(struct mt7996_dev *dev, struct sk_buff *skb)
 {
@@ -2159,6 +2171,8 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 	/* starec hdr trans */
 	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, sta);
+	/* starec tx proc */
+	mt7996_mcu_sta_tx_proc_tlv(skb);
 
 	/* tag order is in accordance with firmware dependency. */
 	if (sta) {
-- 
2.39.2


