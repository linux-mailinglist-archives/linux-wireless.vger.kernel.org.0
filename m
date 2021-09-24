Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2A416FD8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245507AbhIXKDo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 06:03:44 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10624 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245496AbhIXKDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 06:03:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632477731; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=IZmqxqhxc/rmWPSKNvrTIIRji06x0+o64kg1VFKkrXw=; b=EWXpK5DfK/CRm0ERI5Zb37HlLcx4Jlrlig2rv/9Lug9NppZAun27UiwINaALpH2Eyqr0wkSj
 84sTEsTmLuRHlglp/2am3eXKHXRm119IWBQRRZSALYJEEwU+WKmQlXhhRH50KNfQ6tvyHkiG
 TkI0iWBGxNLbihcglCyxY091BGg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 614da1f0bd6681d8ed4b7dc2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 10:01:20
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31F0BC43616; Fri, 24 Sep 2021 10:01:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63E38C43460;
        Fri, 24 Sep 2021 10:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 63E38C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v4 3/6] cfg80211: add definition for 6 GHz power spectral density(psd)
Date:   Fri, 24 Sep 2021 06:00:49 -0400
Message-Id: <20210924100052.32029-4-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924100052.32029-1-wgong@codeaurora.org>
References: <20210924100052.32029-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz regulatory domains introduces power spectral density(psd). This
patch is define the flags for psd.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/net/cfg80211.h       | 5 +++++
 include/net/regulatory.h     | 1 +
 include/uapi/linux/nl80211.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 62dd8422e0dc..f8e0cc19e0ce 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -109,6 +109,8 @@ struct wiphy;
  *	on this channel.
  * @IEEE80211_CHAN_16MHZ: 16 MHz bandwidth is permitted
  *	on this channel.
+ * @IEEE80211_CHAN_PSD: power spectral density (in dBm)
+ *	on this channel.
  *
  */
 enum ieee80211_channel_flags {
@@ -131,6 +133,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_4MHZ		= 1<<16,
 	IEEE80211_CHAN_8MHZ		= 1<<17,
 	IEEE80211_CHAN_16MHZ		= 1<<18,
+	IEEE80211_CHAN_PSD		= 1<<19,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
@@ -164,6 +167,7 @@ enum ieee80211_channel_flags {
  *	on this channel.
  * @dfs_state_entered: timestamp (jiffies) when the dfs state was entered.
  * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS channels.
+ * @psd: power spectral density (in dBm)
  */
 struct ieee80211_channel {
 	enum nl80211_band band;
@@ -180,6 +184,7 @@ struct ieee80211_channel {
 	enum nl80211_dfs_state dfs_state;
 	unsigned long dfs_state_entered;
 	unsigned int dfs_cac_ms;
+	s8 psd;
 };
 
 /**
diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 47f06f6f5a67..ed20004fb6a9 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -221,6 +221,7 @@ struct ieee80211_reg_rule {
 	u32 flags;
 	u32 dfs_cac_ms;
 	bool has_wmm;
+	s8 psd;
 };
 
 struct ieee80211_regdomain {
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c2efea98e060..2ca8fa06f536 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4085,6 +4085,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_80MHZ: 80MHz operation not allowed
  * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
  * @NL80211_RRF_NO_HE: HE operation not allowed
+ * @NL80211_RRF_PSD: channels has power spectral density value
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4103,6 +4104,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_80MHZ		= 1<<15,
 	NL80211_RRF_NO_160MHZ		= 1<<16,
 	NL80211_RRF_NO_HE		= 1<<17,
+	NL80211_RRF_PSD		= 1<<18,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
-- 
2.31.1

