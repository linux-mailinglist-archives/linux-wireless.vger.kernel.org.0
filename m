Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140731E0FB9
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbgEYNps (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 09:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390800AbgEYNps (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 09:45:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF2FC061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:45:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v19so84221wmj.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ktNb0y9yWDGis4At61Kcmw40E/T99mxPS//ru5LqaDs=;
        b=Lc+cch/9ks1bNGc0WZCHEZ53bFZBXi4VSAn6YiLZBleE8qc1VrdwYeEvRi6r0bdigr
         UwNL9OhdaQjB1rsDYPXS1HE01orXjsuodWDl/qAo9MkqOCvuyTUJpq+GQLX56c9rK44j
         /w0l4TZkJ2Pm85Dq89NWohwzN1G8wUknrSZMaZN4lqzgfWQusKQ2RzpyyuguQWnoIVM6
         26fvRMkPXhV1q1pDI8q3E4fLF+1XL6Vxd/BOe/P2KIz8NP7HOkbk5gwUm6h4nBC09MBw
         q0joaoZcTDx0sG/wNFIcjyPTuBcQNj/0Haud3cGG/5EsdGBip60NIh5fAbIMjv+RwM4k
         1Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ktNb0y9yWDGis4At61Kcmw40E/T99mxPS//ru5LqaDs=;
        b=e/s3eiZRqOTN8n7pTDTJp9ch9uiyv53IjUA411WN0/tIXU2+rtMUQKS3jjGsfbCgKV
         PHdDdfVElLBmJ0cwEev6Sio08qSBnFv/bPgMdeKEnwS/g1DqUywgADwj9RTvcPbEIUln
         ztkRXllWrr8zbMBg0JaR9xG+jKoN0KsrpiBuPjJDmwrDQ6CoIEEYHgTobRIo+LxVnUKJ
         z1dtLWqs+yoYkQeyPsnylgecokyK8OKksp1+LDofOOB2YgvTiYTecGXG6g1Z6LBaHzIy
         H/JnziV4b+HFRBCxTdjAFj4aM7Rb3dRKLkSWMIZhE1wJZhoxbLkS2O+Ru+1fE3X2zla3
         AX+A==
X-Gm-Message-State: AOAM532FNqJ3tHvZ+GTiKQyd5HwgNe++8CykUAC2IIrHO2GUKRMgN+45
        mzMCUFfWYzSBHCylgJveTA==
X-Google-Smtp-Source: ABdhPJysY0VS1Ti1/hbd7/QHqUr4Tlcrhw2+7yRAT7S2moHgFBX3gK/NWeQIX0HBZiF8i3UejVA/Eg==
X-Received: by 2002:a05:600c:2f97:: with SMTP id t23mr25694403wmn.150.1590414346776;
        Mon, 25 May 2020 06:45:46 -0700 (PDT)
Received: from vedder.lan (a109-49-9-80.cpe.netcabo.pt. [109.49.9.80])
        by smtp.gmail.com with ESMTPSA id z3sm18822201wrm.81.2020.05.25.06.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 06:45:46 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     johannes@sipsolutions.net
Cc:     stf_xl@wp.pl, julian.calaby@gmail.com, kvalo@codeaurora.org,
        Larry.Finger@lwfinger.net, linux-wireless@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] rt2800: enable MFP support unconditionally
Date:   Mon, 25 May 2020 14:45:20 +0100
Message-Id: <20200525134519.1333-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This gives us WPA3 support out of the box without having to manually disable
hardware crypto. The driver will fall back to software crypto if the connection
requires management frame protection.

Suggested-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 +---
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 3 ++-
 2 files changed, 3 insertions(+), 4 deletions(-)

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
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 32efbc8e9f92..4f19581edd0f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -468,7 +468,8 @@ int rt2x00mac_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	if (!test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags))
 		return 0;
 
-	if (!rt2x00_has_cap_hw_crypto(rt2x00dev))
+	/* The hardware can't do MFP */
+	if (!rt2x00_has_cap_hw_crypto(rt2x00dev) || sta->mfp)
 		return -EOPNOTSUPP;
 
 	/*
-- 
2.26.2

