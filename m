Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91105128E9D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 16:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLVPHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 10:07:19 -0500
Received: from nbd.name ([46.4.11.11]:47414 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfLVPHT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 10:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=34+jQmBp3qWB+Ko19pPS7R8vjnqoBe4sv+ZRxixsQ+k=; b=YN9QUqLsDjXEKns+Y/urMsSafQ
        z1sCNXttmD/XgKGmjd9865uq9PUMRoi+dOUex8ZiLRlJPKqFaKmFrbDkxlvqAmliy6pshFEz2NsYl
        ki4N048BrF+LmbcZFkQ87UeVrsi7Lzrm3SqrzyURoenRN702ikeZgIcF3QwN46plgVY4=;
Received: from [81.95.5.44] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ij2pB-00030U-WB
        for linux-wireless@vger.kernel.org; Sun, 22 Dec 2019 16:07:18 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 5008E742EAFA; Sun, 22 Dec 2019 16:07:17 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: mt7615: increase MCU command timeout
Date:   Sun, 22 Dec 2019 16:07:15 +0100
Message-Id: <20191222150717.51379-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191222150717.51379-1-nbd@nbd.name>
References: <20191222150717.51379-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MCU_EXT_CMD_EFUSE_BUFFER_MODE needs more time on initialization, and
with only 10 seconds it sometimes runs into timeouts.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index fc091278d9e5..c8d6a36f5d0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -144,7 +144,7 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 		    int len, bool wait_resp)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	unsigned long expires = jiffies + 10 * HZ;
+	unsigned long expires = jiffies + 20 * HZ;
 	struct sk_buff *skb;
 	int ret, seq;
 
-- 
2.24.0

