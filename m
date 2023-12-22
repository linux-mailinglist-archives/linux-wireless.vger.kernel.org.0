Return-Path: <linux-wireless+bounces-1211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3540981C6E7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 09:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB1FB22063
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 08:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7AFBF5;
	Fri, 22 Dec 2023 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cTRK7JC/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63FF9C8
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9edfbebca0a711eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Kh4ADFx8DyKsyheb1kxCqsOD8YqzwyrfLZNAEnzeVrQ=;
	b=cTRK7JC/TP6OE7KU4eFbkC5NoeZMhDAlJfw0e+5K68kp8GQslLlrj2d56lkZ5R3BE1+/gARSJ8cvMvMZHZR0c/QAcOLIrJiJFB4Nf12l8S2oPYN1RPDJ+cSvf7ubI+972A4pmXrfGjL46A52BnAXPf74TYbTnYNfbFOXJ+mZYVA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a55efaa0-d3f5-4ac2-8546-ec9aeb65d87f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:d24a8f7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9edfbebca0a711eeba30773df0976c77-20231222
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1416088230; Fri, 22 Dec 2023 16:53:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 16:53:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 16:53:46 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Leon Yen <leon.yen@mediatek.com>
Subject: [PATCH v1 3/4] wifi: mt76: mt792x: update the country list of EU for ACPI SAR
Date: Fri, 22 Dec 2023 16:53:37 +0800
Message-ID: <20231222085338.4530-4-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231222085338.4530-1-mingyen.hsieh@mediatek.com>
References: <20231222085338.4530-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.860300-8.000000
X-TMASE-MatchedRID: VZuxIYcieyyaOlY3WxOn56+dYEguu4aVQl/FdRYkUZKcbyawsiRjd6PF
	jJEFr+olwXCBO/GKkVr3FLeZXNZS4IzHo47z5Aa+cwtUq/gdOcbwxZn5SZV9DgKZS1JL1tAkTk1
	GBFvYVW1Yrf8u8Zq9GO0beEAOU2XCcmRZviJrho/obQWp6Rpd/QcKyX9nDkfBeZUpm6wun3ba/0
	6NhYDa4wyzCDjlUx89p2y3mIB+it9WXGvUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.860300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 937F82216C4683102AF37373C5463ED00BFE8F9F487D4C97ACC41EE3825D52712000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

This patch updates the EU country list to ensure the MTCL table
works correctly.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
index 8fee3d481df0..571ef03cd4cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
@@ -376,7 +376,7 @@ u8 mt792x_acpi_get_mtcl_conf(struct mt792x_phy *phy, char *alpha2)
 		"AT", "BE", "BG", "CY", "CZ", "HR", "DK", "EE",
 		"FI", "FR", "DE", "GR", "HU", "IS", "IE", "IT",
 		"LV", "LI", "LT", "LU", "MT", "NL", "NO", "PL",
-		"PT", "RO", "MT", "SK", "SI", "ES", "CH",
+		"PT", "RO", "SK", "SI", "ES", "SE", "CH",
 	};
 	struct mt792x_acpi_sar *sar = phy->acpisar;
 	struct mt792x_asar_cl *cl;
-- 
2.18.0


