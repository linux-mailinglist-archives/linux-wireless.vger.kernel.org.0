Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92868377F54
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhEJJ2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 05:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEJJ2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 05:28:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310DFC061761
        for <linux-wireless@vger.kernel.org>; Mon, 10 May 2021 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8eS2sKDH/RptV4CgoDk2kx+S81SUzCzAU5Zcp7ZIq34=; b=K/55vvIZxv/qdLrEE66GR4MnC9
        cKw+A6L8fAsGorLnnDKq1++Flz28kR51o21yLADtNwVDaZ4dFTqOdIWhessx+L5FqehWPSlO8PKMi
        md0y8sQHHfl6U3oj/KSL9EqjTsEnGGCb1AYIpNqri2QItBmBo8+iMWCTJMbyY5/PLS3A=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lg2Bt-000572-LC
        for linux-wireless@vger.kernel.org; Mon, 10 May 2021 11:27:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/9] mt76: mt7615: avoid use of ieee80211_tx_info_clear_status
Date:   Mon, 10 May 2021 11:26:57 +0200
Message-Id: <20210510092703.90500-3-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210510092703.90500-1-nbd@nbd.name>
References: <20210510092703.90500-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It overwrites mt76_tx_cb data in the skb

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c600a0b2b00b..bef43c871908 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1389,7 +1389,7 @@ static bool mt7615_mac_add_txs_skb(struct mt7615_dev *dev,
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
 		if (!mt7615_fill_txs(dev, sta, info, txs_data)) {
-			ieee80211_tx_info_clear_status(info);
+			info->status.rates[0].count = 0;
 			info->status.rates[0].idx = -1;
 		}
 
-- 
2.30.1

