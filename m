Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A8C12F6C4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2020 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgACKfu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jan 2020 05:35:50 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgACKfu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jan 2020 05:35:50 -0500
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.168]) with ESMTPSA (Nemesis)
 id 1Mz9lL-1jhtAn2q0J-00wGRN; Fri, 03 Jan 2020 11:35:46 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Subject: [PATCH v2 1/2] cfg80211: Add support for userspace to reset stations in IBSS mode.
Date:   Fri,  3 Jan 2020 11:34:56 +0100
Message-Id: <20200103103457.22778-2-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.25.0.rc0
In-Reply-To: <20200103103457.22778-1-nicolas.cavallari@green-communications.fr>
References: <20200103103457.22778-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aGpwvmsqQ/IPfqNMpw2Zkk0prJdWShA/0+FF3mmQbEmigZ478cq
 QJJUDPnP5sfJwg2KiSNYhGer4gp3KDvZ1uCGziefFhCxf3nKiCrhjXdUYoF6Sk3JPiXaCMl
 AV7BUcBBz29ni8buThw4fGsKOD+afNoEqpu7KxyWNK00EpZAsN/mDwI2NOw3Nt20VpKfDNQ
 nBAiNmmCpAqU8g3QCXoJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VN4Lc2Kt/Fo=:3gq/Q/IDUI1DoXWv/FgVrp
 dfAltPW1d38SxzO4urbe7fVAhaVsSW2CJYnCMqPoBjBpT0tuKaArGBVAD46SXz2NzjHBXV//X
 qBbncWmvqOVV4NRuJugoeGtYVJ/VTUgfcJFRwCocOrmgKrQuSQqUNUEkZPMpxQ1RYlKM2MdgM
 yTfTyW+U/KjXOb5fLi3CBRqzxiHRApla1cT4mDfRNN4ELbXvFKyWXBPbBWoAd5iDnIiYXE5w0
 Ufpd6Xb9w4zxmLJTQH0xp31HVT5frvro8srUXTBjyeqXdUPRJMpQNXwSWRZa7BF1CrCMvlvFa
 PsVXz0MyoSBW6CL1YhgZBjzFFiZ/fjlEICODBcErOworqx1Px5Y854R6yjpUZE/N0IhNCrf/U
 mdrGbaWDOmVCm8TPU5qXhvM5iI7GeI8HQ5U8qvSLZouvYkEBU/H7oNwiFO6JpTriTq7sOlrDN
 vQZlUwiZar6T679tLkGU1DXh9Fcy4v3ChtFSmLjnHxPTMUGpW6k81gyhPOvejCVFtEKepGKI9
 HbFnpM+wuh29xNB2/K9K83RApPoon+6P2hN+Zh5rO+jxLqINY0H1JMZo/oihVlTSUzEFdKNW/
 Fyh9VihjzXFFSGNBSM0JuzJ7uk4CdIp5FS9xuMhs+YmadKE075E2MPDCjwBvNWUnJmrOUuo41
 yK9YU7cHBxRTWkgJNDi6TshHASbhrEOoTYPJ/7auh4U6aBUONgPKI1AMNTnS0aYQ/vx33OSkO
 mI2G0emRfvIGbhr3+FoZwZMDeH8vt3hxhAORiFiJEVifS086+65ukH57tzusG8XTdhsYEiK9/
 6S0/Ncddsd5mtz5DaPguBqFS1Q7r9Eiy/XolRn/6IZg0g0B4yP/JQx2o7+RwS2IZ93byjapt+
 lMIzAdGCGz3US/u3LYuN0ha2ptXInBZoxfiS2vwoP+gNEAtoBDdipx32I4TdAq
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sometimes, userspace is able to detect that a peer silently lost its
state (like, if the peer reboots). wpa_supplicant does this for IBSS-RSN
and currently only resets the key of the peer so that it can attempt
another handshake.

However, the kernel also hold state about the station, such as BA
sessions, probe response parameters and the like.  They also need to be
resetted correctly.

This patch adds the NL80211_EXT_FEATURE_DEL_IBSS_STA feature flag
indicating the driver accepts deleting stations in IBSS mode, which
should send a deauth and reset the state of the station, just like in
mesh point mode.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 include/uapi/linux/nl80211.h | 4 ++++
 net/wireless/nl80211.c       | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5eab191607f8..8f8b9dcb80f1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5521,6 +5521,9 @@ enum nl80211_feature_flags {
  *	feature, which prevents bufferbloat by using the expected transmission
  *	time to limit the amount of data buffered in the hardware.
  *
+ * @NL80211_EXT_FEATURE_DEL_IBSS_STA: The driver supports removing stations
+ *      in IBSS mode, essentially by dropping their state.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5568,6 +5571,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 	NL80211_EXT_FEATURE_AQL,
+	NL80211_EXT_FEATURE_DEL_IBSS_STA,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index da5262b2298b..a2a66a155603 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6073,8 +6073,13 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP_VLAN &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_MESH_POINT &&
-	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
+	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO &&
+	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_ADHOC)
 		return -EINVAL;
+	if (dev->ieee80211_ptr->iftype == NL80211_IFTYPE_ADHOC &&
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_DEL_IBSS_STA))
+		return -EOPNOTSUPP;
 
 	if (!rdev->ops->del_station)
 		return -EOPNOTSUPP;
-- 
2.25.0.rc0

