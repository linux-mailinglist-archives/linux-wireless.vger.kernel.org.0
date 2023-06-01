Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1857E719273
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 07:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjFAFnL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 01:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjFAFm6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 01:42:58 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8641A7
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 22:42:33 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-568ba7abc11so4921137b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685598143; x=1688190143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SI17x27l49eNtz2vhYST+V4+x0Pcr4kkffqCVPftF0o=;
        b=VxmN+RkrHhR89b0ZRKD/dxVPO0wOtra7pAEnqVZF7GPP4gvnxt5rXdjLCLejRWVwf7
         vbWPhW2l8kJc58R0NSNii6GpTCDdxDFNgxMEW98OTyLxyMCCxNviJyNYoiWPK1N8NxOZ
         RpfPPzKp9ZmXpORxLun7I1RKJxpNDYdj/zGXedJfnEq5bOm/y4tIeHWgS9VIhAH8y+9e
         uUajzE5Pmj7UzHD99kNKQKIiT2wRMA0U2ufeL3XeE7tjoraBvBlkWxaw5Ld4fDk/9W9O
         LvYRqQbxrMZbc8MHLkzmeXiS91tGwTOlIHH/YjanhEb3q8+VaY+SCd9CI8E84FT6NqcZ
         moWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685598143; x=1688190143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI17x27l49eNtz2vhYST+V4+x0Pcr4kkffqCVPftF0o=;
        b=MQq7/dqONUAOBW3UHdXJLby8bfK6a8RWCEtxyR4QQYgWByyrxh0L2xynmAXEHkw2uw
         /gtKMyeQLtPLWxOE6hD+ySfGX6LSSygoS7BrXJ7l5h+0CQAdmE7ljvKPjpwOVzS1dXQr
         tQbF2KrzD46YPG8Rnu0SQ1nuZ1w46KkJ/top2VZDrdJ2cQio1lfB5kIWWv7FUb4+W1DB
         9ExV615FGMqfwyNenWJZYOhYuLWBL4zmyqrCjnSRXXCI4PI6lt2np3zwNjh3J1woK4or
         S+fM7WNfIrhy6uFjDNlWbh0qLEU2gCgyzg4YR67QK1nqHEaCjFJzmn3SzFU1XOnKvQvU
         /QWQ==
X-Gm-Message-State: AC+VfDxTaE5hRnSHpyL0wNWeY+fo4a/S8/+esImDpTbrdQFkVCENVUT/
        Hs1LeOpXXW177c9xMTCRDoDUTL2CTjt6vA==
X-Google-Smtp-Source: ACHHUZ7e82M1dq/z37mV7tpp3Kem/ZGvhJKUH52emdg9PhRHn52s0o3RhdfyNWPeM9yMHNgYlQbGow==
X-Received: by 2002:a81:720a:0:b0:565:de67:1584 with SMTP id n10-20020a81720a000000b00565de671584mr8538272ywc.40.1685598143296;
        Wed, 31 May 2023 22:42:23 -0700 (PDT)
Received: from localhost.localdomain (107-218-116-63.lightspeed.jcvlfl.sbcglobal.net. [107.218.116.63])
        by smtp.gmail.com with ESMTPSA id u5-20020a0deb05000000b00565c29cf592sm4793112ywe.10.2023.05.31.22.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 22:42:22 -0700 (PDT)
From:   Neal Sidhwaney <nealsid@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        Neal Sidhwaney <nealsid@gmail.com>
Subject: [PATCH v2] wifi: brcmfmac: Detect corner error case earlier with log
Date:   Thu,  1 Jun 2023 01:40:36 -0400
Message-Id: <20230601054034.43692-1-nealsid@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In some corner cases, an I/O read can fail and return -1, and this
patch detects this slightly earlier than is done today and logs an
appropriate message.

Signed-off-by: Neal Sidhwaney <nealsid@gmail.com>
---

 v2: Add const to variable holding error code & fix patch submission

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 9f9bf08a70bb..39f3d913c1bc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -972,6 +972,7 @@ static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
 	u32 regdata;
 	u32 socitype;
 	int ret;
+	const u32 READ_FAILED = 0xFFFFFFFF;

 	/* Get CC core rev
 	 * Chipid is assume to be at offset 0 from SI_ENUM_BASE
@@ -980,6 +981,11 @@ static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
 	 */
 	regdata = ci->ops->read32(ci->ctx,
 				  CORE_CC_REG(ci->pub.enum_base, chipid));
+	if (regdata == READ_FAILED) {
+	  brcmf_err("MMIO read failed: 0x%08x\n", regdata);
+	  return -ENODEV;
+	}
+
 	ci->pub.chip = regdata & CID_ID_MASK;
 	ci->pub.chiprev = (regdata & CID_REV_MASK) >> CID_REV_SHIFT;
 	socitype = (regdata & CID_TYPE_MASK) >> CID_TYPE_SHIFT;
--
2.40.1
