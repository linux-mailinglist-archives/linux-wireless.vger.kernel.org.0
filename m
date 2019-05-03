Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C8C12BF6
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfECLDe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:03:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLDe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:03:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3622260F3A; Fri,  3 May 2019 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556881413;
        bh=B3GOPsOEtVn+KBXolA1HqkYrPP5z6G3T+xFYHq+9F2g=;
        h=From:To:Cc:Subject:Date:From;
        b=jtraDVFlNGpCrEtZuwAxz3Ui3oYKb35Al2NPKsIdOgZ/RR5npnlPajCJN1gUTr7sS
         zXGuEWzpY57T0JlLprf1EXmnlsd3eY10bMMBdY8B7W3LMFhCXJjtSXE0T7RFarQdis
         v8H3/Vu13ZR2Wi/35ndS4nNkqGktHzFNG88/s8po=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19E8260E5D;
        Fri,  3 May 2019 11:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556881412;
        bh=B3GOPsOEtVn+KBXolA1HqkYrPP5z6G3T+xFYHq+9F2g=;
        h=From:To:Cc:Subject:Date:From;
        b=Qck4Q017PRx6TGe/BQuHcV+oDfO4/B+yaaZy3sgowlzTcBdLkxSekorO0EIqMOPxe
         Q01pD7dGKxRNE/YrmzGKCl6ZuORUB87N8/VOWkCQ0IjmGmePBi9+6T4D3ch8Aowtb/
         4PJL3eabjSCWWJ9/oNXtTSh9iczsJChvKcq/xeZs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19E8260E5D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
Subject: [PATCH v2] {nl,mac}80211: allow 4addr AP operation on crypto controlled devices
Date:   Fri,  3 May 2019 16:33:22 +0530
Message-Id: <1556881402-28078-1-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As per the current design, in the case of sw crypto controlled devices,
it is the device which advertises the support for AP/VLAN iftype based
on it's ability to tranmsit packets encrypted in software
(In VLAN functionality, group traffic generated for a specific
VLAN group is always encrypted in software). Commit db3bdcb9c3ff
("mac80211: allow AP_VLAN operation on crypto controlled devices")
has introduced this change.

Since 4addr AP operation also uses AP/VLAN iftype, this conditional
way of advertising AP/VLAN support has broken 4addr AP mode operation on
crypto controlled devices which do not support VLAN functionality.

In the case of ath10k driver, not all firmwares have support for VLAN
functionality but all can support 4addr AP operation. Because AP/VLAN
support is not advertised for these devices, 4addr AP operations are
also blocked.

Fix this by allowing 4addr operation on devices which do not support
AP/VLAN iftype but can support 4addr AP operation (decision is based on
the wiphy flag WIPHY_FLAG_4ADDR_AP).

Fixes: Commit db3bdcb9c3ff ("mac80211: allow AP_VLAN operation on crypto controlled devices")
Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
---
 include/net/cfg80211.h | 3 ++-
 net/mac80211/util.c    | 4 +++-
 net/wireless/core.c    | 6 +++++-
 net/wireless/nl80211.c | 8 ++++++--
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 87dae86..9481396 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3839,7 +3839,8 @@ struct cfg80211_ops {
  *	on wiphy_new(), but can be changed by the driver if it has a good
  *	reason to override the default
  * @WIPHY_FLAG_4ADDR_AP: supports 4addr mode even on AP (with a single station
- *	on a VLAN interface)
+ *	on a VLAN interface). This flag also serves an extra purpose of
+ *	supporting 4ADDR AP mode on devices which do not support AP/VLAN iftype.
  * @WIPHY_FLAG_4ADDR_STATION: supports 4addr mode even as a station
  * @WIPHY_FLAG_CONTROL_PORT_PROTOCOL: This device supports setting the
  *	control port protocol ethertype. The device also honours the
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index cba4633..1c8384f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3795,7 +3795,9 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* Always allow software iftypes */
-	if (local->hw.wiphy->software_iftypes & BIT(iftype)) {
+	if (local->hw.wiphy->software_iftypes & BIT(iftype) ||
+	    (iftype == NL80211_IFTYPE_AP_VLAN &&
+	     local->hw.wiphy->flags & WIPHY_FLAG_4ADDR_AP)) {
 		if (radar_detect)
 			return -EINVAL;
 		return 0;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index b36ad8e..4e83892 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1396,8 +1396,12 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		}
 		break;
 	case NETDEV_PRE_UP:
-		if (!(wdev->wiphy->interface_modes & BIT(wdev->iftype)))
+		if (!(wdev->wiphy->interface_modes & BIT(wdev->iftype)) &&
+		    !(wdev->iftype == NL80211_IFTYPE_AP_VLAN &&
+		      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP &&
+		      wdev->use_4addr))
 			return notifier_from_errno(-EOPNOTSUPP);
+
 		if (rfkill_blocked(rdev->rfkill))
 			return notifier_from_errno(-ERFKILL);
 		break;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fffe4b3..4b3c528 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3419,8 +3419,7 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_IFTYPE])
 		type = nla_get_u32(info->attrs[NL80211_ATTR_IFTYPE]);
 
-	if (!rdev->ops->add_virtual_intf ||
-	    !(rdev->wiphy.interface_modes & (1 << type)))
+	if (!rdev->ops->add_virtual_intf)
 		return -EOPNOTSUPP;
 
 	if ((type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN ||
@@ -3439,6 +3438,11 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	if (!(rdev->wiphy.interface_modes & (1 << type)) &&
+	    !(type == NL80211_IFTYPE_AP_VLAN && params.use_4addr &&
+	      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP))
+		return -EOPNOTSUPP;
+
 	err = nl80211_parse_mon_options(rdev, type, info, &params);
 	if (err < 0)
 		return err;
-- 
2.7.4

