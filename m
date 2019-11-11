Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5BF6FB7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 09:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfKKIau (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 03:30:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKIau (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 03:30:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id i10so13570769wrs.7
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 00:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfYbEgAY+sR3WMegjSQALh1Z+ZR76lirPNOK7ye15WI=;
        b=gjzRX6FElRGF2YiXqGnW+70KStai+MSuuEbnT/GlxVjUBZuTVA9LKPg6tWbrGNg651
         dWWXPy9d8C43yvFZfkXGzxaa/hbVAYfI4j8c1VbvjlErhs1J8NUE9SKGGEB4g9E+va2G
         jPaJPzsFcO/Kmy5YR60JYR5qwqGawaCxj/+VtGy+G4uWyrvdxL/8AleBLVuZpwAdVTMx
         LYA+sK+bNaoxVmO5inDnR7pf8J8vZRWVZMI/8v32X/fIFkADtu7Ct+7b7zNBDkOODb0Q
         php0LQdre0UTPokV0wsHkCMTQRmE9l2jcY5Zaq6gz1W9ebZ2grrPqzPbGAn7xKIj/dj0
         J2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfYbEgAY+sR3WMegjSQALh1Z+ZR76lirPNOK7ye15WI=;
        b=C506BxWLWso9pLp30fmcDxGsH0QK8CiV5ChZP+SPqUgMHFSEsXbJSYj/QSb1+WeGf3
         kOtCO7VInUvE5MthQ/7kao7vt92utQUbf2l3sZzHCEzsDM/SeU2vTQb7dg4803iZHX+W
         Ic4i0oWxR24NAM93kBxi855RFUw70+PqGm4yn/wvhocUO3H4mBZQUOE/r9IvPrHPqUKg
         PnXSBN9iCwdWWADx8rZChGzKyGRldkbcGFmosoI2dC97eJ0VExinKkJZMTiG4H/GfIQQ
         unjbcFZ7euMIBa+ebj7740ni0ZfNSxuA7nVSbenKyNq0o+MohsSHg4IFauEZpzE3JOIM
         abeA==
X-Gm-Message-State: APjAAAWxqOCRKADgZ0dXD1kEXuHey4FtgNcC4oCW7WIYhd+PYCIiMJ9k
        Xz37fBKDjsuLA2Tfo2AuERDfHjtz
X-Google-Smtp-Source: APXvYqz9QuOoHzXr9dxaAs1TYOGl6ilw72R4moECg96uYMmSQezS69Nck4LCtXSgFstLqvbSLuwoGg==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr20580552wrn.103.1573461047691;
        Mon, 11 Nov 2019 00:30:47 -0800 (PST)
Received: from localhost.localdomain ([193.27.220.66])
        by smtp.gmail.com with ESMTPSA id r2sm4146713wrp.64.2019.11.11.00.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:30:46 -0800 (PST)
From:   Eduardo Abinader <eduardoabinader@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Eduardo Abinader <eduardoabinader@gmail.com>, kvalo@codeaurora.org,
        ath10k@lists.infradead.org
Subject: [PATCH] ath10k:mac: disassoc dbg msg after return check
Date:   Mon, 11 Nov 2019 09:30:40 +0100
Message-Id: <20191111083040.16824-1-eduardoabinader@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 5e3450cfb07b..038d5c27bed7 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6786,13 +6786,13 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		/*
 		 * Disassociation.
 		 */
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac sta %pM disassociated\n",
-			   sta->addr);
-
 		ret = ath10k_station_disassoc(ar, vif, sta);
 		if (ret)
 			ath10k_warn(ar, "failed to disassociate station: %pM vdev %i: %i\n",
 				    sta->addr, arvif->vdev_id, ret);
+		else
+			ath10k_dbg(ar, ATH10K_DBG_MAC, "mac sta %pM disassociated\n",
+			   sta->addr);
 	}
 exit:
 	mutex_unlock(&ar->conf_mutex);
-- 
2.20.1

