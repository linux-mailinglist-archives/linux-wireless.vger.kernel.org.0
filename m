Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5BB2EA3C0
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 04:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbhAEDIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 22:08:35 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:48414 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbhAEDIf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 22:08:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609816089; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=O19Q5KtcGNHtJCX/RiqrbhKDGoWzDR4uwAm5QRHXfTQ=; b=ux7+rPDekp2fmOxtj6M4T1Ny8chrn/vHf+DZTh9FOw1Ym4+ZRZw3pe5hY4PJxT0qNezJpggU
 ifi1zLBrvVYpQ0gh5bhMLXL4EZrM07lfGm0CFm3lO8viO8XkhmTtF/uNRVPjL5wzxoQo34dW
 agCB5cfuEv8aeizmzz64IDsw180=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ff3d7ffb100ecf37a7b65c1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Jan 2021 03:07:43
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66272C433CA; Tue,  5 Jan 2021 03:07:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01337C43461;
        Tue,  5 Jan 2021 03:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01337C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 1/2] mac80211: remove NSS number of 160MHz if not support 160MHz for HE
Date:   Tue,  5 Jan 2021 11:08:39 +0800
Message-Id: <1609816120-9411-2-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609816120-9411-1-git-send-email-wgong@codeaurora.org>
References: <1609816120-9411-1-git-send-email-wgong@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When it does not support 160MHz in HE phy capabilities information,
it should not treat the NSS number of 160MHz as a valid number,
otherwise the final NSS will be set to 0.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/vht.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index d87e020715b3..d872f1d4d946 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -484,6 +484,7 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta)
 void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 {
 	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, rx_nss;
+	bool support_160;
 
 	/* if we received a notification already don't overwrite it */
 	if (sta->sta.rx_nss)
@@ -514,7 +515,13 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 			}
 		}
 
-		he_rx_nss = min(rx_mcs_80, rx_mcs_160);
+		support_160 = !!(he_cap->he_cap_elem.phy_cap_info[0] &
+			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G);
+
+		if (support_160)
+			he_rx_nss = min(rx_mcs_80, rx_mcs_160);
+		else
+			he_rx_nss = rx_mcs_80;
 	}
 
 	if (sta->sta.ht_cap.ht_supported) {
-- 
2.23.0

