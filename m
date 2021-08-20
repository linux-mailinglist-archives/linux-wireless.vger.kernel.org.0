Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9923F2BE6
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhHTMVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 08:21:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53290 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238064AbhHTMV3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 08:21:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629462051; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=B1eeBXXRanM2y/whbXRJaHJkVYC5X+/SfXDWh1SVWAw=; b=doX8aMULlyp9cHhS+u+qx12850crvhYz1lMgcffmB+BP5GtEC8c4lcbBdu2tqxXSbAZdCxaE
 SVr+WpfKmZMxD/NDkxj3dXxFhYywB0rRy+DaHLUC8wayUdRnChIM+Uv3TjELh6gyUsJWZU/L
 PqPK9ypVDJG6+2N9uuHPm1pKZu4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 611f9e229b8228d0d0a4158a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Aug 2021 12:20:50
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 26602C4338F; Fri, 20 Aug 2021 12:20:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3166C43460;
        Fri, 20 Aug 2021 12:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A3166C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 1/8] cfg80211: add power type definition for 6 GHz
Date:   Fri, 20 Aug 2021 08:20:34 -0400
Message-Id: <20210820122041.12157-2-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820122041.12157-1-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
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
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 58c2cd417e89..f17a4d1202fc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -676,6 +676,7 @@ struct key_params {
  *	chan will define the primary channel and all other
  *	parameters are ignored.
  * @freq1_offset: offset from @center_freq1, in KHz
+ * @power_type: power type of BSS for 6 GHz
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
@@ -684,6 +685,7 @@ struct cfg80211_chan_def {
 	u32 center_freq2;
 	struct ieee80211_edmg edmg;
 	u16 freq1_offset;
+	enum nl80211_ap_reg_power power_type;
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f962c06e9818..ab1d4aa85272 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4088,6 +4088,40 @@ enum nl80211_dfs_regions {
 	NL80211_DFS_JP		= 3,
 };
 
+/**
+ * enum nl80211_ap_reg_power - regulatory power for a Access Point
+ *
+ * @NL80211_REG_UNSET_AP: Access Point has no regulatory power mode
+ * @NL80211_REG_LPI: Indoor Access Point
+ * @NL80211_REG_SP: Standard power Access Point
+ * @NL80211_REG_VLP: Very low power Access Point
+ */
+enum nl80211_ap_reg_power {
+	NL80211_REG_UNSET_AP,
+	NL80211_REG_LPI_AP,
+	NL80211_REG_SP_AP,
+	NL80211_REG_VLP_AP,
+	NL80211_REG_AP_POWER_AFTER_LAST,
+	NL80211_REG_AP_POWER_MAX =
+		NL80211_REG_AP_POWER_AFTER_LAST - 1,
+};
+
+/**
+ * enum nl80211_client_reg_power - regulatory power for a client
+ *
+ * @NL80211_REG_UNSET_CLIENT: Client has no regulatory power mode
+ * @NL80211_REG_DEFAULT_CLIENT: Default Client
+ * @NL80211_REG_SUBORDINATE_CLIENT: Subordinate Client
+ */
+enum nl80211_client_reg_power {
+	NL80211_REG_UNSET_CLIENT,
+	NL80211_REG_DEFAULT_CLIENT,
+	NL80211_REG_SUBORDINATE_CLIENT,
+	NL80211_REG_CLIENT_POWER_AFTER_LAST,
+	NL80211_REG_CLIENT_POWER_MAX =
+		NL80211_REG_CLIENT_POWER_AFTER_LAST - 1,
+};
+
 /**
  * enum nl80211_user_reg_hint_type - type of user regulatory hint
  *
-- 
2.31.1

