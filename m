Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE994B3662
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 17:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiBLQVe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 11:21:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiBLQVd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 11:21:33 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F65F181
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 08:21:25 -0800 (PST)
X-UUID: 4057c5fb5fbf4def912445fdd7f75672-20220213
X-UUID: 4057c5fb5fbf4def912445fdd7f75672-20220213
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1297560919; Sun, 13 Feb 2022 00:21:19 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 13 Feb 2022 00:21:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 13 Feb
 2022 00:21:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Feb 2022 00:21:11 +0800
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
Subject: [PATCH] mac80211: fix EAPoL rekey fail in 802.3 rx path
Date:   Sun, 13 Feb 2022 00:20:15 +0800
Message-ID: <6889c9fced5859ebb088564035f84fd0fa792a49.1644680751.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

mac80211 set capability NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211
to upper layer by default. That means we should pass EAPoL packets through
nl80211 path only, and should not send the EAPoL skb to netdevice diretly.
At the meanwhile, wpa_supplicant would not regist sock to listen EAPoL skb
on the netdevice.

However, there is no contorl_port_protocol handler in mac80211 for 802.3 RX
packets, mac80211 driver would pass up the EAPoL rekey frame to netdevice
and wpa_supplicant would be never interactive with this kind of packets,
if SUPPORTS_RX_DECAP_OFFLOAD is enabled. This causes STA always rekey fail
if EAPoL frame go through 802.3 path.

To avoid this problem, align the same process as 802.11 type to handle
this frame before put it into network stack.

Fixes: 80a915ec4427 ("mac80211: add rx decapsulation offload support")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 net/mac80211/rx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0544563ede52..57f5d5500282 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4509,12 +4509,7 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 
 	/* deliver to local stack */
 	skb->protocol = eth_type_trans(skb, fast_rx->dev);
-	memset(skb->cb, 0, sizeof(skb->cb));
-	if (rx->list)
-		list_add_tail(&skb->list, rx->list);
-	else
-		netif_receive_skb(skb);
-
+	ieee80211_deliver_skb_to_local_stack(skb, rx);
 }
 
 static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
-- 
2.18.0

