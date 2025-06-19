Return-Path: <linux-wireless+bounces-24269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 916EFAE034F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 13:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1302188598B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02D2248AC;
	Thu, 19 Jun 2025 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="laUZKVVv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F43224254
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332020; cv=none; b=TVZ5i25P4ds/7px4jsuREGg6U/5nvq0QoWjjVUhTNlECQz6KxR7JLFTPW+rrflJA7vWEzl4SdJdZyQNbjNM5EZhG/Y5yQAYup6gfO9SL+dQ6vF2YnMFa5zOq81WAvbRl1AGSKzd0RtHo3/TdX54dUQdwz+dIxmgUilpeEu05PUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332020; c=relaxed/simple;
	bh=5IRrl8wQmIlmsNGHbvVAfg5KF1cloTL8nYCSUYwQGG8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ErebhA+G7UzMtT3DjIt+bkLizxmV7K+nCPdzdmcTuqaRkXA2+wMv+owgCfbhg5PjWuAIxqWI9IrhVNgWXx0mhNSVR3leAyhZwGh+b2gMA41Dr/ScTTvEb+Q/tlTgeQiPQ8xoAzQ6NC9AQZgrxjmlHU3emvotaaHgOKXuarXqCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=laUZKVVv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5b9bfa844cff11f0b910cdf5d4d8066a-20250619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=D+CCFp+Wc7beQ37y1zJonANxhmhz8jMYorTeDhJV7TE=;
	b=laUZKVVvI0Q9v/dQsf3J5BQ1Rmd0oSJMY5HLOH7zjo4ILltKw0DeiGQ1YpBUe1/2g4w9odjjsdqFGTia0bJfKQAg/nEgpktRLvCcY52w81iJ9X/tciyXsMxJ383NRKAuTXcv8iZ0s9HMzUDJqQjHrm+42NgDPkxl9aZyU8SMVG4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:26555b1f-225a-4496-96dd-78ac90bfc381,IP:0,UR
	L:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-55
X-CID-META: VersionHash:09905cf,CLOUDID:63f4dc58-abad-4ac2-9923-3af0a8a9a079,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:2,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5b9bfa844cff11f0b910cdf5d4d8066a-20250619
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1346564004; Thu, 19 Jun 2025 19:20:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 19 Jun 2025 19:20:01 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 19 Jun 2025 19:20:05 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Leon Yen <leon.yen@mediatek.com>, "Ming
 Yen Hsieh" <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: Limit the concurrent STA and SoftAP to operate on the same channel
Date: Thu, 19 Jun 2025 19:20:05 +0800
Message-ID: <20250619112005.2071110-1-mingyen.hsieh@mediatek.com>
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

From: Leon Yen <leon.yen@mediatek.com>

Due to the lack of NoA(Notice of Absence) mechanism in SoftAP mode, it is
inappropriate to allow concurrent SoftAP and STA to operate on the
different channels.

This patch restricts the concurrent SoftAP and STA to be setup on the same
channel only.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 42 ++++++++++++++++---
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 7f572f8afc02..869fd90202b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -28,7 +28,7 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	},
 };
 
-static const struct ieee80211_iface_limit if_limits_chanctx[] = {
+static const struct ieee80211_iface_limit if_limits_chanctx_mcc[] = {
 	{
 		.max = 2,
 		.types = BIT(NL80211_IFTYPE_STATION) |
@@ -36,8 +36,7 @@ static const struct ieee80211_iface_limit if_limits_chanctx[] = {
 	},
 	{
 		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP) |
-			 BIT(NL80211_IFTYPE_P2P_GO)
+		.types = BIT(NL80211_IFTYPE_P2P_GO)
 	},
 	{
 		.max = 1,
@@ -45,16 +44,47 @@ static const struct ieee80211_iface_limit if_limits_chanctx[] = {
 	}
 };
 
-static const struct ieee80211_iface_combination if_comb_chanctx[] = {
+static const struct ieee80211_iface_combination if_comb_chanctx_mcc[] = {
 	{
-		.limits = if_limits_chanctx,
-		.n_limits = ARRAY_SIZE(if_limits_chanctx),
+		.limits = if_limits_chanctx_mcc,
+		.n_limits = ARRAY_SIZE(if_limits_chanctx_mcc),
 		.max_interfaces = 3,
 		.num_different_channels = 2,
 		.beacon_int_infra_match = false,
 	}
 };
 
+static const struct ieee80211_iface_limit if_limits_chanctx_scc[] = {
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_STATION) |
+			 BIT(NL80211_IFTYPE_P2P_CLIENT)
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP)
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_P2P_DEVICE)
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb_chanctx_scc[] = {
+	{
+		.limits = if_limits_chanctx_scc,
+		.n_limits = ARRAY_SIZE(if_limits_chanctx_scc),
+		.max_interfaces = 3,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = false,
+	}
+};
+
+static const struct ieee80211_iface_combination if_comb_chanctx[] = {
+		if_comb_chanctx_mcc[0],
+		if_comb_chanctx_scc[0],
+};
+
 void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	       struct sk_buff *skb)
 {
-- 
2.34.1


