Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16F14EB7E
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgAaLNL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55768 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728325AbgAaLNL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:11 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEV-0002GC-Ou; Fri, 31 Jan 2020 13:13:08 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:38 +0200
Message-Id: <20200131111300.891737-2-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 01/23] nl80211/cfg80211: add support for non EDCA based ranging measurement
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add support for requesting that the ranging measurement will use
the trigger-based / non trigger-based flow instead of the EDCA based
flow.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h       | 16 ++++++++++++++--
 include/uapi/linux/nl80211.h | 24 ++++++++++++++++++++++++
 net/wireless/core.c          |  6 ++++++
 net/wireless/nl80211.c       |  8 ++++++++
 net/wireless/pmsr.c          | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fa027d0d031b..51a9f5dc237e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3232,6 +3232,12 @@ struct cfg80211_pmsr_result {
  * @ftmr_retries: number of retries for FTM request
  * @request_lci: request LCI information
  * @request_civicloc: request civic location information
+ * @trigger_based: use trigger based ranging for the measurement
+ *		 If neither @trigger_based nor @non_trigger_based is set,
+ *		 EDCA based ranging will be used.
+ * @non_trigger_based: use non trigger based ranging for the measurement
+ *		 If neither @trigger_based nor @non_trigger_based is set,
+ *		 EDCA based ranging will be used.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -3241,7 +3247,9 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 requested:1,
 	   asap:1,
 	   request_lci:1,
-	   request_civicloc:1;
+	   request_civicloc:1,
+	   trigger_based:1,
+	   non_trigger_based:1;
 	u8 num_bursts_exp;
 	u8 burst_duration;
 	u8 ftms_per_burst;
@@ -4379,6 +4387,8 @@ struct wiphy_iftype_ext_capab {
  *	forbid using the value 15 to let the responder pick)
  * @ftm.max_ftms_per_burst: maximum FTMs per burst supported (set to 0 if
  *	not limited)
+ * @ftm.trigger_based: trigger based ranging measurement is supported
+ * @ftm.non_trigger_based: non trigger based ranging measurement is supported
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -4394,7 +4404,9 @@ struct cfg80211_pmsr_capabilities {
 		   asap:1,
 		   non_asap:1,
 		   request_lci:1,
-		   request_civicloc:1;
+		   request_civicloc:1,
+		   trigger_based:1,
+		   non_trigger_based:1;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 809ef9165684..a3ecb713cf72 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6194,12 +6194,14 @@ enum nl80211_ftm_responder_stats {
  * @NL80211_PREAMBLE_HT: HT preamble
  * @NL80211_PREAMBLE_VHT: VHT preamble
  * @NL80211_PREAMBLE_DMG: DMG preamble
+ * @NL80211_PREAMBLE_HE: HE preamble
  */
 enum nl80211_preamble {
 	NL80211_PREAMBLE_LEGACY,
 	NL80211_PREAMBLE_HT,
 	NL80211_PREAMBLE_VHT,
 	NL80211_PREAMBLE_DMG,
+	NL80211_PREAMBLE_HE,
 };
 
 /**
@@ -6392,6 +6394,10 @@ enum nl80211_peer_measurement_attrs {
  *	is valid)
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST: u32 attribute indicating
  *	the maximum FTMs per burst (if not present anything is valid)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED: flag attribute indicating if
+ *	trigger based ranging measurement is supported
+ * @NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED: flag attribute indicating
+ *	if non trigger based ranging measurement is supported
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -6407,6 +6413,8 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_BANDWIDTHS,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_BURSTS_EXPONENT,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST,
+	NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED,
+	NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
@@ -6436,6 +6444,20 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI: request LCI data (flag)
  * @NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC: request civic location data
  *	(flag)
+ * @NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED: request trigger based ranging
+ *	measurement (flag).
+ *	This attribute and %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED are
+ *	mutually exclusive.
+ *      if neither %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED nor
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set, EDCA based
+ *	ranging will be used.
+ * @NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED: request non trigger based
+ *	ranging measurement (flag)
+ *	This attribute and %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED are
+ *	mutually exclusive.
+ *      if neither %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED nor
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set, EDCA based
+ *	ranging will be used.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -6452,6 +6474,8 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES,
 	NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI,
 	NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC,
+	NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED,
+	NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3e25229a059d..341402b4f178 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -693,8 +693,14 @@ int wiphy_register(struct wiphy *wiphy)
 				~(BIT(NL80211_PREAMBLE_LEGACY) |
 				  BIT(NL80211_PREAMBLE_HT) |
 				  BIT(NL80211_PREAMBLE_VHT) |
+				  BIT(NL80211_PREAMBLE_HE) |
 				  BIT(NL80211_PREAMBLE_DMG))))
 			return -EINVAL;
+		if (WARN_ON((wiphy->pmsr_capa->ftm.trigger_based ||
+			     wiphy->pmsr_capa->ftm.non_trigger_based) &&
+			    !(wiphy->pmsr_capa->ftm.preambles &
+			      BIT(NL80211_PREAMBLE_HE))))
+			return -EINVAL;
 		if (WARN_ON(wiphy->pmsr_capa->ftm.bandwidths &
 				~(BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 				  BIT(NL80211_CHAN_WIDTH_20) |
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 00f24d4c623e..5c2a7569c229 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -275,6 +275,8 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES] = { .type = NLA_U8 },
 	[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -1846,6 +1848,12 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST,
 			cap->ftm.max_ftms_per_burst))
 		return -ENOBUFS;
+	if (cap->ftm.trigger_based &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED))
+		return -ENOBUFS;
+	if (cap->ftm.non_trigger_based &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index c09fbf09549d..63dc8023447f 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -126,6 +126,38 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 			    "FTM: civic location request not supported");
 	}
 
+	out->ftm.trigger_based =
+		!!tb[NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED];
+	if (out->ftm.trigger_based && !capa->ftm.trigger_based) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED],
+				    "FTM: trigger based ranging is not supported");
+		return -EINVAL;
+	}
+
+	out->ftm.non_trigger_based =
+		!!tb[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED];
+	if (out->ftm.non_trigger_based && !capa->ftm.non_trigger_based) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED],
+				    "FTM: trigger based ranging is not supported");
+		return -EINVAL;
+	}
+
+	if (out->ftm.trigger_based && out->ftm.non_trigger_based) {
+		NL_SET_ERR_MSG(info->extack,
+			       "FTM: can't set both trigger based and non trigger based");
+		return -EINVAL;
+	}
+
+	if ((out->ftm.trigger_based || out->ftm.non_trigger_based) &&
+	    out->ftm.preamble != NL80211_PREAMBLE_HE) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
+				    "FTM: non EDCA based ranging must use HE preamble");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.24.1

