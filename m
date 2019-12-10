Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F26117C85
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 01:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLJAjY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 19:39:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38737 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfLJAjY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 19:39:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so6523799pls.5
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 16:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQ8jRWchMU/pCJrgAWxeTEB4f5607iPubBgJHWYT3M0=;
        b=dep0PvRaGygfo0EgfIfOWbAnYsDki/VXzduGalZrmePdP/m7sNZWdv1qw71qSj1F6u
         PTQmfeO+0bSywZM+DdI3KP/08oSgSCLBmMK6zsbWiiyPp8F+W3SqbxTwuHr2FG2OOOu3
         Po9FOeAMHcQN5VeO5iKHkWTK0LM/S7KnJKHTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQ8jRWchMU/pCJrgAWxeTEB4f5607iPubBgJHWYT3M0=;
        b=SYyy3wuVao5cpgth5d+o5BHkO4W7aqreswjphXOPC0Ze4lPpwOi04CgH6q8NS1s85A
         TvsRny5nvTv8zKf32cAbZHhuTBGUjI0PXZ1f+nVoVKhi1ssnhxuJzu5lZ/xsBQFTFeOw
         Czi0CkZfyGlSPc2nXwoXYiJ9ya9KqvOTk2yJTaK7bedm/vgONunzO0lW810GEGvy1Sos
         6cIUoficSOFNtteLxJPu06GlyxkLJloRj4XJZOKFFwZXjIES3mwhguNhXfI6UInGER5P
         RIT/ILuwaamFgsPoA7e0ASc6+mT8UikI9CAqEZ+1iiY70h424WPa5TMvLKh/JqjugfBo
         Tf7w==
X-Gm-Message-State: APjAAAWyNkgszERscLMk7iaSPqh/kBn0+HoCuWDaAmUTOscZ7Z3HkWI8
        t+QJaoACz0d+6UrxLrCRNLkUTcWwbUA=
X-Google-Smtp-Source: APXvYqz6I1xzAJjLryfai5wDR7NXlIFVTUtpTz0Qtpn4nx49m5pqdDnECFgGHywphMX7hn1x65m0zw==
X-Received: by 2002:a17:90a:a44:: with SMTP id o62mr2161760pjo.80.1575938363085;
        Mon, 09 Dec 2019 16:39:23 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id p28sm654515pgb.93.2019.12.09.16.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 16:39:22 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Sharvari Harisangam <sharvari@marvell.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: delete unused mwifiex_get_intf_num()
Date:   Mon,  9 Dec 2019 16:39:11 -0800
Message-Id: <20191210003911.28066-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 7afb94da3cd8 ("mwifiex: update set_mac_address logic") fixed the
only user of this function, partly because the author seems to have
noticed that, as written, it's on the borderline between highly
misleading and buggy.

Anyway, no sense in keeping dead code around: let's drop it.

Fixes: 7afb94da3cd8 ("mwifiex: update set_mac_address logic")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 095837fba300..56a18a7f6853 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1294,19 +1294,6 @@ mwifiex_copy_rates(u8 *dest, u32 pos, u8 *src, int len)
 	return pos;
 }
 
-/* This function return interface number with the same bss_type.
- */
-static inline u8
-mwifiex_get_intf_num(struct mwifiex_adapter *adapter, u8 bss_type)
-{
-	u8 i, num = 0;
-
-	for (i = 0; i < adapter->priv_num; i++)
-		if (adapter->priv[i] && adapter->priv[i]->bss_type == bss_type)
-			num++;
-	return num;
-}
-
 /*
  * This function returns the correct private structure pointer based
  * upon the BSS type and BSS number.
-- 
2.24.0.393.g34dc348eaf-goog

