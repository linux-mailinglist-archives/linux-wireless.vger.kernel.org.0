Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A163992F
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Nov 2022 03:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiK0CgL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Nov 2022 21:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiK0CgJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Nov 2022 21:36:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D04014036
        for <linux-wireless@vger.kernel.org>; Sat, 26 Nov 2022 18:36:04 -0800 (PST)
X-UUID: 74369778b0744cec90efdcef5079bf94-20221127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LCg8uNrfi+Nt5wCtxaczJ1ulRIhFRn8JW66px1JD55Q=;
        b=jSGeGdStQNEo51EVJbeePGzSPJxfN7TLu9w8y/LRsQgzj1dMCpN8f79xS1toPStugQS1ZQnrjqaVGHk7veAgUincTxhq9UPSvklCTkJf54Fyr9NmK3VCZzMWcvvB6GhR6srjrFbs/75cCOLfF93l+Nm/JGmc2IuFAmDcPeSN68o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:6d293429-461e-4148-987b-7fd62a11f054,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:6d293429-461e-4148-987b-7fd62a11f054,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:b34765f9-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:2211271035580F4SB7DI,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 74369778b0744cec90efdcef5079bf94-20221127
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 454634999; Sun, 27 Nov 2022 10:35:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 27 Nov 2022 10:35:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sun, 27 Nov 2022 10:35:53 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: fix coverity overrun-call in mt76_get_txpower()
Date:   Sun, 27 Nov 2022 10:35:37 +0800
Message-ID: <6a032457ec0e4b51e649e975fa6272ad78ce4985.1669516185.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Make sure the nss is valid for nss_delta array. Return zero
if the index is invalid.

Coverity message:
Event overrun-call: Overrunning callee's array of size 4 by passing
argument "n_chains" (which evaluates to 15) in call to
"mt76_tx_power_nss_delta".
int delta = mt76_tx_power_nss_delta(n_chains);

Fixes: 07cda406308b ("mt76: fix rounding issues on converting per-chain and combined txpower")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 33f87e518d68..32a77a0ae9da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1110,8 +1110,9 @@ static inline bool mt76_is_skb_pktid(u8 pktid)
 static inline u8 mt76_tx_power_nss_delta(u8 nss)
 {
 	static const u8 nss_delta[4] = { 0, 6, 9, 12 };
+	u8 idx = nss - 1;
 
-	return nss_delta[nss - 1];
+	return (idx < ARRAY_SIZE(nss_delta)) ? nss_delta[idx] : 0;
 }
 
 static inline bool mt76_testmode_enabled(struct mt76_phy *phy)
-- 
2.18.0

