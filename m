Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619BD3E0AC1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 01:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhHDXOF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 19:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhHDXOE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 19:14:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D987C0613D5
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 16:13:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq29so7317438lfb.5
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXIqYOjCRzDQvpLV1MUsqsIWGVoQDTTXzWGc9HVeWLM=;
        b=OxDpH6eVstoPoqfoY6eIIR9Yj5VFY/QHlZLtHgUIamgqoeGfu8YN8trtuYnfmt9/AW
         vqDCRSvqoEr1hICMmeTHSZ0xrN6gWXm0qL2LnSKp/0LtTb3H9Z7c+6gw28lkEQMIrLWS
         vPwRXzUKUN82edqWiAMy2/JY336CtjIKfI5oRsdwpVJNgmzCAaVvwJ7xE05CRW6fdgQy
         4jM5mkc4xsFWly0BvGXGmfNSc9GqpMlChg6H3kWzMhIOycgcR33IJF3Epm4MNudflFtF
         0umd8uZq8pvK4oLntkjEMcb6RtlmHuWFKDFems4rYJNpbLK9VRfvg3rKM5mtiQrA1UQ8
         2w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXIqYOjCRzDQvpLV1MUsqsIWGVoQDTTXzWGc9HVeWLM=;
        b=X6c9tH2kfnV+m+rgA/oIvnr4W7VofDCaY8Mb64xbPbsLzZntsC9JlH35IsTuVuQem9
         d3w2w9FQvQmQl1TJoRyasjNNc8nTvBgN04ZNOF/8/NkvDqw6+Dy7rUR6Gpk9Uv6EGbii
         S5hyztuKRv8FHhs/DVTPGa0onHqDQsz8JgcfRvFepCjKaEbWY28hty0WptvRjtHAkOtT
         5bMDK5TNBc3bRQiFoQR26Sruo9xQoZEcbcCkbzOlIM5KcUQ1GfwctbYLV6uOHT+lprxS
         kLvRnNAQJKd3FJnhIDCxNPyL6CerrfRkRDJlHPDOrub92/7fY+chAq8tr9sPFj3MjjUW
         e02Q==
X-Gm-Message-State: AOAM532h1eR2FH3xn0yMj6dXNJRRssotKF4jymL2bz8AjcveXokIUiFf
        g2PqnyLCM3qLTbUoq6PmWhY=
X-Google-Smtp-Source: ABdhPJwxmWE0F0SFqmMJUkcAxGD1sIR48UjrzVPU+0E31gbpsurmVtHyynIW+kOtFChWxI9IfCvjFg==
X-Received: by 2002:a19:c717:: with SMTP id x23mr1228539lff.230.1628118828784;
        Wed, 04 Aug 2021 16:13:48 -0700 (PDT)
Received: from localhost (37-145-208-50.broadband.corbina.ru. [37.145.208.50])
        by smtp.gmail.com with ESMTPSA id e26sm324645lfs.227.2021.08.04.16.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:13:48 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v3] brcmfmac: use separate firmware for 43430 revision 2
Date:   Thu,  5 Aug 2021 02:13:08 +0300
Message-Id: <20210804231308.576071-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801102503.C56E4C433F1@smtp.codeaurora.org>
References: <20210801102503.C56E4C433F1@smtp.codeaurora.org>
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
Changes in v3:
- rebase against wireless-drivers-next
Changes in v2:
- use 43430B0 firmware for all 43430 revisions above 1
- add Reviewed-by tag
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 97ee9e2e2e35..baabd3bc9fb1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -617,6 +617,7 @@ BRCMF_FW_DEF(4339, "brcmfmac4339-sdio");
 BRCMF_FW_DEF(43430A0, "brcmfmac43430a0-sdio");
 /* Note the names are not postfixed with a1 for backward compatibility */
 BRCMF_FW_CLM_DEF(43430A1, "brcmfmac43430-sdio");
+BRCMF_FW_DEF(43430B0, "brcmfmac43430b0-sdio");
 BRCMF_FW_CLM_DEF(43455, "brcmfmac43455-sdio");
 BRCMF_FW_DEF(43456, "brcmfmac43456-sdio");
 BRCMF_FW_CLM_DEF(4354, "brcmfmac4354-sdio");
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
@@ -4616,4 +4618,3 @@ int brcmf_sdio_sleep(struct brcmf_sdio *bus, bool sleep)

 	return ret;
 }
-
--
2.32.0
