Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA87F13A1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 13:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjKTMkD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 07:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjKTMkC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 07:40:02 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED80DD2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 04:39:54 -0800 (PST)
X-UUID: e42811fa87a111ee8051498923ad61e6-20231120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dQxfV4jO6ePUHsnT7XPjjP6N7wmLBNar3vK44FxCzRk=;
        b=gG7XFOosyGmoQcO1bMG/iKdDKPAPs8Fc1EEILOCkXounJwaPWJkti8SFRK04wCd9Qinp5fBb6/JGBe9XJrtPwCBVoXL2OAPn4R56dIy0gqZ+KDtmJe4M7PuBnpB2k1YkcsSHvzPyplWOm25DNiEphPE081aDygupQ0RoxeJQOCc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:74e03c78-f30e-4585-af93-aaac17fc3c3c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:7baf9995-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e42811fa87a111ee8051498923ad61e6-20231120
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <mingyen.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 687304166; Mon, 20 Nov 2023 20:39:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 Nov 2023 20:39:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 Nov 2023 20:39:46 +0800
From:   Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo@kernel.org>
CC:     <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <Shayne.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH v3 1/3] wifi: mt76: mt7921: fix country count limitation for CLC
Date:   Mon, 20 Nov 2023 20:39:38 +0800
Message-ID: <20231120123940.5788-2-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231120123940.5788-1-mingyen.hsieh@mediatek.com>
References: <20231120123940.5788-1-mingyen.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.822100-8.000000
X-TMASE-MatchedRID: zfURmU8ZpfHhF8fPoBwQ4Eg5Iem1vm3HEjUQ5RU6WJKctWHPLT5Fff/v
        iojdMcFdjBmhBLd6Ukoug5h4T/oO1R1YpEPWJiyzuTzanbzb2FdNfj9Qwj2ifVxOQqP2lG9go8W
        MkQWv6iXBcIE78YqRWvcUt5lc1lLgjMejjvPkBr4Oct/PJ9l2ogToywNhINescFtg7YF5bTviY6
        CZjKIlg6TDmahaxtMqWHFJjGhOqKpumnS3/t4RXKlH6V73nngOnuL8Gnx9ALN5lSmbrC6fdtr/T
        o2FgNrjDLMIOOVTHz2nbLeYgH6K31Zca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.822100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C04D2D3096E42D5C88866C5FABD927ABA518B963E3949FF4A0F820632C9DFBC12000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Due to the increase in the number of power tables on CLC, the variable
nr_country is no longer sufficient to represent the total quantity.
Therefore, we have switched to calculating the length of clc buf to
obtain the correct power table. Additionally, the version number has
been incremented to 1.

Fixes: 23bdc5d8cadf ("wifi: mt76: mt7921: introduce Country Location Control support")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

v2:
  - Convert type of buf_len from "__le16" to "u16".

---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 753a4fc45c70..36ac004e1ec9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1264,6 +1264,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		u8 mtcl_conf;
 		u8 rsvd[62];
 	} __packed req = {
+		.ver = 1,
 		.idx = idx,
 		.env = env_cap,
 		.env_6g = dev->phy.power_type,
@@ -1271,7 +1272,8 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		.mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, alpha2),
 	};
 	int ret, valid_cnt = 0;
-	u8 i, *pos;
+	u16 buf_len = 0;
+	u8 *pos;
 
 	if (!clc)
 		return 0;
@@ -1281,12 +1283,15 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 	if (mt76_find_power_limits_node(&dev->mt76))
 		req.cap |= CLC_CAP_DTS_EN;
 
+	buf_len = le16_to_cpu(clc->len) - sizeof(*clc);
 	pos = clc->data;
-	for (i = 0; i < clc->nr_country; i++) {
+	while (buf_len > 16) {
 		struct mt7921_clc_rule *rule = (struct mt7921_clc_rule *)pos;
 		u16 len = le16_to_cpu(rule->len);
+		u16 offset = len + sizeof(*rule);
 
-		pos += len + sizeof(*rule);
+		pos += offset;
+		buf_len -= offset;
 		if (rule->alpha2[0] != alpha2[0] ||
 		    rule->alpha2[1] != alpha2[1])
 			continue;
-- 
2.18.0

