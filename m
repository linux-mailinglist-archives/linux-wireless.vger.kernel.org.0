Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3302F601A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 12:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbhANLbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 06:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbhANLbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 06:31:06 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E04C06179A
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 03:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ixUx+csBL+2MPJ0Q+vaz3WbYKtI0EGHk49a0YtwmS/w=; b=EkW9q6vn9sIqoRRunjeF/lGAcq
        s24d9tGOWipnYs5ngeiHzTm16JMLU0ftfPeHjKHOWBx7NevWzpIwJFMfU6tRmHm01tBrYCAfGK9kZ
        zwHjbItDWSMLMXV5X+uS/BaDVKQEriXDlUM4c7wrcGv0CCGmNGPAVO3Wb9wnIIvLphGc=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l00og-0001PU-Pc
        for linux-wireless@vger.kernel.org; Thu, 14 Jan 2021 12:29:26 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/7] mt76: mt7915: ensure that init work completes before starting the device
Date:   Thu, 14 Jan 2021 12:29:20 +0100
Message-Id: <20210114112925.87646-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210114112925.87646-1-nbd@nbd.name>
References: <20210114112925.87646-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Without this change, the start operation could potentially race against eeprom
or txbf init

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 73c5ee10fd3e..05dd75961d95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -26,6 +26,8 @@ static int mt7915_start(struct ieee80211_hw *hw)
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	bool running;
 
+	flush_work(&dev->init_work);
+
 	mutex_lock(&dev->mt76.mutex);
 
 	running = mt7915_dev_running(dev);
-- 
2.28.0

