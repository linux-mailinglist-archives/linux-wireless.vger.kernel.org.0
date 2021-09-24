Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE6416FD5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245480AbhIXKDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 06:03:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32146 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245454AbhIXKDe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 06:03:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632477721; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=IP0sYybM0HxKXSdRgwB7ixtI/SKvU15/0Dr5fi1Qn/E=; b=TPfBRA1FT4SAz/nOtkCSOTrz9pfr/4pUd4huShqEHVYfrKDxwnGLQgGczJTPRdwj4T9Jh/Ku
 AOULSyLbCVFpdwQg8m17F23EqY5u5W/Zojx6Zo9SdEiE6NqGaroQgGKfrAKLeVTLUPqhXwD+
 dTkxtp05F1OMcmp8oYQdfovkP3Y=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 614da1eebd9e12ebc5eeeb85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 10:01:18
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F0F5C4360D; Fri, 24 Sep 2021 10:01:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7E0BC4360C;
        Fri, 24 Sep 2021 10:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D7E0BC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v4 2/6] mac80211: add parse regulatory info in 6 GHz operation information
Date:   Fri, 24 Sep 2021 06:00:48 -0400
Message-Id: <20210924100052.32029-3-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924100052.32029-1-wgong@codeaurora.org>
References: <20210924100052.32029-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is to convert the regulatory info subfield in HE operation
element to power type and save in struct cfg80211_chan_def.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/util.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ca8008ba9b1f..66e48f29495a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3385,6 +3385,7 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_he_cap *he_cap;
 	struct cfg80211_chan_def he_chandef = *chandef;
 	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+	struct ieee80211_bss_conf *bss_conf;
 	bool support_80_80, support_160;
 	u8 he_phy_cap;
 	u32 freq;
@@ -3428,6 +3429,18 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 					      NL80211_BAND_6GHZ);
 	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
 
+	bss_conf = &sdata->vif.bss_conf;
+
+	switch (u8_get_bits(he_6ghz_oper->control,
+			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
+	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+		bss_conf->power_type = IEEE80211_REG_LPI_AP;
+		break;
+	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+		bss_conf->power_type = IEEE80211_REG_SP_AP;
+		break;
+	}
+
 	switch (u8_get_bits(he_6ghz_oper->control,
 			    IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH)) {
 	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ:
-- 
2.31.1

