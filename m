Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21A5316EFC
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 19:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhBJSnw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 13:43:52 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50385 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234400AbhBJSlh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 13:41:37 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0224A5C01D1;
        Wed, 10 Feb 2021 13:40:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 10 Feb 2021 13:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mm.st; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm2;
         bh=CVA6GmcR5lZ2KidSaAa9ccPyMeiDjPYqd6lk+MJJ5XU=; b=qyiXkorGdvXc
        4pIWxZz4m/9eNy1ATJWUYu4z1GKBJkClTi6Q7KFoLfJMu+BKBjWbmBA0uNSs/Yko
        mzSubRRo/18q3egzimqLoLAthxzhaH32IJFirVKAII0TLb+89v2NTbBB4G9/+xHC
        relalviE7WiKVVMiS9QffDaPNP79hUzpzukVHYOFbkUg5/55amVaYJaHpvfGKH3T
        JRAN3z31ecj1JRK2Es/rc/ksxvvIJgkqrJjLvuYD7hFLuu4Z1Jd0o1IY8JI/1cb+
        ePIVSgX/o+VCSAue6coyg2ZKfdtJQLJDNCsl23UAstPz4rIoS4vJU7YvHWIcYVw2
        b+A1T/HkZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=CVA6GmcR5lZ2KidSaAa9ccPyMeiDj
        PYqd6lk+MJJ5XU=; b=PRb8Qfly6PcncWhTQxtu7DEEUw9EOG2doo4L+221CCaFL
        VJjbFJ8vFSZ81Oy8L0s8yc6+YmlusytiN4n8bbBi9TyMYwqoSEmZV4ygON9jTbTk
        KF0X/2JBvx1RP9ChFm/3gzNe2Vsj5lquM9GRxgfN6nEE+73aSyZ02ZgZLiudSP5i
        VlP8Ebsm4nEensyuBfrQ+866nMgeSl8OeMl6j92NWtF4fPFn/PHO5guMmNG2LsKz
        rK1hWM0QrS0Bh6qV6dmM9nFQpLcbYRQIVQG0F97ZHtbIYOmDn+CiSBJKscYTSZke
        BwLg+Kki/YxBCyA4ut5I4a50Gshv3WQ5qBikt7WGA==
X-ME-Sender: <xms:mygkYDUd4XSwOV1a5kvMkGQlCTypUaJdmTBu1A8RnDF1QZ4N_Bhgqg>
    <xme:mygkYM-kDUk6Kfu5IQ5Joel-tQq32-Gq1GYBSct_R_uEzpZg2ruTGJB1X_LDOLL4L
    DMF_Tut-UkY-Hmd_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheejgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtjeenucfhrhhomhepgghsvghvohhlohguucfmohiilhhovhcuoeiirggsrgesmhhmrdhs
    theqnecuggftrfgrthhtvghrnhepudekfeevgeejveetjeetvdeivdekheektdfgtddvgf
    efhfdukefhtefgueduudeunecukfhppeekjedrledvrddutddrvddtkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiirggsrgesmhhmrdhsth
X-ME-Proxy: <xmx:mygkYIrla2n_i6HrJwadJe-7aV0LkRydUUbEqcROM5J1hk6Cjaj2Tw>
    <xmx:mygkYGluWR7FG--B1UkfVPXIFLYiXrP8MSZ6Ol6m-OrJweqpiJ9oTA>
    <xmx:mygkYEZiuDGb8nvFykR240jOXJ5ctfjFJLWb_ZXWEqj1egYTNQyRow>
    <xmx:mygkYN6RzJl8WQp0bdIYJHJaAc4o9F_CQPdG0U3hMpRt63V10MgfnA>
