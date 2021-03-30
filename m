Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A6B34DD9C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 03:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC3Bfy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Mar 2021 21:35:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26094 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhC3Bff (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Mar 2021 21:35:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617068135; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4BCrNI1yhpcr/1d3immVsDCuKMRFgozFJisgtc27FsE=; b=p03yD/7ReliCE0k0P6qjray2JKMdJ74YwVl9akWmcrbO11bFKIqp7pdvINwl1nAbLrdb8Oaj
 cSt89EHo2gyk8U/JbPQ7Eh2vSk1Q9/e6qYC2faAP69ehocuakVJCN/z5qVrDuKbdRuYTb5/f
 hydkJsZYWqJWbwSYJ7+eI4a4KjM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 606280663f4005d075a1a478 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Mar 2021 01:35:34
 GMT
Sender: srirrama=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6FFEC433ED; Tue, 30 Mar 2021 01:35:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from srirrama-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBA50C43461;
        Tue, 30 Mar 2021 01:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBA50C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>
Subject: [PATCH] mac80211: Allow concurrent monitor iface and ethernet rx decap
Date:   Tue, 30 Mar 2021 07:05:16 +0530
Message-Id: <1617068116-32253-1-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some HW/driver can support passing ethernet rx decap frames and raw 802.11
frames for the monitor interface concurrently and through separately
calls to ieee80211_rx_napi(). Also packets to monitor interface
doesnt have RX_FLAG_8023 set and can set RX_FLAG_ONLY_MONITOR to
pass them to monitor interface exclusively.
Such drivers can enable the SUPPORTS_CONC_MON_RX_DECAP flag to allow
this using ethernet decap offload while monitor interface is active.

Currently the RX DECAP Offload gets disabled when a monitor
interface is up.

Signed-off-by: Sriram R <srirrama@codeaurora.org>
---
 include/net/mac80211.h | 4 ++++
 net/mac80211/debugfs.c | 1 +
 net/mac80211/iface.c   | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 2d1d629..6b6901b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2399,6 +2399,9 @@ struct ieee80211_txq {
  * @IEEE80211_HW_SUPPORTS_RX_DECAP_OFFLOAD: Hardware supports rx decapsulation
  *	offload
  *
+ * @IEEE80211_HW_SUPPORTS_CONC_MON_RX_DECAP: Hardware supports concurrent rx
+ *	decapsulation offload and passing raw 802.11 frames for monitor iface.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2453,6 +2456,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT,
 	IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD,
 	IEEE80211_HW_SUPPORTS_RX_DECAP_OFFLOAD,
+	IEEE80211_HW_SUPPORTS_CONC_MON_RX_DECAP,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 5296898..9245c04 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -456,6 +456,7 @@ static const char *hw_flag_names[] = {
 	FLAG(AMPDU_KEYBORDER_SUPPORT),
 	FLAG(SUPPORTS_TX_ENCAP_OFFLOAD),
 	FLAG(SUPPORTS_RX_DECAP_OFFLOAD),
+	FLAG(SUPPORTS_CONC_MON_RX_DECAP),
 #undef FLAG
 };
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b80c9b0..b1c1709 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -807,7 +807,8 @@ static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdat
 	    ieee80211_iftype_supports_hdr_offload(sdata->vif.type)) {
 		flags |= IEEE80211_OFFLOAD_DECAP_ENABLED;
 
-		if (local->monitors)
+		if (local->monitors &&
+		    !ieee80211_hw_check(&local->hw, SUPPORTS_CONC_MON_RX_DECAP))
 			flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
 	} else {
 		flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
-- 
2.7.4

