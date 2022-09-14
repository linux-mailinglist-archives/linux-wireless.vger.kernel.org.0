Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D7E5B904F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiINVy5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Sep 2022 17:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiINVyz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Sep 2022 17:54:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603C41A394
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 14:54:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w20so4385675ply.12
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=J7CDL9lle37BJBHK8KbYdH5/36p6tFHxGpB6pf/8hl8=;
        b=Zm7e6V3orV2XO7UZsEKPCSvTmmFt4sWoifcuIn92eHvnWqkUkMpyoaVnihEE8UZiCX
         8QT8s2xCQSAWkdaVy86ZAndjSYyRj1pFwruvLE1KpWRi91z+fmdcps7sX1w9TAeV2wnF
         QHw2gtNCdCMOXABwyPd12u+RYW49M0l9HRcjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=J7CDL9lle37BJBHK8KbYdH5/36p6tFHxGpB6pf/8hl8=;
        b=bG3YWd9+mOJkByibirZRaRoaFVK/TGtaZnnhp1MwZvyLE4W1ktT8XUKzTcMr0xvUX0
         Z6jgRcImkTLa8JhIUiT0Z+4glqloKsfKOACoEOAPuxXudwVh8s2g9KpToGp12SUjFtSd
         XToHFZSd+r9lGDrYLb5gCOWYrKe9FEUmlbmi49JFsLiqnBt0boSLrIg/llttmoXJYNMJ
         kJHMr+wJLLTyYR4aR+Qe0aHz6EhoeZjyjP5P/JAzVoBGrWgRKm+sB4XTjEVnb0Ds7MJf
         Xfnbi8Yt01YFiy6X5i+m5jE2I2oJPr3EiEzqhNT6V1grj05iyELNEywz4LOjgfQu7jbn
         pIzw==
X-Gm-Message-State: ACrzQf0XwN7LmA6ugs8RshI5DAUloR/c6cXV1RzwphyS9C5/SWeNtFe/
        NY9YSbPGf3jb4EXMsMxyvn87zGneKWeERw==
X-Google-Smtp-Source: AMsMyM5iHfh7Ryf7S125IAf1xHDJpQPJYCqZRiNfAqzIhUSj8M1Rk/BeXxgAmgMGcsB6pqGkf4f3zA==
X-Received: by 2002:a17:90b:3ec9:b0:203:246e:4370 with SMTP id rm9-20020a17090b3ec900b00203246e4370mr3318541pjb.221.1663192492996;
        Wed, 14 Sep 2022 14:54:52 -0700 (PDT)
Received: from localhost (139.69.82.34.bc.googleusercontent.com. [34.82.69.139])
        by smtp.gmail.com with UTF8SMTPSA id u8-20020a170902e5c800b001725d542190sm10927467plf.181.2022.09.14.14.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 14:54:52 -0700 (PDT)
From:   Jun Yu <junyuu@chromium.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Jun Yu <junyuu@chromium.org>
Subject: [PATCH] wifi: ath11k: retrieve MAC address from system firmware if provided
Date:   Wed, 14 Sep 2022 21:54:08 +0000
Message-Id: <20220914215408.372520-1-junyuu@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Devices may provide their own MAC address via system firmware (e.g.,
device tree), especially in the case where the device doesn't have a
useful EEPROM on which to store its MAC address (e.g., for integrated
ahb WCN6750).

Use the generic device helper to retrieve the MAC address, and (if
present) honor it above the MAC address advertised by the card.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Jun Yu <junyuu@chromium.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7e91e347c9ff2..591b2b97ca818 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8,6 +8,7 @@
 #include <linux/etherdevice.h>
 #include <linux/bitfield.h>
 #include <linux/inetdevice.h>
+#include <linux/property.h>
 #include <net/if_inet6.h>
 #include <net/ipv6.h>
 
@@ -8967,6 +8968,7 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	struct ath11k_pdev *pdev;
 	int i;
 	int ret;
+	u8 mac_addr[ETH_ALEN] = {0};
 
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
@@ -8979,13 +8981,18 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	if (ret)
 		return ret;
 
+	device_get_mac_address(ab->dev, mac_addr, sizeof(ab->mac_addr));
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 		if (ab->pdevs_macaddr_valid) {
 			ether_addr_copy(ar->mac_addr, pdev->mac_addr);
 		} else {
-			ether_addr_copy(ar->mac_addr, ab->mac_addr);
+			if (is_zero_ether_addr(mac_addr))
+				ether_addr_copy(ar->mac_addr, ab->mac_addr);
+			else
+				ether_addr_copy(ar->mac_addr, mac_addr);
 			ar->mac_addr[4] += i;
 		}
 
-- 
2.37.2.789.g6183377224-goog

