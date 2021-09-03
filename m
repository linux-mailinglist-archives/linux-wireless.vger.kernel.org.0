Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3293FFF69
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Sep 2021 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349318AbhICLuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Sep 2021 07:50:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17175 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhICLuC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Sep 2021 07:50:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630669742; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=dGN37s3jyUX7eiqRdMr8/XPiuEfd1mFm9MFNpMM8P24=; b=jqJuZi0N6jPISVhn5DXGXDROIX/QI+8EUirtuuq26aFJCUrO6WQJzA0MRrTaSxBZyjDxpHn6
 HKdx3UELmXvTq798nO0nmLYU7pyEIEvvYvRcoWFiL6UoA1Jk0mOSwJUO8oS0VZTw2NzkePK1
 JZHm4fXdZAvsObVmic7icFU/FRk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61320b9189cdb62061a54145 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:48:33
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1241DC4360C; Fri,  3 Sep 2021 11:48:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9857CC43460;
        Fri,  3 Sep 2021 11:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9857CC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 3/9] mac80211: add parse regulatory info in 6 GHz operation information
Date:   Fri,  3 Sep 2021 07:48:15 -0400
Message-Id: <20210903114821.23346-4-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903114821.23346-1-wgong@codeaurora.org>
References: <20210903114821.23346-1-wgong@codeaurora.org>
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
index 93d96a4f9c3e..04f2ba530d4f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3352,6 +3352,7 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_he_cap *he_cap;
 	struct cfg80211_chan_def he_chandef = *chandef;
 	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+	struct ieee80211_bss_conf *bss_conf;
 	bool support_80_80, support_160;
 	u8 he_phy_cap;
 	u32 freq;
@@ -3395,6 +3396,18 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
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

