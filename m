Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0BE5AC626
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiIDT3m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiIDT33 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D2EBA8
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gYgaKVyiBI90mSc6lxv3ELz+4I5kkCVxXuIrJojxnts=;
        t=1662319762; x=1663529362; b=KKtijKH7Qn/OA/Bjoqn24xRZpuw2vFoO0oxG0HITkR55EGX
        JEEWQCVhGVie/2c7nltdqD69LALhoLUHt9ijTtPGtWuspDj/uaaQCpu2i0qRZAMHEW5rVUnfi/aMm
        Zf2atqCO4ZUjmivlb+a5CS6mdGDyAa+6zPCW8C0bxtV+dUy/Deg5p1NHA+Oi5GBjbEc/eIDD1kH64
        CxwCgd/vFk0c2xI9P6nHhELEGn3yj9wLi1AD7zp9O+nY1S2dt8y3WDbHbFnIPWMop+yaWaq2TFiFh
        ytopht/sIw6AK+HAFZCyQvI9wyF8/8vusiSkX7JsV2CE6Q/0gg5Fnt5tclINVFxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvJ1-007pTZ-1h;
        Sun, 04 Sep 2022 21:29:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/12] wifi: mwifiex: fix endian annotations in casts
Date:   Sun,  4 Sep 2022 21:29:09 +0200
Message-Id: <20220904212910.3f72609a3825.If4048592701bf04981be1dab18eaaa339b2ea382@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

These cause sparse warnings, and since the device generally
works in little endian we can assume the code is correct, so
just fix the casts accordingly. No binary changes on x86.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/marvell/mwifiex/usb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index c2f2ce2a3f95..d3ab9572e711 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -911,14 +911,14 @@ static int mwifiex_usb_prepare_tx_aggr_skb(struct mwifiex_adapter *adapter,
 		memcpy(payload, skb_tmp->data, skb_tmp->len);
 		if (skb_queue_empty(&port->tx_aggr.aggr_list)) {
 			/* do not padding for last packet*/
-			*(u16 *)payload = cpu_to_le16(skb_tmp->len);
-			*(u16 *)&payload[2] =
+			*(__le16 *)payload = cpu_to_le16(skb_tmp->len);
+			*(__le16 *)&payload[2] =
 				cpu_to_le16(MWIFIEX_TYPE_AGGR_DATA_V2 | 0x80);
 			skb_trim(skb_aggr, skb_aggr->len - pad);
 		} else {
 			/* add aggregation interface header */
-			*(u16 *)payload = cpu_to_le16(skb_tmp->len + pad);
-			*(u16 *)&payload[2] =
+			*(__le16 *)payload = cpu_to_le16(skb_tmp->len + pad);
+			*(__le16 *)&payload[2] =
 				cpu_to_le16(MWIFIEX_TYPE_AGGR_DATA_V2);
 		}
 
@@ -1097,9 +1097,9 @@ static int mwifiex_usb_aggr_tx_data(struct mwifiex_adapter *adapter, u8 ep,
 		}
 
 		payload = skb->data;
-		*(u16 *)&payload[2] =
+		*(__le16 *)&payload[2] =
 			cpu_to_le16(MWIFIEX_TYPE_AGGR_DATA_V2 | 0x80);
-		*(u16 *)payload = cpu_to_le16(skb->len);
+		*(__le16 *)payload = cpu_to_le16(skb->len);
 		skb_send = skb;
 		context = &port->tx_data_list[port->tx_data_ix++];
 		return mwifiex_usb_construct_send_urb(adapter, port, ep,
-- 
2.37.2