Received: from Vsevolods-Mini.lan (87-92-10-208.bb.dnainternet.fi [87.92.10.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8AC1108005F;
        Wed, 10 Feb 2021 13:40:26 -0500 (EST)
Date:   Wed, 10 Feb 2021 20:40:24 +0200
From:   Vsevolod Kozlov <zaba@mm.st>
To:     ajay.kathat@microchip.com, claudiu.beznea@microchip.com,
        kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] wilc1000: Fix use of void pointer as a wrong struct type
Message-ID: <YCQomJ1mO5BLxYOT@Vsevolods-Mini.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ac_classify() expects a struct sk_buff* as its second argument, which is
a member of struct tx_complete_data. priv happens to be a pointer to
struct tx_complete_data, so passing it directly to ac_classify() leads
to wrong behaviour and occasional panics.

Since there is only one caller of wilc_wlan_txq_add_net_pkt and it
already knows the type behind this pointer, and the structure is already
in the header file, change the function signature to use the real type
instead of void* in order to prevent confusion.

Signed-off-by: Vsevolod Kozlov <zaba@mm.st>
---
v2: change function signature to not use pointer to void at all

 drivers/net/wireless/microchip/wilc1000/netdev.c |  2 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c   | 15 ++++++++-------
 drivers/net/wireless/microchip/wilc1000/wlan.h   |  3 ++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 2a1fbbdd6a4b..0c188310919e 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -737,7 +737,7 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	vif->netstats.tx_packets++;
 	vif->netstats.tx_bytes += tx_data->size;
-	queue_count = wilc_wlan_txq_add_net_pkt(ndev, (void *)tx_data,
+	queue_count = wilc_wlan_txq_add_net_pkt(ndev, tx_data,
 						tx_data->buff, tx_data->size,
 						wilc_tx_complete);
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index c12f27be9f79..31d51385ba93 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -408,7 +408,8 @@ static inline u8 ac_change(struct wilc *wilc, u8 *ac)
 	return 1;
 }
 
-int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buffer,
+int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
+			      struct tx_complete_data *tx_data, u8 *buffer,
 			      u32 buffer_size,
 			      void (*tx_complete_fn)(void *, int))
 {
@@ -420,27 +421,27 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buffer,
 	wilc = vif->wilc;
 
 	if (wilc->quit) {
-		tx_complete_fn(priv, 0);
+		tx_complete_fn(tx_data, 0);
 		return 0;
 	}
 
 	tqe = kmalloc(sizeof(*tqe), GFP_ATOMIC);
 
 	if (!tqe) {
-		tx_complete_fn(priv, 0);
+		tx_complete_fn(tx_data, 0);
 		return 0;
 	}
 	tqe->type = WILC_NET_PKT;
 	tqe->buffer = buffer;
 	tqe->buffer_size = buffer_size;
 	tqe->tx_complete_func = tx_complete_fn;
-	tqe->priv = priv;
+	tqe->priv = tx_data;
 	tqe->vif = vif;
 
-	q_num = ac_classify(wilc, priv);
+	q_num = ac_classify(wilc, tx_data->skb);
 	tqe->q_num = q_num;
 	if (ac_change(wilc, &q_num)) {
-		tx_complete_fn(priv, 0);
+		tx_complete_fn(tx_data, 0);
 		kfree(tqe);
 		return 0;
 	}
@@ -451,7 +452,7 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buffer,
 			tcp_process(dev, tqe);
 		wilc_wlan_txq_add_to_tail(dev, q_num, tqe);
 	} else {
-		tx_complete_fn(priv, 0);
+		tx_complete_fn(tx_data, 0);
 		kfree(tqe);
 	}
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index 3d2104f19819..d55eb6b3a12a 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -399,7 +399,8 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 				u32 buffer_size);
 int wilc_wlan_start(struct wilc *wilc);
 int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif);
-int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buffer,
+int wilc_wlan_txq_add_net_pkt(struct net_device *dev,
+			      struct tx_complete_data *tx_data, u8 *buffer,
 			      u32 buffer_size,
 			      void (*tx_complete_fn)(void *, int));
 int wilc_wlan_handle_txq(struct wilc *wl, u32 *txq_count);
-- 
2.20.1

