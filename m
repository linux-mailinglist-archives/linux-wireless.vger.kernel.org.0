Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461003E0453
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 17:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbhHDPhC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbhHDPgx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 11:36:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8240C06179A
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 08:36:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f42so5168300lfv.7
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2lxo1e3eIdECUIQ8IPFw0OqpB2k2yeNhBFpX8Gywfc=;
        b=NBU0xC+F7oliZzv1RogZqjfhU4luliOr58vn0mpxSoza463+UcXr1XeeckfJPmoxCG
         lQUbujuCiPtTbmQXcZwJrYErtnrPEBPwIiM4qqFPsneqGEh6b1qJ3M94wg8I+BPJKfVo
         jfxcHxQ5BciMxqNTX8GoQ/KmipbBKm59YfnY34S8uXyOF5PGHt6m6v9nqCAhXLF/+IHV
         Dp9cryhcH3TloK3ePNwQvv8Ow9TMwKOozBFneHf5l/57szUqSJYfeB3kC31dRDKGI9NQ
         60SykXRtMAxAXg98oVeKb6rx3BGy/7v8eazecxc1zCtLuzA/etSyqR/zFyW6mO0RsOU9
         YIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2lxo1e3eIdECUIQ8IPFw0OqpB2k2yeNhBFpX8Gywfc=;
        b=THcewkEQGLq0NNrnmhZxoc+FRGh3GJ9S+YV97ukHLJTkeRzp15l9l7XN6yp4OPS8BL
         yW7iU/YRAsMzlJmblJS4DIFzC9WWvg/qcQzJmJ8RMS3fWgp7aJnrpLPIWZC6BFwWMqJl
         buT5DgJJi8MkMavy7OON8+PtgbnY3mDlGM1Q43Qs3OS1RmX1r5LEZ/9hGWjgIwUKsSKZ
         4MrCnoRmjyw36RMDg8DRBcbC8tZ/STEzcrje2AfivEZId1TXxczZu+2dlNEItQEtySIQ
         3bV6Mxc+NhKPrFD2sOLaPzqHuLP+qDWqIDu1+u5caxgUjs61kLWK8h5I6ETbY3FF5m6x
         Q6Pw==
X-Gm-Message-State: AOAM533d3UiVJNXtCyNmIjcjslzxAVVaKMhGaaiSkTTtdTnZ+jCWsy4K
        A5hocrcQk1YQuh4+TN05RFU7rg==
X-Google-Smtp-Source: ABdhPJwuhVXcOg5fyUG2DmzTqb99qfnFGGv24XxPZZ6EL9W48D4HVDI4fMU7YAUlN0QRdJO72dc7Gw==
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr19656308lfs.533.1628091399123;
        Wed, 04 Aug 2021 08:36:39 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id v8sm229091lfo.107.2021.08.04.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:36:38 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v2] brcmfmac: firmware: Fix firmware loading
Date:   Wed,  4 Aug 2021 17:34:34 +0200
Message-Id: <20210804153434.3429348-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The patch that would first try the board-specific firmware
had a bug because the fallback would not be called: the
asynchronous interface is used meaning request_firmware_nowait()
returns 0 immediately.

Harden the firmware loading like this:

- If we cannot build an alt_path (like if no board_type is
  specified) just request the first firmware without any
  suffix, like in the past.

- If the lookup of a board specific firmware fails, we get
  a NULL fw in the async callback, so just try again without
  the alt_path. Use a context state variable to check that
  we do not try this indefinitely.

- Rename the brcm_fw_request_done to brcm_fw_request_done_first
  reflecting the fact that this callback is only used for the
  first (main) firmware file, and drop the unnecessary
  prototype.

Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Stefan Hansson <newbyte@disroot.org>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Instead of using a static variable, add a context variable
  "tested_board_variant"
- Collect Arend's review tag.
- Collect Tested-by from Dmitry.
---
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index adfdfc654b10..2b0fb79c5ede 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -428,11 +428,10 @@ struct brcmf_fw {
 	struct device *dev;
 	struct brcmf_fw_request *req;
 	u32 curpos;
+	bool tested_board_variant;
 	void (*done)(struct device *dev, int err, struct brcmf_fw_request *req);
 };
 
-static void brcmf_fw_request_done(const struct firmware *fw, void *ctx);
-
 #ifdef CONFIG_EFI
 /* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
  * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
@@ -638,11 +637,25 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
 	return request_firmware(fw, cur->path, fwctx->dev);
 }
 
-static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
+static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
 {
 	struct brcmf_fw *fwctx = ctx;
+	struct brcmf_fw_item *first = &fwctx->req->items[0];
 	int ret;
 
+	/* Something failed with the first firmware request, such as not
+	 * getting the per-board firmware. Retry this, now using the less
+	 * specific path for the first firmware item, i.e. without the board
+	 * suffix.
+	 */
+	if (!fw && !fwctx->tested_board_variant) {
+		fwctx->tested_board_variant = true;
+		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
+					      fwctx->dev, GFP_KERNEL, fwctx,
+					      brcmf_fw_request_done_first);
+		return;
+	}
+
 	ret = brcmf_fw_complete_request(fw, fwctx);
 
 	while (ret == 0 && ++fwctx->curpos < fwctx->req->n_items) {
@@ -700,19 +713,19 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 	/* First try alternative board-specific path if any */
 	alt_path = brcm_alt_fw_path(first->path, fwctx->req->board_type);
 	if (alt_path) {
+		fwctx->tested_board_variant = false;
 		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
 					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done);
+					      brcmf_fw_request_done_first);
 		kfree(alt_path);
-	}
-	/* Else try canonical path */
-	if (ret) {
+	} else {
+		fwctx->tested_board_variant = true;
 		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
 					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done);
+					      brcmf_fw_request_done_first);
 	}
 	if (ret < 0)
-		brcmf_fw_request_done(NULL, fwctx);
+		brcmf_fw_request_done_first(NULL, fwctx);
 
 	return 0;
 }
-- 
2.31.1

