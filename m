Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E010DE21
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfK3PbL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:11 -0500
Received: from nbd.name ([46.4.11.11]:56038 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfK3Pas (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7ur8L03O0r4ctQAG+RzezVjRPx8TQrUn8WqEMtcjU+E=; b=YeHj9upAkubaP9sjQMOP68t2FO
        jzTyabZkTG8AU5dVqqlDi6ofhl6xUdxha0Y5xkAKqKxwc9ZbZ36ecoiOEXItvCI33tf6feh4dGJNc
        tjxTHFyCh/NRoT4wqa3cmg47YQ9jWNOnuxtL/Z9iRH8ZW6CZxXV2FSvEdrNegtxMFO0k=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006hb-6f
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 07E26721EBDB; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 16/29] mt76: add ext_phy field to struct mt76_wcid
Date:   Sat, 30 Nov 2019 16:30:32 +0100
Message-Id: <20191130153045.28105-16-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Will be used to determine the phy from within the driver

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index cdc0c9e0356c..38ea453b9bee 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -954,6 +954,7 @@ mt76_sta_add(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	ewma_signal_init(&wcid->rssi);
 	if (ext_phy)
 		mt76_wcid_mask_set(dev->wcid_phy_mask, wcid->idx);
+	wcid->ext_phy = ext_phy;
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e237ed72979b..62e2ded6a84c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -200,6 +200,7 @@ struct mt76_wcid {
 	u8 hw_key_idx;
 
 	u8 sta:1;
+	u8 ext_phy:1;
 
 	u8 rx_check_pn;
 	u8 rx_key_pn[IEEE80211_NUM_TIDS][6];
-- 
2.24.0

