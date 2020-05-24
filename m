Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542B71DFE07
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 11:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgEXJsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 05:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgEXJsO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 05:48:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F62EC061A0E
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 02:48:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u13so4119863wml.1
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLuZrpduAl0SnV4bEe3ediS6h1GhiVu+3ApJ2UPACB4=;
        b=cEj2K9mvkOwJj4AxKY5b810zIjiDAXwPyUREYpB1zlEf19GkFy/7ewbA/N1i4NbkJR
         zusQP1Zv/h8hI2BXhXX+DynaaxC8fNurkxK9s+iLJEIobqThi2g5XUQvYIR720qSpe0x
         yhp4P9TehgMl8bLAB19KDFBCsULWCB3g/2y/DbYT3HDkeJN0flawvTfg3z0KLtN/qAtp
         qHDc57lG+brOv1uInJqcf3N47VoYB8yPDpS0sGBLESUnUFj9lgBO4T02GAPtT7Le4oGe
         cKT3dk3ckOhN8svDtXMxHZhP8e0Hn2//S7lnEitk2YYroX7KNXFO79hcHeuwXShR53HP
         ntcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QLuZrpduAl0SnV4bEe3ediS6h1GhiVu+3ApJ2UPACB4=;
        b=QIweYPMc1xa+/e1LRgNZiW2vllFWgXPaZwG6T4cUzzhnjclx6b2Je2BA9F7178KVqy
         TYO9NdSnoIZidmImghxZFrKFwyr2HjcvdbEz+NCOPI7sDBkU/ZiFn+kYgWAIB4816tvx
         iCOjzeQzji2DlKSJybSRWaVnVQ7NeifkeCB3Y56KG8UkXTJQgw9K5goXqNW0cLoL2pUC
         RdLwEtQFXQo/e97m0k8jKlGWrDFrMXt9KntwdPkYpdBLY/180917Tis94W7sh1FSqawJ
         XqHhZdmAqhlndG4TtIeGM6t0ysgzm625REDXzHdSDvCamtVIOruXYpSeqE9QaQJ+PJLf
         Tk2w==
X-Gm-Message-State: AOAM531dgqaX4j34C4bC9TjjUQbCnfyvlcwh8kiAyngywAtVlCpi8M3v
        IoTUEljHMKMocWgcSD+VVg==
X-Google-Smtp-Source: ABdhPJyPfjyZ6HOEP0jFf+xwrrdGfTKDz8O1t7iKQ2NjF8vMwHz88J/BU/V0ZnBsObvUTec+O8rnmQ==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr21512089wmg.100.1590313691925;
        Sun, 24 May 2020 02:48:11 -0700 (PDT)
Received: from presler.lan (a109-49-9-80.cpe.netcabo.pt. [109.49.9.80])
        by smtp.gmail.com with ESMTPSA id h1sm15289064wme.42.2020.05.24.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 02:48:11 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     stf_xl@wp.pl
Cc:     kvalo@codeaurora.org, Larry.Finger@lwfinger.net,
        linux-wireless@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [RFC PATCH] rt2800lib: unconditionally enable MFP
Date:   Sun, 24 May 2020 10:47:31 +0100
Message-Id: <20200524094730.2684-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to Larry [1] (and successfully verified on b43) mac80211
transparently falls back to software for unsupported hardware cyphers. Thus,
there's no reason for not unconditionally enabling MFP. This gives us WPA3
support out of the box, without having to manually disable hardware crypto.

Tested on an RT2790-based Wi-Fi card.

[1] https://lore.kernel.org/linux-wireless/8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net/

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 6beac1f74e7c..a779fe771a55 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -9971,9 +9971,7 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
 	if (!rt2x00_is_usb(rt2x00dev))
 		ieee80211_hw_set(rt2x00dev->hw, HOST_BROADCAST_PS_BUFFERING);
 
-	/* Set MFP if HW crypto is disabled. */
-	if (rt2800_hwcrypt_disabled(rt2x00dev))
-		ieee80211_hw_set(rt2x00dev->hw, MFP_CAPABLE);
+	ieee80211_hw_set(rt2x00dev->hw, MFP_CAPABLE);
 
 	SET_IEEE80211_DEV(rt2x00dev->hw, rt2x00dev->dev);
 	SET_IEEE80211_PERM_ADDR(rt2x00dev->hw,
-- 
2.26.2

