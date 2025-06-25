Return-Path: <linux-wireless+bounces-24460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B42AE78DD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 09:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168E57B568E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2462120B81B;
	Wed, 25 Jun 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Egx2ojAW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA472626
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837054; cv=none; b=lKLgf4gSRLCCWW8rda/Z0bA7n1+k33jimLTIXmoDhwAcQNiiMtKlaVXs7ulujQmYqxzSJEZv2Jfh5SbUMOoI+nCeh8Uu8O0Wv73erXCogQ6ElQZduwJgW/F4UCPpMW0fpHy2W/m0fQyzbn9rka3Lowjl1lnrL4xil9haLo96Er8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837054; c=relaxed/simple;
	bh=RDhe5pJcfrR4I4/zqm+doqhfRsw/HIpxPGkf/g2+FZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KkzD26Y3u+BffsKIfDYm4qIaM5wpA/BxMT6V/Ne64ACYcXhp9txgJBlI3byNxBCg2KAXN8gYN0jgYSffTl0dlvsWND49GIDA8nrGhzmyXyknArn3GWH6Hc8wHnu4sr0RLuH3FNVCD/oYjFMCMPRr44o/M4wXE9mBVw7E82Ww3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Egx2ojAW; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3ca44860519711f0b910cdf5d4d8066a-20250625
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=OERsbOHSRXh3uYJSujNCCNFA7i+zxjD3fhY8uenqd7k=;
	b=Egx2ojAWSIp2lbty0LC50vOzp2l3oKqj3X+bR/5+8HaukdOyJ0N1Sl2F4aoNU+RAkiPNJCQv9KD6JXxU59Ata7tsdSkfQRApl4D3Lib/4jwG3oTHqMOt+GljXwwws/2le79s9YrRHO1fuQB9G6b9qUkXJBZcybWPICtvPM9Jjqk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:0729c803-437d-45fa-b1b3-610410c75d03,IP:0,UR
	L:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-55
X-CID-META: VersionHash:9eb4ff7,CLOUDID:1ecc8a14-6a0e-4a76-950f-481909c914a4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:2,IP:nil
	,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3ca44860519711f0b910cdf5d4d8066a-20250625
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1861708280; Wed, 25 Jun 2025 15:37:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 25 Jun 2025 15:37:22 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 25 Jun 2025 15:37:22 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Leon Yen <leon.yen@mediatek.com>,
	kernel test robot <lkp@intel.com>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt792x: Limit the concurrent STA and SoftAP to operate on the same channel
Date: Wed, 25 Jun 2025 15:37:20 +0800
Message-ID: <20250625073720.1385210-1-mingyen.hsieh@mediatek.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506250512.Q0I4znsF-lkp@intel.com/
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
  - add the "mt792x" tag to title
  - fix the build error for "initializer element is not a complie-time constant" issue
---
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 2224925955d0..bdb4fefc6d36 100644
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
@@ -36,8 +36,23 @@ static const struct ieee80211_iface_limit if_limits_chanctx[] = {
 	},
 	{
 		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP) |
-			 BIT(NL80211_IFTYPE_P2P_GO)
+		.types = BIT(NL80211_IFTYPE_P2P_GO)
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_P2P_DEVICE)
+	}
+};
+
+static const struct ieee80211_iface_limit if_limits_chanctx_scc[] = {
+	{
+		.max = 2,
+		.types = BIT(NL80211_IFTYPE_STATION) |
+			 BIT(NL80211_IFTYPE_P2P_CLIENT)
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP)
 	},
 	{
 		.max = 1,
@@ -47,11 +62,18 @@ static const struct ieee80211_iface_limit if_limits_chanctx[] = {
 
 static const struct ieee80211_iface_combination if_comb_chanctx[] = {
 	{
-		.limits = if_limits_chanctx,
-		.n_limits = ARRAY_SIZE(if_limits_chanctx),
+		.limits = if_limits_chanctx_mcc,
+		.n_limits = ARRAY_SIZE(if_limits_chanctx_mcc),
 		.max_interfaces = 3,
 		.num_different_channels = 2,
 		.beacon_int_infra_match = false,
+	},
+	{
+		.limits = if_limits_chanctx_scc,
+		.n_limits = ARRAY_SIZE(if_limits_chanctx_scc),
+		.max_interfaces = 3,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = false,
 	}
 };
 
-- 
2.34.1


