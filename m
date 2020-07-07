Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F1521692C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2020 11:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgGGJgm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jul 2020 05:36:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30564 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbgGGJgm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jul 2020 05:36:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594114601; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3jRVmBb0Hp9j/OK6PP+4ZVivpyXu87BtfmmwjnEznZM=; b=JFXJIUsmF1mLEUVrBwHA8pgyEDF84iDbzhcs3asWAdwAAMjDSSrkVCSilCfJ6BI/qIQKAxqp
 JYa2dfcDcpq6kIbQg0Hg3+MH1P7d1oqi9M/OSCxCggWNINTB12sbscxQtt6jZpIjHjD2uDwD
 POxmpROEWT4YaEG2b6NA4HFMwiE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f04421fc9789fa9063fb0cb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Jul 2020 09:36:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8E443C433C6; Tue,  7 Jul 2020 09:36:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E07FFC433C8;
        Tue,  7 Jul 2020 09:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E07FFC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ppranees@codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>
Subject: [PATCH v2] mac80211: avoid bss color setting in non-he mode
Date:   Tue,  7 Jul 2020 15:06:12 +0530
Message-Id: <1594114572-26168-1-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding bss-color configuration for HE mode alone.
Earlier we have enabled it by default, irrespective
of capabilities. But bss-color feature is only for
HE mode. Hence avoiding this by adding bss-color flag
only for HE mode.

Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
v2:
        -addressed Rajkumar's comments.
        -moved remaining HE flags under
         corresponding check.
---
 net/mac80211/cfg.c     | 8 +++++---
 net/mac80211/mlme.c    | 4 +++-
 net/wireless/nl80211.c | 3 +++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9b36054..4b98c8f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -991,9 +991,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		      BSS_CHANGED_SSID |
 		      BSS_CHANGED_P2P_PS |
 		      BSS_CHANGED_TXPOWER |
-		      BSS_CHANGED_TWT |
-		      BSS_CHANGED_HE_OBSS_PD |
-		      BSS_CHANGED_HE_BSS_COLOR;
+		      BSS_CHANGED_TWT;
 	int i, err;
 	int prev_beacon_int;
 
@@ -1019,6 +1017,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		sdata->vif.bss_conf.frame_time_rts_th =
 			le32_get_bits(params->he_oper->he_oper_params,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
+		changed |= BSS_CHANGED_HE_OBSS_PD;
+
+		if (!params->he_bss_color.disabled)
+			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
 	mutex_lock(&local->mtx);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b2a9d47..76ba761 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3463,7 +3463,9 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		bss_conf->he_bss_color.disabled =
 			le32_get_bits(elems->he_operation->he_oper_params,
 				      IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
-		changed |= BSS_CHANGED_HE_BSS_COLOR;
+
+		if (!params->he_bss_color.disabled)
+			changed |= BSS_CHANGED_HE_BSS_COLOR;
 
 		bss_conf->htc_trig_based_pkt_ext =
 			le32_get_bits(elems->he_operation->he_oper_params,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 263ae39..29b15dd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5019,6 +5019,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	/* disabling BSS color default */
+	params.he_bss_color.disabled = true;
+
 	if (info->attrs[NL80211_ATTR_HE_BSS_COLOR]) {
 		err = nl80211_parse_he_bss_color(
 					info->attrs[NL80211_ATTR_HE_BSS_COLOR],
-- 
2.7.4

