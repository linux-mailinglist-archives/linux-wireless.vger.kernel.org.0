Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742EF10764B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 18:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKVRRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 12:17:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39538 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKVRRC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 12:17:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so1314956pga.6
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 09:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6+LL8qsLHJX2/gsW2qsgwafSTmgjosS9b/ig7Inn4hU=;
        b=e8BrkZ8/YCsuoD4K1DwERM6hGLEHvmbT6BR3qxdP36+HdJ9mPgnnOtz/TweKJr+JRJ
         K+ZyKkg31vxIOiDQSAd/E8bcHqeRH9d/kb5yzfH7KKS+tZDAC6T7tdD/iT/5L7xHhh49
         12CJjBxv+wQhcGjwBVJrTa0eWy4u/4m0YRxcmvYZoRgqOPgKp5GnyUa0OkPjwawxLJr/
         VXmWXU2ndF+W0FAKDD9mHMkV1RGN8NaXacozpGLTeSk2Nmp1jRlGy5hkvCRmteCTV42a
         3+ZyN+BE8E1VHodYjS6CM/VKiBjy0+iR1jeCsNtsP2UYNVKZ9JgTL9FCBhEH6YGAu9H7
         r57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6+LL8qsLHJX2/gsW2qsgwafSTmgjosS9b/ig7Inn4hU=;
        b=jzH+Oziqi4AMqvErZpGTNVMhQSxIK8iQKVtTjnGp9QR4tEermIPmESwxbuftN6FtuQ
         BAjA7el7R6Ts6S35BKuAKQ7+lALnTiSmkHG1f0HwWD31elx3CyyyleGSF/C6bcjnahNX
         TYd0TI/9QYVGz2MtF2Mnf/8/Q5gXPo2oxyaqtGyc573qxi/4e7JVbWB/e75IZDLjyGuy
         ORk8GZqiT1Z2Dh6uqpBHdyBkGq1oPix2x6WKIDiCq15cVeGjImgSZ80CSUGmWRbrNPOw
         NX1pLcz6uEAFDdK0fIY9pr7Nbl0r7FHvzo9umR1yI5Nf65+HstWlz2QYl5FnLvM9Z64k
         USTw==
X-Gm-Message-State: APjAAAVkCATevR3NaHSWJkzpmoVRbGETe1WBGbEttt+ZaxKlMZr5UO8T
        3W56BlWoB8QQNtcrX5P2lCqlKH7p
X-Google-Smtp-Source: APXvYqwUsXDBVrO5FFBT3W5HINDTFp8JZ8jbWghJZBTryTMvyHPO093GStiQnvDmMNfUtiMEozrjgA==
X-Received: by 2002:a65:6081:: with SMTP id t1mr16831267pgu.391.1574443019623;
        Fri, 22 Nov 2019 09:16:59 -0800 (PST)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id b13sm7406030pgj.28.2019.11.22.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 09:16:59 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/2] mac80211_hwsim: enable parent TSF feature
Date:   Fri, 22 Nov 2019 09:14:00 -0800
Message-Id: <20191122171401.8788-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support for this is already in nl80211, and some code paths in
mac80211_hwsim already set the rx_status to allow the parent TSF
value to be sent to user space.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 772e54f0696f..e9bc599481d4 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2825,6 +2825,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			       NL80211_FEATURE_DYNAMIC_SMPS |
 			       NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_BSS_PARENT_TSF);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
-- 
2.17.1

