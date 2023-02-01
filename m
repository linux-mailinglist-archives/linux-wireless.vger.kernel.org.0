Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0FE686638
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 13:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjBAMsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 07:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjBAMsi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 07:48:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F52D4480
        for <linux-wireless@vger.kernel.org>; Wed,  1 Feb 2023 04:48:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C25E61534
        for <linux-wireless@vger.kernel.org>; Wed,  1 Feb 2023 12:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512ACC433D2;
        Wed,  1 Feb 2023 12:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675255716;
        bh=3JK3w2nCqPfaJq+UDqyG9AjNa8lZMNE5j0PchLFYoNg=;
        h=From:To:Cc:Subject:Date:From;
        b=mAIGYefIlBZgR6kseMxoEEUwZlkTK5WQNiFsigHKR9nfuyyvh7d0Ebs5QoZbyfYyJ
         lNevL/VPREbvfQtA4+r2v9i8wGKOQBPIq70kkcbF3Uln7JVL8MbrH+XCHbvnyyOfKx
         +HbNgOEAwCGmebVaMd41QQ89sHmN87x7fTqdxYmR71+ovc2hLXIReCKQOQqV+oLt5c
         KovRIeKDxw1vlxlD9WTt3d1gacVM8i9kZzLX7Lrtj4oxGk4R+fQhb66pfDD1PZiNSO
         GGs/fPxXPOH8Z8at17OWRN7mgYqndfNcCrXGj/Y1r9Vw23k6QmgpMa3IMSSfQ8czGJ
         HlASCcbEUSEQA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH wireless-next] wifi: mac80211: get rid of gfp in cfg80211_bss_color_notify
Date:   Wed,  1 Feb 2023 13:48:30 +0100
Message-Id: <c687724e7b53556f7a2d9cbe3d11cdcf065cb687.1675255390.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since cfg80211_bss_color_notify() is now always run in non-atomic
context, get rid of gfp_t flags in the routine signature and always use
GFP_KERNEL for netlink message allocation.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on the one below not yet applied on wireless-next:
https://patchwork.kernel.org/project/linux-wireless/patch/3f6cf60c892ad40c1cca4a55d62b1224ef1c6ce9.1674644379.git.lorenzo@kernel.org/
---
 include/net/cfg80211.h | 16 ++++++----------
 net/mac80211/cfg.c     |  3 +--
 net/wireless/nl80211.c |  6 +++---
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 54a77d906b2d..b4e9d7f2d1b3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8842,12 +8842,11 @@ void cfg80211_bss_flush(struct wiphy *wiphy);
 /**
  * cfg80211_bss_color_notify - notify about bss color event
  * @dev: network device
- * @gfp: allocation flags
  * @cmd: the actual event we want to notify
  * @count: the number of TBTTs until the color change happens
  * @color_bitmap: representations of the colors that the local BSS is aware of
  */
-int cfg80211_bss_color_notify(struct net_device *dev, gfp_t gfp,
+int cfg80211_bss_color_notify(struct net_device *dev,
 			      enum nl80211_commands cmd, u8 count,
 			      u64 color_bitmap);
 
@@ -8858,10 +8857,9 @@ int cfg80211_bss_color_notify(struct net_device *dev, gfp_t gfp,
  * @gfp: allocation flags
  */
 static inline int cfg80211_obss_color_collision_notify(struct net_device *dev,
-						       u64 color_bitmap, gfp_t gfp)
+						       u64 color_bitmap)
 {
-	return cfg80211_bss_color_notify(dev, gfp,
-					 NL80211_CMD_OBSS_COLOR_COLLISION,
+	return cfg80211_bss_color_notify(dev, NL80211_CMD_OBSS_COLOR_COLLISION,
 					 0, color_bitmap);
 }
 
@@ -8875,8 +8873,7 @@ static inline int cfg80211_obss_color_collision_notify(struct net_device *dev,
 static inline int cfg80211_color_change_started_notify(struct net_device *dev,
 						       u8 count)
 {
-	return cfg80211_bss_color_notify(dev, GFP_KERNEL,
-					 NL80211_CMD_COLOR_CHANGE_STARTED,
+	return cfg80211_bss_color_notify(dev, NL80211_CMD_COLOR_CHANGE_STARTED,
 					 count, 0);
 }
 
@@ -8888,8 +8885,7 @@ static inline int cfg80211_color_change_started_notify(struct net_device *dev,
  */
 static inline int cfg80211_color_change_aborted_notify(struct net_device *dev)
 {
-	return cfg80211_bss_color_notify(dev, GFP_KERNEL,
-					 NL80211_CMD_COLOR_CHANGE_ABORTED,
+	return cfg80211_bss_color_notify(dev, NL80211_CMD_COLOR_CHANGE_ABORTED,
 					 0, 0);
 }
 
@@ -8901,7 +8897,7 @@ static inline int cfg80211_color_change_aborted_notify(struct net_device *dev)
  */
 static inline int cfg80211_color_change_notify(struct net_device *dev)
 {
-	return cfg80211_bss_color_notify(dev, GFP_KERNEL,
+	return cfg80211_bss_color_notify(dev,
 					 NL80211_CMD_COLOR_CHANGE_COMPLETED,
 					 0, 0);
 }
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c3e4e48e9ce9..c42fba79fcce 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4661,8 +4661,7 @@ void ieee80211_color_collision_detection_work(struct work_struct *work)
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
 	sdata_lock(sdata);
-	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap,
-					     GFP_KERNEL);
+	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap);
 	sdata_unlock(sdata);
 }
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 64cf6110ce9d..59fcf7b0d784 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19063,7 +19063,7 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
-int cfg80211_bss_color_notify(struct net_device *dev, gfp_t gfp,
+int cfg80211_bss_color_notify(struct net_device *dev,
 			      enum nl80211_commands cmd, u8 count,
 			      u64 color_bitmap)
 {
@@ -19077,7 +19077,7 @@ int cfg80211_bss_color_notify(struct net_device *dev, gfp_t gfp,
 
 	trace_cfg80211_bss_color_notify(dev, cmd, count, color_bitmap);
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
@@ -19100,7 +19100,7 @@ int cfg80211_bss_color_notify(struct net_device *dev, gfp_t gfp,
 	genlmsg_end(msg, hdr);
 
 	return genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy),
-				       msg, 0, NL80211_MCGRP_MLME, gfp);
+				       msg, 0, NL80211_MCGRP_MLME, GFP_KERNEL);
 
 nla_put_failure:
 	nlmsg_free(msg);
-- 
2.39.1

