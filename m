Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD541D54F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 10:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349046AbhI3IRe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 04:17:34 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:18888 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348949AbhI3IRd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 04:17:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632989751; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=0xTZoD9OiNUYm0bAZkUfnj3+242hlNTrKosJKt38oYk=; b=KTa6eX9sa39h5WBEnijMWzmeiNZ+Gn4faY4BG0pKylK+xc1O6g3l5mfpn2Ig2CtgUvoKXq0y
 W4VI0gdunbOrORMnVMQYM1BWSW8SdjRm758AlQIGNwpY2uK3dj1Hruq0xePKLIulgO5BPr+I
 h5Sq+dNPdLxZwuqKzZUFxgxcgG8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6155722d9ffb413149b3efa1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Sep 2021 08:15:41
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F453C4360C; Thu, 30 Sep 2021 08:15:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43609C4338F;
        Thu, 30 Sep 2021 08:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 43609C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] cfg80211: seperate get channel number from ies
Date:   Thu, 30 Sep 2021 04:15:33 -0400
Message-Id: <20210930081533.4898-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get channel number from ies is a common logic, so seperate it to a new
function, which could also be used by lower driver.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/net/cfg80211.h |  9 +++++++++
 net/wireless/scan.c    | 41 ++++++++++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 911fae42b0c0..2ed677d203a7 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6268,6 +6268,15 @@ static inline void cfg80211_gen_new_bssid(const u8 *bssid, u8 max_bssid,
 	u64_to_ether_addr(new_bssid_u64, new_bssid);
 }
 
+/**
+ * cfg80211_get_ies_channel_number - returns the channel number from ies
+ * @ie: ies
+ * @ielen: length of IEs
+ * @band: enum nl80211_band of the channel
+ */
+int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
+				    enum nl80211_band band);
+
 /**
  * cfg80211_is_element_inherited - returns if element ID should be inherited
  * @element: element to check
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 019952d4fc7d..a0dd4fa136eb 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1782,25 +1782,13 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 	return NULL;
 }
 
-/*
- * Update RX channel information based on the available frame payload
- * information. This is mainly for the 2.4 GHz band where frames can be received
- * from neighboring channels and the Beacon frames use the DSSS Parameter Set
- * element to indicate the current (transmitting) channel, but this might also
- * be needed on other bands if RX frequency does not match with the actual
- * operating channel of a BSS.
- */
-static struct ieee80211_channel *
-cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
-			 struct ieee80211_channel *channel,
-			 enum nl80211_bss_scan_width scan_width)
+int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
+				    enum nl80211_band band)
 {
 	const u8 *tmp;
-	u32 freq;
 	int channel_number = -1;
-	struct ieee80211_channel *alt_channel;
 
-	if (channel->band == NL80211_BAND_S1GHZ) {
+	if (band == NL80211_BAND_S1GHZ) {
 		tmp = cfg80211_find_ie(WLAN_EID_S1G_OPERATION, ie, ielen);
 		if (tmp && tmp[1] >= sizeof(struct ieee80211_s1g_oper_ie)) {
 			struct ieee80211_s1g_oper_ie *s1gop = (void *)(tmp + 2);
@@ -1820,6 +1808,29 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 			}
 		}
 	}
+	return channel_number;
+}
+EXPORT_SYMBOL(cfg80211_get_ies_channel_number);
+
+/*
+ * Update RX channel information based on the available frame payload
+ * information. This is mainly for the 2.4 GHz band where frames can be received
+ * from neighboring channels and the Beacon frames use the DSSS Parameter Set
+ * element to indicate the current (transmitting) channel, but this might also
+ * be needed on other bands if RX frequency does not match with the actual
+ * operating channel of a BSS.
+ */
+static struct ieee80211_channel *
+cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
+			 struct ieee80211_channel *channel,
+			 enum nl80211_bss_scan_width scan_width)
+{
+	const u8 *tmp;
+	u32 freq;
+	int channel_number;
+	struct ieee80211_channel *alt_channel;
+
+	channel_number = cfg80211_get_ies_channel_number(ie, ielen, channel->band);
 
 	if (channel_number < 0) {
 		/* No channel information in frame payload */
-- 
2.31.1

