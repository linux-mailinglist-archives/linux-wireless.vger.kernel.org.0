Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69716C0CA
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 13:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgBYM2v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 07:28:51 -0500
Received: from nbd.name ([46.4.11.11]:53752 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgBYM2u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 07:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VKFr7tplQZG+iFv/6D252Xk6cjewOeMSs1sKn25cAxM=; b=qh5DeLBZ4pKA3ls7eAsZK+B4ro
        ijvc8NjWGgQgA+4GEmlLELDyC3fLjmqHGiUqgYMYNo8RXpQwNVSlhBpadx/wKx0RYOcBb8+ziLuWx
        FNmIvfN3ux1qgVl6UNUMlscfS6IslsceJXjlJ0YoUU56O3+oLFQsHiP8RcHyyZKY4ohg=;
Received: from [80.255.7.116] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1j6ZKS-0006CK-Vp
        for linux-wireless@vger.kernel.org; Tue, 25 Feb 2020 13:28:49 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EFB3A7E3F8B8; Tue, 25 Feb 2020 13:28:47 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: mt7603: make dynamic sensitivity adjustment configurable via debugfs
Date:   Tue, 25 Feb 2020 13:28:47 +0100
Message-Id: <20200225122847.40846-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200225122847.40846-1-nbd@nbd.name>
References: <20200225122847.40846-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In some cases it may be useful for debugging to disable this feature

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/init.c    | 1 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h  | 1 +
 4 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index a84e801d4cf0..cc7c788abedd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -123,4 +123,6 @@ void mt7603_init_debugfs(struct mt7603_dev *dev)
 				    mt7603_radio_read);
 	debugfs_create_u8("sensitivity_limit", 0600, dir,
 			    &dev->sensitivity_limit);
+	debugfs_create_bool("dynamic_sensitivity", 0600, dir,
+			    &dev->dynamic_sensitivity);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 97ba5ddc44bb..f641a8b56b39 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -541,6 +541,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 
 	dev->slottime = 9;
 	dev->sensitivity_limit = 28;
+	dev->dynamic_sensitivity = true;
 
 	ret = mt7603_init_hardware(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index a3daae41f2f4..39b7c5d6e6cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1727,6 +1727,9 @@ mt7603_false_cca_check(struct mt7603_dev *dev)
 	int min_signal;
 	u32 val;
 
+	if (!dev->dynamic_sensitivity)
+		return;
+
 	val = mt76_rr(dev, MT_PHYCTRL_STAT_PD);
 	pd_cck = FIELD_GET(MT_PHYCTRL_STAT_PD_CCK, val);
 	pd_ofdm = FIELD_GET(MT_PHYCTRL_STAT_PD_OFDM, val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 831a269472b3..7fadf094e9be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -142,6 +142,7 @@ struct mt7603_dev {
 	u8 ed_strict_mode;
 	u8 ed_strong_signal;
 
+	bool dynamic_sensitivity;
 	s8 sensitivity;
 	u8 sensitivity_limit;
 
-- 
2.24.0

