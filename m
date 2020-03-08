Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5580A17D6A5
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 23:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCHWJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 18:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgCHWJP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 18:09:15 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20BB82083E;
        Sun,  8 Mar 2020 22:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583705355;
        bh=0sP3xQJnSSPWdJPq59NoY8TpyORlbZzrCx0XGTjsAaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utPrhzYL8J0uWCvPGwYtuUmGpunUJHJFw4ItxNmjFK5tYeaDz5ULUw8e1+k1iZoGo
         taXRgR/ww8FjuAWWSgdEu6gKXJ04BHpXIm/N6NvxNaw/v5t20qyR0K6gwQWSAXpIIh
         YUdCKZ99ucHMPOsPVQ1ZL3IZY+n4G2IlJxI/sV9Q=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v2 05/25] mt76: always init to 0 mcu messages
Date:   Sun,  8 Mar 2020 23:08:17 +0100
Message-Id: <491494d2a8a084ee3e418d7d9a8d3e610cfcb1fd.1583705012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583705012.git.lorenzo@kernel.org>
References: <cover.1583705012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Always initialize to 0 mcu messages since if they are not propely
configured they could hang the firmware.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mcu.c        | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 1 -
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 633ad948c21d..4048f446e3ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -9,14 +9,16 @@ struct sk_buff *
 mt76_mcu_msg_alloc(const void *data, int head_len,
 		   int data_len, int tail_len)
 {
+	int length = head_len + data_len + tail_len;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(head_len + data_len + tail_len,
-			GFP_KERNEL);
+	skb = alloc_skb(length, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
+	memset(skb->head, 0, length);
 	skb_reserve(skb, head_len);
+
 	if (data && data_len)
 		skb_put_data(skb, data, data_len);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index b466b3ab8a2c..77985d81c447 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -27,7 +27,6 @@ __mt7603_mcu_msg_send(struct mt7603_dev *dev, struct sk_buff *skb,
 		seq = ++mdev->mcu.msg_seq & 0xf;
 
 	txd = (struct mt7603_mcu_txd *)skb_push(skb, hdrlen);
-	memset(txd, 0, hdrlen);
 
 	txd->len = cpu_to_le16(skb->len);
 	if (cmd == -MCU_CMD_FW_SCATTER)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b24240f90a7d..b94b1b73fd1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -62,7 +62,6 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
 
 	mcu_txd = (struct mt7615_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
-	memset(mcu_txd, 0, sizeof(*mcu_txd));
 
 	if (cmd != -MCU_CMD_FW_SCATTER) {
 		q_idx = MT_TX_MCU_PORT_RX_Q0;
-- 
2.24.1

