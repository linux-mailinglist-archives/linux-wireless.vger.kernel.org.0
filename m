Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D6496CC1
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jan 2022 15:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiAVO7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Jan 2022 09:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiAVO7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Jan 2022 09:59:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FE0C06173D
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 06:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3328B801C1
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 14:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71422C340E4;
        Sat, 22 Jan 2022 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642863552;
        bh=b98vHUG1Ig12yhmR/tvv+3Bm1JhY7JuxW2Clf5W09l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXLFEPPXMrKA4iXfS+SUZxrWx3wSWq1vb01gqDLcbwyqI/8lktrQx5IIx4svyI7AF
         EQLxwv0vqIYZtcNuHyOT+Ao5UeZ9vgpj6f2/fG0qGvo4G0OOA/lkI3ixnlKojdR2Ss
         yRPYK7j92HWRpOaXptz75+dFoY4+nd9S51lSqy5gJykC/zjC1wsmI7skjligGFK4w+
         iWwIFHGNI3PePpMsH/15HJIYhpTeZtgkf1/aeQlrLUqOY0PAfo5mJf5qlGtGDAIcxA
         3oCKc20Bemo22VX+8Y2hKAJRAASe7AHGiaTNzeiZ5mEhf8u/ExonSfq/RpG52BmyNC
         o9jE3DjFnSLEg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 1/2] mt76: mt7603: check sta_rates pointer in mt7603_sta_rate_tbl_update
Date:   Sat, 22 Jan 2022 15:58:57 +0100
Message-Id: <bdb88f8ce1250b0934aaae1d92360e3431a36ba8.1642863255.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642863255.git.lorenzo@kernel.org>
References: <cover.1642863255.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check sta_rates pointer value in mt7603_sta_rate_tbl_update routine
since minstrel_ht_update_rates can fail allocating rates array.

Fixes: c8846e1015022 ("mt76: add driver for MT7603E and MT7628/7688")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 2b546bc05d82..83c5eec5b163 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -641,6 +641,9 @@ mt7603_sta_rate_tbl_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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

