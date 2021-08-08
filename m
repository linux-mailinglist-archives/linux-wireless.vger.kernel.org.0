Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414653E3C22
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Aug 2021 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhHHSFq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Aug 2021 14:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhHHSFp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Aug 2021 14:05:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A5C061760
        for <linux-wireless@vger.kernel.org>; Sun,  8 Aug 2021 11:05:26 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m18so8918761ljo.1
        for <linux-wireless@vger.kernel.org>; Sun, 08 Aug 2021 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGJAl+Fq7GcSLnAox4645t1xKPlQNJc87nCcOMMco4k=;
        b=YeITZrqEyTzmWF5O6g5b4jLcvOiXJZvGkK2+FslrE3dDseGdW7SqeYDoTJts9BpsZh
         AYonFaR0fF+IPcyGEK3OZ+EQMWyWmTD4vin3VVLxLWnLV1czwuJ9gKojQwIwSwIwEBTG
         Ziy3q/3MgUOe7H/ynRrp61wflox9Q/kJzPo06oydOyDGwftMBNARDMSuI+GR+Vj9Msnx
         Ujpxx95a6cbU5TUbzbJlrsWiG1gQs33XIRBzEXFB8dS7vHCpc4HpvlUflAsLM5OHBUPB
         7EYkIHDYSjB1tsrIplMcpwbsemcBBV+y/thA0C9Ao5x41qEI+8F3pnOYL2c3BzOjeKQP
         DQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGJAl+Fq7GcSLnAox4645t1xKPlQNJc87nCcOMMco4k=;
        b=Ru39R8e3fnaqe5c0YgALfIEx2l+E1RIZxK/yFBq67nDOuR9BeZBDjuR+c/vgYBYVK0
         A0yP89Npa7rKlx5XdC7qoNZsQt9v1ldqqvSCk7VVdTgKcr7jNTiUOzL/e/CBlu1Ofc9j
         7AQyf5k/UmBFGksA82/zRAwvUUrVLNzAQhzCOfp6hwHQeXmOhhGtzLJY/7L+wxdKAuJC
         dOqdyStmGJpt1hNYcVQkTdIRRnEr3B6aok6xou6oB803GddWuyamRMMKm+LU4U3H7PX9
         spGecbZH/PlcU8lt7eoDfx6vps76+4MAa6ZsSqDy1YBCgaod8k4Sa/6ucavzH43L83+l
         tcbw==
X-Gm-Message-State: AOAM531z7+5OnMoSNRTUy07sPyMzmw4sMEzoTNOHDJUsOyvp3chjiDgU
        /l9IaEfkdQHMjp+t9/d5KZPcItVhis0=
X-Google-Smtp-Source: ABdhPJzo76jAbBBo1asB8JQAAAY7Rpbg9xeCTOlKjUpZi00k2MCX8eyj052OiCKsU4FW+txjeu0qzQ==
X-Received: by 2002:a2e:b989:: with SMTP id p9mr13246274ljp.477.1628445924668;
        Sun, 08 Aug 2021 11:05:24 -0700 (PDT)
Received: from localhost.localdomain (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.gmail.com with ESMTPSA id c9sm1205574lfb.181.2021.08.08.11.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 11:05:24 -0700 (PDT)
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
Subject: [PATCH v5] brcmfmac: firmware: Fix firmware loading
Date:   Sun,  8 Aug 2021 21:05:10 +0300
Message-Id: <20210808180510.8753-1-digetx@gmail.com>
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

- Added MODULE_FIRMWARE match for per-board SDIO bins, making
  userspace tools to pull all the relevant firmware files.

Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
Cc: Stefan Hansson <newbyte@disroot.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
ChangeLog v4->v5:
- Added MODULE_FIRMWARE to catch per-board SDIO firmware files.
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
 .../broadcom/brcm80211/brcmfmac/sdio.c        |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 97ee9e2e2e35..1d1b0b7d8d9b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -629,6 +629,9 @@ BRCMF_FW_CLM_DEF(43012, "brcmfmac43012-sdio");
 MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-sdio.*.txt");
 MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.*.txt");
 
+/* per-board firmware binaries */
+MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-sdio.*.bin");
+
 static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43143_CHIP_ID, 0xFFFFFFFF, 43143),
 	BRCMF_FW_ENTRY(BRCM_CC_43241_CHIP_ID, 0x0000001F, 43241B0),
-- 
2.32.0

