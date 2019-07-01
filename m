Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2075C2C9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGASUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 14:20:23 -0400
Received: from nbd.name ([46.4.11.11]:44392 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfGASUX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 14:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9X3e2qSfmHu3g2gCoZyH9lge8kBO0ioGTySFUJ3JZV4=; b=kDh20Xkh2oQDK61Ldx2F3lwQ2t
        LyQ+Zu0zkw5GVEJOAUtfVfwKd41sBXwv2Q4hidJtijYV7NLxUiMJXTE+3Njd4ncUcTvCtW2wGLUEW
        0DC47JMzBVORazucSdlpr2iieRt/OTBtwKCDcMYVAhKnGRsQnxWcNK7GnDs6V9pGfKC8=;
Received: from p54ae9425.dip0.t-ipconnect.de ([84.174.148.37] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hi0ub-0007zy-T8
        for linux-wireless@vger.kernel.org; Mon, 01 Jul 2019 20:20:21 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id 2003360F54D4; Mon,  1 Jul 2019 20:20:20 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: clean up FWDL TXQ during/after firmware upload
Date:   Mon,  1 Jul 2019 20:20:20 +0200
Message-Id: <20190701182020.6144-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since we don't clean that tx queue from the tx tasklet, we need to do it
after the firmware upload is done. This patch also adds a cleanup step during
the upload, to help reclaim memory faster.

Fixes unprocessed queued frames eating up memory  long after the firmware
upload has already completed

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 06d146198e33..de371bd2e0b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -248,6 +248,7 @@ static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 
 		data += cur_len;
 		len -= cur_len;
+		mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
 	}
 
 	return ret;
@@ -525,6 +526,8 @@ static int mt7615_load_firmware(struct mt7615_dev *dev)
 		return -EIO;
 	}
 
+	mt76_queue_tx_cleanup(dev, MT_TXQ_FWDL, false);
+
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 
 	return 0;
-- 
2.17.0

