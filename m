Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25122386B3C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 22:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhEQUVq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 16:21:46 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:37502 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbhEQUVl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 16:21:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621282825; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=r4C048Cyt1NAQETCpOJSuLki6BUx/oLBHbbMepKinxY=; b=atZ6J8j09UZYwQxSOzWioCz4o4PQ05LdeXfwdhppu6Lm8s3hOM3zcY27OJ9lYX0q47mOu8+3
 A/47fL5J+HS2HgPcnJZcitokh6D2vOohcgajrrA61O4J8TQs78m+TVTwZpRXMjW+RHyWkBqE
 F03yYY4yswrOHqtY8uK1x3ewVgo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60a2cff65f788b52a542f777 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 May 2021 20:20:06
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2D60EC43460; Mon, 17 May 2021 20:20:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D1D7C4338A;
        Mon, 17 May 2021 20:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D1D7C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 1/9] cfg80211: add power type definition for 6G Hz
Date:   Mon, 17 May 2021 16:19:24 -0400
Message-Id: <20210517201932.8860-2-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517201932.8860-1-wgong@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6GHz regulatory domains introduces different modes for 6GHz AP
operations Low Power Indoor(LPI), Standard Power(SP) and Very Low
Power(VLP). 6GHz STAs could be operated as either Regular or
Subordinate clients. This patch is define the flags for power type
of AP and STATION mode.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 911fae42b0c0..13d92c643794 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -675,6 +675,7 @@ struct key_params {
  *	chan will define the primary channel and all other
  *	parameters are ignored.
  * @freq1_offset: offset from @center_freq1, in KHz
+ * @power_type: power type of BSS for 6G
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
@@ -683,6 +684,7 @@ struct cfg80211_chan_def {
 	u32 center_freq2;
 	struct ieee80211_edmg edmg;
 	u16 freq1_offset;
+	enum nl80211_ap_reg_power power_type;
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ac78da99fccd..9f8e9e49a16a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4085,6 +4085,36 @@ enum nl80211_dfs_regions {
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
+	NL80211_REG_MAX_AP_TYPE = 3,
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
+	NL80211_REG_MAX_CLIENT_TYPE = 2,
+};
+
 /**
  * enum nl80211_user_reg_hint_type - type of user regulatory hint
  *
-- 
2.31.1

