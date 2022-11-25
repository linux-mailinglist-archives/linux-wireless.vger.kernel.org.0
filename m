Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520FF6388E0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 12:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKYLhJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 06:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKYLhI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 06:37:08 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CBF1BE8A
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 03:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LKzLSJoPZvWxv6KRKP5lI0j5R2+f7wf4lYjKNr+wSa8=;
        t=1669376228; x=1670585828; b=bf17S1pAcuoZixpPvzkuYkMWHIn8CGZ/80606gFpwQjwmap
        69zAYKRbgySL3pioJcr+XVj3ATPyUUefUp7u3EFT4mYwdtx9ZspaR2AaIRwJApjfSyn9eHoDTrQFV
        eL5Ripueeuz0bmi/9qkvJ6xPWuazBkfUZ/xIEBYqP90nulqNbDztuGA+xahIx0JcRZcwcz186ewPx
        HyxJowINDKhBVaPMzpPBKFyg6SSiQ7vx5XhT58f9IjWB5uf6ko44krhkTiLCgEw0epls/N6a4qYr/
        vy/cw8LM8/b3C6ZxvY3ftbUqIFhxi6oaPT5JiHexAYE3Uyrd5mdTxh/ND3Ei/+hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oyX0w-008pvO-2u;
        Fri, 25 Nov 2022 12:37:04 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        =?UTF-8?q?S=C3=B6nke=20Huster?= <shuster@seemoo.tu-darmstadt.de>
Subject: [PATCH 2/2] wifi: cfg80211: don't allow multi-BSSID in S1G
Date:   Fri, 25 Nov 2022 12:36:58 +0100
Message-Id: <20221125123657.9275cf55a8d5.I1d453a442edfe92bec33e38cc1c79da5faa9505d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123657.44ab63af8fc7.Ib449c5f95120320db924edf5935133467eedc3d2@changeid>
References: <20221125123657.44ab63af8fc7.Ib449c5f95120320db924edf5935133467eedc3d2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In S1G beacon frames there shouldn't be multi-BSSID elements
since that's not supported, remove that to avoid a potential
integer underflow and/or misparsing the frames due to the
different length of the fixed part of the frame.

While at it, initialize non_tx_data so we don't send garbage
values to the user (even if it doesn't seem to matter now.)

Reported-and-tested-by: Sönke Huster <shuster@seemoo.tu-darmstadt.de>
Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 4d217798890a..3d86482e83f5 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2527,10 +2527,15 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	const struct cfg80211_bss_ies *ies1, *ies2;
 	size_t ielen = len - offsetof(struct ieee80211_mgmt,
 				      u.probe_resp.variable);
-	struct cfg80211_non_tx_bss non_tx_data;
+	struct cfg80211_non_tx_bss non_tx_data = {};
 
 	res = cfg80211_inform_single_bss_frame_data(wiphy, data, mgmt,
 						    len, gfp);
+
+	/* don't do any further MBSSID handling for S1G */
+	if (ieee80211_is_s1g_beacon(mgmt->frame_control))
+		return res;
+
 	if (!res || !wiphy->support_mbssid ||
 	    !cfg80211_find_elem(WLAN_EID_MULTIPLE_BSSID, ie, ielen))
 		return res;
-- 
2.38.1

