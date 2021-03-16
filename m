Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833D233D815
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 16:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbhCPPtE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 11:49:04 -0400
Received: from m42-2.mailgun.net ([69.72.42.2]:25169 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhCPPsm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 11:48:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615909722; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GXZ4+vm4fjxDMZeZv5adoETyWw+/5fuT5KFGMoyetH8=; b=Rd6hDMRN7geP/3vRtlgtKapAEHRR5e8u97qXXe+PlJg7vvCfOhY9diUHS2u22gjn68IXwdJS
 +6dctMCpFR8cIZqPRmf47jTJpeZLZmKp2EIATaEjg8DRhLV4qCjwV72eKU0D3PI1JY/eJvHz
 /osBAjeYOpq+xMwzopt5UzaPDBc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6050d34a5d70193f883ff9d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Mar 2021 15:48:26
 GMT
Sender: gsamin=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58B08C43461; Tue, 16 Mar 2021 15:48:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from c-gsamin-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gsamin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D1C6C433C6;
        Tue, 16 Mar 2021 15:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D1C6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=gsamin@codeaurora.org
From:   Govindaraj <gsamin@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Govindaraj <gsamin@codeaurora.org>
Subject: [PATCH] mac80211: fix low throughput due to invalid addba extension
Date:   Tue, 16 Mar 2021 21:17:54 +0530
Message-Id: <1615909674-13412-1-git-send-email-gsamin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Addba request action frame received with the extension element from
certain 11ac stations, but the cmd id and length not matching to addba
extension and it failing in element parsing. Due to this, addba request
not acknowledged and aggregation not started which is causing low
throughput. Hence validating the cmd id before processing addba extension.

Signed-off-by: Govindaraj <gsamin@codeaurora.org>
---
 net/mac80211/agg-rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index cce28e3..ea473d7 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -494,7 +494,8 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 
 	ies_len = len - offsetof(struct ieee80211_mgmt,
 				 u.action.u.addba_req.variable);
-	if (ies_len) {
+	if (ies_len &&
+	    mgmt->u.action.u.addba_req.variable[0] == WLAN_EID_ADDBA_EXT) {
 		ieee802_11_parse_elems(mgmt->u.action.u.addba_req.variable,
                                 ies_len, true, &elems, mgmt->bssid, NULL);
 		if (elems.parse_error)
-- 
2.7.4

