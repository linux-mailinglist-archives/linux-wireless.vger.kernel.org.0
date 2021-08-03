Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6973DF87D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 01:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhHCXaC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Aug 2021 19:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhHCXaB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Aug 2021 19:30:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECFEC061757
        for <linux-wireless@vger.kernel.org>; Tue,  3 Aug 2021 16:29:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f42so1300491lfv.7
        for <linux-wireless@vger.kernel.org>; Tue, 03 Aug 2021 16:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77+9YXp3jj+rN/Pk2KfaWP9zDZrcZqnNXtYW8KyfWi8=;
        b=J0omb48aAgMB2lbMwDtomWLbHQvMLPV8zLagUTtxJEoBgUKYaImxPt2MTNYnDiw/AF
         H5G/CuVPcbyIN2XR8XKxzHVta0fUmvfKz6U/aGGPtZLGLGkruXKol7aLy2Nim+c5N/lq
         0R9lGcAjvLMwYZ4sbhqZ92gxxfQ7TLwxPSFF3fpx66QXFDoo8IFM/GlIlqm/Txi/m4R3
         I1fl8rXIExHjAw062Twe0dLCMnFoJ/9bT+NowLLPEuSBaojfxSwnhU4JcsrsWxmSGLWa
         DnEe5QOeerL99xymaqPsfR4kx/U/U98eUW+FYXBewOx+V65HJrB6wypriYo724WhRbe7
         yQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77+9YXp3jj+rN/Pk2KfaWP9zDZrcZqnNXtYW8KyfWi8=;
        b=syn1D27b/ziZULz80ln7zTyarao3sP/zSg0PWJlPS2Vhq39QTQ2WhWSYAZKZ4lF2Qz
         C2RHarhujok1tIRXlSWB1DGQo6cgV/rBP+yPH0YcgztNzgAAws3/yxVGympnu2S3b1GS
         3tWN24N0RiABHaBKml4/9tU7G8ClH7PSH+NVyT000dZ2tmB1RphmYirUX7fJRhEaFHjz
         o95uZR9OK8Vq4+4VZldKzylqrw9A5ZWgCzTlmzLhtEplM9v+tnbyIL8FrxxYTyWD8Cyf
         g0luHl8DKfmFzJjfA/nCJptV7FHn3oE6sbV/sOmoualV8GfBIy/5vTk8N4TgVkic4nui
         CMzA==
X-Gm-Message-State: AOAM530aA7gGNaxqzYCCVwaIJrQQLOXRqo9Eqb8BSiYorlbs2eWyXO8O
        JpONG5XRRn1RXNGJd8Oe1V7tIg==
X-Google-Smtp-Source: ABdhPJyTq1pigTPI9gVBduMYZtv6OSE1AEVqXptgY49b6AA2YAJvx4Qa6BJhp/W+C4D4QTHVw9J3yw==
X-Received: by 2002:a05:6512:b88:: with SMTP id b8mr18146409lfv.563.1628033388141;
        Tue, 03 Aug 2021 16:29:48 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id e5sm37213ljn.72.2021.08.03.16.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:29:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Hansson <newbyte@disroot.org>
Subject: [PATCH] brcmfmac: firmware: Fix firmware loading
Date:   Wed,  4 Aug 2021 01:27:46 +0200
Message-Id: <20210803232746.3389570-1-linus.walleij@linaro.org>
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
  the alt_path. Use a static variable to check that we do not
  try this indefinitely.

- Rename the brcm_fw_request_done to brcm_fw_request_done_first
  reflecting the fact that this callback is only used for the
  first (main) firmware file, and drop the unnecessary
  prototype.

Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Stefan Hansson <newbyte@disroot.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 29 +++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index adfdfc654b10..71ca4a517e42 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -431,8 +431,6 @@ struct brcmf_fw {
 	void (*done)(struct device *dev, int err, struct brcmf_fw_request *req);
 };
 
-static void brcmf_fw_request_done(const struct firmware *fw, void *ctx);
-
 #ifdef CONFIG_EFI
 /* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
  * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
@@ -638,11 +636,26 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
 	return request_firmware(fw, cur->path, fwctx->dev);
 }
 
-static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
+static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
 {
 	struct brcmf_fw *fwctx = ctx;
+	struct brcmf_fw_item *first = &fwctx->req->items[0];
+	static bool retry = true;
 	int ret;
 
+	/*Something failed with the first firmware request , such as not
+	 * getting the per-board firmware. Retry this, now using the less
+	 * specific path for the first firmware item, i.e. without the board
+	 * suffix.
+	 */
+	if (!fw && retry) {
+		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
+					      fwctx->dev, GFP_KERNEL, fwctx,
+					      brcmf_fw_request_done_first);
+		retry = false;
+		return;
+	}
+
 	ret = brcmf_fw_complete_request(fw, fwctx);
 
 	while (ret == 0 && ++fwctx->curpos < fwctx->req->n_items) {
@@ -702,17 +715,15 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 	if (alt_path) {
 		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
 					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done);
+					      brcmf_fw_request_done_first);
 		kfree(alt_path);
-	}
-	/* Else try canonical path */
-	if (ret) {
+	} else {
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

