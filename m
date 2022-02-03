Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4224A8555
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 14:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350816AbiBCNgH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 08:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244071AbiBCNgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 08:36:04 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E62C061401
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9D4EIzHcNcIZ78v6verPDgKFBAxjG4RfJr0Su9O5m94=; b=t3x/C3rjtD8MnS1BKS/PbcTXsF
        cUfHfmTEekyumY+VXCjvYhkBQhp3k31pUvk2qG3716aATxi/P4ymYgEwIU9rkULulim79EIU4cwwY
        Lc16FrzmaiqhiTODwlUrL/zIBuHvYcsu2574kbvipJplY6w/fjFdPi4m3JQeO7yEUNyE=;
Received: from p200300daa71e0b007cedb37d167c1481.dip0.t-ipconnect.de ([2003:da:a71e:b00:7ced:b37d:167c:1481] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nFcHK-0001Et-PG
        for linux-wireless@vger.kernel.org; Thu, 03 Feb 2022 14:36:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/5] mt76: mt76x02: use mt76_phy_dfs_state to determine radar detector state
Date:   Thu,  3 Feb 2022 14:36:00 +0100
Message-Id: <20220203133600.92211-5-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220203133600.92211-1-nbd@nbd.name>
References: <20220203133600.92211-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes corner cases in enabling/disabling detector

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index a601350531cd..024a5c0a5a57 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -823,10 +823,7 @@ EXPORT_SYMBOL_GPL(mt76x02_phy_dfs_adjust_agc);
 
 void mt76x02_dfs_init_params(struct mt76x02_dev *dev)
 {
-	struct cfg80211_chan_def *chandef = &dev->mphy.chandef;
-
-	if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
-	    dev->mt76.region != NL80211_DFS_UNSET) {
+	if (mt76_phy_dfs_state(&dev->mphy) > MT_DFS_STATE_DISABLED) {
 		mt76x02_dfs_init_sw_detector(dev);
 		mt76x02_dfs_set_bbp_params(dev);
 		/* enable debug mode */
-- 
2.32.0 (Apple Git-132)

