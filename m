Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42A7416FD6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245492AbhIXKDj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 06:03:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62796 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245468AbhIXKDh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 06:03:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632477724; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=uwFxiwjJGfWbbq/xc4B8uB5Lsb5yhYjskzkDkMxdh6Q=; b=HkraOlKy9qBlNa9gKIJI9pkzkn23u3gHKLsAPAXOExwKa5SDE8Js3nTuLw6dWCD/7a2mMNCU
 5+Bmdf2FtucCH/Fq+yIQmFi+53XWyeh3j0c8j/M0LRy2sXTUmsl/YJEbykK5I5U7NQ+qgztM
 j36Ij3WF/nGZ935qlZu77pAjtT0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 614da1ede0480a7d6fcea670 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 10:01:17
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8DD0C4360D; Fri, 24 Sep 2021 10:01:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A036C43460;
        Fri, 24 Sep 2021 10:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4A036C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v4 1/6] mac80211: add power type definition for 6 GHz
Date:   Fri, 24 Sep 2021 06:00:47 -0400
Message-Id: <20210924100052.32029-2-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924100052.32029-1-wgong@codeaurora.org>
References: <20210924100052.32029-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz regulatory domains introduces different modes for 6 GHz AP
operations Low Power Indoor(LPI), Standard Power(SP) and Very Low
Power(VLP). 6 GHz STAs could be operated as either Regular or
Subordinate clients. This patch is define the flags for power type
of AP and STATION mode.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/linux/ieee80211.h | 34 ++++++++++++++++++++++++++++++++++
 include/net/mac80211.h    |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 694264503119..1e2d7f25d4f9 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1988,6 +1988,40 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 			      int mcs, bool ext_nss_bw_capable,
 			      unsigned int max_vht_nss);
 
+/**
+ * enum ieee80211_ap_reg_power - regulatory power for a Access Point
+ *
+ * @IEEE80211_REG_UNSET_AP: Access Point has no regulatory power mode
+ * @IEEE80211_REG_LPI: Indoor Access Point
+ * @IEEE80211_REG_SP: Standard power Access Point
+ * @IEEE80211_REG_VLP: Very low power Access Point
+ */
+enum ieee80211_ap_reg_power {
+	IEEE80211_REG_UNSET_AP,
+	IEEE80211_REG_LPI_AP,
+	IEEE80211_REG_SP_AP,
+	IEEE80211_REG_VLP_AP,
+	IEEE80211_REG_AP_POWER_AFTER_LAST,
+	IEEE80211_REG_AP_POWER_MAX =
+		IEEE80211_REG_AP_POWER_AFTER_LAST - 1,
+};
+
+/**
+ * enum ieee80211_client_reg_power - regulatory power for a client
+ *
+ * @IEEE80211_REG_UNSET_CLIENT: Client has no regulatory power mode
+ * @IEEE80211_REG_DEFAULT_CLIENT: Default Client
+ * @IEEE80211_REG_SUBORDINATE_CLIENT: Subordinate Client
+ */
+enum ieee80211_client_reg_power {
+	IEEE80211_REG_UNSET_CLIENT,
+	IEEE80211_REG_DEFAULT_CLIENT,
+	IEEE80211_REG_SUBORDINATE_CLIENT,
+	IEEE80211_REG_CLIENT_POWER_AFTER_LAST,
+	IEEE80211_REG_CLIENT_POWER_MAX =
+		IEEE80211_REG_CLIENT_POWER_AFTER_LAST - 1,
+};
+
 /* 802.11ax HE MAC capabilities */
 #define IEEE80211_HE_MAC_CAP0_HTC_HE				0x01
 #define IEEE80211_HE_MAC_CAP0_TWT_REQ				0x02
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index af0fc13cea34..8923a9fc4126 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -632,6 +632,7 @@ struct ieee80211_fils_discovery {
  * @s1g: BSS is S1G BSS (affects Association Request format).
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
+ * @power_type: power type of BSS for 6 GHz
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -702,6 +703,7 @@ struct ieee80211_bss_conf {
 	u32 unsol_bcast_probe_resp_interval;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
+	enum ieee80211_ap_reg_power power_type;
 };
 
 /**
-- 
2.31.1

