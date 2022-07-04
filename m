Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB556522D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiGDKZs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 06:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiGDKZZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 06:25:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A332010FEC
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 03:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656930246; x=1688466246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EvUYaTqGrY7Ds94cNF7HnBqnA+zaPRn8jhmHdgqloj0=;
  b=n0EpQBtl0gxk1u72qKEA3NTW/RsMP+3nMkJ64FkCNnoV3Dfs2xebZpMK
   /i3k2DVRtwtTUORc+SAYNqLHruD2K7tmgrmRXc9D5p13f0HtI2kMMo9rQ
   USOm3xCpyM8a94xs8bSISDFaBNy/7rH/k3OQFhqGwa3kqWwi6OvBF+3wB
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Jul 2022 03:24:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:24:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:05 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:03 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 2/7] mac80211: rework on 6 GHz power type definition
Date:   Mon, 4 Jul 2022 15:53:36 +0530
Message-ID: <20220704102341.5692-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704102341.5692-1-quic_adisi@quicinc.com>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz regulatory domains introduces different modes for 6 GHz AP
operation - Low Power Indoor(LPI), Standard Power(SP) and Very Low
Power(VLP). 6 GHz STAs could be operated as either Regular or
Subordinate clients. We have separate definitions of AP and client.

However, IEEE80211_REG_UNSET_* is not a defined power type. Hence,
remove IEEE80211_REG_UNSET_* from both AP and client power mode
enums.

To demonstrate unset or invalid type, (IEEE80211_REG_*_POWER_MAX + 1)
value can be used instead.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/linux/ieee80211.h | 10 ++++------
 net/mac80211/util.c       |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index f386f9ed41f3..606b5ba8b161 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2132,18 +2132,17 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 /**
  * enum ieee80211_ap_reg_power - regulatory power for a Access Point
  *
- * @IEEE80211_REG_UNSET_AP: Access Point has no regulatory power mode
  * @IEEE80211_REG_LPI: Indoor Access Point
  * @IEEE80211_REG_SP: Standard power Access Point
  * @IEEE80211_REG_VLP: Very low power Access Point
- * @IEEE80211_REG_AP_POWER_AFTER_LAST: internal
+ * @IEEE80211_REG_AP_POWER_AFTER_LAST: internal use
  * @IEEE80211_REG_AP_POWER_MAX: maximum value
  */
 enum ieee80211_ap_reg_power {
-	IEEE80211_REG_UNSET_AP,
 	IEEE80211_REG_LPI_AP,
 	IEEE80211_REG_SP_AP,
 	IEEE80211_REG_VLP_AP,
+	/* keep last */
 	IEEE80211_REG_AP_POWER_AFTER_LAST,
 	IEEE80211_REG_AP_POWER_MAX =
 		IEEE80211_REG_AP_POWER_AFTER_LAST - 1,
@@ -2152,16 +2151,15 @@ enum ieee80211_ap_reg_power {
 /**
  * enum ieee80211_client_reg_power - regulatory power for a client
  *
- * @IEEE80211_REG_UNSET_CLIENT: Client has no regulatory power mode
  * @IEEE80211_REG_DEFAULT_CLIENT: Default Client
  * @IEEE80211_REG_SUBORDINATE_CLIENT: Subordinate Client
- * @IEEE80211_REG_CLIENT_POWER_AFTER_LAST: internal
+ * @IEEE80211_REG_CLIENT_POWER_AFTER_LAST: internal use
  * @IEEE80211_REG_CLIENT_POWER_MAX: maximum value
  */
 enum ieee80211_client_reg_power {
-	IEEE80211_REG_UNSET_CLIENT,
 	IEEE80211_REG_DEFAULT_CLIENT,
 	IEEE80211_REG_SUBORDINATE_CLIENT,
+	/* keep last */
 	IEEE80211_REG_CLIENT_POWER_AFTER_LAST,
 	IEEE80211_REG_CLIENT_POWER_MAX =
 		IEEE80211_REG_CLIENT_POWER_AFTER_LAST - 1,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index bccc3a309ed0..efdea5c2f2db 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3524,7 +3524,7 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		bss_conf->power_type = IEEE80211_REG_SP_AP;
 		break;
 	default:
-		bss_conf->power_type = IEEE80211_REG_UNSET_AP;
+		bss_conf->power_type = IEEE80211_REG_AP_POWER_MAX + 1;
 		break;
 	}
 
-- 
2.17.1

