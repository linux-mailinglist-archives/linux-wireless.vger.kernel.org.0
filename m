Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D293E114F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhHEJco (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhHEJcn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 05:32:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55C8C061765
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 02:32:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l4so6229878ljq.4
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+cEnD9ZqLHpKmC6ohpEymsFjdq4jNdNTMItaFWE82A=;
        b=EaIAjuW9tLWDLwvLV/QudRcoMJvrxPC1RRZ/iH90vSjhSRg7Wkp12T6ePuiJ1pnFUv
         EeqUE/N/svlNqTgFGwBjyHtTmLT9MJ1pAIkL96pxzmHXsvjUhf8OdP67eUVFHNS74is0
         a/dB85FGt0hu8WXniRHT3BAWRBVN+G9NiqZgiBkQZKo4Vj0PgyxfFo5evFetZWOFvD3Q
         uhCNOJpSVp7yRRJ+w7Ume6cdne+/Qz67bBTwk4zq9IyIe6zafrctiDdreGDsxvOtoEsx
         D4APz0YHWP9NeniNCC2uzK/r0cGhZMzwl5g0QzgvxcH3oL0paIHzSY3BorXrEqMNlnF1
         OffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+cEnD9ZqLHpKmC6ohpEymsFjdq4jNdNTMItaFWE82A=;
        b=t/ltY3IwQxbsl2qBgEETHharo/dfPY6gTwJyQKOSL9ps8i8E1feuICaoMm+vVMJXgK
         BOnN3o2eq6kkF8aU3bZbKhGXYd+teNB99biC0b6VyQ0IyLVaeDTORMUxGa6g3FrIJOA/
         nBVNvoUrZ5fLx4lOM7VJDJ5PKCHKc1m0QHSjc6xvMOplfEvrZaDjucOiyBF2AFKCqFUA
         rgPPvDbXvpOfvLbpzvHBMR/j1Gsi4H6WUC79L3IP6CHLZv1GyhedHvAS7a6V/n2Nlzct
         8MxwlHWCrpN/Tyifcyb5kc6PDvUPl681iORYITGYDCeqCiSEG6v94ljNseX7WhvmgE79
         VT4g==
X-Gm-Message-State: AOAM532aoQ30JA550L9VypXBAAiKFsj8jb4yTYkSzxxC5Dan/ndprY4w
        8JYrOq+d3G7gTxuwdI/X+s7gzw==
X-Google-Smtp-Source: ABdhPJxtkMa7SydgNjX9/VQiiVsok8+n5QyDJq6JIfFZCPk/cHXSZnbMwUkcEt9beAyN2XM9Bz/EAw==
X-Received: by 2002:a2e:9a5a:: with SMTP id k26mr2567418ljj.150.1628155947039;
        Thu, 05 Aug 2021 02:32:27 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b1sm356765ljo.100.2021.08.05.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 02:32:26 -0700 (PDT)
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
Subject: [PATCH v3] brcmfmac: firmware: Fix firmware loading
Date:   Thu,  5 Aug 2021 11:30:23 +0200
Message-Id: <20210805093023.3465081-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Rename state variable to "tried_board_variant".
ChangeLog v1->v2:
- Instead of using a static variable, add a context variable
  "tested_board_variant"
- Collect Arend's review tag.
- Collect Tested-by from Dmitry.
---
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index adfdfc654b10..d32491fd74fe 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -428,11 +428,10 @@ struct brcmf_fw {
 	struct device *dev;
 	struct brcmf_fw_request *req;
 	u32 curpos;
+	bool tried_board_variant;
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
+	if (!fw && !fwctx->tried_board_variant) {
+		fwctx->tried_board_variant = true;
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
+		fwctx->tried_board_variant = false;
 		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
 					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done);
+					      brcmf_fw_request_done_first);
 		kfree(alt_path);
-	}
-	/* Else try canonical path */
-	if (ret) {
+	} else {
+		fwctx->tried_board_variant = true;
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

