Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F110ABCF7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 17:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfIFPtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 11:49:17 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:36807 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfIFPtR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 11:49:17 -0400
Received: by mail-oi1-f175.google.com with SMTP id k20so5327934oih.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2019 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kpf3xq7rpPMSCOEsI1NIQkSetSswswsecm6J7RvedB8=;
        b=iwd7jNU2jKVOwrXCcuNHrIDWe6jGL+HrCuZLGVmyOzWRjWim7OslGwlaEyGbRTs7dM
         Kb/RBpQRQS/DyghofhkCsc/MwDgTnRz7ZbWAbJJ1Nl5zYb6B+pe+SLeIEyC1s+Yya6Xr
         r6K8wyYCyofx5dzvr/Ru6j/Ka5bMbBxTPSRaRCUC73Sg1dvkULTIY8nWSv0ZCafCYvad
         RohUqtEmwJWbOhSiVJMFoV+kXA8KFKsy3EUVv+zHftP9PA1bwLWLHI8nZEwpH3VSgT7s
         SYMKc/5PXS9GTLD+szL2jaWDb3MpnXuyrahcsrxTAaWeb9S8mDYFzzsukgnThiVHnnO6
         8oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kpf3xq7rpPMSCOEsI1NIQkSetSswswsecm6J7RvedB8=;
        b=aFm38IAVl+X64/6NhU1r8pwT7yLt1g6Eoic89XTky1ERijmQNfufpGBNgubzeKiiJx
         BkUKiNEgOTJ7ac991ky0kCIDxEXLykR5yA06UCxDOKp2p6Afi27vMF+8WKTLP1KWbhYj
         glds5OkG1D7CYlfnHbF3guHerksTJ9bkO8uN6vTTPoZ5EYMK4IRnlXEcBCYQkSO2cerd
         CFO+w2wyKek86ZRMAZc9BtZcDFSRxJi1zX/NPc9dyiQYVGUl/YwyGSnB894qYdAvm7vA
         mLqu2vG++sCpessOiU6xed1Ty4E4wacRcbpaFRtBwUNtxv1F3HLVFqE7s4xTxImLpPAC
         Ulcg==
X-Gm-Message-State: APjAAAVZBJddIxm6sx1I8VvtH2VbFV+GHgUOH+xHEjG0lwJ5L2fXT7L/
        g0lLfjo2xGowe8B3t9xWvLhgO93e
X-Google-Smtp-Source: APXvYqwShFt0DHVXz18QpObkTs9ztJs0gFzoKdTcWHNcb7LCRw7jkfiDoa40wTkM9hW9OaAbzYsw6A==
X-Received: by 2002:aca:5b84:: with SMTP id p126mr7608718oib.4.1567784955825;
        Fri, 06 Sep 2019 08:49:15 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j7sm2105587otn.65.2019.09.06.08.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:49:14 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [RFCv3 3/3] nl80211: Send large new_wiphy events
Date:   Fri,  6 Sep 2019 10:43:03 -0500
Message-Id: <20190906154303.9303-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190906154303.9303-1-denkenz@gmail.com>
References: <20190906154303.9303-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Send large NEW_WIPHY events on a new multicast group so that clients
that can accept larger messages do not need to round-trip to the kernel
and perform extra filtered wiphy dumps.

A new multicast group is introduced and the large message is sent before
the legacy message.  This way clients that listen on both multicast
groups can ignore duplicate legacy messages if needed.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 include/uapi/linux/nl80211.h | 31 +++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

Changes in this version:

- Updated the docs based on Johannes' feedback
- Added WARN_ON in case the large message building fails (e.g. our
  buffer size needs to be increased)
- Minor style fixes based on Johannes' feedback
- Added a missing skb_get to take an extra reference when sending
  NEW/DEL INTERFACE events.

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index beee59c831a7..7a125cb4d9d9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -50,6 +50,7 @@
 #define NL80211_MULTICAST_GROUP_MLME		"mlme"
 #define NL80211_MULTICAST_GROUP_VENDOR		"vendor"
 #define NL80211_MULTICAST_GROUP_NAN		"nan"
+#define NL80211_MULTICAST_GROUP_CONFIG2		"config2"
 #define NL80211_MULTICAST_GROUP_TESTMODE	"testmode"
 
 #define NL80211_EDMG_BW_CONFIG_MIN	4
@@ -267,8 +268,30 @@
  * @NL80211_CMD_NEW_WIPHY: Newly created wiphy, response to get request
  *	or rename notification. Has attributes %NL80211_ATTR_WIPHY and
  *	%NL80211_ATTR_WIPHY_NAME.
+ *
+ *	Note that when %NL80211_CMD_NEW_WIPHY is being sent as an event, it
+ *	will be multicast on two groups: "config" and "config2".  The messages
+ *	on the two multicast groups will be different.  On "config" multicast
+ *	group, %NL80211_CMD_NEW_WIPHY messages will be 'reduced' size and will
+ *	only contain legacy information.  This is due to historical kernel
+ *	behavior that limited such messages to 4096 bytes.  The "config2"
+ *	multicast group was introduced to support applications that can
+ *	allocate larger buffers and can thus accept new wiphy events with
+ *	the full set of information included.  Messages on the "config2"
+ *	multicast group are sent before the "config" multicast group.
+ *
+ *	There are no limits (outside of netlink protocol limits) on
+ *	message sizes that can be sent over the "config2" multicast group. It
+ *	is assumed that applications utilizing "config2" multicast group
+ *	utilize buffers that are inherently large enough or can utilize
+ *	MSG_PEEK/MSG_TRUNC in the netlink transport in order to allocate big
+ *	enough buffers.
  * @NL80211_CMD_DEL_WIPHY: Wiphy deleted. Has attributes
  *	%NL80211_ATTR_WIPHY and %NL80211_ATTR_WIPHY_NAME.
