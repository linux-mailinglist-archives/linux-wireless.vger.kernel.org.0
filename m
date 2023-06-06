Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C89724304
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbjFFMuM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjFFMuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B511717
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=uMKTJnagN6NVEX/K3sla8M4Bl9Fj+7qLrOKbuKEfdz4=;
        t=1686055783; x=1687265383; b=jKVM1inRGBuyHIu2UnsZN4dNOm/ZyoAT9dR74II5uroS58D
        mfpTwt6ImTDkuMQBDzpGFhYY9i6IohEs1j06lyb+LLeBqLg1bEnEpENpX1dIhnDRxHXulbrr/FnUg
        HCjobnzHyOg5wGCzfH+keRUA1ml/E5hQ3/5re+hxXLU0PbXPlkyVkXnN7Pg3tZaRoLGUtToGYNvCN
        hl0z+bVhDLyoq6SBeHbexci4wFAoGgJDkcUQt5YF4ezHyZ9UmA8MIKsHfCEu22MM73hA+HjCDKao/
        18HfqF7w4boxXPInauOwZUhcDuACtb55cu0ZZjcCokiHI8X5BBsWYBSF40cPL++g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W82-00FZDP-23;
        Tue, 06 Jun 2023 14:49:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/14] wifi: cfg80211: wext: hold wiphy lock in siwgenie
Date:   Tue,  6 Jun 2023 14:49:23 +0200
Message-Id: <20230606144753.82cc542296a6.I2d480428b7314ab4407fa55e73c0e289692e59b8@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606124933.181107-1-johannes@sipsolutions.net>
References: <20230606124933.181107-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Missed this ioctl since it's in wext-sme.c where we
usually get via a front-level ioctl handler in the
other files, but it should also hold the wiphy lock
to align the locking contract towards the driver.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/wext-sme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index f231207ca210..f3eaa3388694 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -3,7 +3,7 @@
  * cfg80211 wext compat for managed mode.
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2009, 2020-2022 Intel Corporation
+ * Copyright (C) 2009, 2020-2023 Intel Corporation
  */
 
 #include <linux/export.h>
@@ -338,6 +338,7 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 	if (!ie_len)
 		ie = NULL;
 
+	wiphy_lock(wdev->wiphy);
 	wdev_lock(wdev);
 
 	/* no change */
@@ -370,6 +371,7 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 	err = 0;
  out:
 	wdev_unlock(wdev);
+	wiphy_unlock(wdev->wiphy);
 	return err;
 }
 
-- 
2.40.1

