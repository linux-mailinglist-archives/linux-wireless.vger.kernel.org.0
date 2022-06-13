Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F315854838A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiFMJTj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 05:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbiFMJTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD21F14D14
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d14so6208215eda.12
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to
         :cc;
        bh=OHBXs0DbY77ATKoHUGkTyqnhfdtuttsxGgPkMN1OQUc=;
        b=SOpniUvrIwzr3EsUmruKb70w1NZ0wsgcN7oliL4cEsnv3MbBrSzVH724MpxdpLdFw3
         9GZbrLFxEnFQ6pXRkdS4VNo06PN3MKwfAyZ0QOEMb4GkY8wvc+W91+wD4pUAZqEfW5IB
         zsXZeJ5A34ALvS4ehJPUR8PEYMScXG7hjUOzEIdWGQR3VxzL7TVh1NksxM2ZLGD4Henn
         9hegXMo1GOlDVvJ0+2is7eUzurudkA3+ZpYW5+TuB0PV+84+iXVj4Ri5mb4u+nHmILPu
         BqADSvwtIObfDkE+T6RLeqPd34m3KfZCSw282bw3i2W47XW9w6h34iOI9TPs0tWaiLR0
         1KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to:cc;
        bh=OHBXs0DbY77ATKoHUGkTyqnhfdtuttsxGgPkMN1OQUc=;
        b=msGFhqP+NpsEuazGCfJxZlxIJ2mVlnVmpLoK2Le/pK78K7TTTuzmuqDJba4a60JXLc
         ZOftU8eIGAdAsf8LUTaZzWU5251Vq6bRbskHklbiWr4m1MjzqkF3HSEcPYz+idlNuY0l
         OBiSBqZ7Fxx6PyDMjWfiWkejmLVxaVSVMwySC8g6S6c+pSERJJyIeUErosjBl1hoJVYr
         LTCPTUkC89oyZoFUnYYt6EVMQD4XCLlKTUhj/aOBuPtukfqw6s2qi3EOj6vJkUgoeS/N
         hfDWGcbrrdO4zcoYy7tPuRxShqD9T8bf+fyU7VzCOOWoWHhiJxw+YNAzZqYNUXXqZnXw
         0BWQ==
X-Gm-Message-State: AOAM532+0n+rtxqpBsspgKw1LBrYu1HUFgmOjojb8b7tb8ILqKf622Aq
        EAvv+ltZfCzBdelE6TppEmDdUk+yIfO6Oj34F0w=
X-Google-Smtp-Source: ABdhPJx4xn566r0x4dkv4J/CjL0s+WbrGpg3vsHyoCzJ0+w/7ZHtuTqzWa+CaT3jqynibVoAP0DJ85FEWir3IWEOEC0=
MIME-Version: 1.0
X-Received: by 2002:a05:6402:1d51:b0:41f:cf6c:35a5 with SMTP id
 dz17-20020a0564021d5100b0041fcf6c35a5mr64939661edb.25.1655111970315; Mon, 13
 Jun 2022 02:19:30 -0700 (PDT)
Received: from 35650733073 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jun 2022 05:19:29 -0400
From:   aspriel@gmail.com
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
Date:   Mon, 13 Jun 2022 05:19:29 -0400
Message-ID: <CAJ65rDwMzF8hhuykrikSdsPMgy4GhLkTUfqTfn-cbHwCL5OE2Q@mail.gmail.com>
Subject: [PATCH 7/7] brcmfmac: introduce BRCMFMAC exported symbols namespace
To:     Kalle Valo <kvalo@kernel.org>, arend.vanspriel@broadcom.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of using EXPORT_SYMBOL() use namespace variant and only if
build vendor-specific code as separate module.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c   | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h     | 6 ++++++
 .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c   | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c    | 4 ++--
 .../net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c   | 1 +
 5 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
index 790116a735c7..d55f3271d619 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
@@ -21,6 +21,7 @@ static void __exit brcmf_bca_exit(void)
 }

 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(BRCMFMAC);

 module_init(brcmf_bca_init);
 module_exit(brcmf_bca_exit);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 5d627b8dbb50..8cafe59c089d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -13,6 +13,12 @@
 #include <net/cfg80211.h>
 #include "fweh.h"

+#if IS_ENABLED(CONFIG_BRCMFMAC_VENDOR_MODULES)
+#define BRCMF_EXPORT_SYMBOL_GPL(__sym)	EXPORT_SYMBOL_NS_GPL(__sym, BRCMFMAC)
+#else
+#define BRCMF_EXPORT_SYMBOL(__sym)
+#endif
+
 #define TOE_TX_CSUM_OL		0x00000001
 #define TOE_RX_CSUM_OL		0x00000002

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
index 34294724a1f8..f82fbbe3ecef 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
@@ -21,6 +21,7 @@ static void __exit brcmf_cyw_exit(void)
 }

 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(BRCMFMAC);

 module_init(brcmf_cyw_init);
 module_exit(brcmf_cyw_exit);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index d0ba2aba093b..be72203f4e0b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -112,7 +112,7 @@ int brcmf_fwvid_register_vendor(enum
brcmf_fwvendor fwvid, struct module *vmod,

 	return 0;
 }
-EXPORT_SYMBOL(brcmf_fwvid_register_vendor);
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fwvid_register_vendor);

 int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct
module *mod)
 {
@@ -145,7 +145,7 @@ int brcmf_fwvid_unregister_vendor(enum
brcmf_fwvendor fwvid, struct module *mod)

 	return 0;
 }
-EXPORT_SYMBOL(brcmf_fwvid_unregister_vendor);
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fwvid_unregister_vendor);
 #else
 static inline int brcmf_fwvid_request_module(enum brcmf_fwvendor fwvid)
 {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
index 23e3a4557880..02918d434556 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
@@ -21,6 +21,7 @@ static void __exit brcmf_wcc_exit(void)
 }

 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(BRCMFMAC);

 module_init(brcmf_wcc_init);
 module_exit(brcmf_wcc_exit);
-- 
2.32.0
