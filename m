Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B308B27E880
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgI3MZA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgI3MYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51FC0613D0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5A7Dv3EgpEii8hsCTrA9+wseQDQJnBLziksdXx/lwRk=; b=aYxpVXYICbEsIGC9/UPU3Z2Jlv
        9B8tTNvN/kVH6Kqibr2uf8BxiWPalnh8zwJctJbOu9A0nFHHcZb2Qfj2dXJFkZWL7YYEIBap5vfyv
        xxuy/zqRzGpqChfTSyexLnpJN4PXmGPhN8Jr+z3hPz6HRGoRsqbwFzPx+OLF+weHcJG8=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA4-0005MT-5F
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:44 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 07/10] mt76: mt7603: switch to .mcu_skb_send_msg
Date:   Wed, 30 Sep 2020 14:24:38 +0200
Message-Id: <20200930122441.64523-7-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122441.64523-1-nbd@nbd.name>
References: <20200930122441.64523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduces code duplication

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   | 43 +++----------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index f787c9d3088e..b2ccfe6772ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -36,14 +36,16 @@ mt7603_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 }
 
 static int
-__mt7603_mcu_msg_send(struct mt7603_dev *dev, struct sk_buff *skb,
-		      int cmd, int *wait_seq)
+mt7603_mcu_skb_send_msg(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, int *wait_seq)
 {
+	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
 	int hdrlen = dev->mcu_running ? sizeof(struct mt7603_mcu_txd) : 12;
-	struct mt76_dev *mdev = &dev->mt76;
 	struct mt7603_mcu_txd *txd;
 	u8 seq;
 
+	mdev->mcu.timeout = 3 * HZ;
+
 	seq = ++mdev->mcu.msg_seq & 0xf;
 	if (!seq)
 		seq = ++mdev->mcu.msg_seq & 0xf;
@@ -74,39 +76,6 @@ __mt7603_mcu_msg_send(struct mt7603_dev *dev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, MT_TXQ_MCU, skb, 0);
 }
 
-static int
-mt7603_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
-		    int len, bool wait_resp)
-{
-	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
-	unsigned long expires = jiffies + 3 * HZ;
-	struct sk_buff *skb;
-	int ret, seq;
-
-	skb = mt76_mcu_msg_alloc(mdev, data, len);
-	if (!skb)
-		return -ENOMEM;
-
-	mutex_lock(&mdev->mcu.mutex);
-
-	ret = __mt7603_mcu_msg_send(dev, skb, cmd, &seq);
-	if (ret)
-		goto out;
-
-	while (wait_resp) {
-		skb = mt76_mcu_get_response(&dev->mt76, expires);
-		ret = mt7603_mcu_parse_response(mdev, cmd, skb, seq);
-		dev_kfree_skb(skb);
-		if (ret != -EAGAIN)
-			break;
-	}
-
-out:
-	mutex_unlock(&mdev->mcu.mutex);
-
-	return ret;
-}
-
 static int
 mt7603_mcu_init_download(struct mt7603_dev *dev, u32 addr, u32 len)
 {
@@ -271,7 +240,7 @@ int mt7603_mcu_init(struct mt7603_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7603_mcu_ops = {
 		.headroom = sizeof(struct mt7603_mcu_txd),
-		.mcu_send_msg = mt7603_mcu_msg_send,
+		.mcu_skb_send_msg = mt7603_mcu_skb_send_msg,
 		.mcu_parse_response = mt7603_mcu_parse_response,
 		.mcu_restart = mt7603_mcu_restart,
 	};
-- 
2.28.0

