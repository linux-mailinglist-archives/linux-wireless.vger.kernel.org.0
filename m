Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F879573321
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiGMJpL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiGMJpJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7337DA5A9
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GY1Y1arMzfUGmVRJjkVBiNfLpGerwep6HqLXdceADSY=;
        t=1657705508; x=1658915108; b=UHUqigrYsCKdEOqO1+8jDt8KYz6mXgNEe9doREXnmIHUdNy
        g8RHWvFGC0M31iqd/19ZnH78yPBPptgVQvIBTdHkcEVxPkgIbSP3imlNXYLbOFVCvunnwJjRZ0S5y
        lCzK3z9HEy+RVRYKIU3x/Dnu0LZV6W8bAQeOkNjF1D5/pPuvkWcgOHWgKT1L3eHfxQ2i7u+L+wa7B
        fFNZYRr3UkjMNngYc4hY1DAng+n8KIOPaeNb7kfB1gNM7S/jnwJLrRn8nLuz3b0XqrKBlHPUS50f2
        rLbDhfqoH4kR1kCe+tZNH9A9afACYjq58cd+/uPCBebkgzf93veOwMCHUfd62MMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYva-00EgvB-3g;
        Wed, 13 Jul 2022 11:45:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 05/76] wifi: cfg80211: Allow MLO TX with link source address
Date:   Wed, 13 Jul 2022 11:43:51 +0200
Message-Id: <20220713114425.9097a949e4a3.I8f699d52688c38c6fc1e3434c02e4c8d3161fffc@changeid>
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

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Management frames are transmitted from link address and not device
address. Allow that.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/mlme.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 14584488de67..935537c64ed8 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -637,6 +637,18 @@ void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev)
 	cfg80211_mgmt_registrations_update(wdev);
 }
 
+static bool cfg80211_allowed_address(struct wireless_dev *wdev, const u8 *addr)
+{
+	int i;
+
+	for_each_valid_link(wdev, i) {
+		if (ether_addr_equal(addr, wdev->links[i].addr))
+			return true;
+	}
+
+	return ether_addr_equal(addr, wdev_address(wdev));
+}
+
 int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			  struct wireless_dev *wdev,
 			  struct cfg80211_mgmt_tx_params *params, u64 *cookie)
@@ -735,7 +747,7 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			return err;
 	}
 
-	if (!ether_addr_equal(mgmt->sa, wdev_address(wdev))) {
+	if (!cfg80211_allowed_address(wdev, mgmt->sa)) {
 		/* Allow random TA to be used with Public Action frames if the
 		 * driver has indicated support for this. Otherwise, only allow
 		 * the local address to be used.
-- 
2.36.1

