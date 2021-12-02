Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59E466A8A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbhLBTj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 14:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhLBTj0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 14:39:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E180C06174A
        for <linux-wireless@vger.kernel.org>; Thu,  2 Dec 2021 11:36:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0D8362782
        for <linux-wireless@vger.kernel.org>; Thu,  2 Dec 2021 19:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37520C00446;
        Thu,  2 Dec 2021 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638473763;
        bh=YGZ+XD91BKvj+H6n4PEhbm/jDp6JoOiuUIe09XP5XQY=;
        h=From:To:Cc:Subject:Date:From;
        b=ppZRFieaORCKpAq5zbqmfuYOlg9gGB1XL0hlWIFGTxXk2yr7YI0HX6wdvf6VWJdRg
         0HbjHDYUECdCQ6svJ18WDrGdNiPakqawUD2HX8bXRTp1+uEZldZlaJcztd41RUQ4/q
         X4zTtDSFUwLVLJkCuA+ri+9FvlEJrVfovcVIWwfgJsYxQcdetbBvKYPnSluEw4FXl/
         +VTZ0wAzvkCm17VpJWXL2o24AI9DBXUNoqQImWS6GA66A7a1/DsUWSJu5zmXIC1DMa
         i4ilBQDfGvIFpJj5Km3R2sspNIVHSczGwJd4AE5g0D4up25ywwT/fxDYsI+7z+ACjB
         DPqyKHSL5lizQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7663: disable 4addr capability
Date:   Thu,  2 Dec 2021 20:35:57 +0100
Message-Id: <009c6c2bc8436f38de85e125cdd7157f1b21a2cf.1638473687.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

4addr is not supported by the driver/firmware yet

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 47f23ac905a3..52182ab6d240 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -378,6 +378,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	if (is_mt7663(&phy->dev->mt76)) {
 		wiphy->iface_combinations = if_comb;
 		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+		wiphy->flags &= ~WIPHY_FLAG_4ADDR_STATION;
 	} else {
 		wiphy->iface_combinations = if_comb_radar;
 		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_radar);
-- 
2.31.1