+ *	Note that when %NL80211_CMD_DEL_WIPHY is being sent as an event, it
+ *	will be multicast on two groups: "config" and "config2".  Messages on
+ *	the "config2" multicast group are sent before the "config" multicast
+ *	group.
  *
  * @NL80211_CMD_GET_INTERFACE: Request an interface's configuration;
  *	either a dump request for all interfaces or a specific get with a
@@ -281,10 +304,18 @@
  *	be sent from userspace to request creation of a new virtual interface,
  *	then requires attributes %NL80211_ATTR_WIPHY, %NL80211_ATTR_IFTYPE and
  *	%NL80211_ATTR_IFNAME.
+ *	Note that when %NL80211_CMD_NEW_INTERFACE is being sent as an event, it
+ *	will be multicast on two groups: "config" and "config2".  Messages on
+ *	the "config2" multicast group are sent before the "config" multicast
+ *	group.
  * @NL80211_CMD_DEL_INTERFACE: Virtual interface was deleted, has attributes
  *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_WIPHY. Can also be sent from
  *	userspace to request deletion of a virtual interface, then requires
  *	attribute %NL80211_ATTR_IFINDEX.
+ *	Note that when %NL80211_CMD_DEL_INTERFACE is being sent as an event, it
+ *	will be multicast on two groups: "config" and "config2".  Messages on
+ *	the "config2" multicast group are sent before the "config" multicast
+ *	group.
  *
  * @NL80211_CMD_GET_KEY: Get sequence counter information for a key specified
  *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC.
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 03421f66eea3..68f496c0c0a4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -46,6 +46,7 @@ enum nl80211_multicast_groups {
 	NL80211_MCGRP_MLME,
 	NL80211_MCGRP_VENDOR,
 	NL80211_MCGRP_NAN,
+	NL80211_MCGRP_CONFIG2,
 	NL80211_MCGRP_TESTMODE /* keep last - ifdef! */
 };
 
@@ -56,6 +57,7 @@ static const struct genl_multicast_group nl80211_mcgrps[] = {
 	[NL80211_MCGRP_MLME] = { .name = NL80211_MULTICAST_GROUP_MLME },
 	[NL80211_MCGRP_VENDOR] = { .name = NL80211_MULTICAST_GROUP_VENDOR },
 	[NL80211_MCGRP_NAN] = { .name = NL80211_MULTICAST_GROUP_NAN },
+	[NL80211_MCGRP_CONFIG2] = { .name = NL80211_MULTICAST_GROUP_CONFIG2 },
 #ifdef CONFIG_NL80211_TESTMODE
 	[NL80211_MCGRP_TESTMODE] = { .name = NL80211_MULTICAST_GROUP_TESTMODE }
 #endif
@@ -1856,6 +1858,7 @@ struct nl80211_dump_wiphy_state {
 	long start;
 	long split_start, band_start, chan_start;
 	bool legacy;
+	bool large_message;
 };
 
 static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
@@ -2414,7 +2417,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 
  nla_put_failure:
 	if ((state->legacy && state->split_start < 9) ||
-	    !last_good_pos) {
+	    !last_good_pos || state->large_message) {
 		genlmsg_cancel(msg, hdr);
 		return -EMSGSIZE;
 	}
@@ -14732,14 +14735,37 @@ void nl80211_notify_wiphy(struct cfg80211_registered_device *rdev,
 			  enum nl80211_commands cmd)
 {
 	struct sk_buff *msg;
+	size_t alloc_size;
 	struct nl80211_dump_wiphy_state state = {};
 
 	WARN_ON(cmd != NL80211_CMD_NEW_WIPHY &&
 		cmd != NL80211_CMD_DEL_WIPHY);
 
+	if (cmd == NL80211_CMD_NEW_WIPHY) {
+		state.large_message = true;
+		alloc_size = 8192UL;
+	} else {
+		alloc_size = NLMSG_DEFAULT_SIZE;
+	}
+
+	msg = nlmsg_new(alloc_size, GFP_KERNEL);
+	if (!msg)
+		goto legacy;
+
+	if (WARN_ON(nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, &state) < 0)) {
+		nlmsg_free(msg);
+		goto legacy;
+	}
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_CONFIG2, GFP_KERNEL);
+
+legacy:
+	state.large_message = false;
 	state.legacy = true;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	alloc_size = NLMSG_DEFAULT_SIZE;
+	msg = nlmsg_new(alloc_size, GFP_KERNEL);
 	if (!msg)
 		return;
 
@@ -14767,6 +14793,10 @@ void nl80211_notify_iface(struct cfg80211_registered_device *rdev,
 		return;
 	}
 
+	/* We will be sending the same message twice, grab an extra ref */
+	msg = skb_get(msg);
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_CONFIG2, GFP_KERNEL);
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
 				NL80211_MCGRP_CONFIG, GFP_KERNEL);
 }
-- 
2.19.2

