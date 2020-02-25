Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1725D16C0CB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 13:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgBYM2v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 07:28:51 -0500
Received: from nbd.name ([46.4.11.11]:53756 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbgBYM2v (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 07:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=u4m8Xfv6OFxYgqJTd80I7Cl5L/XD4jwAZRRZRhkeGj0=; b=tJQpPFctn+V82Q0cQC7jCQZppv
        S0anKmFT1YevBav8lMlGeV8nljNIhTxzbgjMkXEAFYF3312AHMiXXx4ZdfbSWOEfkkYaH7O2wWqb5
        DpvRGVU2XpUA+w6ktpm2mZaVkpB/aIJ6R+CqpYBGis1Q5y8Rx4Lt/uSReGxlterQ2Dgw=;
Received: from [80.255.7.116] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j6ZKS-0006CM-Vp
        for linux-wireless@vger.kernel.org; Tue, 25 Feb 2020 13:28:49 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EAF567E3F8B7; Tue, 25 Feb 2020 13:28:47 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] mt76: mt7603: add upper limit for dynamic sensitivity minimum receive power
Date:   Tue, 25 Feb 2020 13:28:46 +0100
Message-Id: <20200225122847.40846-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200225122847.40846-1-nbd@nbd.name>
References: <20200225122847.40846-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the minimum power is raised too much, it can make it impossible for weaker
clients to connect, and there are some scenarios where the false detects will
not go down no matter how much the sensitivity is adjusted.
Fixes connectivity issues in some rare cases

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/init.c    | 1 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c     | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h  | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index 47c85a9fac28..a84e801d4cf0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -121,4 +121,6 @@ void mt7603_init_debugfs(struct mt7603_dev *dev)
 				    mt7603_reset_read);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
 				    mt7603_radio_read);
+	debugfs_create_u8("sensitivity_limit", 0600, dir,
+			    &dev->sensitivity_limit);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 9e40e81bcc29..97ba5ddc44bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -540,6 +540,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 		dev->mphy.antenna_mask = 1;
 
 	dev->slottime = 9;
+	dev->sensitivity_limit = 28;
 
 	ret = mt7603_init_hardware(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 8f5ca9283f7d..a3daae41f2f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1750,7 +1750,8 @@ mt7603_false_cca_check(struct mt7603_dev *dev)
 	min_signal -= 15;
 
 	false_cca = dev->false_cca_ofdm + dev->false_cca_cck;
-	if (false_cca > 600) {
+	if (false_cca > 600 &&
+	    dev->sensitivity < -100 + dev->sensitivity_limit) {
 		if (!dev->sensitivity)
 			dev->sensitivity = -92;
 		else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index ef374641fe80..831a269472b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -143,6 +143,7 @@ struct mt7603_dev {
 	u8 ed_strong_signal;
 
 	s8 sensitivity;
+	u8 sensitivity_limit;
 
 	u8 beacon_check;
 	u8 tx_hang_check;
-- 
2.24.0

