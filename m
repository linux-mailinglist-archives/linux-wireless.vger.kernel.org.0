Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51F7105FFD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 06:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKVF3f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 00:29:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43041 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfKVF3e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 00:29:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so2912048pfb.10
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 21:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9G4UM2vhuEG4TSdFZTVuZ71GTOHLABBI6xxxI/2Oncw=;
        b=WaDUta6XODn4hzzqR0np+iPcfBChaSE05EpSM8UrALWvgf7x/9f0e8SMvgXTGXaN74
         Irmx+lKSr5piR/mhpfRO+HVN7bu7ukOSsxCxlNav6kvJn3SG/q0TV9VGoWEKM+8yISrK
         Bc5MtndhyGLDrWQFgc5fSdMf+/79HC0AWnnavMoEKxnAti/HKBQnIPreGoLnrWIpbhXZ
         EdU3ei0kxlwAUbNl8/FywUG2qzQeoeh5RranVfooFhbBQ0QfNtx3k3ARWrVdT9uV7QtX
         pcpYtJsjn94TXL0llHTzpE182eTvmUrzxf89ubigJh+EYnryHC+HUHZoVtjYtbjidWoV
         I0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9G4UM2vhuEG4TSdFZTVuZ71GTOHLABBI6xxxI/2Oncw=;
        b=gNC3IOfmB1H65frnsn63mdzaxphxG6xvR0SHEIOJSaWI/Jx9VK+CfnGr+7pOQZ/Pyw
         wORhpVi6EbFsE7mVKbjlJ7O96hk14FnUKSPVOhl9NH4xXBktd7sJc5Z36N3J6RRv9Cfc
         gQWPy1otHKeNz1riMgHcbkaiKj3CANpJ6gaAE/R8EjWLXjS7Bw/vBgQSr5WnAVV27Ppw
         Flrks3Qv8BGkRUCymKArD05r646Fx1ew/FI7oGyKQhxxWJPuv5RoVTGPbAC1unU+zjfN
         2XNdr1yKKfY4R5S8q49FeHsN5Mb+lmriUPdLPL062UzQ7x/pTzfh3rI9Lf92jMJiJ9/n
         9zPw==
X-Gm-Message-State: APjAAAVgSeSrlZfb2Ch2KXDFaNq6RLCJCvq40zW4toublIDi1zh7feyc
        srNh0xN+iNrBCzEMbsxDKJS2IOoUYXc=
X-Google-Smtp-Source: APXvYqwPwHZStvNKOZtUBWgPYiEFiNFqEQLMngqNoFN6jFqDKFjISduUPDUYh2y907mFwD+Qn6zs9w==
X-Received: by 2002:a63:7456:: with SMTP id e22mr14245471pgn.314.1574400573682;
        Thu, 21 Nov 2019 21:29:33 -0800 (PST)
Received: from localhost ([38.121.20.202])
        by smtp.gmail.com with ESMTPSA id x192sm5658165pfd.96.2019.11.21.21.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 21:29:32 -0800 (PST)
From:   huangwenabc@gmail.com
To:     linux-wireless@vger.kernel.org
Cc:     linux-distros@vs.openwall.org, security@kernel.org,
        libertas-dev@lists.infradead.org
Subject: [PATCH] libertas: Fix two buffer overflows at parsing bss descriptor
Date:   Fri, 22 Nov 2019 13:29:17 +0800
Message-Id: <20191122052917.11309-1-huangwenabc@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Huang <huangwenabc@gmail.com>

add_ie_rates() copys rates without checking the length 
in bss descriptor from remote AP.when victim connects to 
remote attacker, this may trigger buffer overflow.
lbs_ibss_join_existing() copys rates without checking the length 
in bss descriptor from remote IBSS node.when victim connects to 
remote attacker, this may trigger buffer overflow.
Fix them by putting the length check before performing copy.

This fix addresses CVE-2019-14896 and CVE-2019-14897.

Signed-off-by: Wen Huang <huangwenabc@gmail.com>
---
 drivers/net/wireless/marvell/libertas/cfg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 57edfada0..290280764 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -273,6 +273,10 @@ add_ie_rates(u8 *tlv, const u8 *ie, int *nrates)
 	int hw, ap, ap_max = ie[1];
 	u8 hw_rate;
 
+	if (ap_max > MAX_RATES) {
+		lbs_deb_assoc("invalid rates\n");
+		return tlv;
+	}
 	/* Advance past IE header */
 	ie += 2;
 
@@ -1777,6 +1781,10 @@ static int lbs_ibss_join_existing(struct lbs_private *priv,
 	} else {
 		int hw, i;
 		u8 rates_max = rates_eid[1];
+		if (rates_max > MAX_RATES) {
+			lbs_deb_join("invalid rates");
+			goto out;
+		}
 		u8 *rates = cmd.bss.rates;
 		for (hw = 0; hw < ARRAY_SIZE(lbs_rates); hw++) {
 			u8 hw_rate = lbs_rates[hw].bitrate / 5;
-- 
2.17.1

