Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06E717A719
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCEOEl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:04:41 -0500
Received: from mailext.lri.fr ([129.175.15.10]:48418 "HELO mailext.lri.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725991AbgCEOEl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:04:41 -0500
Received: from [129.175.15.10] (mailext.lri.fr [129.175.15.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailext.lri.fr (Postfix) with ESMTPSA id A1CDBC0F82;
        Thu,  5 Mar 2020 14:58:02 +0100 (CET)
From:   Nicolas Cavallari <cavallar@lri.fr>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.com>
Subject: [PATCH v3 1/2] cfg80211: Add support for userspace to reset stations in IBSS mode
Date:   Thu,  5 Mar 2020 14:57:53 +0100
Message-Id: <20200305135754.12094-1-cavallar@lri.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

Sometimes, userspace is able to detect that a peer silently lost its
state (like, if the peer reboots). wpa_supplicant does this for IBSS-RSN
by registering for auth/deauth frames, but when it detects this, it is
only able to remove the encryption keys of the peer and close its port.

However, the kernel also hold other state about the station, such as BA
sessions, probe response parameters and the like.  They also need to be
resetted correctly.

This patch adds the NL80211_EXT_FEATURE_DEL_IBSS_STA feature flag
indicating the driver accepts deleting stations in IBSS mode, which
should send a deauth and reset the state of the station, just like in
mesh point mode.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.=
fr>

---
v3: rebased on wireless-testing and reworded commit
v2: Use a nl80211 feature flag instead of patching every driver.
---
 include/uapi/linux/nl80211.h | 4 ++++
 net/wireless/nl80211.c       | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b002ef2060fa..872db33034a3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5642,6 +5642,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_BEACON_PROTECTION: The driver supports Beacon pr=
otection
  *	and can receive key configuration for BIGTK using key indexes 6 and 7=
.
  *
+ * @NL80211_EXT_FEATURE_DEL_IBSS_STA: The driver supports removing stati=
ons
+ *      in IBSS mode, essentially by dropping their state.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5690,6 +5693,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 	NL80211_EXT_FEATURE_AQL,
 	NL80211_EXT_FEATURE_BEACON_PROTECTION,
+	NL80211_EXT_FEATURE_DEL_IBSS_STA,
=20
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 15000275b32d..35c57bcff871 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6269,8 +6269,13 @@ static int nl80211_del_station(struct sk_buff *skb=
, struct genl_info *info)
 	if (dev->ieee80211_ptr->iftype !=3D NL80211_IFTYPE_AP &&
 	    dev->ieee80211_ptr->iftype !=3D NL80211_IFTYPE_AP_VLAN &&
 	    dev->ieee80211_ptr->iftype !=3D NL80211_IFTYPE_MESH_POINT &&
-	    dev->ieee80211_ptr->iftype !=3D NL80211_IFTYPE_P2P_GO)
+	    dev->ieee80211_ptr->iftype !=3D NL80211_IFTYPE_P2P_GO &&
+	    dev->ieee80211_ptr->iftype !=3D NL80211_IFTYPE_ADHOC)
 		return -EINVAL;
+	if (dev->ieee80211_ptr->iftype =3D=3D NL80211_IFTYPE_ADHOC &&
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_DEL_IBSS_STA))
+		return -EOPNOTSUPP;
=20
 	if (!rdev->ops->del_station)
 		return -EOPNOTSUPP;
--=20
2.25.1

