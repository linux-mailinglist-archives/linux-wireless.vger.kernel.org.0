Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00A714A9AE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 19:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgA0SR6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 13:17:58 -0500
Received: from nbd.name ([46.4.11.11]:48206 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgA0SR5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 13:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3zhUoqc2bbhf/giTsJ3p839W3UHaOtAacnpPL3Avbbw=; b=W97+DLU4GheBgiJw/QBdCUMviP
        iF6p73cwlxBO+NiEz+1AAoPIdiFq3vV/XX7ToHtLQHxCHMFDotaxqkB2CaZWFehYQ+Ln3CATQGmEh
        qHLcyZY8APs2NUnDThoEIPBw0r7G3hbbTywzecfegR3GbBj1rnV95B0PeA62fU2CR2wk=;
Received: from [178.162.209.132] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iw8xP-0007da-Ju
        for linux-wireless@vger.kernel.org; Mon, 27 Jan 2020 19:17:55 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 1A70F7A566E2; Mon, 27 Jan 2020 19:17:54 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/5] mt76: enable Airtime Queue Limit support
Date:   Mon, 27 Jan 2020 19:17:54 +0100
Message-Id: <20200127181754.2810-5-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200127181754.2810-1-nbd@nbd.name>
References: <20200127181754.2810-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is supported by all drivers

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9947e627318b..2a85e0cb5793 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -283,6 +283,7 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AQL);
 
 	wiphy->available_antennas_tx = dev->phy.antenna_mask;
 	wiphy->available_antennas_rx = dev->phy.antenna_mask;
-- 
2.24.0

