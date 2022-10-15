Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECEB5FF989
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Oct 2022 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJOJtM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Oct 2022 05:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJOJtL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Oct 2022 05:49:11 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Oct 2022 02:49:09 PDT
Received: from mail-m11873.qiye.163.com (mail-m11873.qiye.163.com [115.236.118.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD150BBC
        for <linux-wireless@vger.kernel.org>; Sat, 15 Oct 2022 02:49:09 -0700 (PDT)
Received: from DESKTOP-SCL4MNH.localdomain (unknown [119.36.235.38])
        by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 75413900734;
        Sat, 15 Oct 2022 17:40:26 +0800 (CST)
From:   taozhang <taozhang@bestechnic.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, taozhang <taozhang@bestechnic.com>
Subject: [PATCH] mac80211: fix memory free error when registering wiphy fail
Date:   Sat, 15 Oct 2022 17:38:31 +0800
Message-Id: <20221015093831.2341-1-taozhang@bestechnic.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTB4YVkweQ0xNTU8YHR4ZQlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKQlVITVVJSE5VSENZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6EAw5Kj0ZCzcoMRYUVkoN
        FAMwCTRVSlVKTU1OQ0lNQ0lNQkJKVTMWGhIXVQ8aFAETGhUcOxkeCA8eGBMVEhhVGBQWRVlXWRIL
        WUFZSkpCVUhNVUlITlVIQ1lXWQgBWUFKQk5PNwY+
X-HM-Tid: 0a83db0429382eafkusn75413900734
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_register_hw free the allocated cipher suites when
registering wiphy fail, and ieee80211_free_hw will re-free it.

set wiphy_ciphers_allocated to false after freeing allocated
cipher suites.

Signed-off-by: taozhang <taozhang@bestechnic.com>
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

