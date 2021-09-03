Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB143FFF64
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Sep 2021 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhICLuA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Sep 2021 07:50:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17175 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhICLty (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Sep 2021 07:49:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630669734; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=L0D+wO9kLSIqvuf/i4348J2+bF82B4cbC78mzqFBkMQ=; b=ohge2VD4N68y+N/jPdlN+uJcDBDjzbftHxK0LEfVdKXscTnSFi60Ap7rHHO08S3YQKa3BVze
 +7x96TeR8j735FJlcfwhXtTowqeLZuno85Fvq0MnqcxRnDGhU8ulC3E40F48WTT3sdsFErXp
 cudfzoUAMTexvl/bZiMM+HpmCfg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61320b8e4d644b7d1c5e92fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:48:30
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55F4AC43616; Fri,  3 Sep 2021 11:48:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9328FC4360D;
        Fri,  3 Sep 2021 11:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9328FC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 1/9] mac80211: add power type definition for 6 GHz
Date:   Fri,  3 Sep 2021 07:48:13 -0400
Message-Id: <20210903114821.23346-2-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903114821.23346-1-wgong@codeaurora.org>
References: <20210903114821.23346-1-wgong@codeaurora.org>
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
index 68d8b9cdd3b8..2bab84297407 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1942,6 +1942,40 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
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
index e89530d0d9c6..d0522d7f3351 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -631,6 +631,7 @@ struct ieee80211_fils_discovery {
  * @s1g: BSS is S1G BSS (affects Association Request format).
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
+ * @power_type: power type of BSS for 6 GHz
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -700,6 +701,7 @@ struct ieee80211_bss_conf {
 	u32 unsol_bcast_probe_resp_interval;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
+	enum ieee80211_ap_reg_power power_type;
 };
 
 /**
-- 
2.31.1

