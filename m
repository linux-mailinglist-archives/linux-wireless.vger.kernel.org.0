Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569A0467493
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 11:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379772AbhLCKQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 05:16:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33906 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379673AbhLCKQZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 05:16:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51E2D6241A
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 10:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB06C53FC7;
        Fri,  3 Dec 2021 10:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638526380;
        bh=0E7pO1toW2LWmpemz2i6+UL0kACQynPAp2on+yvV1cw=;
        h=From:To:Cc:Subject:Date:From;
        b=abfb4ho/0GcQWleZomZFaPYVVr8JiuqXCEUahrwNWGEVLVVN/9eMbsCVGAdBlJvNb
         2GQkjhTdXLpPGSoIB/CrmnBWj6oMrm9ZaS4R16R04/JKDPuSjSm1f0DTWn6EnEAb46
         wzD6ZEsZSqlZFpoHQScj+DzzNrmC5jWGxRxovoLswYZj/NuWvm83AJGD5s57XHHbSD
         9CsIWCMVQdaN0LuxD0CawkfJ/zG82lhsvUoH6y8MEhD7MtbLXF30edNq3o1/HJuhbR
         LegGfCvU6ASmJI1TqdkhEFI5k/lGk3EbhyqdeMfcGxvdYDk/WRNJtQOm3aogprcokh
         cUw0RXRWFhR1A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2] mt76: mt7663: disable 4addr capability
Date:   Fri,  3 Dec 2021 11:12:54 +0100
Message-Id: <34bce056b4047070c8ee111c57bd599405a95322.1638526120.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

4addr is not supported by the offload firmware yet

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- disable 4addr support for offload firmware only
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 47f23ac905a3..a753c7476d31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -194,6 +194,7 @@ mt7615_check_offload_capability(struct mt7615_dev *dev)
 		ieee80211_hw_set(hw, SUPPORTS_PS);
 		ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 
+		wiphy->flags &= ~WIPHY_FLAG_4ADDR_STATION;
 		wiphy->max_remain_on_channel_duration = 5000;
 		wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
 				   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR |
-- 
2.31.1

