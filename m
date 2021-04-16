Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8425D361ABD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 09:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhDPHmy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 03:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbhDPHmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 03:42:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE2FC061574
        for <linux-wireless@vger.kernel.org>; Fri, 16 Apr 2021 00:42:22 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lXJ7K-00CT45-NT; Fri, 16 Apr 2021 09:42:18 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] cfg80211: scan: drop entry from hidden_list on overflow
Date:   Fri, 16 Apr 2021 09:42:14 +0200
Message-Id: <20210416094212.5de7d1676ad7.Ied283b0bc5f504845e7d6ab90626bdfa68bb3dc0@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we overflow the maximum number of BSS entries and free the
new entry, drop it from any hidden_list that it may have been
added to in the code above or in cfg80211_combine_bsses().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 758eb7d2a706..caa8eafbd583 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1751,6 +1751,8 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 
 		if (rdev->bss_entries >= bss_entries_limit &&
 		    !cfg80211_bss_expire_oldest(rdev)) {
+			if (!list_empty(&new->hidden_list))
+				list_del(&new->hidden_list);
 			kfree(new);
 			goto drop;
 		}
-- 
2.30.2

