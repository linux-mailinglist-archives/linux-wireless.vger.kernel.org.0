Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282B963C17D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 14:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiK2NzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 08:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiK2NzL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 08:55:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C70751C15
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d1so22207642wrs.12
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K6BxC9Few1unoYyEXS7ken2ZfO5fb2GBQ1okhO96VMI=;
        b=HsS/+s+6iRC++8iMVshLhVTq0/PWkWtSIG++WJkKKv4tkaKOE6n3sFr8/kCg66Xtag
         YTRJ1azyL9Pd9Z1Dz5KWReQAe/NgUKsU/CqxxUqh0fjQOyeZHxmRvcpPjqspuRa7EX3K
         Qanca+hcl5J4N6cbj607isJg5xzXYhkjWdAvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6BxC9Few1unoYyEXS7ken2ZfO5fb2GBQ1okhO96VMI=;
        b=PrwLQnYnV1gUlHg4kIfRUy1mrtXkJ3pMk2N3V+YAlbZUWpq4Kz+L7IAEYnCsYaoQil
         93Dz5Bc2SBpBZIosHzc9pQR3StmiEp/ovnp2MXuqZcY/naS3UjZNhQiH6KeuXpueaSEn
         nnt2817opE/m3RYQaI4zc4NaG/Q9sIHjWbw27uOXkgtDlVT4GUbYvQ1nv07vRwL835rt
         2Iyw/aGpWRV++e50lGX1tF9fP2cUs7cjjbCa2tgNcbrvTtDhw6sNChFset+95wXq4x/p
         CSe68H6FGux8j7CXVwRpQ6mXIsz8ZwJFZxghzPkNJydNqA6KRVjeomZe5gjnuyArEw1J
         owaw==
X-Gm-Message-State: ANoB5pma1i3pGaMk+ReJYaxyLLp+Vts2kL+UYjXN9hTV3S9Gmh/FNXcI
        oU5iiHTbNZ4pjaGaKshgvDKWsw==
X-Google-Smtp-Source: AA0mqf7tycQ08NQXyWtWPLMBKiyo2QZBSy7Tcu05qN6Co8XESEwprHEN48E2ILFzQlkcNJeLAw7Y3A==
X-Received: by 2002:a5d:5611:0:b0:241:cfa5:20d9 with SMTP id l17-20020a5d5611000000b00241cfa520d9mr28223918wrv.451.1669730108052;
        Tue, 29 Nov 2022 05:55:08 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.com ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b003b4935f04a4sm2472005wmb.5.2022.11.29.05.55.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:55:07 -0800 (PST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V2 0/7] brcmfmac: support devices from multiple vendors
Date:   Tue, 29 Nov 2022 14:54:39 +0100
Message-Id: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f9fd5f05ee9c554a"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000f9fd5f05ee9c554a
Content-Transfer-Encoding: 8bit

Took my sweet time coming with this follow-up series, but here
it is. Hopefully, sending patches is working for me now.

The bcm43xx family of wifi chipsets found its way to different
groups inside and outside Broadcom. For the fullmac devices this
means that in those difference groups firmware is being developed
and the firmware api is bound to diverge. This series introduces
a design change to accomodate supporting multiple firmware api's.
The vender-specific support can be compiled in brcmfmac or
built as a separate module. Currently the vendor-specific support
does not have any real effect. At the momemt looking into SAE support
which appear to be different for Cypress devices so that might be a
first use-case.

The patches apply to the main branch of the wireless-next repository.

Arend van Spriel (7):
  brcmfmac: add function to unbind device to bus layer api
  brcmfmac: add firmware vendor info in driver data
  brcmfmac: add support for vendor-specific firmware api
  brcmfmac: add support for Cypress firmware api
  brcmfmac: add support Broadcom BCA firmware api
  brcmfmac: add vendor name in revinfo debugfs file
  brcmfmac: introduce BRCMFMAC exported symbols namespace

 .../broadcom/brcm80211/brcmfmac/Makefile      |  11 +
 .../broadcom/brcm80211/brcmfmac/bca/Makefile  |  12 ++
 .../broadcom/brcm80211/brcmfmac/bca/core.c    |  27 +++
 .../broadcom/brcm80211/brcmfmac/bca/module.c  |  27 +++
 .../broadcom/brcm80211/brcmfmac/bca/vops.h    |  11 +
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  52 ++---
 .../broadcom/brcm80211/brcmfmac/bus.h         |  30 ++-
 .../broadcom/brcm80211/brcmfmac/core.c        |  12 +-
 .../broadcom/brcm80211/brcmfmac/core.h        |   8 +
 .../broadcom/brcm80211/brcmfmac/cyw/Makefile  |  12 ++
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    |  27 +++
 .../broadcom/brcm80211/brcmfmac/cyw/module.c  |  27 +++
 .../broadcom/brcm80211/brcmfmac/cyw/vops.h    |  11 +
 .../broadcom/brcm80211/brcmfmac/fwvid.c       | 199 ++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/fwvid.h       |  47 +++++
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  70 +++---
 .../broadcom/brcm80211/brcmfmac/sdio.c        |  12 +-
 .../broadcom/brcm80211/brcmfmac/usb.c         |  27 ++-
 .../broadcom/brcm80211/brcmfmac/wcc/Makefile  |  12 ++
 .../broadcom/brcm80211/brcmfmac/wcc/core.c    |  27 +++
 .../broadcom/brcm80211/brcmfmac/wcc/module.c  |  27 +++
 .../broadcom/brcm80211/brcmfmac/wcc/vops.h    |  11 +
 22 files changed, 634 insertions(+), 65 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/vops.h
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/vops.h
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/vops.h

-- 
2.35.1


--000000000000f9fd5f05ee9c554a
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA1A2/9ikp+y793pWz6
z891mNLrjm5osiG7TZJnHxH+vzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjExMjkxMzU1MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEARaS7xoO3pW+IicY9DE4d6MmuW7aq6MH34naI
OGOAQoTXELchIQzN8k0B9mrhcUbb0JQub0EVlBljASweYupckqei0vi0GFjNKS6ciFoAez5y+ozO
C43wlcMNfw1HYWFpwRL4IYHuMnIW+TdTF6t+GIRsCApHI5R60QjKJ8Zj1KUWQjditL5xzcY8TbFt
dinXmSayJo7oo37igcCN8fn/R185X/l4dZhDbNTGlD1w/CpKge57RPTPPUxUmR3zmviZCo0qdjIZ
Fg5yVw7wEXnv5fpDYBBHn7xHN1QPUCQkWv6VQXRyvP1+yyF486xIuqFqRO3ahRFvm9aAsbbgco4a
PQ==
--000000000000f9fd5f05ee9c554a--
