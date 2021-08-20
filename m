Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5313F2BF2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 14:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbhHTMVw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 08:21:52 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:45228 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbhHTMVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 08:21:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629462073; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=RTUiezN9FbKIsshyxNe23rZMeP1NaJDLEYiD0lv96m4=; b=G+EtpBXFz6rNBiU1GhT7OifYQ75UIaq8TgptuGF+rZqKSdp2ZI6O0PWlGxSkIs6zbrHesZP+
 QItJyMCzu8+CI+HYpKzOFynYBAFtrWF6MwZSdZv54jxMcRU1LDcE2JfI6MHI7W/dsdP92kOt
 SvFoekg5rclD8YVy/PfIWn5AoWo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 611f9e2989fbdf3ffe7b8de8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Aug 2021 12:20:57
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9404FC4360C; Fri, 20 Aug 2021 12:20:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2EF4C4360D;
        Fri, 20 Aug 2021 12:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E2EF4C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 5/8] cfg80211: save power spectral density(psd) of regulatory rule
Date:   Fri, 20 Aug 2021 08:20:38 -0400
Message-Id: <20210820122041.12157-6-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820122041.12157-1-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
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
 net/wireless/reg.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0406ce7334fa..602d95e8bde6 100644
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
@@ -1876,6 +1884,9 @@ static void handle_channel_adjacent_rules(struct wiphy *wiphy,
 							 rrule2->dfs_cac_ms);
 		}
 
+		if (chan->flags & IEEE80211_CHAN_PSD)
+			chan->psd = min_t(s8, rrule1->psd, rrule1->psd);
+
 		return;
 	}
 
@@ -2533,6 +2544,9 @@ static void handle_channel_custom(struct wiphy *wiphy,
 			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 	}
 
+	if (chan->flags & IEEE80211_CHAN_PSD)
+		chan->psd = reg_rule->psd;
+
 	chan->max_power = chan->max_reg_power;
 }
 
-- 
2.31.1

