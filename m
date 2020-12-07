Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1614E2D097C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 04:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgLGDgV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 22:36:21 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:16904 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGDgV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 22:36:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607312171; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=LNMOSKvGYcTzz1DReRMBlYYRtT9j0tvPhTJ05fd7Eao=; b=uwYylBtnZ2GLFyP5KV4N6Y+oQ+/sSs2l0bBJ1PXOf6gcoyl/LQ0knIg9GNV31R7Y16BEDXIk
 bccSAzh0VZtnYz0v+OqxtWtO6vBxRFlBOFUNVFTU893q2xWls3ffvD/9Swv9i4tbhwOEj4EZ
 sKpCWK0us71BRCU2vE7fYR0Y3IA=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fcda307dc0fd8a3173a29bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 03:35:35
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58C65C43462; Mon,  7 Dec 2020 03:35:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80016C433ED;
        Mon,  7 Dec 2020 03:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80016C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 2/2] ath10k: pass the ssid info to get the correct bss entity
Date:   Mon,  7 Dec 2020 11:36:35 +0800
Message-Id: <1607312195-3583-3-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607312195-3583-1-git-send-email-wgong@codeaurora.org>
References: <1607312195-3583-1-git-send-email-wgong@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When connect to an AP with WPA mode, ath10k need to set need_ptk_4_way to
firmware in WMI_PEER_ASSOC_CMD, then the data path is disallow in
firmware, it will be allowed untill firmware finish the 4 way handshake.

It failed with a test case with below steps:
1. configure AP with WPA mode with ssid1 SimpleConnect_a_orbvt_ch1,
   bssid1 and channel 1.
2. connect to ssid1 and ping success.
3. wait 10 seconds which is less than
   IEEE80211_SCAN_RESULT_EXPIRE(30 seconds).
4. configure AP with OPEN mode with ssid2 SimpleConnect_b_z3a00_ch1,
   but use same bssid1 and channel 1 of step 1.
5. disconnect ssid1.
6. connect to ssid2 and ping fail.

Fail reason:
When run step 6, ath10k_peer_assoc_h_crypto() called cfg80211_get_bss()
with bssid and chan info, but ssid1 and ssid2 have the same bssid and
channel, then there have 2 entry for ssid1 and ssid2 in cfg80211. The
ssid1's order is before ssid2 in bss_list, and ssid1's age is less than
the expire time which is IEEE80211_SCAN_RESULT_EXPIRE(30 seconds). Then
ssid1's entry is selected and ath10k_peer_assoc_h_crypto() parsed it and
get the rsnie and then need_ptk_4_way is set to firmware, so data path
is disallowed and it will not receive 4 way handshake for OPEN mode,
so ping fail in step 6.

This patch is to pass the ssid info to cfg80211_get_bss() as same as
cfg80211_mlme_assoc() and cfg80211_mlme_auth(), then it will find the
correct bss entry in above test case, then case success.

For AP mode, the ssid info is filled in ieee80211_start_ap(), for STATION
mode, it is filled in ieee80211_mgd_assoc(). Tested for both AP/STATION
mode with QCA6174 hw3.2 PCI, it is success start/connect/ping for
WPA/OPEN mode.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 82b4bf5ba612..67cb2efc72d9 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2177,7 +2177,8 @@ static void ath10k_peer_assoc_h_crypto(struct ath10k *ar,
 	if (WARN_ON(ath10k_mac_vif_chan(vif, &def)))
 		return;
 
-	bss = cfg80211_get_bss(ar->hw->wiphy, def.chan, info->bssid, NULL, 0,
+	bss = cfg80211_get_bss(ar->hw->wiphy, def.chan, info->bssid,
+			       info->ssid_len ? info->ssid : NULL, info->ssid_len,
 			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
 	if (bss) {
 		const struct cfg80211_bss_ies *ies;
-- 
2.23.0

