Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6F41B2B8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbhI1PQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241317AbhI1PQb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A18986120D;
        Tue, 28 Sep 2021 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842092;
        bh=HHA240+qwJYN6MUH1FmZJd2HQZ/EokRIJOGK/TIwOS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwP0h89RAZyQUe9VRoUeMnmFYyR2DPHybj/8+SbAko3utUYqa3m4th9CHcBZpn/XV
         j0PLbMnAe/VChzDJRN9tWppqx8U0tNZ6qhjzeOfdTNIQiRyDBiTKMRCF+rQW37sL0T
         51VZRFHD71mMcJaxT9pBcgaN7tkT0pD36ZlS+mcq2nBjf8gx2xnu5h/0qS81YeOzFl
         NKivRjJrCgufyQfBOQ2iEl6lufF1ysYGTQijFHBBDyWngJsgDhQiqtENv31eilIaa3
         FsSOhITT8gPMTi2fPQWkY6zghrd1VbS/LPD0LcjraIYQAuZ0DVrClXRA4y1RkDCMF7
         idFORPL9WYGQg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com, john@phrozen.org
Subject: [RFC 2/7] cfg80211: introduce nl80211_set_offchan_chain callback
Date:   Tue, 28 Sep 2021 17:14:33 +0200
Message-Id: <56056fbcca59213f5acce9484b14f3150bada042.1632841652.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632841652.git.lorenzo@kernel.org>
References: <cover.1632841652.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce NL80211_CMD_OFFCHAN_CHAIN command in order to configure
offchannel chain if supported by the underlay driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c2efea98e060..51ddd6f198d4 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1200,6 +1200,10 @@
  * @NL80211_CMD_COLOR_CHANGE_COMPLETED: Notify userland that the color change
  *	has completed
  *
+ * @NL80211_CMD_OFFCHAN_CHAIN: Configure dedicated chain available for radar
+ *	detection on some hw. The driver is supposed to implement CAC
+ *	management in sw or fw.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1440,6 +1444,8 @@ enum nl80211_commands {
 	NL80211_CMD_COLOR_CHANGE_ABORTED,
 	NL80211_CMD_COLOR_CHANGE_COMPLETED,
 
+	NL80211_CMD_OFFCHAN_CHAIN,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bf7cd4752547..7c0902d35635 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9064,6 +9064,39 @@ static int nl80211_stop_sched_scan(struct sk_buff *skb,
 	return cfg80211_stop_sched_scan_req(rdev, req, false);
 }
 
+static int nl80211_set_offchan_chain(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	enum nl80211_dfs_regions dfs_region;
+	struct wiphy *wiphy = &rdev->wiphy;
+	struct cfg80211_chan_def chandef;
+	int err;
+
+	dfs_region = reg_get_dfs_region(wiphy);
+	if (dfs_region == NL80211_DFS_UNSET)
+		return -EINVAL;
+
+	err = nl80211_parse_chandef(rdev, info, &chandef);
+	if (err)
+		return err;
+
+	err = cfg80211_chandef_dfs_required(wiphy, &chandef, NL80211_IFTYPE_AP);
+	if (err < 0)
+		return err;
+
+	if (!err)
+		return -EINVAL;
+
+	if (!cfg80211_chandef_dfs_usable(wiphy, &chandef))
+		return -EINVAL;
+
+	if (!rdev->ops->set_offchan_chain)
+		return -EOPNOTSUPP;
+
+	return rdev_set_offchan_chain(rdev, &chandef);
+}
+
 static int nl80211_start_radar_detection(struct sk_buff *skb,
 					 struct genl_info *info)
 {
@@ -15907,6 +15940,14 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
 				  NL80211_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL80211_CMD_OFFCHAN_CHAIN,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_set_offchan_chain,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY |
+				  NL80211_FLAG_NEED_RTNL,
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
-- 
2.31.1

