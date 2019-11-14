Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C12CFBEE4
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 06:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfKNFA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 00:00:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35100 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfKNFA2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 00:00:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C87860D96; Thu, 14 Nov 2019 05:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573707627;
        bh=ctXjkgCpsp43C0Lz3c3lWtvVfW2eTKhURTiQ60BIdjc=;
        h=From:To:Cc:Subject:Date:From;
        b=TUvyGYR+LuXA03UJFf7WudN44yzYTn2FTsA4vtIDdcVp0ASmhiDUY50qq4Fg8wWH7
         L5D4sE5VJ149ZWl/GHVL4mJXEoTin768BnfzNGTiXfFiM+eKWVVRtbtBh0ep55AyS+
         gGTJ2MSHiqepD7n3dlC4X7KogCIxmRtD9IUGwHAA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D209660540;
        Thu, 14 Nov 2019 05:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573707626;
        bh=ctXjkgCpsp43C0Lz3c3lWtvVfW2eTKhURTiQ60BIdjc=;
        h=From:To:Cc:Subject:Date:From;
        b=YS4HCOOxCQtbPBVahbqz9m+tv8Rxcq32dh5YLFejJn5gbm3TJYAF5IM/COBgmnkKD
         tzNd6Z7Aq4RNeLz5EIzLayCQ1ns3zdefL0R6vckUAKfvwNjGLGWQPQJBddUSWsFbQR
         LG708xnK1O5jOjQijC9h9cylNrZOR7uz7WDbIgbo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D209660540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] ath10k: remove the max_sched_scan_reqs value
Date:   Thu, 14 Nov 2019 13:00:01 +0800
Message-Id: <20191114050001.4658-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The struct cfg80211_wowlan of NET_DETECT WoWLAN feature share the same
struct cfg80211_sched_scan_request together with scheduled scan request
feature, and max_sched_scan_reqs of wiphy is only used for sched scan,
and ath10k does not support scheduled scan request feature, so ath10k
does not set flag NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR, but ath10k
set max_sched_scan_reqs of wiphy to a non zero value 1, then function
nl80211_add_commands_unsplit of cfg80211 will set it support command
NL80211_CMD_START_SCHED_SCAN because max_sched_scan_reqs is a non zero
value, but actually ath10k not support it, then it leads a mismatch result
for sched scan of cfg80211, then application shill found the mismatch and
stop running case of MAC random address scan and then the case fail.

After remove max_sched_scan_reqs value, it keeps match for sched scan and
case of MAC random address scan pass.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
Tested with QCA6174 PCIe with firmware WLAN.RM.4.4.1-00110-QCARMSWP-1.

Fixes: ce834e280f2f875 ("ath10k: support NET_DETECT WoWLAN feature")
Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: change commit log
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

