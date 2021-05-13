Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F537F350
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 09:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhEMHES (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 May 2021 03:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhEMHER (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 May 2021 03:04:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03210C061574
        for <linux-wireless@vger.kernel.org>; Thu, 13 May 2021 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EqLaSyzcSCBfBlTR/kEof3rcsA9sQ2ZSIrNmQ6zcbG8=; b=UhD32vclZHPgpYkaoDIA0sKAp3
        LZEXhqBtpRg3kq7dt0BQD5OAubUux6J3Q0ecuZ6aPwOv7758hutnI2zy/7kB64hzDHlatRzpxrtAZ
        kj0pRQZroasGf7HcVLC0Xv+JjMWi3Q64qF4J5ifffMY3od+GpP7dz0ib/3x6fB5EjjaQ=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lh5NB-0002Nm-GB; Thu, 13 May 2021 09:03:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH 5.13] mt76: validate rx A-MSDU subframes
Date:   Thu, 13 May 2021 09:03:03 +0200
Message-Id: <20210513070303.20253-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mitigate A-MSDU injection attacks (CVE-2020-24588) by detecting if the
destination address of a subframe equals an RFC1042 (i.e., LLC/SNAP)
header, and if so dropping the complete A-MSDU frame. This mitigates
known attacks, although new (unknown) aggregation-based attacks may
remain possible.

This defense works because in A-MSDU aggregation injection attacks, a
normal encrypted Wi-Fi frame is turned into an A-MSDU frame. This means
the first 6 bytes of the first A-MSDU subframe correspond to an RFC1042
header. In other words, the destination MAC address of the first A-MSDU
subframe contains the start of an RFC1042 header during an aggregation
attack. We can detect this and thereby prevent this specific attack.
For details, see Section 7.2 of "Fragment and Forge: Breaking Wi-Fi
Through Frame Aggregation and Fragmentation".

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 977acab0360a..03fe62837557 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -514,10 +514,36 @@ EXPORT_SYMBOL_GPL(mt76_free_device);
 static void mt76_rx_release_amsdu(struct mt76_phy *phy, enum mt76_rxq_id q)
 {
 	struct sk_buff *skb = phy->rx_amsdu[q].head;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_dev *dev = phy->dev;
 
 	phy->rx_amsdu[q].head = NULL;
 	phy->rx_amsdu[q].tail = NULL;
+
+	/*
+	 * Validate if the amsdu has a proper first subframe.
+	 * A single MSDU can be parsed as A-MSDU when the unauthenticated A-MSDU
+	 * flag of the QoS header gets flipped. In such cases, the first
+	 * subframe has a LLC/SNAP header in the location of the destination
+	 * address.
+	 */
+	if (skb_shinfo(skb)->frag_list) {
+		int offset = 0;
+
+		if (!(status->flag & RX_FLAG_8023)) {
+			offset = ieee80211_get_hdrlen_from_skb(skb);
+
+			if ((status->flag &
+			     (RX_FLAG_DECRYPTED | RX_FLAG_IV_STRIPPED)) ==
+			    RX_FLAG_DECRYPTED)
+				offset += 8;
+		}
+
+		if (ether_addr_equal(skb->data + offset, rfc1042_header)) {
+			dev_kfree_skb(skb);
+			return;
+		}
+	}
 	__skb_queue_tail(&dev->rx_skb[q], skb);
 }
 
-- 
2.30.1

