Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F503FFF68
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Sep 2021 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbhICLuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Sep 2021 07:50:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20507 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349023AbhICLt7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Sep 2021 07:49:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630669739; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XI+1JWFKXuTIl053ryCOv7u9PvZrXBuAZlr+HypEck4=; b=u89pmAhjNIVT2tNEiaxk9P5zQrIwp4l8w72jxq7MpAadZNbrtgL8FlHlYKu66SiNMRzNGgpP
 U1dW1S204Qi9/QRR/fuXic5ZfdvKPG5xNx1Mxm4fOs+25B531NC8pXvMKW94MrKTvTCTmZFz
 Q1iGxWRu9V1nE8PX+7pkoospMJQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61320b944d644b7d1c5ea61f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:48:36
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 436C4C4360C; Fri,  3 Sep 2021 11:48:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0566C43617;
        Fri,  3 Sep 2021 11:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A0566C43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 5/9] cfg80211: save power spectral density(psd) of regulatory rule
Date:   Fri,  3 Sep 2021 07:48:17 -0400
Message-Id: <20210903114821.23346-6-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903114821.23346-1-wgong@codeaurora.org>
References: <20210903114821.23346-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The power spectral density(psd) of regulatory rule should be take
effect to the channels. This patch is to save the values to the
channel which has psd value.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/wireless/reg.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0406ce7334fa..a971d97aaf12 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1583,6 +1583,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_160MHZ;
 	if (rd_flags & NL80211_RRF_NO_HE)
 		channel_flags |= IEEE80211_CHAN_NO_HE;
+	if (rd_flags & NL80211_RRF_PSD)
+		channel_flags |= IEEE80211_CHAN_PSD;
 	return channel_flags;
 }
 
@@ -1787,6 +1789,9 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 				chan->dfs_cac_ms = reg_rule->dfs_cac_ms;
 		}
 
+		if (chan->flags & IEEE80211_CHAN_PSD)
+			chan->psd = reg_rule->psd;
+
 		return;
 	}
 
@@ -1807,6 +1812,9 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 	}
 
+	if (chan->flags & IEEE80211_CHAN_PSD)
+		chan->psd = reg_rule->psd;
+
 	if (chan->orig_mpwr) {
 		/*
 		 * Devices that use REGULATORY_COUNTRY_IE_FOLLOW_POWER
@@ -1876,6 +1884,12 @@ static void handle_channel_adjacent_rules(struct wiphy *wiphy,
 							 rrule2->dfs_cac_ms);
 		}
 
+		if ((rrule1->flags & NL80211_RRF_PSD) &&
+		    (rrule2->flags & NL80211_RRF_PSD))
+			chan->psd = min_t(s8, rrule1->psd, rrule2->psd);
+		else
+			chan->flags &= ~NL80211_RRF_PSD;
+
 		return;
 	}
 
@@ -2533,6 +2547,9 @@ static void handle_channel_custom(struct wiphy *wiphy,
 			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 	}
 
+	if (chan->flags & IEEE80211_CHAN_PSD)
+		chan->psd = reg_rule->psd;
+
 	chan->max_power = chan->max_reg_power;
 }
 
-- 
2.31.1

