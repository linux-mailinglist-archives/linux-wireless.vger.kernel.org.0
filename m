Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52FF573366
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiGMJqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiGMJpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B066F789E
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2ktBs/Wn+htEtZJFsSRL5e+GbbwsEbP19iE4iM70VO0=;
        t=1657705528; x=1658915128; b=Z2DdMNEt9U5X/GrXa24YNar2wpL4qLO7fBFptrvTMc4/i6C
        CUbA/k2rAWQaJVVcqlzvrlWWP0Jt9EWTlzDlvBER5+mAqzRPs4WcVxFziuR9kKkYzha0fuHrBGZ7T
        Jwwm4oePK+ombuMGvC+yzM/kvgxm8vHSdNgg7GyBh2ZrOTTapej++rmaCC5WMhdEXHM5D09vKgQ3i
        iudxnLyQH8gil4q3Yj1LDDR7/9H0497VMKyKgVeK5UHAI55NnCR0WeeWFrS7y33ueFd4whPko4gca
        0W/0mozuTs3m+erg19rVubK55pQWIwUl0LllwGeXAh7RgGn6EghiCTJxEk+rG2Ug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvu-00EgvB-EI;
        Wed, 13 Jul 2022 11:45:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 62/76] wifi: nl80211: set BSS to NULL if IS_ERR()
Date:   Wed, 13 Jul 2022 11:44:48 +0200
Message-Id: <20220713114426.b5c378d6ddb8.I7462f3a786637ec8ccf5cca040e7e8debe52f4e3@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the BSS lookup returned an error, set it to NULL so we
don't try to free it.

Fixes: d648c23024bd ("wifi: nl80211: support MLO in auth/assoc")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 35fb2b0517d9..b75398f0d5b4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10767,6 +10767,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 						  &bssid);
 			if (IS_ERR(req.links[link_id].bss)) {
 				err = PTR_ERR(req.links[link_id].bss);
+				req.links[link_id].bss = NULL;
 				goto free;
 			}
 
-- 
2.36.1

