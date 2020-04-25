Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291211B853D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDYJ2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 05:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDYJ2W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 05:28:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF29C09B04A
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2020 02:28:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so14469952wma.4
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2020 02:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pchPCOpTMEQnDTQh/FE5CthN2dZfV/XUd2nDQqrx6UA=;
        b=rvsRW32UhJX3XeBkid02kNRA/A5Cy1d+0/hZ4M6H2lCNKsNzxZFnxf3WWZdmNqgMIN
         HABJjewR/GfL37pQjQs9bSPDxGRZ9ysdAX69AlBBDazvdVZ4RMBOmZryMRbd/ZTc/FSP
         WjuoProAwI1/yQw9309343uiWseVqQbeLXxP9qIDANLPc+EBg9WHZacrFUV1rcBSFszB
         iLFbZdjoFG/rVyTkllSOSRqA7jCDnG7VKYEkKZFJ67nf+GHDZhVWetiH/ef4mITbsEAp
         XXlw4zZ5HoD3YCExesw0ZPRWTT+kX0t7hREGb9+9DD+LV7ziEevllRzOjn7rVbobh4dj
         UvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pchPCOpTMEQnDTQh/FE5CthN2dZfV/XUd2nDQqrx6UA=;
        b=NyRD7jeKYgfKMLqNTyQdGZuVjB9okDOk2efVip2qHaeCXr46gCsfSYqkJLpIBF+dLz
         YfmVRSy6nck7H9CWSL7Fc5JFwN3pSskECalVYxa4Scg32z/HWFn9CHLqBXDoCOYo1e7f
         iC9+aphgK/tYuBM6myaxd3KpN9VS1fB0lQ/kWvKLvUJCPWWf6lvdoxvo/1VTcKIDqvHj
         AOKKrenhlyOMBKxe5y5+3bGS5dpCkcWwdjZ6x4DQQUlsgqk4YGKWN43f7CDJ8sdt+zie
         fg+IvwJoTL6ybDemBu9FhhZExU5XRABAeP13ulcvPTvppkNMwIJ0YZKvXaYsWkeHc0yP
         pxLQ==
X-Gm-Message-State: AGi0Puavt02Bkk2a7oahUtlGQLhaIRoPV1WMbWnFlehXOsezTrZzD/BO
        D+uqX6PtkD5atXDI83lJa5YcE37o
X-Google-Smtp-Source: APiQypKfEjHhEcxrfZYG1dq92iBShS4AWgIVfAKoV+YD7rSpiCakINFWoh/8liA6uZSk6nkbXbrrKg==
X-Received: by 2002:a05:600c:220c:: with SMTP id z12mr14820200wml.84.1587806899981;
        Sat, 25 Apr 2020 02:28:19 -0700 (PDT)
Received: from debian64.daheim (p5B0D7BFA.dip0.t-ipconnect.de. [91.13.123.250])
        by smtp.gmail.com with ESMTPSA id o3sm11862079wru.68.2020.04.25.02.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 02:28:18 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.93)
        (envelope-from <chunkeey@gmail.com>)
        id 1jSH6b-0002Tt-FI; Sat, 25 Apr 2020 11:28:13 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, fschaefer.oss@googlemail.com
Subject: [PATCH] carl9170: remove P2P_GO support
Date:   Sat, 25 Apr 2020 11:28:11 +0200
Message-Id: <20200425092811.9494-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch follows up on a bug-report by Frank Schäfer that
discovered P2P GO wasn't working with wpa_supplicant.
This patch removes part of the broken P2P GO support but
keeps the vif switchover code in place.

Cc: <stable@vger.kernel.org>
Link: <https://lkml.kernel.org/r/3a9d86b6-744f-e670-8792-9167257edef8@googlemail.com>
Reported-by: Frank Schäfer <fschaefer.oss@googlemail.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/carl9170/fw.c   |  4 +---
 drivers/net/wireless/ath/carl9170/main.c | 21 ++++-----------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/fw.c b/drivers/net/wireless/ath/carl9170/fw.c
index 51934d191f33..1ab09e1c9ec5 100644
--- a/drivers/net/wireless/ath/carl9170/fw.c
+++ b/drivers/net/wireless/ath/carl9170/fw.c
@@ -338,9 +338,7 @@ static int carl9170_fw(struct ar9170 *ar, const __u8 *data, size_t len)
 		ar->hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
 
 		if (SUPP(CARL9170FW_WLANTX_CAB)) {
-			if_comb_types |=
-				BIT(NL80211_IFTYPE_AP) |
-				BIT(NL80211_IFTYPE_P2P_GO);
+			if_comb_types |= BIT(NL80211_IFTYPE_AP);
 
 #ifdef CONFIG_MAC80211_MESH
 			if_comb_types |=
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 5914926a5c5b..816929fb5b14 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -582,11 +582,10 @@ static int carl9170_init_interface(struct ar9170 *ar,
 	ar->disable_offload |= ((vif->type != NL80211_IFTYPE_STATION) &&
 	    (vif->type != NL80211_IFTYPE_AP));
 
-	/* While the driver supports HW offload in a single
-	 * P2P client configuration, it doesn't support HW
-	 * offload in the favourit, concurrent P2P GO+CLIENT
-	 * configuration. Hence, HW offload will always be
-	 * disabled for P2P.
+	/* The driver used to have P2P GO+CLIENT support,
+	 * but since this was dropped and we don't know if
+	 * there are any gremlins lurking in the shadows,
+	 * so best we keep HW offload disabled for P2P.
 	 */
 	ar->disable_offload |= vif->p2p;
 
@@ -639,18 +638,6 @@ static int carl9170_op_add_interface(struct ieee80211_hw *hw,
 			if (vif->type == NL80211_IFTYPE_STATION)
 				break;
 
-			/* P2P GO [master] use-case
-			 * Because the P2P GO station is selected dynamically
-			 * by all participating peers of a WIFI Direct network,
-			 * the driver has be able to change the main interface
-			 * operating mode on the fly.
-			 */
-			if (main_vif->p2p && vif->p2p &&
-			    vif->type == NL80211_IFTYPE_AP) {
-				old_main = main_vif;
-				break;
-			}
-
 			err = -EBUSY;
 			rcu_read_unlock();
 
-- 
2.26.2

