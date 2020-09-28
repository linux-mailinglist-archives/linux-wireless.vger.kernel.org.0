Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B7627AC6E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 13:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgI1LHZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 07:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgI1LHY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 07:07:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0FDC061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 04:07:24 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMr07-00CRXd-40; Mon, 28 Sep 2020 13:07:23 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: fix non-split wiphy information
Date:   Mon, 28 Sep 2020 13:07:18 +0200
Message-Id: <20200928130717.3e6d9c6bada2.Ie0f151a8d0d00a8e1e18f6a8c9244dd02496af67@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When dumping wiphy information, we try to split the data into
many submessages, but for old userspace we still support the
old mode where this doesn't happen.

However, in this case we were not resetting our state correctly
and dumping multiple messages for each wiphy, which would have
broken such older userspace.

This was broken pretty much immediately afterwards because it
only worked in the original commit where non-split dumps didn't
have any more data than split dumps...

Fixes: fe1abafd942f ("nl80211: re-add channel width and extended capa advertising")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2c9e9a2d1688..935ff973412a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2355,7 +2355,10 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		 * case we'll continue with more data in the next round,
 		 * but break unconditionally so unsplit data stops here.
 		 */
-		state->split_start++;
+		if (state->split)
+			state->split_start++;
+		else
+			state->split_start = 0;
 		break;
 	case 9:
 		if (rdev->wiphy.extended_capabilities &&
-- 
2.26.2

