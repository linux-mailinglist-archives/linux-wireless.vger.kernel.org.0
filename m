Return-Path: <linux-wireless+bounces-1187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A981C293
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 02:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556C01C221CA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 01:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35538A31;
	Fri, 22 Dec 2023 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JDikRr89"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83027631
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c2fa6306a06611eea5db2bebc7c28f94-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GlqYnIl/pPeOM+Is0rIMjAHas0xJUlaFyJhYmZfymUo=;
	b=JDikRr89UBgNzSJdwW/NfAEMvfIbWlprmh+EDztqBdfdIOO0Zn4RYnhYGqauAIFzA1YlkQ0yLG+uikyM+LFiP8f08DEIzfnhxB5NzAekE2/fxfz/geXc76h8LtlYoWDGYHo4RK+WPnPk/zTz4ZIhHgTNzqFcxmQo0Qu7+o+H0sM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:df52e939-01b3-4572-9c1a-1d62a4d595fe,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ac42718d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c2fa6306a06611eea5db2bebc7c28f94-20231222
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 666126168; Fri, 22 Dec 2023 09:09:31 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 09:09:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 09:09:30 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [v4,0/2] wifi: mac80211: refactor STA CSA parsing flows
Date: Fri, 22 Dec 2023 09:09:12 +0800
Message-ID: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.297500-8.000000
X-TMASE-MatchedRID: kDnsWQ7qnraLwgJA7qJvFHW+ghheMOWfsf4f4CxxueQ3DLgNZ/WB37Wd
	0nDAWA79sRIB98XGTDmkeU7arquyzkkjllSXrjtQFEUknJ/kEl5q8/xv2Um1avoLR4+zsDTtIAm
	DJ33CtzwMIaxbNW7UOwNfbEZAfUf4zu855L2HSWraiMkgO1bzUOkbqRGVnep1dmtRsRmKkASJZP
	T2ZDPuzPD2QfzMDLjho65UufHcDvg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.297500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	EB3194B599F3B3DF333E83943D2D0CD327F2576092590A701156CD00C20C17612000:8

These patches refactor the STA CSA parsing flows and add an utility to help.

Michael-CY Lee (2):
  wifi: mac80211: Add utility for converting op_class into chandef
  wifi: mac80211: refactor STA CSA parsing flows

 include/net/cfg80211.h   |  13 ++
 net/mac80211/spectmgmt.c | 302 ++++++++++++++++++++++++++++++++-------
 net/wireless/util.c      |  76 ++++++++++
 3 files changed, 338 insertions(+), 53 deletions(-)

-- 
2.25.1


