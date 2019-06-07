Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9E39268
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfFGQoA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 12:44:00 -0400
Received: from nbd.name ([46.4.11.11]:58274 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730484AbfFGQn7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 12:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ztfmCLh7/+hc7Bz5FdvHk4iOr4N3Xc+lH4FXCpCceBI=; b=nWxyvI/AxmHiA8YN5F4jjfv2oV
        vX2UhlVJLPQvuFEoWfWQ6wJTwYRRQPnDNLQGpacyA+ZxEt1I4esCcV6XdTd0Iq6QcUCT1cULwzuE+
        iCD7qpwSc3PZ+Yh1qF96YNuBaGKR7ogXDVrKhL3KJIBJR0zD2P5rhV3Nb8ZtRbUEl+rQ=;
Received: from p4ff13bc7.dip0.t-ipconnect.de ([79.241.59.199] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hZHyA-0008DC-IK
        for linux-wireless@vger.kernel.org; Fri, 07 Jun 2019 18:43:58 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id B3CEA5C32BC0; Fri,  7 Jun 2019 18:43:56 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: fix setting chan->max_power
Date:   Fri,  7 Jun 2019 18:43:53 +0200
Message-Id: <20190607164355.51876-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190607164355.51876-1-nbd@nbd.name>
References: <20190607164355.51876-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When setting chan->max_power after registering the wiphy, chan->max_reg_power
needs to be used as a limit

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/init.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt76x2/init.c | 9 +++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 2238e3daedc6..bce51997ff3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -494,7 +494,7 @@ mt7603_init_txpower(struct mt7603_dev *dev,
 
 	for (i = 0; i < sband->n_channels; i++) {
 		chan = &sband->channels[i];
-		chan->max_power = target_power;
+		chan->max_power = min_t(int, chan->max_reg_power, target_power);
 		chan->orig_mpwr = target_power;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index 57e46d57b449..d67401f895ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -279,8 +279,9 @@ mt76x0_init_txpower(struct mt76x02_dev *dev,
 		mt76x0_get_tx_power_per_rate(dev, chan, &t);
 		mt76x0_get_power_info(dev, chan, &tp);
 
-		chan->max_power = (mt76x02_get_max_rate_power(&t) + tp) / 2;
-		chan->orig_mpwr = chan->max_power;
+		chan->orig_mpwr = (mt76x02_get_max_rate_power(&t) + tp) / 2;
+		chan->max_power = min_t(int, chan->max_reg_power,
+					chan->orig_mpwr);
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/init.c
index c6078e90ca43..97c3543eed8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/init.c
@@ -173,13 +173,14 @@ void mt76x2_init_txpower(struct mt76x02_dev *dev,
 		mt76x2_get_power_info(dev, &txp, chan);
 		mt76x2_get_rate_power(dev, &t, chan);
 
-		chan->max_power = mt76x02_get_max_rate_power(&t) +
+		chan->orig_mpwr = mt76x02_get_max_rate_power(&t) +
 				  txp.target_power;
-		chan->max_power = DIV_ROUND_UP(chan->max_power, 2);
+		chan->orig_mpwr = DIV_ROUND_UP(chan->orig_mpwr, 2);
 
 		/* convert to combined output power on 2x2 devices */
-		chan->max_power += 3;
-		chan->orig_mpwr = chan->max_power;
+		chan->orig_mpwr += 3;
+		chan->max_power = min_t(int, chan->max_reg_power,
+					chan->orig_mpwr);
 	}
 }
 EXPORT_SYMBOL_GPL(mt76x2_init_txpower);
-- 
2.17.0

