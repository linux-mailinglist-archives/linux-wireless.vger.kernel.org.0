Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9EB496CC2
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jan 2022 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiAVO7U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Jan 2022 09:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiAVO7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Jan 2022 09:59:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2025CC06173B
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 06:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A00C260DCB
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 14:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01565C004E1;
        Sat, 22 Jan 2022 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642863554;
        bh=xRQiJJFG76hnTUsM/sn8k0gKg0XbKbeYVC2ttH9gU1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gA7YPWQZrqV3ie8opCw/rlG3Q5viVHssgK+rJmcqQvN1zoKSFVXNvARTKqU+ZnK3Y
         P3FFhi3Iv/ncITZd88x4LvtyML8RYpuzXZT3R1f0BX7peHC+9RdJ+RX40b10oDyN4N
         qjmfk1vlGBT0Vji3OtOBbPiE+iyffxiylRgGizXdXSLPzFJXLbFZa7XSZ4a0lfCF0D
         UMdgqWjHsiPi05p+fko9QK24tEN99RpILHYzkybwgogqgNxeSpun3WmDd+PhUXlGJz
         sviyYwSvCuBo/T+qwTpAsnVa6TAFBnd9QHjImQxIkzTUjykOecv5UThMWLRInb8j0e
         9Kw6h2K4Wwvyg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 2/2] mt76: mt7615: check sta_rates pointer in mt7615_sta_rate_tbl_update
Date:   Sat, 22 Jan 2022 15:58:58 +0100
Message-Id: <c8da460f23e5d9df3b27a91d67667990dc2dbb6b.1642863255.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642863255.git.lorenzo@kernel.org>
References: <cover.1642863255.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check sta_rates pointer value in mt7615_sta_rate_tbl_update routine
since minstrel_ht_update_rates can fail allocating rates array.

Fixes: 04b8e65922f63 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 9f7ac78f1222..fca38f0e1a27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -689,6 +689,9 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 	struct ieee80211_sta_rates *sta_rates = rcu_dereference(sta->rates);
 	int i;
 
+	if (!sta_rates)
+		return;
+
 	spin_lock_bh(&dev->mt76.lock);
 	for (i = 0; i < ARRAY_SIZE(msta->rates); i++) {
 		msta->rates[i].idx = sta_rates->rate[i].idx;
-- 
2.34.1

