Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2247782156
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfHEQKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 12:10:11 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:37193 "EHLO
        9.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbfHEQKK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 12:10:10 -0400
X-Greylist: delayed 10790 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 12:10:10 EDT
Received: from player692.ha.ovh.net (unknown [10.108.35.223])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id DA3D6106B69
        for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2019 14:34:06 +0200 (CEST)
Received: from awhome.eu (p4FF919A6.dip0.t-ipconnect.de [79.249.25.166])
        (Authenticated sender: postmaster@awhome.eu)
        by player692.ha.ovh.net (Postfix) with ESMTPSA id 6C6658800C66;
        Mon,  5 Aug 2019 12:34:05 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1565008444;
        bh=GuaEZkHdngvst1wNsTBEawaiBcwNHCBwHUawf2KI8b0=;
        h=From:To:Cc:Subject:Date;
        b=tLIT7lF5Hf3egpWRL2coXNZQS5gmPBr4Ptm94dmtAfU/Qd3NvziHW4VY4lYD6Uzx6
         wwh60vo0f+1Q7LuSPQqwheHXjUSlpieqfvkhijLV3gsNNye6TxZD7d+qkbbU8Zhttl
         ptMmAmZvXOQEFMg+2ga13ImQDRX+oyITFrODZcSk=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH v2] cfg80211: Fix Extended Key ID key install checks
Date:   Mon,  5 Aug 2019 14:34:00 +0200
Message-Id: <20190805123400.51567-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2467409648627358919
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddtjedghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix two shortcomings in the Extended Key ID API:

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

Changes compared to v1:
Refuse any Extended Key ID actions for TKIP keys. V1 still allowed them
for keyid 0.

Remarks from v1 still apply and are unchanged:

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


 net/wireless/util.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index d0e35b7b9e35..e74837824cea 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -233,25 +233,30 @@ int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
 
 	switch (params->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
+		/* Extended Key ID can only be used with CCMP/GCMP ciphers */
+		if ((pairwise && key_idx) ||
+		    params->mode != NL80211_KEY_RX_TX)
+			return -EINVAL;
+		break;
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

