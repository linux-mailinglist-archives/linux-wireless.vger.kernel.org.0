Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF13C3FE8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jul 2021 01:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhGKXVx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jul 2021 19:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKXVw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jul 2021 19:21:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C17C0613E5
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jul 2021 16:19:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y42so38930172lfa.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jul 2021 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51fRqTjpuWN2bespRR1sDjHMLrNChk1Ih5rtMgkmMSc=;
        b=CGmcdTjy4r4wvv06WdxVG1CaCBVaPOMs2b3Fd7qrKUITak5uY9RfNLrktE49tTyS06
         m1sjGtHCGVwrXQoescnjzpRIBLXnH3khJvlQ57uD+13FOJIDGk0Z+aB2HS5OaSEwsXYk
         0c70c0JBjeAK0GYjRiYqtpKHVa2vNVIdHB+AA5GT1xvP1VMJkukamwfIq5xDPUziv4Hy
         CdzQVRLXyvA4TSHIpDOBre+gSBegLXI8awkzDg+v88hMfHKLEPvJpR6Zo2uXGoMAMW1V
         FfuvUZjUNUdzYoIaVdrQfjItteYusBTggv/euJI2T5cM0tndp6tjALY70noQ6Vjjq+Jc
         wzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51fRqTjpuWN2bespRR1sDjHMLrNChk1Ih5rtMgkmMSc=;
        b=oqHN4OkGBVlbZpSjlue/euoxYFY4fGAn7ub0YYVMa1JeM3zfFns7yBpvwVFnGeAjJN
         qiyuN6hStaMbogOB459Q6+zKKiDztKI/AQx7i4pys5PJX+fF9gYRHn2zMws2N3VAYphU
         VRlgqwuvjnoHREKAHvAPwVKNZBqB1cCXROWgVke3SWVMmXL3wXQGYaK3PJyc9wsli+6x
         Ot0Hl0Z+q6es4OWquniXOeg5LgwLU4VC2ocG/qxIJsnAJCgsTXHc04uhJmDPJsve9BA7
         wSLF/BbjSisAPXeAFebez6vv+GTEXJ3Md2jEES2Lvqqnrb/IorkrzpzeW84MoktZwKJG
         fqfg==
X-Gm-Message-State: AOAM531LbD2wnqyune+3HSEAvcEvr/n6f6xFHWqGIsZol/gEadORXghb
        PxYr946zFxpAPse/GeRQK0eEYQ==
X-Google-Smtp-Source: ABdhPJyHCS9BoZ3848CGnCOwdcygTF+2nfMI/fxwzoynXtepU/3/yqcZsNSYf7h4PWHOFvGlvt7z3A==
X-Received: by 2002:a05:6512:3886:: with SMTP id n6mr36374790lft.419.1626045542227;
        Sun, 11 Jul 2021 16:19:02 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r3sm1138768lfc.280.2021.07.11.16.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 16:19:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        phone-devel@vger.kernel.org, newbyte@disroot.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] brcmfmac: firmware: Allow per-board firmware binaries
Date:   Mon, 12 Jul 2021 01:16:59 +0200
Message-Id: <20210711231659.255479-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After some crashes in the 3D engine (!) on the Samsung GT-I8530
it turns out that the main firmware file can be device dependent,
something that was previously only handled for the NVRAM
parameter file.

Rewrite the code a bit so we can a per-board suffixed firmware
binary as well, if this does not exist we fall back to the
canonical firmware name.

Example: a 4330 device with the OF board compatible is
"samsung,gavini". We will first try
"brcmfmac4330-sdio.samsung,gavini.bin" then "brcmfmac4330-sdio.bin"
if that does not work.

Cc: phone-devel@vger.kernel.org
Cc: newbyte@disroot.org
Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 53 +++++++++++++++----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index d40104b8df55..adfdfc654b10 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -594,28 +594,47 @@ static int brcmf_fw_complete_request(const struct firmware *fw,
 	return (cur->flags & BRCMF_FW_REQF_OPTIONAL) ? 0 : ret;
 }
 
+static char *brcm_alt_fw_path(const char *path, const char *board_type)
+{
+	char alt_path[BRCMF_FW_NAME_LEN];
+	char suffix[5];
+
+	strscpy(alt_path, path, BRCMF_FW_NAME_LEN);
+	/* At least one character + suffix */
+	if (strlen(alt_path) < 5)
+		return NULL;
+
+	/* strip .txt or .bin at the end */
+	strscpy(suffix, alt_path + strlen(alt_path) - 4, 5);
+	alt_path[strlen(alt_path) - 4] = 0;
+	strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
+	strlcat(alt_path, board_type, BRCMF_FW_NAME_LEN);
+	strlcat(alt_path, suffix, BRCMF_FW_NAME_LEN);
+
+	return kstrdup(alt_path, GFP_KERNEL);
+}
+
 static int brcmf_fw_request_firmware(const struct firmware **fw,
 				     struct brcmf_fw *fwctx)
 {
 	struct brcmf_fw_item *cur = &fwctx->req->items[fwctx->curpos];
 	int ret;
 
-	/* nvram files are board-specific, first try a board-specific path */
+	/* Files can be board-specific, first try a board-specific path */
 	if (cur->type == BRCMF_FW_TYPE_NVRAM && fwctx->req->board_type) {
-		char alt_path[BRCMF_FW_NAME_LEN];
+		char *alt_path;
 
-		strlcpy(alt_path, cur->path, BRCMF_FW_NAME_LEN);
-		/* strip .txt at the end */
-		alt_path[strlen(alt_path) - 4] = 0;
-		strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
-		strlcat(alt_path, fwctx->req->board_type, BRCMF_FW_NAME_LEN);
-		strlcat(alt_path, ".txt", BRCMF_FW_NAME_LEN);
+		alt_path = brcm_alt_fw_path(cur->path, fwctx->req->board_type);
+		if (!alt_path)
+			goto fallback;
 
 		ret = request_firmware(fw, alt_path, fwctx->dev);
+		kfree(alt_path);
 		if (ret == 0)
 			return ret;
 	}
 
+fallback:
 	return request_firmware(fw, cur->path, fwctx->dev);
 }
 
@@ -660,6 +679,7 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 {
 	struct brcmf_fw_item *first = &req->items[0];
 	struct brcmf_fw *fwctx;
+	char *alt_path;
 	int ret;
 
 	brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
@@ -677,9 +697,20 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 	fwctx->req = req;
 	fwctx->done = fw_cb;
 
-	ret = request_firmware_nowait(THIS_MODULE, true, first->path,
-				      fwctx->dev, GFP_KERNEL, fwctx,
-				      brcmf_fw_request_done);
+	/* First try alternative board-specific path if any */
+	alt_path = brcm_alt_fw_path(first->path, fwctx->req->board_type);
+	if (alt_path) {
+		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
+					      fwctx->dev, GFP_KERNEL, fwctx,
+					      brcmf_fw_request_done);
+		kfree(alt_path);
+	}
+	/* Else try canonical path */
+	if (ret) {
+		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
+					      fwctx->dev, GFP_KERNEL, fwctx,
+					      brcmf_fw_request_done);
+	}
 	if (ret < 0)
 		brcmf_fw_request_done(NULL, fwctx);
 
-- 
2.31.1

