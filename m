Return-Path: <linux-wireless+bounces-15444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A129D0A9F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 09:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5C51F2112E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28C13D502;
	Mon, 18 Nov 2024 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bs2WsHTP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C881405FB
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917310; cv=none; b=kNur1jNAsPknBHej75UCP/G9WeR/4g7xE0lexrjYa680l4O31f7G2vGhE3+SxGDTrugrbwpXJ0vb2iJe6ZWVX80w8npLf/7No1c1eryMJ3+Vv36ev9pNskObG6yfREYcsKAvfscZ2HzkxODVcj4YyZxxIckabfkustmcEIxZDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917310; c=relaxed/simple;
	bh=2JSt9Jlw7NrPjsaq3s5iFfLX5SgNGJ8eopI/H150z80=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZYpdqI3hFDHGBkN8Je6TE7w10hMEliF61TA5x92Opwz3w4LieyIFVix7LkStudVFQ37R8x1phKSmRWVs9FXRZ2PJyxg/HAU2D3I70yHgJb1Bub2GoHhg3ajFHpWf0EzWvHIDnj3JXo+nYgWq9fsBRN+1tUdvnGCPx7xkDUzEElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Bs2WsHTP; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4812afa8a58411efbd192953cf12861f-20241118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bupWu58wFlbrYCb8nodGJcVmV3Ojq4m8SJykFoWlCUo=;
	b=Bs2WsHTPQdisWU/qjcKVMacjZjEalWwVhgDIDoOsw/TTr35bRFKkLmDslr6NPMz+q4hV2IjOgcw7fgZRyhcbX6ukeZDjiEN/uxUfPC7JEhJ2JEp7AkkUZBNo2MaVE23CjjpASwMRTG91qQM0dpvWG6K9xcAvJmIHUfnVYPN6QbE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:3c86a27c-813f-488c-983a-094610abeb8e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:6f7e394f-a2ae-4b53-acd4-c3dc8f449198,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4812afa8a58411efbd192953cf12861f-20241118
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <benjamin-jw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 502221233; Mon, 18 Nov 2024 16:08:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Nov 2024 16:08:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Nov 2024 16:08:18 +0800
From: Benjamin Lin <benjamin-jw.lin@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, "Money
 Wang" <money.wang@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Benjamin Lin
	<benjamin-jw.lin@mediatek.com>
Subject: [PATCH] wifi: mac80211: fix incorrect timing to initialize station NSS capability
Date: Mon, 18 Nov 2024 16:07:22 +0800
Message-ID: <20241118080722.9603-1-benjamin-jw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.230800-8.000000
X-TMASE-MatchedRID: 439J4N2hqK3S/7ipJ1OBvPVFR4sC8dPyTJDl9FKHbrn8yBPolNpM2MPr
	YKJeXuZuuW76JsuTd2VXcbk9NdYP6o9Tk4aumaegEdFsavUQKAfJ5SXtoJPLyAHj24s7wUMNo8W
	MkQWv6iXBcIE78YqRWvcUt5lc1lLgjMejjvPkBr6/PeWIFJydjuY+W2R+jVGyN2f4SYTMagnSAl
	9/socB8nw6mE2j5X6hk8hwTGR/EFPXFyu5iuz7D7WMOxHu6tdLuTusilhZ2GR5lSmbrC6fdtr/T
	o2FgNrjDLMIOOVTHz2nbLeYgH6K31Zca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.230800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7B0B3A4090CBA7A2D500AD6C5FBB8B2633A6FC145C6DBEE76583253DD46845CC2000:8

Station's spatial streaming capability should be initialized before
handling VHT OMN, because the handling requires the capability information.

Fixes: a8bca3e9371d ("wifi: mac80211: track capability/opmode NSS separately")
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
---
 net/mac80211/cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6c0b228523cb..d58b24671a66 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1935,6 +1935,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 						    params->eht_capa_len,
 						    link_sta);
 
+	ieee80211_sta_init_nss(link_sta);
+
 	if (params->opmode_notif_used) {
 		/* returned value is only needed for rc update, but the
 		 * rc isn't initialized here yet, so ignore it
@@ -1944,8 +1946,6 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 					      sband->band);
 	}
 
-	ieee80211_sta_init_nss(link_sta);
-
 	return 0;
 }
 
-- 
2.45.2


