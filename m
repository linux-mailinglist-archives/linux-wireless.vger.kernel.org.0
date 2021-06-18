Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0663AC912
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFRKqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:46:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48220 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229522AbhFRKqC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:46:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwv-001YXx-Pi; Fri, 18 Jun 2021 13:42:11 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:36 +0300
Message-Id: <iwlwifi.20210618133832.f097a6144b59.I27dec8b994df52e691925ea61be4dd4fa6d396c0@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 11/31] nl80211/cfg80211: add BSS color to NDP ranging parameters
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

In NDP ranging, the initiator need to set the BSS color in the NDP
to the BSS color of the responder. Add the BSS color as a parameter
for NDP ranging.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h       |  8 ++++++--
 include/uapi/linux/nl80211.h |  6 +++++-
 net/wireless/pmsr.c          | 12 ++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5224f885a99a..6a54caa6fa16 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7,7 +7,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014 Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 
 #include <linux/ethtool.h>
@@ -3522,7 +3522,10 @@ struct cfg80211_pmsr_result {
  *		 If neither @trigger_based nor @non_trigger_based is set,
  *		 EDCA based ranging will be used.
  * @lmr_feedback: negotiate for I2R LMR feedback. Only valid if either
- *	@trigger_based or @non_trigger_based is set.
+ *		 @trigger_based or @non_trigger_based is set.
+ * @bss_color: the bss color of the responder. Optional. Set to zero to
+ *	indicate the driver should set the BSS color. Only valid if
+ *	@non_trigger_based or @trigger_based is set.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -3540,6 +3543,7 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 burst_duration;
 	u8 ftms_per_burst;
 	u8 ftmr_retries;
+	u8 bss_color;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f962c06e9818..771f238ccff1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -11,7 +11,7 @@
  * Copyright 2008 Jouni Malinen <jouni.malinen@atheros.com>
  * Copyright 2008 Colin McCabe <colin@cozybit.com>
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -6912,6 +6912,9 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK: negotiate for LMR feedback. Only
  *	valid if either %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED or
  *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR: optional. The BSS color of the
+ *	responder. Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
+ *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED is set.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -6931,6 +6934,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED,
 	NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED,
 	NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK,
+	NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index d245968b74cb..328cf54bda82 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -168,6 +168,18 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (tb[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR]) {
+		if (!out->ftm.non_trigger_based && !out->ftm.trigger_based) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    tb[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR],
+					    "FTM: BSS color set for EDCA based ranging");
+			return -EINVAL;
+		}
+
+		out->ftm.bss_color =
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR]);
+	}
+
 	return 0;
 }
 
-- 
2.32.0

