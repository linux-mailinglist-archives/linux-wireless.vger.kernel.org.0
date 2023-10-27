Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D87D9B40
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbjJ0OXc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345738AbjJ0OXb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 10:23:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C481187
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 07:23:22 -0700 (PDT)
X-UUID: 5fb43c9e74d411eea33bb35ae8d461a2-20231027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vcDrZzaMTeW3MiV5yhk9Ro3SKcVOc+eJXb6PH5a7FNA=;
        b=pzif4YlSPXbK66ENWjzdcQKKJ46YfBgaUJnpeApSO63Ica5rpRIPO22kmRT0k/AEeseCJXxz5DJGoWuwgZdt8bL0rzVtSRMVUizRVZTc4BdnLDPU9Bub6hdVr3S8GYEtKebaZd9G8PtWvzMKxlBcVk63H1rn3y66vLZm0YqaRlQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:cbb1f759-9c1a-46f8-9006-0f49721466e7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:dfd5f971-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 5fb43c9e74d411eea33bb35ae8d461a2-20231027
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1346552869; Fri, 27 Oct 2023 22:23:18 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Oct 2023 22:23:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Oct 2023 22:23:17 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Kalle Valo" <kvalo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [next] wifi: mt76: mt7921: fix the missing default CLC channel config value
Date:   Fri, 27 Oct 2023 22:22:43 +0800
Message-ID: <3c03260707034f997864c20d7f77f88c6e24e56b.1698415301.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.451800-8.000000
X-TMASE-MatchedRID: +aPT1BniHkxPwhYh7WurQ23NvezwBrVmWDLajM22ETbxxaAXDrCns6vW
        9qD1DQeTjwQarLbSitSx8xfnDVGMQyZywmJvYiNpA9lly13c/gERWG8HyxfLI7lmMfLNiuka0p6
        6g4/WVuhP7yM7bfVWWIAy6p60ZV62fJ5/bZ6npdjKayT/BQTiGu5+4KX96PVEK6DfNkvIv+YytG
        HO66XW3QLaqW/p/SSDjDfWgUD8xCZqgCmb2XIMHXFha5mJQS63DKW6jJ2i0UOHacorxE7l9sn2W
        lhAdnbBdATQdtPksR+3/JiWOe6GXXSWgQ2GpXdZbxffl9hhCBw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.451800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DC85E81DB92A109DB74E891CEF1C774BE3F517E1A5765F28A6534F3F177E49652000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

No matter CLC is enabled or disabled, the driver should initialize
the default value for channel configuration of CLC.

Reported-and-tested-by: Ben Greear <greearb@candelatech.com>
Closes: https://lore.kernel.org/all/2fb78387-d226-3193-8ca7-90040561b9ad@candelatech.com/
Fixes: 09382d8f8641 ("mt7921: update the channel usage when the regd domain changed")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 63f3d4a5c9aa..2cc2d2788f83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -375,6 +375,7 @@ static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	int ret, i, len, offset = 0;
 	u8 *clc_base = NULL, hw_encap = 0;
 
+	dev->phy.clc_chan_conf = 0xff;
 	if (mt7921_disable_clc ||
 	    mt76_is_usb(&dev->mt76))
 		return 0;
-- 
2.18.0

