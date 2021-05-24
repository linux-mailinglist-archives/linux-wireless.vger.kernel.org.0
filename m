Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC6138DFE9
	for <lists+linux-wireless@lfdr.de>; Mon, 24 May 2021 05:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhEXDik (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 May 2021 23:38:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63828 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232125AbhEXDij (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 May 2021 23:38:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621827432; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=oKAkKSZrsrmoutto39uMBJ+LDG+zUwDxjXkEC8nxgr0=; b=OMu9bEdoFKNueC1BZGCuEXgDDb53oJ5fVBA4DusSMHE3gUR5nu05ZikZKF2Lu7zGa7SPqi0I
 9HURcfnvyHYXgqYiw3FdRpDR5tbmPGYwgWVKtg4sjLdw/8BBJo/Fp8DQlLoB+Oh0nJeiuAOM
 Fu4EoP1SzKFFus2zZH5jHHdKpnM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60ab1f4dc229adfeffd0ad8f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 May 2021 03:36:45
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80247C4338A; Mon, 24 May 2021 03:36:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30FCCC433F1;
        Mon, 24 May 2021 03:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30FCCC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3] wireless: add check of field VHT Extended NSS BW Capable for 160/80+80 MHz setting
Date:   Sun, 23 May 2021 23:36:24 -0400
Message-Id: <20210524033624.16993-1-wgong@codeaurora.org>
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
v3: add __le16_to_cpu for __le16 tx_highest
v2: change code style
 net/wireless/chan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 285b8076054b..a2d11c801585 100644
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
+	ext_nss_cap = __le16_to_cpu(vht_cap->vht_mcs.tx_highest) & IEEE80211_VHT_EXT_NSS_BW_CAPABLE;
 
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

