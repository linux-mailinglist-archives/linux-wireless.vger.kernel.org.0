Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90F5BD4F2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 20:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiISSy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiISSy4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 14:54:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DDA19C00
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 11:54:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so145952pjo.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LHt2asP7IS39+HUdIYEAweJxqFZWBJgPF+CNSEdqcO8=;
        b=WiQw1fEwVz1wsac4d7nmD7OuORFCn2snakK0+6I6Z/OXWqZMmpSKVdYRsRtKO+2xOm
         B+MLUNb5DYPux8X3IhnjNc2VPaYGLsmxGwKxZfq0ImkZrBNBd0WR9W9stYxmwdY89Dyg
         nYYLkktQuJEUKyvwJobmeZDJGM64gGp0pjcZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LHt2asP7IS39+HUdIYEAweJxqFZWBJgPF+CNSEdqcO8=;
        b=tz5BBH2dhzFc5iHGI+eYkca/5ODVAt3kh4+iWv/QMjqINiwBW+wCRd50dBBWD0phlN
         vvwxEWVO+cUSLY3URFMr1CyWE7POd0O91fisksur4ft5Fp06BHN1z6Y2NAbea/0Z1rHx
         3XifHVH49NqZGDD2xrl+rYniZjSajb6l4ebBROxV3uMZivCOkVQpRY7cMvNNc4NXb0dw
         dqUkIJNULb7DVMLR/efpar2eyqnojCWcG8sPkALmqOtn1+JtPBgUU+IVHmVO51W1y8Vd
         LFv24Yg40Yd1hQ+LvKchgXuOXtAI2EhSjkWQiGIkTYxfAt7p7byoVt6DLhMbuWo9ELzD
         mX6g==
X-Gm-Message-State: ACrzQf0yw0UtjSjUmL2s55cUR9Wd0AHzBpx6w3mVaTIaDFaNcfRLHxGW
        DX4R9kmqqHMUE7o/FTfaUk6J4g==
X-Google-Smtp-Source: AMsMyM6X5DXgNLS/Eq9ke3FGhQ1UwUPCegmw6Ux0BObi1EdyMkhlWSeIxqlu+DKO+XfDPFQVFc2Pxw==
X-Received: by 2002:a17:903:284:b0:178:2a94:9b6a with SMTP id j4-20020a170903028400b001782a949b6amr1126189plr.135.1663613695340;
        Mon, 19 Sep 2022 11:54:55 -0700 (PDT)
Received: from localhost (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with UTF8SMTPSA id p14-20020a170902e74e00b00177324a7862sm21354709plf.45.2022.09.19.11.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:54:54 -0700 (PDT)
From:   Jun Yu <junyuu@chromium.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Jun Yu <junyuu@chromium.org>
Subject: [PATCH v2] wifi: ath11k: retrieve MAC address from system firmware if provided
Date:   Mon, 19 Sep 2022 18:54:48 +0000
Message-Id: <20220919185448.545399-1-junyuu@chromium.org>
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

