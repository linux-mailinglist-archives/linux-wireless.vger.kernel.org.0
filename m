Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6EFF884E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 06:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfKLF5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 00:57:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfKLF5m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 00:57:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6503860B6E; Tue, 12 Nov 2019 05:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573538261;
        bh=mzx3N3lG/Lol6wL/LRDhTGjC7TPVERY5qOz0pGET1OU=;
        h=From:To:Cc:Subject:Date:From;
        b=itahC21ABcqmxIGW5W3fbeBqhryQTyVzfqvhVRn2W+RmNxGWVjF19PEe0E6Pgfqwa
         SZdcWL2IbB+6U6dd7b4n62282HC4yl5lllW9UZyBtPjBjsEn18cw3yBjjPM5s5Gm3H
         s9eiV0EIQfiGR2wmN9Ie4QxhvmLSqj4XfZFPLHQc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36B7460CED;
        Tue, 12 Nov 2019 05:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573538261;
        bh=mzx3N3lG/Lol6wL/LRDhTGjC7TPVERY5qOz0pGET1OU=;
        h=From:To:Cc:Subject:Date:From;
        b=itahC21ABcqmxIGW5W3fbeBqhryQTyVzfqvhVRn2W+RmNxGWVjF19PEe0E6Pgfqwa
         SZdcWL2IbB+6U6dd7b4n62282HC4yl5lllW9UZyBtPjBjsEn18cw3yBjjPM5s5Gm3H
         s9eiV0EIQfiGR2wmN9Ie4QxhvmLSqj4XfZFPLHQc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36B7460CED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: remove the max_sched_scan_reqs value
Date:   Tue, 12 Nov 2019 13:57:28 +0800
Message-Id: <20191112055728.28847-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k do not support NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR, if
set max_sched_scan_reqs to a non zero value, then nl80211_add_commands_unsplit
will set a SCHED_SCAN attribute, some application tool will use this attribute
to check mac random support, when it check SCHED_SCAN has set and not
set NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR, it will report mac random
not support.

Remove the max_sched_scan_reqs value will pass the application tool's
check and pass test case of random mac address.

testd with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Fixes: ce834e280f2f875 ("ath10k: support NET_DETECT WoWLAN feature")
Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index e8bdb2ba9b18..9aa499b0527e 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8902,7 +8902,6 @@ int ath10k_mac_register(struct ath10k *ar)
 	ar->hw->wiphy->max_scan_ie_len = WLAN_SCAN_PARAMS_MAX_IE_LEN;
 
 	if (test_bit(WMI_SERVICE_NLO, ar->wmi.svc_map)) {
-		ar->hw->wiphy->max_sched_scan_reqs = 1;
 		ar->hw->wiphy->max_sched_scan_ssids = WMI_PNO_MAX_SUPP_NETWORKS;
 		ar->hw->wiphy->max_match_sets = WMI_PNO_MAX_SUPP_NETWORKS;
 		ar->hw->wiphy->max_sched_scan_ie_len = WMI_PNO_MAX_IE_LENGTH;
-- 
2.23.0

