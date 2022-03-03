Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8214CB572
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 04:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiCCD3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 22:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCCD3i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 22:29:38 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB833B
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 19:28:53 -0800 (PST)
X-UUID: 3ce70156f4284a01b6bed69a66598b55-20220303
X-UUID: 3ce70156f4284a01b6bed69a66598b55-20220303
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 613262838; Thu, 03 Mar 2022 11:28:45 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 3 Mar 2022 11:28:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Mar
 2022 11:28:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 11:28:43 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: fix monitor mode crash with sdio driver
Date:   Thu, 3 Mar 2022 11:28:40 +0800
Message-ID: <d065e4492a9e995d6ebe95c7ad8a1ec6183f56ef.1646277169.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

mt7921s driver may receive frames with fragment buffers. If there is a
CTS packet received in monitor mode, the payload is 10 bytes only and
need 6 bytes header padding after RXD buffer. However, only RXD in the
first linear buffer, if we pull buffer size RXD-size+6 bytes with
skb_pull(), that would trigger "BUG_ON(skb->len < skb->data_len)" in
__skb_pull().

To avoid the nonlinear buffer issue, enlarge the RXD size from 128 to
136 to make sure all MCU operation in linear buffer.

136 = 128 + 8
  128 : RXD size
  8   : max header padding length

[   52.007562] kernel BUG at include/linux/skbuff.h:2313!
[   52.007578] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   52.007987] pc : skb_pull+0x48/0x4c
[   52.008015] lr : mt7921_queue_rx_skb+0x494/0x890 [mt7921_common]
[   52.008361] Call trace:
[   52.008377]  skb_pull+0x48/0x4c
[   52.008400]  mt76s_net_worker+0x134/0x1b0 [mt76_sdio 35339a92c6eb7d4bbcc806a1d22f56365565135c]
[   52.008431]  __mt76_worker_fn+0xe8/0x170 [mt76 ef716597d11a77150bc07e3fdd68eeb0f9b56917]
[   52.008449]  kthread+0x148/0x3ac
[   52.008466]  ret_from_fork+0x10/0x30

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5e10fe156926..4f4ce3b3df54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -19,7 +19,8 @@
 
 #define MT_MCU_RING_SIZE	32
 #define MT_RX_BUF_SIZE		2048
-#define MT_SKB_HEAD_LEN		128
+/* 136 = 128+8. 128: RXD, 8:max header padding*/
+#define MT_SKB_HEAD_LEN		136
 
 #define MT_MAX_NON_AQL_PKT	16
 #define MT_TXQ_FREE_THR		32
-- 
2.18.0

