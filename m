Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E39720E05
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jun 2023 08:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjFCGBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Jun 2023 02:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCGBc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Jun 2023 02:01:32 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EC3E55
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 23:01:31 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-568af2f6454so29605217b3.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jun 2023 23:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685772090; x=1688364090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk9Xl9xoxV6Yau2FTfyWrUwCe2JG+DhTDPbuOloks3o=;
        b=GbpFg6winX4c0G+uDSvU2/O1WqW37zeYE86D3nzF04VLmceBa5JnQyRIOTo1s+WonQ
         TijaRppQM/JSjE6R9BZac0dFfB2j63QEhOUrYMa3btj2rz73gV0irnaAVtlym0DLlxZ7
         rLrtaRkO9kyJ0Q0AqrGzFp7YuE3qNoHOXRvgYAaLFVQoZmfXwybBDizlf6JUAKwe+S7M
         MxKNi/qYPcPeKiVyLg15dCv6wIxvFTHzj87KOQVXE92vdTSOJb6qc07wZ/y8zcZZTI7g
         E8ldfCoBCdYY3Hm6l+Pqmr7APMU/hH5HkccQqCcLpSE9B8olZIafNtn/BpAxI0bOWrSG
         SDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685772090; x=1688364090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sk9Xl9xoxV6Yau2FTfyWrUwCe2JG+DhTDPbuOloks3o=;
        b=QQP5Eq2JEEw8GWz8ec5mRFI5NwSj2LfZwxPkXJRLhIREJUsK2LiCvZ+fyYepslCgV3
         zlt0p1+yDmg7oXw4aJ9eE/v3lxZQTFiReQAAY+0cdUjzilHFToKXx0d47cl2OJEF2/Un
         twlWVewCPC5W6N7c/eLZh/MxxfG9iO7YPyZDALONU6Fd2f7yHe3wsn9VuoU02MpBbCfi
         m8iEGBqVEMMYK23frqLxvpS4JAuiMzZHJvJaJXWFi9OqzsLHbObOJQAQ5Xh7kcltMVi+
         4fCYcDLkvAg7YXW82GWWtMDYwRJQGMBu+D4Rj25MW6IFxEcAaWP2pQjsMFJryEYcJCrS
         SAHw==
X-Gm-Message-State: AC+VfDztOK/uaqGoE0gSjwgBPsxYN3Rf9cnOB13wpwq0iFRCjRJ1GD1M
        ct7ZMiC7aOHY1QCToHcbu4AC76QxZuNohg==
X-Google-Smtp-Source: ACHHUZ6EqjU2T2fq4GePyR59f2Jd/FbYuABCm6luhjGAUNTQSCiHgaokzYuIDmbOWbdlzMx9ftIBSw==
X-Received: by 2002:a81:a0d6:0:b0:565:f16:9d07 with SMTP id x205-20020a81a0d6000000b005650f169d07mr2436595ywg.17.1685772090505;
        Fri, 02 Jun 2023 23:01:30 -0700 (PDT)
Received: from localhost.localdomain (107-218-116-63.lightspeed.jcvlfl.sbcglobal.net. [107.218.116.63])
        by smtp.gmail.com with ESMTPSA id e6-20020a81dd06000000b00559be540b56sm1171288ywn.134.2023.06.02.23.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 23:01:28 -0700 (PDT)
From:   Neal Sidhwaney <nealsid@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        Neal Sidhwaney <nealsid@gmail.com>
Subject: [PATCH v3] wifi: brcmfmac: Detect corner error case earlier with log
Date:   Sat,  3 Jun 2023 02:00:23 -0400
Message-Id: <20230603060021.57225-1-nealsid@gmail.com>
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

In brcmf_chip_recognition, the return value from an MMIO read is
interpreted as various fields without checking if it failed, which is
harmless today, as the interpreted fields are checked for validity a
few lines below.  However, in corner cases (on my MacbookPro 14,1,
sometimes after waking from sleep or soft reboot), when this happens,
it causes the logging to be misleading, because the message indicates
an unsupported chip type ("brcmfmac: brcmf_chip_recognition: chip
backplane type 15 is not supported").  This patch detects this case
slightly earlier and logs an appropriate message, with the same return
result as is the case today.

Signed-off-by: Neal Sidhwaney <nealsid@gmail.com>
---
 v3: Fix indentation and add context to commit message
 v2: Add const to variable holding error code & fix patch submission

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 9f9bf08a70bb..2ef92ef25517 100644
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
+		brcmf_err("MMIO read failed: 0x%08x\n", regdata);
+		return -ENODEV;
+	}
+
 	ci->pub.chip = regdata & CID_ID_MASK;
 	ci->pub.chiprev = (regdata & CID_REV_MASK) >> CID_REV_SHIFT;
 	socitype = (regdata & CID_TYPE_MASK) >> CID_TYPE_SHIFT;
--
2.40.1
