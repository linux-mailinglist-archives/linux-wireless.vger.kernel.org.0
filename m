Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3F45AB437
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiIBOvx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiIBOvJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E1BC7B81
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Vkn9bX2get9xJfGaW7IT8bl2uJfcZVU6lSSkxkJlWGQ=;
        t=1662127995; x=1663337595; b=Amz6I0JlBrc2iHnh7BQM5CO3IVP4wZ8GZqc0NOj3xL//Djg
        FEa6AzprOZWt/EaulGisOHwuAt/J7+RJ6pOinIhSkmVzKNpTSEOebbiIG2WXSXQEPKXtysIbn2anF
        pcd1u2LOM0UuO0sIGMijqXxnZnH/19HV0ZUdI3mpOFk8Nkx1V3Z+XKVTlOxelXpZ0Wcvnz9CjIp3x
        Xw4XcGqxxAJFQBoKYwOkZSQIBJ1iNtuIFj+8yCCFq6dkKy7kpgCZ/5KH01x44m65OLxGthu6amVSf
        mQjJ2Q4fydGTjC32pgY5dc4c7rU+/lVYnciXMg3CZfNor+c8ednz9pY+kXXtrYXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pz-006Ch3-1N;
        Fri, 02 Sep 2022 16:13:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 23/27] wifi: mac80211: fix double SW scan stop
Date:   Fri,  2 Sep 2022 16:12:55 +0200
Message-Id: <20220902161143.90c4cba91722.If9fe28ed40e21b8979e56cf498491f003432a461@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
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

When we stop a not-yet-started scan, we erroneously call
into the driver, causing a sequence of sw_scan_start()
followed by sw_scan_complete() twice. This now causes a
warning in hwsim with the recent commit that validates
the address passed to wmediumd/virtio. Fix this by doing
the calls only if we were actually scanning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index fa8ddf576bc1..a30964589a94 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -482,7 +482,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	/* Set power back to normal operating levels. */
 	ieee80211_hw_config(local, 0);
 
-	if (!hw_scan) {
+	if (!hw_scan && was_scanning) {
 		ieee80211_configure_filter(local);
 		drv_sw_scan_complete(local, scan_sdata);
 		ieee80211_offchannel_return(local);
-- 
2.37.2

