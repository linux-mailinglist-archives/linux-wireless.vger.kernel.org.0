Return-Path: <linux-wireless+bounces-1076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C817819B4D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0571C24FD6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325D1F5FC;
	Wed, 20 Dec 2023 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NhkpO516"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77D1DA40
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 31af968a9f1911eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yERtKqeMRnRz8EWKdpgnTZ0HdSoa6D6t6hyWkYUHSl8=;
	b=NhkpO5169CZ3gBDyflCdn3ZYRoV+C8riUyQu0sKyl/01JUD5j4YdB1gECcr/blxANGukM6VqN3z2gXC1BZGbjcM1L7UzVo0TVlseAPPad4L5qUXhhbvmSs/rVKsefqP25ss+y3xlzM2NedrmfsSwgo/VUA8YiPu++HuuL9XvGpk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:186cf09c-c3ff-413c-a971-3a1886a7c246,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:7008fa81-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 31af968a9f1911eea5db2bebc7c28f94-20231220
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 447517547; Wed, 20 Dec 2023 17:21:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 17:21:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 17:21:43 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 1/4] wifi: mt76: mt7921: fix incorrect type conversion for CLC command
Date: Wed, 20 Dec 2023 17:21:35 +0800
Message-ID: <20231220092138.12830-2-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231220092138.12830-1-mingyen.hsieh@mediatek.com>
References: <20231220092138.12830-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.267000-8.000000
X-TMASE-MatchedRID: zfURmU8ZpfG0A65es43yNsFWmsryu9ZfN/BTU5ZfZRIFi3R9x/2qQp7O
	325kkkmthleoxClEaad3ASMeJ378tBdg+HtW3bymnVTWWiNp+v9MkOX0UoduuQNBdqC0PZz4o8W
	MkQWv6iXBcIE78YqRWvcUt5lc1lLgjMejjvPkBr7gBxE/u1mqEiwnOlZD/aCzUx3FFlKt//Pssr
	Rv1LUSc8ORKiRcdxPZV6BJkTJ5zLM6JULy9tmMFNQv8m9xy61E6bVO/2eNXpp5lSmbrC6fdtr/T
	o2FgNrjDLMIOOVTHz2nbLeYgH6K31Zca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.267000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A9628858CAE42CA78503249E5CD6113C15647B1935D23998BF7B19D20005686B2000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

clc->len is defined as 32 bits in length, so it must also be
operated on with 32 bits, not 16 bits.

Fixes: fa6ad88e023d ("wifi: mt76: mt7921: fix country count limitation for CLC")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312112104.Zkc3QUHr-lkp@intel.com/
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 5fcee178b698..f1145002c900 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1271,7 +1271,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		.mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, alpha2),
 	};
 	int ret, valid_cnt = 0;
-	u16 buf_len = 0;
+	u32 buf_len = 0;
 	u8 *pos;
 
 	if (!clc)
@@ -1282,7 +1282,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 	if (mt76_find_power_limits_node(&dev->mt76))
 		req.cap |= CLC_CAP_DTS_EN;
 
-	buf_len = le16_to_cpu(clc->len) - sizeof(*clc);
+	buf_len = le32_to_cpu(clc->len) - sizeof(*clc);
 	pos = clc->data;
 	while (buf_len > 16) {
 		struct mt7921_clc_rule *rule = (struct mt7921_clc_rule *)pos;
-- 
2.18.0


