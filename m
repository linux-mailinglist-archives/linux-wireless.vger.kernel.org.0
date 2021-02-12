Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E18319C99
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 11:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhBLKX7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 05:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhBLKXs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 05:23:48 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB412C0613D6
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 02:22:20 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lAVac-001o4X-Jq; Fri, 12 Feb 2021 11:22:18 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix rate mask reset
Date:   Fri, 12 Feb 2021 11:22:14 +0100
Message-Id: <20210212112213.36b38078f569.I8546a20c80bc1669058eb453e213630b846e107b@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Coverity reported the strange "if (~...)" condition that's
always true. It suggested that ! was intended instead of ~,
but upon further analysis I'm convinced that what really was
intended was a comparison to 0xff/0xffff (in HT/VHT cases
respectively), since this indicates that all of the rates
are enabled.

Change the comparison accordingly.

I'm guessing this never really mattered because a reset to
not having a rate mask is basically equivalent to having a
mask that enables all rates.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 2ffbe6d33366 ("mac80211: fix and optimize MCS mask handling")
Fixes: b119ad6e726c ("mac80211: add rate mask logic for vht rates")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c4c70e30ad7f..68a0de02b561 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2950,14 +2950,14 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 			continue;
 
 		for (j = 0; j < IEEE80211_HT_MCS_MASK_LEN; j++) {
-			if (~sdata->rc_rateidx_mcs_mask[i][j]) {
+			if (sdata->rc_rateidx_mcs_mask[i][j] != 0xff) {
 				sdata->rc_has_mcs_mask[i] = true;
 				break;
 			}
 		}
 
 		for (j = 0; j < NL80211_VHT_NSS_MAX; j++) {
-			if (~sdata->rc_rateidx_vht_mcs_mask[i][j]) {
+			if (sdata->rc_rateidx_vht_mcs_mask[i][j] != 0xffff) {
 				sdata->rc_has_vht_mcs_mask[i] = true;
 				break;
 			}
-- 
2.26.2

