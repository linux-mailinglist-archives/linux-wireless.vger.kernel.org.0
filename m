Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE2B573371
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiGMJrC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiGMJpo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E266F8962
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IzBRxpxGlNmts79l/1UzNlDg52Q2m506Q4iOlT8VG60=;
        t=1657705533; x=1658915133; b=T6o65kGGNDwOi+FB7t+KUQvXoIMCrfSvKZqqhccL1zkyeLE
        MvKYg7matncj3c1U3S0OFU92RFKqixPZadGCT/PRbnqXnRCqueyUHB7vpd5mXD7trK3mJl7kN1mvT
        1nUMioTr7oB3ru/2KgfK0qakOHGM/o7BiEggvQrdiJj6h5VzfezWB4bM39Tv6Z8+POU6o6Wuh7zQw
        2RDDfOHDlLK6EWL+yBrXRa9BsnWwP381XnH7oXG/0/guPuOi2oDDBy2vj02aLaUQStQVWxAD9jaBs
        AXsYtW2bo8bWayTXQu7m8WDWZ/cFJgl46X6ZAKMeGhykiYsw4uyGAdhs/M2DLb9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvy-00EgvB-Na;
        Wed, 13 Jul 2022 11:45:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 76/76] wifi: cfg80211: set country_elem to NULL
Date:   Wed, 13 Jul 2022 11:45:02 +0200
Message-Id: <20220713114426.4af2e0d5839c.I1939ee155c2c3fc0caa78cee7a5c162395a47a8c@changeid>
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

The link loop will always have a valid link so that
it's always set, but static checkers don't always
see that, so set it to NULL explicitly.

Fixes: efbabc116500 ("cfg80211: Indicate MLO connection info in connect and roam callbacks")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/sme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 00be498aab2e..8e8a79bd237c 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -723,7 +723,7 @@ void __cfg80211_connect_result(struct net_device *dev,
 			       bool wextev)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	const struct element *country_elem;
+	const struct element *country_elem = NULL;
 	const u8 *country_data;
 	u8 country_datalen;
 #ifdef CONFIG_CFG80211_WEXT
-- 
2.36.1

