Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BED436A26
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 20:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhJUSLK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 14:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhJUSLK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 14:11:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5705861B1B;
        Thu, 21 Oct 2021 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839734;
        bh=FVFZGzgXoO9ITxsruUoX5r7waH8eVo5fR2ZDGjDpd5E=;
        h=From:To:Cc:Subject:Date:From;
        b=RgJgT7+aF5/1X3K7fBeumkTF11xULDuQRg4PeuybEeLzaff1+VcbcN0JRU6OqH7d4
         1ZHZuU5claBTMbFgb1TwI60uvot1c9RpSBXNZ6LzOYYi8zU/yG2STnm1B2hq2vEJZt
         2L5WKkGKXX8X20dwDTO0Bj9s5mkhdViw5oDABjDo9flEnmwTE9yrUruXKxHekMB0fi
         IcVjbFTIBglG+CLN9mRiUS2ermKC2AcKBTYgqhMc0/TLI5tg3yMRi2bb67VPMGfCPN
         tdDArAS9DUpsAvRLKRkRT7h9kzyXG+nHfdGxWWIg4Cx9hxhGuOxhaGJSqvEgMkVdBV
         4qX4LWg/YzWFA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: disable 4addr capability
Date:   Thu, 21 Oct 2021 20:08:41 +0200
Message-Id: <b0db1a0f7b5da01d386ce03d56b5aecdc0d727fa.1634838660.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

4addr is not supported by the driver/firmware yet

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 87265045e2dd..210998f086ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -62,7 +62,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	hw->vif_data_size = sizeof(struct mt7921_vif);
 
 	wiphy->iface_combinations = if_comb;
-	wiphy->flags &= ~WIPHY_FLAG_IBSS_RSN;
+	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
+			  WIPHY_FLAG_4ADDR_STATION);
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
-- 
2.31.1

