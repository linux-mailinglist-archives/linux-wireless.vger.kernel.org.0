Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35084419547
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 15:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhI0Nob (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 09:44:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14996 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234114AbhI0Noa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 09:44:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632750172; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Z37yVYh8YICEJtn+fkhkvwtyMzcivSLYdi245wxWQ6w=; b=VJBrtdpGoT8NmOSb0VmjBbukFRXD9wYnlpbV9VtvUJ8LA4JYnMpMiSXG8TvQOr3W4lDJYlG8
 Iiov4FRTOxl4MhyinvWiyHY8aGBnp18Hi6a2OsZ8v/FQX5qeZCFE8KA+cLl183ZWGLE+rpWK
 zM0WgWxSvolzO99np8Mmo0pYdsc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6151ca24713d5d6f96d4ca94 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Sep 2021 13:41:56
 GMT
Sender: tmariyap=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5774BC4338F; Mon, 27 Sep 2021 13:41:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cdchalpyex0390930-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tmariyap)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F0F2C4360C;
        Mon, 27 Sep 2021 13:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5F0F2C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Thiraviyam Mariyappan <tmariyap@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <tmariyap@codeaurora.org>
Subject: [PATCH] mac80211: fix incorrect nss config
Date:   Mon, 27 Sep 2021 19:11:44 +0530
Message-Id: <1632750104-1722-1-git-send-email-tmariyap@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In HE capabilities, HE-MCS Rx map field filled with value 0x3 for all eight
spatial streams if txrx chains configured as incorrect value.
This patch changes configure at least single spatial stream for HE-MCS
0 to 7 in all supported channel widths if nss configured as incorrect
value.

Signed-off-by: Thiraviyam Mariyappan <tmariyap@codeaurora.org>
---
 net/mac80211/he.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index c05af70..ee113ff5 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -151,6 +151,13 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 		       &he_cap_ie[sizeof(he_cap->he_cap_elem) + mcs_nss_size],
 		       he_ppe_size);
 
+	if (he_cap->he_mcs_nss_supp.rx_mcs_80 == cpu_to_le16(0xFFFF)) {
+		he_cap->has_he = false;
+		sdata_info(sdata, "Ignoring HE IE from %pM due to incorrect rx_mcs_80\n",
+			   sta->addr);
+		return;
+	}
+
 	he_cap->has_he = true;
 
 	sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
-- 
2.7.4

