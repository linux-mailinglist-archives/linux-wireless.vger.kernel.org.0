Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB2639F277
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFHJea (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhFHJe3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 05:34:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D08C061789
        for <linux-wireless@vger.kernel.org>; Tue,  8 Jun 2021 02:32:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lqY66-003gsH-BL; Tue, 08 Jun 2021 11:32:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] cfg80211: shut down interfaces on failed resume
Date:   Tue,  8 Jun 2021 11:32:29 +0200
Message-Id: <20210608113226.d564ca69de7c.I2e3c3e5d410b72a4f63bade4fb075df041b3d92f@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608113226.14020430e449.I78e19db0a55a8295a376e15ac4cf77dbb4c6fb51@changeid>
References: <20210608113226.14020430e449.I78e19db0a55a8295a376e15ac4cf77dbb4c6fb51@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If resume fails, we should shut down all interfaces as the
hardware is probably dead. This was/is already done now in
mac80211, but we need to change that due to locking issues,
so move it here and do it without the wiphy lock held.

Fixes: 2fe8ef106238 ("cfg80211: change netdev registration/unregistration semantics")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 9b959e3b09c6..0c3f05c9be27 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -133,6 +133,10 @@ static int wiphy_resume(struct device *dev)
 	if (rdev->wiphy.registered && rdev->ops->resume)
 		ret = rdev_resume(rdev);
 	wiphy_unlock(&rdev->wiphy);
+
+	if (ret)
+		cfg80211_shutdown_all_interfaces(&rdev->wiphy);
+
 	rtnl_unlock();
 
 	return ret;
-- 
2.31.1

