Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0038517D6A2
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 23:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCHWJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 18:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCHWJL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 18:09:11 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D2762083E;
        Sun,  8 Mar 2020 22:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583705350;
        bh=4+cAbQUfuCpgHKGN1/CeRCdKC0EvuboIRQwtXQoYeXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w7+kBXW7KqD9YQTlBwk18k9GXGs4WVdtG1RMcJoZN6SEHso7fXyl8jNxCcx/DqbrD
         oR522AWzMszM4cCFBr6K8QDGkR6GR6tP26+0P8LAk+0J+3K/z1yCQPEY5Un1jscVmX
         0serPthQF206bhoBrBYcrmvx4GA6trRkQ5n4NuC0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v2 02/25] mt76: mt7615: introduce mt7615_mcu_wait_response
Date:   Sun,  8 Mar 2020 23:08:14 +0100
Message-Id: <dbb35f147bbd23751d25229dc5bdc7808f498910.1583705012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583705012.git.lorenzo@kernel.org>
References: <cover.1583705012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mcu_wait_response in order to be reused parsing mt7663u
mcu messages

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 38 ++++++++++++-------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 71b209fe439f..a4e971d7f6a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -144,12 +144,33 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int cmd,
 	return ret;
 }
 
+int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq)
+{
+	unsigned long expires = jiffies + 20 * HZ;
+	struct sk_buff *skb;
+	int ret = 0;
+
+	while (true) {
+		skb = mt76_mcu_get_response(&dev->mt76, expires);
+		if (!skb) {
+			dev_err(dev->mt76.dev, "Message %d (seq %d) timeout\n",
+				cmd, seq);
+			return -ETIMEDOUT;
+		}
+
+		ret = mt7615_mcu_parse_response(dev, cmd, skb, seq);
+		if (ret != -EAGAIN)
+			break;
+	}
+
+	return ret;
+}
+
 static int
 mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 		    int len, bool wait_resp)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	unsigned long expires = jiffies + 20 * HZ;
 	struct sk_buff *skb;
 	int ret, seq;
 
@@ -163,19 +184,8 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	if (ret)
 		goto out;
 
-	while (wait_resp) {
-		skb = mt76_mcu_get_response(mdev, expires);
-		if (!skb) {
-			dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
-				cmd, seq);
-			ret = -ETIMEDOUT;
-			break;
-		}
-
-		ret = mt7615_mcu_parse_response(dev, cmd, skb, seq);
-		if (ret != -EAGAIN)
-			break;
-	}
+	if (wait_resp)
+		ret = mt7615_mcu_wait_response(dev, cmd, seq);
 
 out:
 	mutex_unlock(&mdev->mcu.mutex);
-- 
2.24.1

