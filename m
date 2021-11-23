Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D68645A14F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 12:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhKWLZX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 06:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbhKWLZW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 06:25:22 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43170C061714
        for <linux-wireless@vger.kernel.org>; Tue, 23 Nov 2021 03:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IZf3jOrbeCmBTSmo2tSK1OYJbWs9YSTwCQWr47+8sCU=; b=GwoYujgQlbDSIrhaQT+GVEtD4Y
        ZtFnMcjFSzkoA3hnMHblvAKKXze1elQIKY0fiwWGMAKhSaeLPxMMoW/lUx6Dj0pVPUjmI092VfJDn
        Iy3DjB9Mng4vJCcZSHvnciwV7BmiqFT25icmUA5PWA2TOlrcoYSIYghobT2Hw+xHK9yw=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mpTsJ-0006pu-D3
        for linux-wireless@vger.kernel.org; Tue, 23 Nov 2021 12:22:11 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7915: fix decap offload corner case with 4-addr VLAN frames
Date:   Tue, 23 Nov 2021 12:22:08 +0100
Message-Id: <20211123112209.71161-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With 4-address mode VLAN frames, an internal header translation step fails,
leaving behind an extra 2-byte length field that must be reomved by the driver.
Add a check for this condition to fix receiving such packets

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 0358ee71704f..6c14cb1cfd5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -749,10 +749,29 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			return -EINVAL;
 		hdr_trans = false;
 	} else {
+		int pad_start = 0;
+
 		skb_pull(skb, hdr_gap);
 		if (!hdr_trans && status->amsdu) {
-			memmove(skb->data + 2, skb->data,
-				ieee80211_get_hdrlen_from_skb(skb));
+			pad_start = ieee80211_get_hdrlen_from_skb(skb);
+		} else if (hdr_trans && (rxd2 & MT_RXD2_NORMAL_HDR_TRANS_ERROR)) {
+			/*
+			 * When header translation failure is indicated,
+			 * the hardware will insert an extra 2-byte field
+			 * containing the data length after the protocol
+			 * type field.
+			 */
+			pad_start = 12;
+			if (get_unaligned_be16(skb->data + pad_start) == ETH_P_8021Q)
+				pad_start += 4;
+
+			if (get_unaligned_be16(skb->data + pad_start) !=
+			    skb->len - pad_start - 2)
+				pad_start = 0;
+		}
+
+		if (pad_start) {
+			memmove(skb->data + 2, skb->data, pad_start);
 			skb_pull(skb, 2);
 		}
 	}
-- 
2.30.1

