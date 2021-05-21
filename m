Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE15F38BC58
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 04:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbhEUCT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 22:19:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29990 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232347AbhEUCT6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 22:19:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621563516; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=EQFDhszrTgfGuv/UxHUgWZQdR7DrSIYZ3g3o7KNNaqI=; b=H45t5+og4VWlsUE7W69V+yHX/ENiANqcFA6shXSWS+q33NRcOdCNNj3y5F7ZCkoM6ZbsAYAP
 GcMgzNfMdAndCVLqj6EdSvsJEldC+7+kOMUJlV6W+2q1H4K00MnswZTn0g49bmYqtFaMoMKq
 4VQ2Bcszl1Pq1Q8lfRbMMthHXNs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60a71869d1aee7698d4e001a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 May 2021 02:18:17
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AE70C433F1; Fri, 21 May 2021 02:18:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59D77C43460;
        Fri, 21 May 2021 02:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59D77C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2] wireless: add check of field VHT Extended NSS BW Capable for 160/80+80 MHz setting
Date:   Thu, 20 May 2021 22:18:09 -0400
Message-Id: <20210521021809.23986-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Table 9-251—Supported VHT-MCS and NSS Set subfields, it has subfield VHT Extended
NSS BW Capable, its definition is:
Indicates whether the STA is capable of interpreting the Extended NSS BW
Support subfield of the VHT Capabilities Information field.

This patch is to add check for the subfield.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: change code style
 net/wireless/chan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 285b8076054b..e29562659ae5 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -942,7 +942,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 	struct ieee80211_sta_vht_cap *vht_cap;
 	struct ieee80211_edmg *edmg_cap;
 	u32 width, control_freq, cap;
-	bool support_80_80 = false;
+	bool ext_nss_cap, support_80_80 = false;
 
 	if (WARN_ON(!cfg80211_chandef_valid(chandef)))
 		return false;
@@ -950,6 +950,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 	ht_cap = &wiphy->bands[chandef->chan->band]->ht_cap;
 	vht_cap = &wiphy->bands[chandef->chan->band]->vht_cap;
 	edmg_cap = &wiphy->bands[chandef->chan->band]->edmg_cap;
+	ext_nss_cap = vht_cap->vht_mcs.tx_highest & IEEE80211_VHT_EXT_NSS_BW_CAPABLE;
 
 	if (edmg_cap->channels &&
 	    !cfg80211_edmg_usable(wiphy,
@@ -1015,7 +1016,8 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 			(cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ) ||
 			(cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ &&
 			 cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) ||
-			u32_get_bits(cap, IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) > 1;
+			(ext_nss_cap &&
+			 u32_get_bits(cap, IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) > 1);
 		if (chandef->chan->band != NL80211_BAND_6GHZ && !support_80_80)
 			return false;
 		fallthrough;
@@ -1037,7 +1039,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		cap = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 		if (cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ &&
 		    cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ &&
-		    !(vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
+		    !(ext_nss_cap && (vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK)))
 			return false;
 		break;
 	default:
-- 
2.31.1

