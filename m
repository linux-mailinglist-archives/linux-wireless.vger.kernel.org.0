Return-Path: <linux-wireless+bounces-4972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCC88107D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FFD1F23A48
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875E03E489;
	Wed, 20 Mar 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aoPEbMyk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF83BBCE
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932975; cv=none; b=sOmHwqmbWYHvohhSdzrIdBZ9rn24ist5eOr/5ERfARtMcUBL1vQS03BdThYnABaFGcbqENmO4I9lBwnZwCmbSOznvTjz3gJTvUQ9OoKyskBuuPglxm7JCbHIFrEiGh2t/WvyO5uIUdC56LQYXanIanU1UKjNzNOvIijvLnU7aRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932975; c=relaxed/simple;
	bh=/e2cPE4yHJQIbif2gA3VIknZO1Tg6dEI9GmssZ8Ht/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkfVDv9ciyZ2H6rV9MDoqEKQYMiJdPf3m3Ffcuj1sga1SVq7kNDLbUHcPoAXEbWT0hFtD/itUOE1A9KnGaHh3k6020PMfozFLpAWE34X8W15M4Ad2cfXp9DgQAQmNqfH73SfzV1jIfhgQw6ERVnnlWifo9zKLEcD6Sd2vCE/Go0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aoPEbMyk; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4ffdc642e6aa11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=X8ITgvAhZ8RSF+B080AMULdqxWoFzeWj5eoZVoVsg/M=;
	b=aoPEbMykvPWVYHXeTCc4G+HY/MO9cY0+E+Zu5IYwe1c9zBTDBIFIebmOfjPdTPrXjBfiAwq9cy/Wkj7XMlATiFnhIDvdnqLomcgbnpBKL0hlItOSdu2dqMXeWNeyM8G3zEGTIjn/XyDdEDc9d3BsdZlrFeN3Q8Zxn1pC8L324ns=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d06d29e5-555d-4a8a-86a9-78eaccbc5279,IP:0,U
	RL:0,TC:0,Content:19,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:19
X-CID-META: VersionHash:6f543d0,CLOUDID:a3d81d00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4ffdc642e6aa11eeb8927bc1f75efef4-20240320
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2133056185; Wed, 20 Mar 2024 19:09:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
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
	<linux-mediatek@lists.infradead.org>, Henry Yen <henry.yen@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 05/10] wifi: mt76: mt7996: fix non-main BSS no beacon issue for MBSS scenario
Date: Wed, 20 Mar 2024 19:09:13 +0800
Message-ID: <20240320110918.3488-5-shayne.chen@mediatek.com>
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
X-TM-AS-Result: No-10-1.577500-8.000000
X-TMASE-MatchedRID: uVuWzlu52RmtuHmXLC26Q0KcYi5Qw/RVVo4lwLFUdiuc6BFapCp/z1e/
	KWmAuveAIV4u8YKdeKtdPJV7o2tMJQzyMxeMEX6wFEUknJ/kEl7dB/CxWTRRu4PtEWvP7F7FE2U
	/xa551YOM/tIGy0ozX5kMJmvG7sHCNr+TKrgBJC3yPLLJKwlCvUrrG60YP2io77sCu63mYEoFb2
	esI+aqW1m+StfP/8zJgITnGkK0NFNRskXKHhdfKpij9M86UwHhsKHfMTjCprxgY1U509rkKp6oP
	1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.577500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DB7BBED5C167443EC6BD36A0ED0DAD60D12070B9A9CD921CD4CCD210DAF31ABF2000:8
X-MTK: N

From: Henry Yen <henry.yen@mediatek.com>

Do not add UNI_BSS_INFO_11V_MBSSID tag when bssid_indicator is not set
to avoid abnormal beaconing behavior in non-11v MBSS scenario.

Signed-off-by: Henry Yen <henry.yen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 744156655d9f..c4eefc593a40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -819,11 +819,14 @@ mt7996_mcu_bss_mbssid_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct bss_info_uni_mbssid *mbssid;
 	struct tlv *tlv;
 
+	if (!vif->bss_conf.bssid_indicator)
+		return;
+
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_11V_MBSSID, sizeof(*mbssid));
 
 	mbssid = (struct bss_info_uni_mbssid *)tlv;
 
-	if (enable && vif->bss_conf.bssid_indicator) {
+	if (enable) {
 		mbssid->max_indicator = vif->bss_conf.bssid_indicator;
 		mbssid->mbss_idx = vif->bss_conf.bssid_index;
 		mbssid->tx_bss_omac_idx = 0;
-- 
2.39.2


