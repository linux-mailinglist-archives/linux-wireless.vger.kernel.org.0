Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF1359B5D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 12:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhDIKJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 06:09:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44312 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234438AbhDIKIC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 06:08:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUnd0-000ELR-Kp; Fri, 09 Apr 2021 12:40:40 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:25 +0300
Message-Id: <iwlwifi.20210409123755.eff546283504.I2606161e700ac24d94d0b50c8edcdedd4c0395c2@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 12/15] nl80211/cfg80211: add a flag to negotiate for LMR feedback in NDP ranging
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add a flag that indicates that the ISTA shall indicate support for
LMR feedback in NDP ranging negotiation.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h       |  5 ++++-
 include/uapi/linux/nl80211.h |  4 ++++
 net/wireless/nl80211.c       |  1 +
 net/wireless/pmsr.c          | 12 +++++++++++-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 955a4f711fdd..78aeeefe77b6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3521,6 +3521,8 @@ struct cfg80211_pmsr_result {
  * @non_trigger_based: use non trigger based ranging for the measurement
  *		 If neither @trigger_based nor @non_trigger_based is set,
  *		 EDCA based ranging will be used.
+ * @lmr_feedback: negotiate for I2R LMR feedback. Only valid if either
+ *		 @trigger_based or @non_trigger_based is set.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -3532,7 +3534,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	   request_lci:1,
 	   request_civicloc:1,
 	   trigger_based:1,
-	   non_trigger_based:1;
+	   non_trigger_based:1,
+	   lmr_feedback:1;
 	u8 num_bursts_exp;
 	u8 burst_duration;
 	u8 ftms_per_burst;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 325f2c621840..bc41cea9f2fa 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6904,6 +6904,9 @@ enum nl80211_peer_measurement_ftm_capa {
  *      if neither %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED nor
  *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set, EDCA based
  *	ranging will be used.
+ * @NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK: negotiate for LMR feedback. Only
+ *	valid if either %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED or
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -6922,6 +6925,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC,
 	NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED,
 	NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED,
+	NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f56307185b8a..c5d1c93ddfae 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -309,6 +309,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index a95c79d18349..d570453b6dad 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  */
 #ifndef __PMSR_H
 #define __PMSR_H
@@ -158,6 +158,16 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	out->ftm.lmr_feedback =
+		!!tb[NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK];
+	if (!out->ftm.trigger_based && !out->ftm.non_trigger_based &&
+	    out->ftm.lmr_feedback) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK],
+				    "FTM: LMR feedback set for EDCA based ranging");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.31.0

