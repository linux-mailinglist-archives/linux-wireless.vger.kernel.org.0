Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C7E3B65E6
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 17:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhF1Pmv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhF1Pmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 11:42:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCDBC0D941D
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 07:54:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a18so10909787lfs.10
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTbSUbM1268hTodnYEfrSQ4SI+5Cv+kn+Rphaaes6Oc=;
        b=syqIAip6E0BSc7B0RdeEki9AoDvvCk7lzUBg0lhzzyG4vg2ICNgbTZfeo1pwX6ijKq
         dmGRcu/+s70Y6k+L5j4tw8Y9QYNI0Apb2IsgPD1FDzAG4+n5HmaESH6eoLype5hdMAHQ
         k7ZTaTl2L5OIeTl7Gg8069PaZj/LYNCBAtrr/9J4f5TTqYloxmV9WuTF3XCFQpdl+rf8
         FA+y7TKlfOjniUwjqMGbo8uJ6G1wkcxjcFn/XCCXn8FH1Vpe85PebxCxouDva8urlJ1w
         O7tkgJfJLexGMVD66U53I+y6Y6corGwiWYBDSnPRukjs3Wps38v3ots8GKMuj7Z+gBeT
         wPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTbSUbM1268hTodnYEfrSQ4SI+5Cv+kn+Rphaaes6Oc=;
        b=KDHLEqdcZruL33soTFPV/XXJgrdYzr8f6cU2G/zy5OKEKZ3Z52UaIXOmCKGPEzYTLm
         6loruwNE15k0Ihv0merxUUouT79ItkXfUUwgyx90CbFF+/tp0VTktfPqNUGB8uDgXgbC
         QjbwLQc9n7K9Z1CGiDwl3cGqxcwtP6Yw6Z+5PxG1YeZoYRK/8NZfZFZRkEyqMu8lhb2G
         /isrviJu1dxdAibmOJGZRqicDoP9sSN2Hlo2z0sSC2vRvgiN8gO/dkrQrcej77LUjT8v
         3a4jnNt2MU3PC2QmL+lud/A/5cBgB8Th7lNTGv4ZvqHVe4zBgSQXBxuzAgrKi0LDkYm7
         PgcA==
X-Gm-Message-State: AOAM533XOWiBMisIGyzOllnguD5K/ifuIv3b5CwxNuzDKOdr6dP7k9cT
        SQGj0BdYbq8lbtWgrE8NIRQ=
X-Google-Smtp-Source: ABdhPJwLEtV3ABLea52sfNU/dhIdbp/38NR2pCl2OPlO2G2/0ARj1RAIsJBMSk7nKmo0jUX7hmf7Vg==
X-Received: by 2002:a05:6512:ad2:: with SMTP id n18mr16625542lfu.543.1624892093285;
        Mon, 28 Jun 2021 07:54:53 -0700 (PDT)
Received: from localhost ([62.176.30.88])
        by smtp.gmail.com with ESMTPSA id y17sm1341296lfg.71.2021.06.28.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 07:54:52 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v2] brcmfmac: use separate firmware for 43430 revision 2
Date:   Mon, 28 Jun 2021 17:54:12 +0300
Message-Id: <20210628145412.26046-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210509233010.2477973-1-mike.rudenko@gmail.com>
References: <20210509233010.2477973-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A separate firmware is needed for Broadcom 43430 revision 2.  This
chip can be found in e.g. certain revisions of Ampak AP6212 wireless
IC. Original firmware file from IC vendor is named
'fw_bcm43436b0.bin', but brcmfmac and also btbcm drivers report chip
id 43430, so requested firmware file name is
'brcmfmac43430b0-sdio.bin' in line with other 43430 revisions.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
Changes in v2:
- use 43430B0 firmware for all 43430 revisions above 1
- add Reviewed-by tag
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 16ed325795a8..97fda7e0be7c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -617,6 +617,7 @@ BRCMF_FW_DEF(4339, "brcmfmac4339-sdio");
 BRCMF_FW_DEF(43430A0, "brcmfmac43430a0-sdio");
 /* Note the names are not postfixed with a1 for backward compatibility */
 BRCMF_FW_DEF(43430A1, "brcmfmac43430-sdio");
+BRCMF_FW_DEF(43430B0, "brcmfmac43430b0-sdio");
 BRCMF_FW_DEF(43455, "brcmfmac43455-sdio");
 BRCMF_FW_DEF(43456, "brcmfmac43456-sdio");
 BRCMF_FW_DEF(4354, "brcmfmac4354-sdio");
@@ -643,7 +644,8 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43362_CHIP_ID, 0xFFFFFFFE, 43362),
 	BRCMF_FW_ENTRY(BRCM_CC_4339_CHIP_ID, 0xFFFFFFFF, 4339),
 	BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0x00000001, 43430A0),
-	BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0xFFFFFFFE, 43430A1),
+	BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0x00000002, 43430A1),
+	BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0xFFFFFFFC, 43430B0),
 	BRCMF_FW_ENTRY(BRCM_CC_4345_CHIP_ID, 0x00000200, 43456),
 	BRCMF_FW_ENTRY(BRCM_CC_4345_CHIP_ID, 0xFFFFFDC0, 43455),
 	BRCMF_FW_ENTRY(BRCM_CC_4354_CHIP_ID, 0xFFFFFFFF, 4354),
@@ -4617,4 +4619,3 @@ int brcmf_sdio_sleep(struct brcmf_sdio *bus, bool sleep)

 	return ret;
 }
-
--
2.32.0
