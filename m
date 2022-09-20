Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D37B5BD8CA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 02:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiITAb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 20:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiITAb0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 20:31:26 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5751B27B34
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 17:31:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e5so1225308pfl.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3PNG2GhX9MS6pqBLx1SD4wmDS0vBOFDzpiI8k/Y1NQY=;
        b=JkkhATs/ylEliOjshIBZv+N9/k5iW7my8lvUE9I1I77Pv5bpmUCxYJeFHFzHm/9C0t
         d8AF/oT6R3kL4GlNSZuj0/srd5+xF6r+MERfgcMWzbBEdK+Ub7s2WcLu1t/vsdm7T8en
         h4UihtZ2SZA82JjnbDlOex/X7vF+i1F1XeAGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3PNG2GhX9MS6pqBLx1SD4wmDS0vBOFDzpiI8k/Y1NQY=;
        b=qGAsU+oQfRQhMOuliAfpKxhI5lBZf8rzUo29uaMbrrM9Oiqd61kabSmAARncgmqLf7
         rDEWuZ+NlD2D5MfVAiRLBwe66AXkTbJRFJ6wQ9C11t3iTNhxRHTFwDVRPUn2nTY5Hjvw
         WwbvoOyJiuLbNxkRLotX65W0K0KOvZCeAg8Z+5pirfHbRq6YWvxZhBTmrVGCh+QDjiiO
         +jf1L4Y2wPq5R900xXmE2jUC4iGjDkshw1lcTZSstqhMiCt7IkOMj2haAYCjPXZJvEgw
         00RnI+wkvSjjGEZRXLw4V5iNzyOTEYd5pP9jxF0P86Oi+q/WKCWmQwuNoTLwJnQ9ncI0
         BUJw==
X-Gm-Message-State: ACrzQf1KawVjRfPCrRlQCJSbwKmwYLFymCvFSL1O1gkP8y+z7pyGN1aT
        3zTHgb8QW6p1Xbq1xhMxQ8hguQ==
X-Google-Smtp-Source: AMsMyM5GDRcjQxtGAMgNL3Tom47j2MIdBldFkbGeDcXaQTVDfAeG2GO9ll7QI+Ah8reV8QQQMslK+A==
X-Received: by 2002:a63:fc14:0:b0:430:d1d0:fe33 with SMTP id j20-20020a63fc14000000b00430d1d0fe33mr17757445pgi.328.1663633884836;
        Mon, 19 Sep 2022 17:31:24 -0700 (PDT)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with UTF8SMTPSA id d2-20020a170902cec200b0015e8d4eb219sm21403855plg.99.2022.09.19.17.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 17:31:24 -0700 (PDT)
From:   Jun Yu <junyuu@chromium.org>
To:     ath11k@lists.infradead.org, quic_jjohnson@quicinc.com
Cc:     linux-wireless@vger.kernel.org, Jun Yu <junyuu@chromium.org>
Subject: [PATCH v3] wifi: ath11k: retrieve MAC address from system firmware if provided
Date:   Tue, 20 Sep 2022 00:31:17 +0000
Message-Id: <20220920003117.841442-1-junyuu@chromium.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v2 -> v3: add patch changelog
v1 -> v2: use the updated device_get_mac_address signature

 drivers/net/wireless/ath/ath11k/mac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7e91e347c9ff2..16a238ef713e7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8967,6 +8967,7 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	struct ath11k_pdev *pdev;
 	int i;
 	int ret;
+	u8 mac_addr[ETH_ALEN] = {0};
 
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
@@ -8979,13 +8980,18 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	if (ret)
 		return ret;
 
+	device_get_mac_address(ab->dev, mac_addr);
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
2.31.0

