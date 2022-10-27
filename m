Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D793A60F4B1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiJ0KQG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 06:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbiJ0KQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 06:16:04 -0400
Received: from mail-m11878.qiye.163.com (mail-m11878.qiye.163.com [115.236.118.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB741A98DE
        for <linux-wireless@vger.kernel.org>; Thu, 27 Oct 2022 03:16:01 -0700 (PDT)
Received: from DESKTOP-SCL4MNH.localdomain (unknown [119.36.235.38])
        by mail-m11878.qiye.163.com (Hmail) with ESMTPA id 1054B740825;
        Thu, 27 Oct 2022 18:15:55 +0800 (CST)
From:   ZhangTao <taozhang@bestechnic.com>
To:     johannes@sipsolutions.net
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        ZhangTao <taozhang@bestechnic.com>
Subject: [PATCH RESEND] mac80211: fix memory free crash when registering wiphy fail
Date:   Thu, 27 Oct 2022 18:15:02 +0800
Message-Id: <20221027101502.211-1-taozhang@bestechnic.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkNKVktKGR8ZHx1DHxpNSlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKQlVITVVJSE5VSENZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OQg6LRw*FD0jCxIzOBw#Agw4
        H01PFE5VSlVKTU1NQ01OTE5OTEpNVTMWGhIXVQ8aFAETGhUcOxkeCA8eGBMVEhhVGBQWRVlXWRIL
        WUFZSkpCVUhNVUlITlVIQ1lXWQgBWUFJSklONwY+
X-HM-Tid: 0a8418f0f4602eb4kusn1054b740825
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_register_hw free the allocated cipher suites when
registering wiphy fail, and ieee80211_free_hw re-free it.

set wiphy_ciphers_allocated to false after freeing allocated
cipher suites.

Signed-off-by: ZhangTao <taozhang@bestechnic.com>
---
 net/mac80211/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 46f3eddc2..02b5abc73 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1439,8 +1439,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	ieee80211_led_exit(local);
 	destroy_workqueue(local->workqueue);
  fail_workqueue:
-	if (local->wiphy_ciphers_allocated)
+	if (local->wiphy_ciphers_allocated) {
 		kfree(local->hw.wiphy->cipher_suites);
+		local->wiphy_ciphers_allocated = false;
+	}
 	kfree(local->int_scan_req);
 	return result;
 }
@@ -1508,8 +1510,10 @@ void ieee80211_free_hw(struct ieee80211_hw *hw)
 	mutex_destroy(&local->iflist_mtx);
 	mutex_destroy(&local->mtx);
 
-	if (local->wiphy_ciphers_allocated)
+	if (local->wiphy_ciphers_allocated) {
 		kfree(local->hw.wiphy->cipher_suites);
+		local->wiphy_ciphers_allocated = false;
+	}
 
 	idr_for_each(&local->ack_status_frames,
 		     ieee80211_free_ack_frame, NULL);
-- 
2.17.1

