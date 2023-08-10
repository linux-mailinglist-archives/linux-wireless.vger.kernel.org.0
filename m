Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206F977777C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 13:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjHJLuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 07:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHJLuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 07:50:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313410E7
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 04:50:04 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RM4vP4CvQz1L9w0;
        Thu, 10 Aug 2023 19:48:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 19:50:01 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <jerome.pouiller@silabs.com>, <kvalo@kernel.org>
CC:     <lizetao1@huawei.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH -next] wifi: wfx: Use devm_kmemdup to replace devm_kmalloc + memcpy
Date:   Thu, 10 Aug 2023 19:49:39 +0800
Message-ID: <20230810114939.2104013-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the helper function devm_kmemdup() rather than duplicating its
implementation, which helps to enhance code readability.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/wireless/silabs/wfx/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index 0b50f7058bbb..ede822d771aa 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -293,13 +293,12 @@ struct wfx_dev *wfx_init_common(struct device *dev, const struct wfx_platform_da
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 	hw->wiphy->n_iface_combinations = ARRAY_SIZE(wfx_iface_combinations);
 	hw->wiphy->iface_combinations = wfx_iface_combinations;
-	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmalloc(dev, sizeof(wfx_band_2ghz), GFP_KERNEL);
+	/* FIXME: also copy wfx_rates and wfx_2ghz_chantable */
+	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmemdup(dev, &wfx_band_2ghz,
+							   sizeof(wfx_band_2ghz), GFP_KERNEL);
 	if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
 		goto err;
 
-	/* FIXME: also copy wfx_rates and wfx_2ghz_chantable */
-	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz, sizeof(wfx_band_2ghz));
-
 	wdev = hw->priv;
 	wdev->hw = hw;
 	wdev->dev = dev;
-- 
2.34.1

