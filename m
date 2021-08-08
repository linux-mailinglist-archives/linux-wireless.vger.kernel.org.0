Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE95C3E3ACB
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Aug 2021 16:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhHHOaa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Aug 2021 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHOaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Aug 2021 10:30:30 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A5FC061760
        for <linux-wireless@vger.kernel.org>; Sun,  8 Aug 2021 07:30:10 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h2so7522977lji.6
        for <linux-wireless@vger.kernel.org>; Sun, 08 Aug 2021 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WpV5cwalJ4FwdcQ/gfw1gsyCcE8M3YXyhd4MHP9CiTU=;
        b=vPCP0mbwFWjxZhjdPbkXGPf3PHXuoo0gtieVEuWUtnCv+phs918G3uV0tqRifPwxzB
         D9bcwxeV+A8Z8mfK85VQTYo+rWzn+AOdN3mgiYbnBLQwMZWi3RwDA868mo4Bau3mqMzV
         U7DlRE5Y7AgNwJKNrFTvgRSm3oNlV6yvvtUlARVDPBaeEnxwRVUP1CMvucqi+UhesCPn
         aUXx2meoqlE29W1RgFx0WpvJff+r8AQMUC9rmGXRuyVhHj3u8OTmYK35EEbSB11SMA8e
         E4LPn8mSPY+2Ud0dp5sG1lpzyIMXsiRYZkpTynyRTB+EszcEr/u4wjOIzHkVD0cdmeXC
         fxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WpV5cwalJ4FwdcQ/gfw1gsyCcE8M3YXyhd4MHP9CiTU=;
        b=h2ufQROfp7IWDhaRXjEOupr1UZeUIDsVlxtLuLZt0WHlzXJQHXeP27CaKRxy5rM8xP
         OavG0feKTKWe/iJNVxcIyIMTDce/BJdLSeKcSkTjfXZhn5KeiviiBnUYkUEJhnXVPidI
         f5bCqfAsnF1ii1KI1TGPo13F17hkiuDgzP5wSba/gW6u9LSWGtOD3VU42aa0IaN8gLxJ
         V6KC4eQ7W7iry47Ea+23zC0YRdCBBFClWaSjcjbYnvXHBzu3Zokqrmg9LjZqsomwbWg5
         MA4FM1BahjJGpxGwXeAVucSotYXgg/479sFAPXliTjmrKdbDX1Ogf6fye7fV35WFUyJP
         Bixg==
X-Gm-Message-State: AOAM5303a6LlrZmx/b+/UyIAwZIMLgg4Q5p2y6L1YgqkP3ORMMITkOwc
        TyE4T5bgPQ8pqLCdhq7qb6Y=
X-Google-Smtp-Source: ABdhPJyEmaoe0OB/RYc24rfgGR7tm5X1rm90rb9z8wtXKKNKUFzuNMxoSm6qlBVBjJS2BixMaosvVQ==
X-Received: by 2002:a05:651c:1307:: with SMTP id u7mr5153734lja.413.1628433007784;
        Sun, 08 Aug 2021 07:30:07 -0700 (PDT)
Received: from localhost.localdomain (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.gmail.com with ESMTPSA id h21sm1306030ljh.48.2021.08.08.07.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 07:30:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-wireless@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>
Subject: [PATCH v4] brcmfmac: firmware: Fix firmware loading
Date:   Sun,  8 Aug 2021 17:28:57 +0300
Message-Id: <20210808142857.7451-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

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
  the alt_path from a dedicated brcm_fw_request_done_alt_path
  callback.

- Drop the unnecessary prototype of brcm_fw_request_done.

Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
Cc: Stefan Hansson <newbyte@disroot.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
ChangeLog v3->v4:
- Added brcmf_fw_request_done_alt_path() callback to replace the
  "tried_board_variant" variable, making code cleaner and errors
  handled consistently.
ChangeLog v2->v3:
- Rename state variable to "tried_board_variant".
ChangeLog v1->v2:
- Instead of using a static variable, add a context variable
  "tested_board_variant"
- Collect Arend's review tag.
- Collect Tested-by from Dmitry.
---
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index adfdfc654b10..0eb13e5df517 100644
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
@@ -658,6 +656,22 @@ static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
 	kfree(fwctx);
 }
 
+static void brcmf_fw_request_done_alt_path(const struct firmware *fw, void *ctx)
+{
+	struct brcmf_fw *fwctx = ctx;
+	struct brcmf_fw_item *first = &fwctx->req->items[0];
+	int ret = 0;
+
+	/* Fall back to canonical path if board firmware not found */
+	if (!fw)
+		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
+					      fwctx->dev, GFP_KERNEL, fwctx,
+					      brcmf_fw_request_done);
+
+	if (fw || ret < 0)
+		brcmf_fw_request_done(fw, ctx);
+}
+
 static bool brcmf_fw_request_is_valid(struct brcmf_fw_request *req)
 {
 	struct brcmf_fw_item *item;
@@ -702,11 +716,9 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 	if (alt_path) {
 		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
 					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done);
+					      brcmf_fw_request_done_alt_path);
 		kfree(alt_path);
-	}
-	/* Else try canonical path */
-	if (ret) {
+	} else {
 		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
 					      fwctx->dev, GFP_KERNEL, fwctx,
 					      brcmf_fw_request_done);
-- 
2.32.0

