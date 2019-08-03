Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E98078D
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2019 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfHCRxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Aug 2019 13:53:40 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:38008 "EHLO
        18.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfHCRxk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Aug 2019 13:53:40 -0400
X-Greylist: delayed 6598 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Aug 2019 13:53:37 EDT
Received: from player774.ha.ovh.net (unknown [10.108.54.72])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id DA0871FF0C2
        for <linux-wireless@vger.kernel.org>; Sat,  3 Aug 2019 17:24:26 +0200 (CEST)
Received: from awhome.eu (p4FF919A6.dip0.t-ipconnect.de [79.249.25.166])
        (Authenticated sender: postmaster@awhome.eu)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id 789B48937F49;
        Sat,  3 Aug 2019 15:24:25 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1564845863;
        bh=KqUS3Y5w2JocdzoHqGhEyCwH/crxcwWUxbIk3pE7sPw=;
        h=From:To:Cc:Subject:Date;
        b=KKKQr0fnbQYRkbuIf4gegyk+jZnop6ijUzG+BYCaYtUUVcQu3tHLiiFC6x/EIKzlb
         4FibR5hY77DL0PrazslHO5zZw+VLXazgxw/WEBjpDnrQK4sDdq6s0IhOX+owsoaodn
         2dOZo2wrmVQlJzAPlHbt2Sin8Bw07N9ioj9+MuEE=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] cfg80211: Fix Extended Key ID key install checks
Date:   Sat,  3 Aug 2019 17:23:18 +0200
Message-Id: <20190803152318.5497-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12045440157173095623
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddtuddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix two shortcomings of the Extended Key ID API:

 1) Allow the userspace to install pairwise keys using keyid 1 without
    NL80211_KEY_NO_TX set. This allows the userspace to install and
    activate pairwise keys with keyid 1 in the same way as for keyid 0,
    simplifying the API usage for e.g. FILS and FT key installs.

 2) IEEE 802.11 - 2016 restricts Extended Key ID usage to CCMP/GCMP
    ciphers in IEEE 802.11 - 2016 "9.4.2.25.4 RSN capabilities".
    Enforce that when installing a key.

Fixes: 6cdd3979a2bd ("nl80211/cfg80211: Extended Key ID support")
Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

This patch ended up redesigning the Extended Key ID key install checks
from scratch...

While working on wpa_supplicant/hostapd Extended Key ID support it
turned out that it's still useful to be able to install and activate a
pairwise key for Tx in one step. So instead of forcing the userspace to
always install and then activate a key I would prefer to fix the API and
relax the checks with this patch.
Down side of that is, that we have to get the fix also into 5.2 and 5.3.
All kernels without the fix will potentially not work correctly with the
upcoming userspace when using FT (fast roaming) or FILS with an Extended
Key ID capable AP. (Anyone using the existing API will not notice the
difference, but I'm next to sure it's only used by my experimental hostapd
patches so far.)

So ideally we get this patch back ported to all kernels which also have
6cdd3979a2bd ("nl80211/cfg80211: Extended Key ID support")

Another issue I tripped over while getting the hostapd patches into
shape is, that our mac80211 TKIP SW crypto implementation drops unicast
packets on receive when they are using keyid 1.
Since a standard compliant implementation of Extended Key ID must not
use TKIP enforcing that rule at key install seems to be preferable
to handle that within mac80211.

 net/wireless/util.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index d0e35b7b9e35..962ca7fc1ab7 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -233,25 +233,29 @@ int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
 
 	switch (params->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
+		/* Extended Key ID can only be used with CCMP/GCMP ciphers */
+		if (pairwise && key_idx)
+			return -EINVAL;
+		/* fall through */
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		/* IEEE802.11-2016 allows only 0 and - when using Extended Key
-		 * ID - 1 as index for pairwise keys.
+		/* IEEE802.11-2016 allows only 0 and - when supporting
+		 * Extended Key ID - 1 as index for pairwise keys.
 		 * @NL80211_KEY_NO_TX is only allowed for pairwise keys when
 		 * the driver supports Extended Key ID.
 		 * @NL80211_KEY_SET_TX can't be set when installing and
 		 * validating a key.
 		 */
-		if (params->mode == NL80211_KEY_NO_TX) {
-			if (!wiphy_ext_feature_isset(&rdev->wiphy,
-						     NL80211_EXT_FEATURE_EXT_KEY_ID))
-				return -EINVAL;
-			else if (!pairwise || key_idx < 0 || key_idx > 1)
+		if ((params->mode == NL80211_KEY_NO_TX && !pairwise) ||
+		    params->mode == NL80211_KEY_SET_TX)
+			return -EINVAL;
+		if (wiphy_ext_feature_isset(&rdev->wiphy,
+					    NL80211_EXT_FEATURE_EXT_KEY_ID)) {
+			if (pairwise && (key_idx < 0 || key_idx > 1))
 				return -EINVAL;
-		} else if ((pairwise && key_idx) ||
-			   params->mode == NL80211_KEY_SET_TX) {
+		} else if (pairwise && key_idx) {
 			return -EINVAL;
 		}
 		break;
-- 
2.22.0

