Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E046A1E0AC4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbgEYJic (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389367AbgEYJib (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:38:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A340AC061A0E;
        Mon, 25 May 2020 02:38:31 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd9Yy-002c5s-VE; Mon, 25 May 2020 11:38:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>, stable@vger.kernel.org,
        syzbot+fd5332e429401bf42d18@syzkaller.appspotmail.com
Subject: [PATCH] cfg80211: fix debugfs rename crash
Date:   Mon, 25 May 2020 11:38:17 +0200
Message-Id: <20200525113816.fc4da3ec3d4b.Ica63a110679819eaa9fb3bc1b7437d96b1fd187d@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Removing the "if (IS_ERR(dir)) dir = NULL;" check only works
if we adjust the remaining code to not rely on it being NULL.
Check IS_ERR_OR_NULL() before attempting to dereference it.

I'm not actually entirely sure this fixes the syzbot crash as
the kernel config indicates that they do have DEBUG_FS in the
kernel, but this is what I found when looking there.

Cc: stable@vger.kernel.org
Fixes: d82574a8e5a4 ("cfg80211: no need to check return value of debugfs_create functions")
Reported-by: syzbot+fd5332e429401bf42d18@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 341402b4f178..ce024440fa51 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -142,7 +142,7 @@ int cfg80211_dev_rename(struct cfg80211_registered_device *rdev,
 	if (result)
 		return result;
 
-	if (rdev->wiphy.debugfsdir)
+	if (!IS_ERR_OR_NULL(rdev->wiphy.debugfsdir))
 		debugfs_rename(rdev->wiphy.debugfsdir->d_parent,
 			       rdev->wiphy.debugfsdir,
 			       rdev->wiphy.debugfsdir->d_parent, newname);
-- 
2.26.2

