Return-Path: <linux-wireless+bounces-10010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C5928301
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 09:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4A51F248F3
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025CE145320;
	Fri,  5 Jul 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bwjoGfPL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209EC14532A
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165438; cv=none; b=aMxFMHvI813m91mcipbkP6S/D0AYnSaf9yacjuFmO4fqw759Xsh/RPkqob1X6UAlD5crhpV9f9WPmC8qACiw/nSFctKEh42iE06g7YFLm3FC0mVCwiE6W3fY3NvhwI1Kcm08vUs5Kryqv4GkmYdVmkAOqfhRNaoDhDI33G+m3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165438; c=relaxed/simple;
	bh=iyxcPHwM6gIbLH6IPwB1eMeKEXyJoS4tT6ywnJla0zE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FgqhyG3043immCs1p30n9CcHg9bnH2KiYRqq15nDzl78ErP7me5/MMuQgFa4a/zvsuBf+AiksEBJDWpdFHXaeCZ05ht/dTBPP6gkNT18Ldj8XMZq4fa4/OXTfm8DQ+VG/zr8Xq3eRUU4kwzAP2MkAswH6P06t5x/0ClXafvtpUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bwjoGfPL; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5296ce983aa211ef8b8f29950b90a568-20240705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+Genc6bw8EEUj5p6mEyYsPrW+rddwzOEpICsPZD+xTQ=;
	b=bwjoGfPL9yTThfu/BMQrX/7TZyznst4ipScPeXv0zLJ1BWPDn5MDSwDHk0qkq2lt7GK0WlvWuIfzenKcBKGZu7UaLeTlJzbUkcUZpez8ps2t3OgT4TxtUdrMo+A8aXRz7BQIVe20IW8a1mlNjrhgIdNsWkkQ0ChWV/qUX21hP0k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:ab67393f-4c17-4458-b6aa-b7f5f34fe9a9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:d1de190d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5296ce983aa211ef8b8f29950b90a568-20240705
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1225494349; Fri, 05 Jul 2024 15:43:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Jul 2024 15:43:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Jul 2024 15:43:51 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: do not check BSS color collision in certain cases
Date: Fri, 5 Jul 2024 15:43:46 +0800
Message-ID: <20240705074346.11228-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Do not check BSS color collision in following cases
1. already under a color change
2. color change is disabled

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
 net/mac80211/rx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0ff9062a130c..59ad24a71141 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3358,6 +3358,7 @@ static void
 ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_mgmt *mgmt = (void *)rx->skb->data;
+	struct ieee80211_bss_conf *bss_conf;
 	const struct element *ie;
 	size_t baselen;
 
@@ -3368,7 +3369,9 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 	if (ieee80211_hw_check(&rx->local->hw, DETECTS_COLOR_COLLISION))
 		return;
 
-	if (rx->link->conf->csa_active)
+	bss_conf = rx->link->conf;
+	if (bss_conf->csa_active || bss_conf->color_change_active ||
+	    !bss_conf->he_bss_color.enabled)
 		return;
 
 	baselen = mgmt->u.beacon.variable - rx->skb->data;
@@ -3380,7 +3383,6 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 				    rx->skb->len - baselen);
 	if (ie && ie->datalen >= sizeof(struct ieee80211_he_operation) &&
 	    ie->datalen >= ieee80211_he_oper_size(ie->data + 1)) {
-		struct ieee80211_bss_conf *bss_conf = rx->link->conf;
 		const struct ieee80211_he_operation *he_oper;
 		u8 color;
 
-- 
2.25.1


