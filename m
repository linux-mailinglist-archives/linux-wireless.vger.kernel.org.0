Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741AE63C17E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 14:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiK2NzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 08:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiK2NzL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 08:55:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6352882
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so10885457wmg.2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNtzi8yZHlSqMmGKalLdQ4hIVQsroXq3Q5p1VzoZBPo=;
        b=CF9Qh26NifcWpfMs58JyQQQ7/aD00OyqdOl8BQYl9af/eg1qDXZmg0nQcCWh1rZqFq
         5IXOmt8XXoLisNUVYRFFmar5IKPyVVxr+ZZrAeBu36OEWMtRETqOtsDpLXBTHAlLFfs/
         +y0Hjjiwa1lrccPDru5diFrNvYfIPUEn/otSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNtzi8yZHlSqMmGKalLdQ4hIVQsroXq3Q5p1VzoZBPo=;
        b=kxwyUgcIkMTUe0HITztXpvxfvSlVSkVIktklj0GXY/OYG/KsAYom/OaCqPL/LvZ3+X
         mlB/C7akIBHCSfKgvxa7mzI+KKhE7iWfZqFIvP9nGdDPop0sHgZ9iPXTDQSYWAbtRxjA
         AP5leSuzUBesuSYBrcGXqe8UKkiQibr/X3lWUH+WnMNn2Ud3LQw2MyisfaAaNGfKgDMO
         IltdMx1sFSuxyMdoO7mMnQCpHk8jX37yq7w+ZMkDS+zUvgihByOlPsS5TLky4JmkyUZJ
         xpCTLnSloHcHTWLJBvhmURZQWebETCMQHkFD9zjGoAloWirkkS+Jr24qWkZru65jPcnS
         SDvA==
X-Gm-Message-State: ANoB5pmvftJ3jOXayP62vtgjXvuw6mnpfqGEMXtFX4kDbTEASh7W4Nh3
        6CEoasuTNKA4EfgZ698ZtUT9RaB+vCWCQcRcuqw=
X-Google-Smtp-Source: AA0mqf6prsR1w9/us3nJ5s1iKjYwxcm0iVKdLVfn0JJAT9raJNiYvjxegpU6FgpIsGnpIkeFJFFW7Q==
X-Received: by 2002:a05:600c:3ba1:b0:3d0:47c:9ff5 with SMTP id n33-20020a05600c3ba100b003d0047c9ff5mr34906789wms.121.1669730109663;
        Tue, 29 Nov 2022 05:55:09 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.com ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b003b4935f04a4sm2472005wmb.5.2022.11.29.05.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:55:08 -0800 (PST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>
Subject: [PATCH V2 1/7] brcmfmac: add function to unbind device to bus layer api
Date:   Tue, 29 Nov 2022 14:54:40 +0100
Message-Id: <20221129135446.151065-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
References: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000119f3205ee9c56f2"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000119f3205ee9c56f2
Content-Transfer-Encoding: 8bit

Introduce a new bus callback .remove() which will unbind the device
from the driver. This allows the common driver layer to stop handling
a device.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h  | 13 +++++++++++++
 .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 12 +++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 60f5645aead3..256456e38108 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/firmware.h>
+#include <linux/device.h>
 #include "debug.h"
 
 /* IDs of the 6 default common rings of msgbuf protocol */
@@ -74,6 +75,7 @@ struct brcmf_bus_dcmd {
  * @get_ramsize: obtain size of device memory.
  * @get_memdump: obtain device memory dump in provided buffer.
  * @get_blob: obtain a firmware blob.
+ * @remove: initiate unbind of the device.
  *
  * This structure provides an abstract interface towards the
  * bus specific driver. For control messages to common driver
@@ -94,6 +96,7 @@ struct brcmf_bus_ops {
 			enum brcmf_blob_type type);
 	void (*debugfs_create)(struct device *dev);
 	int (*reset)(struct device *dev);
+	void (*remove)(struct device *dev);
 };
 
 
@@ -257,6 +260,16 @@ int brcmf_bus_reset(struct brcmf_bus *bus)
 	return bus->ops->reset(bus->dev);
 }
 
+static inline void brcmf_bus_remove(struct brcmf_bus *bus)
+{
+	if (!bus->ops->remove) {
+		device_release_driver(bus->dev);
+		return;
+	}
+
+	bus->ops->remove(bus->dev);
+}
+
 /*
  * interface functions from common layer
  */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 244ba48cc304..c949051c4bc4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4171,6 +4171,15 @@ static int brcmf_sdio_bus_reset(struct device *dev)
 	return 0;
 }
 
+static void brcmf_sdio_bus_remove(struct device *dev)
+{
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_sdio_dev *sdiod = bus_if->bus_priv.sdio;
+
+	device_release_driver(&sdiod->func2->dev);
+	device_release_driver(&sdiod->func1->dev);
+}
+
 static const struct brcmf_bus_ops brcmf_sdio_bus_ops = {
 	.stop = brcmf_sdio_bus_stop,
 	.preinit = brcmf_sdio_bus_preinit,
@@ -4183,7 +4192,8 @@ static const struct brcmf_bus_ops brcmf_sdio_bus_ops = {
 	.get_memdump = brcmf_sdio_bus_get_memdump,
 	.get_blob = brcmf_sdio_get_blob,
 	.debugfs_create = brcmf_sdio_debugfs_create,
-	.reset = brcmf_sdio_bus_reset
+	.reset = brcmf_sdio_bus_reset,
+	.remove = brcmf_sdio_bus_remove,
 };
 
 #define BRCMF_SDIO_FW_CODE	0
-- 
2.35.1


--000000000000119f3205ee9c56f2
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBe50nRg0mhJlUQNp/1
XKunJKXEL0KIAv2FQdM/ibwEnjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjExMjkxMzU1MDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAaqCkux3F/16blqyxrdkSkHQaJyW0y+SSuthg
yz0rkFgCJSCUhEAE1jpvYE55PFgr5gWbhmkE/mNJ+4s0BKV2PIX6OzAOLU4pvbgtV1XWNplM7Thc
s6auva6vPCmxRKOGNsOsm+lF7g7ctBQ/zeA5e+ARYP4il3jbNCSN8OLSG3hrWzIDGVkrL5IhHbjt
IWvZWusWHm5ZumInuCGHPR+nbrqH9lyqmsITTSwnTF/ed/wKmGa1+p7ICv/PyPUKEJSJ+szRx03k
CvlqmaKcb/iTRXxB9HiDCRopAk5Z568VytIx5zAM88n0i2LOEVpqXi/1ioots8+jlCz+wu7pjYzt
CQ==
--000000000000119f3205ee9c56f2--
