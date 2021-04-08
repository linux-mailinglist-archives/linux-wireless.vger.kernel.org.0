Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363AF3581D2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhDHLbB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhDHLa6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 07:30:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4762C061763
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 04:30:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh5so956390pjb.5
        for <linux-wireless@vger.kernel.org>; Thu, 08 Apr 2021 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whg5uvgIxjBQi611PiDallF8tjAml5Jz5ytoZKbEBgI=;
        b=z15WyVNWMuOFLu9lTNFRL8UtMgUPlrJRlSdO6RtMUQhZnqJ4YKyXFHrtKo0xUCMzqU
         aIcxyvcAHaRhVgE25Zmdwvj+r2GsuP5+BPI6rkoxuT6WrRYSFhQpV5IDFxqXaiJyvoQq
         BkLaslzdgXUSqO3UBUz2mJlSAedDsHjk8BDX9r1u+/g2yqdOhqMjVt0V17e05QbKt1td
         4hfaktJC3DMAEPc+v3DZ5zJihDvaDW4Dx37PCDzhBbhxVjmbMAdF37RPBQIKc27MYdJD
         /r+NAlmp2gz7Fxee6/xW4L7yAQ/Xpeh6VCpm8TeDmf+rhv6CJ7AvgihbQpIYhv/1wpE9
         QwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=whg5uvgIxjBQi611PiDallF8tjAml5Jz5ytoZKbEBgI=;
        b=bYfblp2AclIafgVd5HFxlF3Dv1BVPB0P1Pe2aZpr8QC8rizbkgQrKz9oTMusvOwwMx
         EvwSibRuCX3smw0zTmIWwHTGUUcjwaWknc8RRluaDbHCiG2TzVQ6IxzK7qlorZXJBeZ5
         0TR7MTiuyUwhUe+FO/9z6WTT4CPqLL5XAt9x44L6s+Q3M/Yaa6Sv+ARBLoZf6NLZ50nR
         /6TpXrcMVnpKQJei7ef63Md/5P5PDacu+F0QthoF21d6tnckIC2d8RT9gE0dsPvmmKX2
         LUZGGdR+V/fGGPY+wvTndefKrEgdTOPnoiij9l8VNRs8lmp284uCcpXx2QLwPu2Rz+/U
         yJRQ==
X-Gm-Message-State: AOAM530g6tP0V16SwTlxGka3UGnqXM5SlWLcJPMnHQdU5emO2A7ul8/U
        mVgQAHC55ZdTeY0iyTq4cbfrxw==
X-Google-Smtp-Source: ABdhPJyQvGADSuc6DEN+e9ZixTPoEGAvz9QaetodxFRXkaG0uvAqaN8gVXT8JZC4sZqzJMuM+YJwrw==
X-Received: by 2002:a17:902:ea89:b029:e9:2813:2db9 with SMTP id x9-20020a170902ea89b02900e928132db9mr7250665plb.61.1617881447259;
        Thu, 08 Apr 2021 04:30:47 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id x18sm7753267pfi.105.2021.04.08.04.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:30:46 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] brcmfmac: support parse country code map from DT
Date:   Thu,  8 Apr 2021 19:30:22 +0800
Message-Id: <20210408113022.18180-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408113022.18180-1-shawn.guo@linaro.org>
References: <20210408113022.18180-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With any regulatory domain requests coming from either user space or
802.11 IE (Information Element), the country is coded in ISO3166
standard.  It needs to be translated to firmware country code and
revision with the mapping info in settings->country_codes table.
Support populate country_codes table by parsing the mapping from DT.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index a7554265f95f..ea5c7f434c2c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -12,12 +12,61 @@
 #include "common.h"
 #include "of.h"
 
+static int brcmf_of_get_country_codes(struct device *dev,
+				      struct brcmf_mp_device *settings)
+{
+	struct device_node *np = dev->of_node;
+	struct brcmfmac_pd_cc_entry *cce;
+	struct brcmfmac_pd_cc *cc;
+	int count;
+	int i;
+
+	count = of_property_count_strings(np, "brcm,ccode-map");
+	if (count < 0) {
+		/* The property is optional, so return success if it doesn't
+		 * exist. Otherwise propagate the error code.
+		 */
+		return (count == -EINVAL) ? 0 : count;
+	}
+
+	cc = devm_kzalloc(dev, sizeof(*cc) + count * sizeof(*cce), GFP_KERNEL);
+	if (!cc)
+		return -ENOMEM;
+
+	cc->table_size = count;
+
+	for (i = 0; i < count; i++) {
+		const char *map;
+		int ret;
+
+		cce = &cc->table[i];
+
+		if (of_property_read_string_index(np, "brcm,ccode-map",
+						  i, &map))
+			continue;
+
+		/* String format e.g. US-Q2-86 */
+		strncpy(cce->iso3166, map, 2);
+		strncpy(cce->cc, map + 3, 2);
+
+		ret = kstrtos32(map + 6, 10, &cce->rev);
+		if (ret < 0)
+			dev_warn(dev, "failed to read rev of map %s: %d",
+				 cce->iso3166, ret);
+	}
+
+	settings->country_codes = cc;
+
+	return 0;
+}
+
 void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		    struct brcmf_mp_device *settings)
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
 	int irq;
+	int ret;
 	u32 irqf;
 	u32 val;
 
@@ -47,6 +96,10 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	    !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
 		return;
 
+	ret = brcmf_of_get_country_codes(dev, settings);
+	if (ret)
+		dev_warn(dev, "failed to get OF country code map\n");
+
 	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
 		sdio->drive_strength = val;
 
-- 
2.17.1

