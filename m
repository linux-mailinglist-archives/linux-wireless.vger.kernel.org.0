Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F442D368E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 23:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgLHWzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 17:55:21 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:63135 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbgLHWzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 17:55:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607468096; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=dLstmuiftDBm36AO/XybB5auDZnJ5xyen5F7BS3UFxI=; b=wcLAyKZx6M9pDzRCdzSz6zqT4J7ds1BmZrFxo+/7K4zr10cnvzsDDktWx9V3MoT7NYXzawAw
 R+mG79ak4nZUnn38c4y7MuESrdVrRicCiTJgfjBkNVZvadPdZfw3491qSVnqG+hSkzECmpmH
 k4Bvpb25OzoR3W3oy2QV9aiZ7eE=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fd00425a44f9b1da0795117 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 22:54:29
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7283C433C6; Tue,  8 Dec 2020 22:54:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30DEFC433ED;
        Tue,  8 Dec 2020 22:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30DEFC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=msinada@codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH 2/2] mac80211: Handling driver updated MU-EDCA params
Date:   Tue,  8 Dec 2020 14:54:04 -0800
Message-Id: <1607468044-31789-2-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607468044-31789-1-git-send-email-msinada@codeaurora.org>
References: <1607468044-31789-1-git-send-email-msinada@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Added necessary function to pass through driver updated MU-EDCA
parameters to user space.

Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
 include/net/mac80211.h | 15 +++++++++++++++
 net/mac80211/mlme.c    | 12 ++++++++++++
 net/mac80211/trace.h   | 20 ++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 05c7524bab26..eeadddaf1f6a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6695,4 +6695,19 @@ struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
 struct sk_buff *
 ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif);
+
+/**
+ * ieee80211_update_muedca_params - update MU-EDCA parameters.
+ *
+ * This function is used to pass dynamically updated MU-EDCA parameters
+ * from driver to user space in order for parameters to be updated in beacon.
+ *
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @params: updated MU-EDCA parameters
+ * @gfp: allocation flags
+ */
+void ieee80211_update_muedca_params(struct ieee80211_hw *hw,
+				    struct ieee80211_mu_edca_param_set
+				    *params, gfp_t gfp);
+
 #endif /* MAC80211_H */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6adfcb9c06dc..aba8fecf8284 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5934,3 +5934,15 @@ void ieee80211_cqm_beacon_loss_notify(struct ieee80211_vif *vif, gfp_t gfp)
 	cfg80211_cqm_beacon_loss_notify(sdata->dev, gfp);
 }
 EXPORT_SYMBOL(ieee80211_cqm_beacon_loss_notify);
+
+void ieee80211_update_muedca_params(struct ieee80211_hw *hw,
+				    struct ieee80211_mu_edca_param_set
+				    *params, gfp_t gfp)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	trace_api_update_muedca_params(local, params);
+
+	cfg80211_update_muedca_params_event(local->hw.wiphy, params, gfp);
+}
+EXPORT_SYMBOL(ieee80211_update_muedca_params);
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 89723907a094..4ede71bea435 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2767,6 +2767,26 @@ TRACE_EVENT(drv_sta_set_4addr,
 	)
 );
 
+TRACE_EVENT(api_update_muedca_params,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_mu_edca_param_set *params),
+
+	TP_ARGS(local, params),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " updated MU-EDCA parameters",
+		LOCAL_PR_ARG
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.7.4

