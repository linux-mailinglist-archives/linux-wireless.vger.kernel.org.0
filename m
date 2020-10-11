Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C0F28A839
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Oct 2020 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgJKQUo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Oct 2020 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387739AbgJKQUo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Oct 2020 12:20:44 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00BC0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 11 Oct 2020 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mf1TU+vAlZ3cuyuDsOHZ8HXxbL4wAGb5TC7oIAhHUH0=; b=q2Pq6c7EgpwDH0lYKi/us2uZ4Q
        K1CJ7hYopIJMIWHPcKLANAdkwaBEA1a7clI5iDzRaUiKr/tEO/np5EaXUwM1tJI5pmlXYEGZ6AXWV
        WksO0Eh+fZjYgCeesNdBRxbSypMyxcPTveQypOOXoF+MH7bFThHdn6qaAOVhPPv8tLCU=;
Received: from p54ae9462.dip0.t-ipconnect.de ([84.174.148.98] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kRe5S-0004gJ-4Q; Sun, 11 Oct 2020 18:20:42 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] mt76: add back the SUPPORTS_REORDERING_BUFFER flag
Date:   Sun, 11 Oct 2020 18:20:40 +0200
Message-Id: <20201011162040.63714-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It was accidentally dropped while adding multiple wiphy support
Fixes fast-rx support and avoids handling reordering in both mac80211
and the driver

Cc: stable@vger.kernel.org
Fixes: c89d36254155 ("mt76: add function for allocating an extra wiphy")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index a778ecc65261..2bc1ef1cbfea 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -305,6 +305,7 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
+	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 
 	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD)) {
 		ieee80211_hw_set(hw, TX_AMSDU);
-- 
2.28.0

