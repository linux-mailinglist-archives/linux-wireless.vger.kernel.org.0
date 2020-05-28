Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B1D1E6489
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391273AbgE1Ouo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgE1Ou3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:50:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99702C08C5C8
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:50:29 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJrX-004vYI-LL; Thu, 28 May 2020 16:50:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/24] cfg80211: add and expose HE 6 GHz band capabilities
Date:   Thu, 28 May 2020 16:50:04 +0200
Message-Id: <20200528165011.244cd5cb9db8.Icd8c773277a88c837e7e3af1d4d1013cc3b66543@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

These capabilities cover what would otherwise be transported
in HT/VHT capabilities, but only a subset thereof that is
actually needed on 6 GHz with HE already present. Expose the
capabilities to userspace, drivers are expected to set them
as using the 6 GHz band (currently) requires HE capability.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       | 3 +++
 include/uapi/linux/nl80211.h | 3 +++
 net/wireless/nl80211.c       | 9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index da734ea71b5a..9b76be3d561a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -354,10 +354,13 @@ struct ieee80211_sta_he_cap {
  *
  * @types_mask: interface types mask
  * @he_cap: holds the HE capabilities
+ * @he_6ghz_capa: HE 6 GHz capabilities, must be filled in for a
+ *	6 GHz band channel (and 0 may be valid value).
  */
 struct ieee80211_sband_iftype_data {
 	u16 types_mask;
 	struct ieee80211_sta_he_cap he_cap;
+	struct ieee80211_he_6ghz_capa he_6ghz_capa;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e42ae429383e..5b350d032fa3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3565,6 +3565,8 @@ enum nl80211_mpath_info {
  *     defined in HE capabilities IE
  * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band HE capability attribute currently
  *     defined
+ * @NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA: HE 6GHz band capabilities (__le16),
+ *	given for all 6 GHz band channels
  * @__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST: internal use
  */
 enum nl80211_band_iftype_attr {
@@ -3575,6 +3577,7 @@ enum nl80211_band_iftype_attr {
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY,
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET,
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE,
+	NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA,
 
 	/* keep last */
 	__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bf8bd8268cb7..3a24e6add13e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1562,6 +1562,7 @@ static int nl80211_send_coalesce(struct sk_buff *msg,
 
 static int
 nl80211_send_iftype_data(struct sk_buff *msg,
+			 const struct ieee80211_supported_band *sband,
 			 const struct ieee80211_sband_iftype_data *iftdata)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &iftdata->he_cap;
@@ -1585,6 +1586,12 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 			return -ENOBUFS;
 	}
 
+	if (sband->band == NL80211_BAND_6GHZ &&
+	    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA,
+		    sizeof(iftdata->he_6ghz_capa),
+		    &iftdata->he_6ghz_capa))
+		return -ENOBUFS;
+
 	return 0;
 }
 
@@ -1633,7 +1640,7 @@ static int nl80211_send_band_rateinfo(struct sk_buff *msg,
 			if (!iftdata)
 				return -ENOBUFS;
 
-			err = nl80211_send_iftype_data(msg,
+			err = nl80211_send_iftype_data(msg, sband,
 						       &sband->iftype_data[i]);
 			if (err)
 				return err;
-- 
2.26.2

