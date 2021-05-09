Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE23437790F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 00:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEIWnk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 May 2021 18:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhEIWnk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 May 2021 18:43:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049C3C061573
        for <linux-wireless@vger.kernel.org>; Sun,  9 May 2021 15:42:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y9so18488366ljn.6
        for <linux-wireless@vger.kernel.org>; Sun, 09 May 2021 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwL6My/mFtFWZcll0pHCPGHD51NxptuT9Qe2aLO/Puw=;
        b=P8X64JDSbpUd8wi/1Vd54I0r8iVpNHHtaTIrS2pE4KNTuLS00TWmMLQ9Z5IL+2R3h/
         T67p/PyTqdSujKl51ZCkSfCjS0/zYdwxLqzmtNhJTFLvpisnqGe6eD62esuHkgMcj+Ls
         qTdOeyoCwbQKRSYVUjz8H8jSiomGZ3N+8izGhg27UdkCj/ffZRlt7gI1PEf6vNDkXa0i
         SOp7AuGHAzsap6ZJ0CQ8k8TgODb5JcRlxZbbvMkzevIG46KYE0wyd+29sodpyvoPka2i
         59kOHktnRWhZZDb/+xOuzqkinhB6Mh/rhy9BEsMHQRpVymMadhFxsUanuOtw9ZSbiRtO
         eFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwL6My/mFtFWZcll0pHCPGHD51NxptuT9Qe2aLO/Puw=;
        b=XWsM52F5IFdGLiO5A4J7XZawLRXb5yIsivr3oBcQc0W+Lnc66H7MeipnCF8OmMDoAX
         E2Dz37vCPKLzdsp7O4Bx3u3wkmFJYhH5hHYzEcryyNH/FKcegIXsVpD+vij/mxv+WlpY
         crWcRC22PlT2t9x6vk4VBvSOZsheHa6apW7C3jhUoPzHWRkUm0BoXMK5vpcMkbahTdTe
         jnr5b4Qw5Z2WpyZjvNa1WRJbxkWgjVawpH8UbJJHR/KC0qxEyyC+sUDuPFND3HfzMndh
         K3/QJIkvU84pFwP3LJPO5h6jQ5sUS9SeITkQEuJo34co1gSELGwbzmK6YuBwo5LCI+4l
         XwAQ==
X-Gm-Message-State: AOAM5331yh4aBB0+vwsotnRM0+U9jJ85qHPa3TDw3eIBYElwkL7o5IQs
        33Dk8oxsJIP78+kfJyHY9Wk7gGvxenPSKg==
X-Google-Smtp-Source: ABdhPJxTxXTg8Eki1uL2q4mdBYFgj92AR6YJCSx39RsPUD+Q7QoXRJ1DFUI9FDmTHI3YrpIZjjbEYg==
X-Received: by 2002:a2e:814d:: with SMTP id t13mr17117957ljg.467.1620600154364;
        Sun, 09 May 2021 15:42:34 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r25sm2018545lfm.145.2021.05.09.15.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 15:42:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] brcmfmac: Obtain reset GPIO
Date:   Mon, 10 May 2021 00:42:26 +0200
Message-Id: <20210509224226.348127-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This grabs the reset GPIO and holds it de-asserted, if available.
Asserting this signal will make the SDIO card re-enumerate.

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/common.c  | 10 ++++++++++
 .../net/wireless/broadcom/brcm80211/brcmfmac/common.h  |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index e3758bd86acf..40e18ebfe1ea 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -446,6 +446,16 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 		brcmf_dmi_probe(settings, chip, chiprev);
 		brcmf_of_probe(dev, bus_type, settings);
 	}
+	/* Fetch WL_RESET GPIO and de-assert it, if available */
+	settings->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (settings->reset) {
+		/*
+		 * If we found a reset GPIO, we may have just de-asserted it
+		 * so wait some 8 ms for PLLs to lock, se figure 32, WLAN
+		 * boot-up sequence in the manual.
+		 */
+		usleep_range(8000, 10000);
+	}
 	return settings;
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
index 8b5f49997c8b..4209e71ebcdd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
@@ -7,6 +7,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/platform_data/brcmfmac.h>
+#include <linux/gpio/consumer.h>
 #include "fwil_types.h"
 
 #define BRCMF_FW_ALTPATH_LEN			256
@@ -39,6 +40,8 @@ extern struct brcmf_mp_global_t brcmf_mp_global;
  * @roamoff: Firmware roaming off?
  * @ignore_probe_fail: Ignore probe failure.
  * @country_codes: If available, pointer to struct for translating country codes
+ * @board_type: String with the board type name
+ * @reset: GPIO descriptor for the RESET line
  * @bus: Bus specific platform data. Only SDIO at the mmoment.
  */
 struct brcmf_mp_device {
@@ -50,6 +53,7 @@ struct brcmf_mp_device {
 	bool		ignore_probe_fail;
 	struct brcmfmac_pd_cc *country_codes;
 	const char	*board_type;
+	struct gpio_desc *reset;
 	union {
 		struct brcmfmac_sdio_pd sdio;
 	} bus;
-- 
2.30.2

