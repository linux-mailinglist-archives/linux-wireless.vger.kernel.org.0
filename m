Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A7A4929D4
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 16:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345988AbiARPp3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jan 2022 10:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345950AbiARPp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jan 2022 10:45:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677DEC061574
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jan 2022 07:45:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id w26so28612304wmi.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jan 2022 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XW3XyYPWyDrzLuk5OlJH9x7qHaKXFg/lu4ttGQKoBvs=;
        b=fMOqZc+C2OgBidKo18D7W/+HESPSArvtvFNi2Oqgnb7eAwiqy9NaX0lMDzIfdbMMEs
         ZnBFbU7eNTilAvym0tEtBa3t56QYVhC6sTi9P474c+WE6ZmZWus53sgXGPNq6mDUDb+E
         VBTh9cfarNrLgTorIohBFG/iHo6b8BmDVASilGCnK4IPByghXhA4b2KACyLmxhoIaoIR
         REnTZrqgzqjNsrSOwdIHjfwqy4RjHoAiV3hbdZbwK08/7x2FPOm+/UKxuxYl0FixyUKZ
         INP7SSLTEzh9fV8h5FAIuHODS/GvM9rfStJc5ZlfMyrPn6E8qYc5+I/zbTv6tmmfrj/O
         61nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XW3XyYPWyDrzLuk5OlJH9x7qHaKXFg/lu4ttGQKoBvs=;
        b=5jVQ8+Z9SrIIewRaHm9QuQxlo5vPiQimj/93cuOFQkiQZe7Cgut0fLdPJLk9tpZRX4
         izJmHG/RI9C5EqJKr5RLV2lmcpw3rXPoMMAm4NWWRtjzi8GZ8iwRfvpQnFSQMM6P6mci
         nqWPsQZMSljo378mmJ5GCvwUZFd3QKVz3VuFDDRSrvz9L3EKcgX0Sn2HCrZTxImFdY82
         +eIp2QNZP1+Bzr/MQGr45hy5468rT0aEJbh5m639SwTRrER9UdPHnsWTkNBEOaGqX1lu
         aemaJiM01EJVzS36hhZH3bTldYkWQI5U9M5vxKO0YUT3SjWNs6EwzdIYsc5a3jDWlneg
         oYpw==
X-Gm-Message-State: AOAM531Ez/fb+53OPQUuK2VLHCqjLfiG3fSMHrQ7+x/clqWOGAemzCTx
        8Ltc/carWuWWFRTwawUGY9Q8S1ERwzoYCA==
X-Google-Smtp-Source: ABdhPJwmPGzCp0dknsBOTG8CH0CrlRWjbRZhKR5isBrrbG13mU4B+awymxotEgeys2hOe+U4OthgGA==
X-Received: by 2002:a5d:4ad0:: with SMTP id y16mr25123076wrs.169.1642520725541;
        Tue, 18 Jan 2022 07:45:25 -0800 (PST)
Received: from buildbot.pitowers.org ([2a00:1098:3142:14:ae1f:6bff:fedd:de54])
        by smtp.gmail.com with ESMTPSA id bg12sm4251018wmb.5.2022.01.18.07.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:45:25 -0800 (PST)
From:   Phil Elwell <phil@raspberrypi.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH] brcmfmac: firmware: Fix crash in brcm_alt_fw_path
Date:   Tue, 18 Jan 2022 15:45:14 +0000
Message-Id: <20220118154514.3245524-1-phil@raspberrypi.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
by a check to the validity of the fwctx->req->board_type pointer. This
results in a crash in strlcat when, for example, the WLAN chip is found
in a USB dongle.

Prevent the crash by adding the necessary check.

See: https://github.com/raspberrypi/linux/issues/4833

Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 0eb13e5df5177..d99140960a820 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -693,7 +693,7 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 {
 	struct brcmf_fw_item *first = &req->items[0];
 	struct brcmf_fw *fwctx;
-	char *alt_path;
+	char *alt_path = NULL;
 	int ret;
 
 	brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
@@ -712,7 +712,9 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 	fwctx->done = fw_cb;
 
 	/* First try alternative board-specific path if any */
-	alt_path = brcm_alt_fw_path(first->path, fwctx->req->board_type);
+	if (fwctx->req->board_type)
+		alt_path = brcm_alt_fw_path(first->path,
+					    fwctx->req->board_type);
 	if (alt_path) {
 		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
 					      fwctx->dev, GFP_KERNEL, fwctx,
-- 
2.25.1

