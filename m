Return-Path: <linux-wireless+bounces-24762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DDEAF122D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 12:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0879525873
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43E255F26;
	Wed,  2 Jul 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mvqlbPMl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0789A211F
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453065; cv=none; b=mdp1hv5ht91A+7rS2kYI94SOyQAKW+6HsEBGrtbi9zaXxFxWyxyBtDqBil2FtW1pwjezBZaGFMrPnFQqZo6po5Hh4T5f14nGRiO9lzsdfSNtcJuEVzm+kSQTufdPf29oOOG6mSfFBBFhF99ZZHzTbnxb4FV31sse4/68PU2W/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453065; c=relaxed/simple;
	bh=UNOZEvdr6W/waJpgP5ZfUXBGlPbnEnBOBAzAeQowv7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j5+JK+LbzskZQ07yGRTflOP4kgsHm4+2k8Ev6mPpmAUHbZT2u8H7tFK7bYP5SF/i6pN71iSe/Fi4+poBI5n0cUiLOBgD3xG/Mbds6/YmY1w14Daf0x8k4l/wUCM4bLrjy/GWh7Rvs0jotZTgU3CqJP43oXtl0nLtxCRF11IYeFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mvqlbPMl; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7cdc80f6573111f0b33aeb1e7f16c2b6-20250702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bEVziZ0eHEerI8E7lOtKLbZkM3NzOCChhELV4G+dw0E=;
	b=mvqlbPMloW/QWGrxntG7SanN1gxOl1wKCB5/qv4Ft9bF97Dflh5CuS7ZNt7pB+7+OoDWE+tdp3pBPtHuK5VXPjC06cYVE3dA0/9HnXW33+btfNRq9jn+o3aZz0z5PiiALBbyO9CrIIdIoCaPsuB40XNVn8L0kLWPD+bEgXh6NgI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:27ac4ef9-5837-46a0-9803-f9dab8e5b904,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:7c30cd73-15a7-4ae6-ad4b-94c27b45c266,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7cdc80f6573111f0b33aeb1e7f16c2b6-20250702
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 273679900; Wed, 02 Jul 2025 18:44:10 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 2 Jul 2025 18:44:09 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 2 Jul 2025 18:44:09 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: determine missing link_id in ieee80211_rx_for_interface() based on band
Date: Wed, 2 Jul 2025 18:44:03 +0800
Message-ID: <20250702104403.2738634-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

For broadcast frames, every interface might have to process it and
therefore the link_id cannot be determined in the driver.

When the frame is about to be forwarded to each interface, we can
use the member "band" in struct ieee80211_rx_status to determine the
"link_id" for each interface.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Reviewed-by: Money Wang <money.wang@mediatek.com>
---
 net/mac80211/rx.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..7671fd39a60e 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5115,8 +5115,28 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
 		sta = sta_info_get_bss(rx->sdata, hdr->addr2);
-		if (status->link_valid)
+		if (status->link_valid) {
 			link_id = status->link_id;
+		} else if (ieee80211_vif_is_mld(&rx->sdata->vif)) {
+			struct ieee80211_supported_band *sband;
+			struct ieee80211_link_data *link;
+			int i;
+
+			for_each_valid_link(&rx->sdata->wdev, i) {
+				link = rcu_dereference(rx->sdata->link[i]);
+				if (!link)
+					continue;
+
+				sband = ieee80211_get_link_sband(link);
+				if (!sband)
+					continue;
+
+				if (status->band == sband->band) {
+					link_id = i;
+					break;
+				}
+			}
+		}
 	}
 
 	if (!ieee80211_rx_data_set_sta(rx, sta, link_id))
-- 
2.25.1


