Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20B63C184
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 14:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiK2NzZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 08:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiK2NzX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 08:55:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C325B56EEF
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:21 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id x17so22187656wrn.6
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xx9KeJ585Iqv7hOUO0YZtymPwDApgXhYGIbV4fHlbk=;
        b=UqWNCUcs+8z+GAR5rKH8U9FplEUMzgD91rUWrQIvJWCrcH6BUqxEM6JGNZBIe5Kzea
         xuegJekPke8dcte8Tsf6XYyo3Mx/nGg4QdbjTwUcND95OtjbkUIdZlHJdOE7S9NK9nbP
         6btenutUaPiYzqqdIczPVzJmZpktkPv7fn3N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xx9KeJ585Iqv7hOUO0YZtymPwDApgXhYGIbV4fHlbk=;
        b=P3Od2mz88+fUoMzIaC2Dk8laHJSMeMHKb1/A4kZ65sDBHg2zhGJneuTuFIZ+5s5Z7D
         YGshRiUw3Elsl7NDZnP1uq+ialE3ECzhHN5iQeCi00Nf/itRfRWeH20ZUTbNillKlwbf
         mYAlksRaf/SQXDMHMMfN2kBZqfOXMYryytxIaywdH0WhVGHyPOppyQqW3W4+fwL7y2/g
         MAbxsesg9OD0C/Egfcq/2oGQmOrdwaChuuct2R8yJCUXhuCTNwO7VZeKMK7X+W6RdQXj
         PC7fxi7xTU1CheKvx2W3ax+9FI+mLovgwzliFk/cE3Ph92q6Ps8SKIdGbIX98F0hPVgX
         j9EQ==
X-Gm-Message-State: ANoB5pn7DsresMyo0ZyA4QrhCzanXEYEbdaZFkOTxqUq8mJUKQHu1tJB
        r84pYpcLvuYQuYHgb4rx05oaGw==
X-Google-Smtp-Source: AA0mqf4aAmCnsvufUaPMze1Kre+sO59ezTe/h9O2f8GsviDLVlplyWi1ATiJ3nwpdSorcJQrbYznug==
X-Received: by 2002:a5d:5611:0:b0:241:cfa5:20d9 with SMTP id l17-20020a5d5611000000b00241cfa520d9mr28224425wrv.451.1669730120348;
        Tue, 29 Nov 2022 05:55:20 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.com ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b003b4935f04a4sm2472005wmb.5.2022.11.29.05.55.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:55:18 -0800 (PST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>
Subject: [PATCH V2 7/7] brcmfmac: introduce BRCMFMAC exported symbols namespace
Date:   Tue, 29 Nov 2022 14:54:46 +0100
Message-Id: <20221129135446.151065-8-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
References: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b4c9ba05ee9c56b6"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000b4c9ba05ee9c56b6
Content-Transfer-Encoding: 8bit

Using a namespace variant to make clear it is only intended to be used
by the vendor-specific modules. The symbol will only truly export the
symbols when the driver and consequently the vendor-specific part are
built as kernel modules.

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

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
index 790116a735c7..d55f3271d619 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
@@ -21,6 +21,7 @@ static void __exit brcmf_bca_exit(void)
 }
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(BRCMFMAC);
 
 module_init(brcmf_bca_init);
 module_exit(brcmf_bca_exit);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index a98b86982502..e4f911dd414b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -13,6 +13,12 @@
 #include <net/cfg80211.h>
 #include "fweh.h"
 
+#if IS_MODULE(CONFIG_BRCMFMAC)
+#define BRCMF_EXPORT_SYMBOL_GPL(__sym)	EXPORT_SYMBOL_NS_GPL(__sym, BRCMFMAC)
+#else
+#define BRCMF_EXPORT_SYMBOL_GPL(__sym)
+#endif
+
 #define TOE_TX_CSUM_OL		0x00000001
 #define TOE_RX_CSUM_OL		0x00000002
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
index 34294724a1f8..f82fbbe3ecef 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
@@ -21,6 +21,7 @@ static void __exit brcmf_cyw_exit(void)
 }
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(BRCMFMAC);
 
 module_init(brcmf_cyw_init);
 module_exit(brcmf_cyw_exit);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index 6f16157a8a4e..86eafdb40541 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -109,7 +109,7 @@ int brcmf_fwvid_register_vendor(enum brcmf_fwvendor fwvid, struct module *vmod,
 
 	return 0;
 }
-EXPORT_SYMBOL(brcmf_fwvid_register_vendor);
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fwvid_register_vendor);
 
 int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct module *mod)
 {
@@ -142,7 +142,7 @@ int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct module *mod)
 
 	return 0;
 }
-EXPORT_SYMBOL(brcmf_fwvid_unregister_vendor);
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fwvid_unregister_vendor);
 #else
 static inline int brcmf_fwvid_request_module(enum brcmf_fwvendor fwvid)
 {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
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
2.35.1


--000000000000b4c9ba05ee9c56b6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCs1Ub3oZ/4Fl2Aa2Do
LJdpd//M1TtoQLKq7R05/DzbDDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjExMjkxMzU1MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAhd7pZDxJifzJ6DANsaRhfa4cPwSibYs5aa43
/S+Mu540OmO4Ok7aP/eW5TXwVZb5/rYiFgife/rDf+8ghd2tmd5i2nzd2mtnBYpCkucIJMptFq+a
LCR5c11e+GKMJlJYqDq5p2MvfYW0AvcQ0+bLQaXIc0pYvfPj2j63c4r+Vbc0mhyF7264w8NVqLw7
0F5PbaHpjLxb/wgOrr4KXPKJR6hsWfXGzCThENV7vNzmIN37p+laWsxPZpF+a9RoN7zFm1RLglHG
5P4EUjqx2DA3S9ZEGRwYMJu5Z09bZZ7VzFF0iPzsx9SBvbmxWLYfwaSUEHkMYHasF8vK62XkMd6l
3Q==
--000000000000b4c9ba05ee9c56b6--
