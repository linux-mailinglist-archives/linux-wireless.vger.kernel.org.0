Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD219A37
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 11:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfEJJFC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 05:05:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfEJJFC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 05:05:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6FA460592; Fri, 10 May 2019 09:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557479100;
        bh=blmfcAf7YUjIe9vLn0MW8s7FG+amc+L9kkZ+TyFU7Yg=;
        h=From:To:Cc:Subject:Date:From;
        b=D1qnQwH8/nmjaL7A+ilCkNk+igIzrHkEU7lnTQA1Lt0lqQRgxx2/Q0bg0T0edl39a
         +p/+nIrAiz1xAw6vqXQXCJCA8o3TlLwr/fS4gnFSaqA+v+dw8rmAsZeOJ+B67f1dSe
         TYRivjOWZPFW86kDmRM5qBP7u/NLwyLLxvso3SPA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from yyuwang-64bit.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yyuwang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35B7A6028D;
        Fri, 10 May 2019 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557479100;
        bh=blmfcAf7YUjIe9vLn0MW8s7FG+amc+L9kkZ+TyFU7Yg=;
        h=From:To:Cc:Subject:Date:From;
        b=D1qnQwH8/nmjaL7A+ilCkNk+igIzrHkEU7lnTQA1Lt0lqQRgxx2/Q0bg0T0edl39a
         +p/+nIrAiz1xAw6vqXQXCJCA8o3TlLwr/fS4gnFSaqA+v+dw8rmAsZeOJ+B67f1dSe
         TYRivjOWZPFW86kDmRM5qBP7u/NLwyLLxvso3SPA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35B7A6028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yyuwang@codeaurora.org
From:   Yu Wang <yyuwang@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Yu Wang <yyuwang@codeaurora.org>
Subject: [PATCH] mac80211: handle deauthentication/disassociation from TDLS peer
Date:   Fri, 10 May 2019 17:04:52 +0800
Message-Id: <1557479092-18276-1-git-send-email-yyuwang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When receiving a deauthentication/disassociation frame from a TDLS
peer, a station should not disconnect the current AP, but only
disable the current TDLS link if it's enabled.

Without this change, a TDLS issue can be reproduced by following the
steps as below:

1. STA-1 and STA-2 are connected to AP, bidirection traffic is running
   between STA-1 and STA-2.
2. Set up TDLS link between STA-1 and STA-2, stay for a while, then
   teardown TDLS link.
3. Repeat step #2 and monitor the connection between STA and AP.

During the test, one STA may send a deauthentication/disassociation
frame to another, after TDLS teardown, with reason code 6/7, which
means: Class 2/3 frame received from nonassociated STA.

On receive this frame, the receiver STA will disconnect the current
AP and then reconnect. It's not a expected behavior, purpose of this
frame should be disabling the TDLS link, not the link with AP.

Signed-off-by: Yu Wang <yyuwang@codeaurora.org>
---
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/mlme.c        | 12 +++++++++++-
 net/mac80211/tdls.c        | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 861bf83..3a360b0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2223,6 +2223,9 @@ void ieee80211_tdls_cancel_channel_switch(struct wiphy *wiphy,
 					  const u8 *addr);
 void ieee80211_teardown_tdls_peers(struct ieee80211_sub_if_data *sdata);
 void ieee80211_tdls_chsw_work(struct work_struct *wk);
+void ieee80211_tdls_handle_disconnect(struct ieee80211_sub_if_data *sdata,
+				      const u8 *peer, u16 reason);
+const char *ieee80211_get_reason_code_string(u16 reason_code);
 
 extern const struct ethtool_ops ieee80211_ethtool_ops;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b7a9fe3..383b0df 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2963,7 +2963,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 #define case_WLAN(type) \
 	case WLAN_REASON_##type: return #type
 
-static const char *ieee80211_get_reason_code_string(u16 reason_code)
+const char *ieee80211_get_reason_code_string(u16 reason_code)
 {
 	switch (reason_code) {
 	case_WLAN(UNSPECIFIED);
@@ -3028,6 +3028,11 @@ static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data *sdata,
 	if (len < 24 + 2)
 		return;
 
+	if (!ether_addr_equal(mgmt->bssid, mgmt->sa)) {
+		ieee80211_tdls_handle_disconnect(sdata, mgmt->sa, reason_code);
+		return;
+	}
+
 	if (ifmgd->associated &&
 	    ether_addr_equal(mgmt->bssid, ifmgd->associated->bssid)) {
 		const u8 *bssid = ifmgd->associated->bssid;
@@ -3077,6 +3082,11 @@ static void ieee80211_rx_mgmt_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	reason_code = le16_to_cpu(mgmt->u.disassoc.reason_code);
 
+	if (!ether_addr_equal(mgmt->bssid, mgmt->sa)) {
+		ieee80211_tdls_handle_disconnect(sdata, mgmt->sa, reason_code);
+		return;
+	}
+
 	sdata_info(sdata, "disassociated from %pM (Reason: %u=%s)\n",
 		   mgmt->sa, reason_code,
 		   ieee80211_get_reason_code_string(reason_code));
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index d30690d..fcc5cd4 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1994,3 +1994,26 @@ void ieee80211_tdls_chsw_work(struct work_struct *wk)
 	}
 	rtnl_unlock();
 }
+
+void ieee80211_tdls_handle_disconnect(struct ieee80211_sub_if_data *sdata,
+				      const u8 *peer, u16 reason)
+{
+	struct ieee80211_sta *sta;
+
+	rcu_read_lock();
+	sta = ieee80211_find_sta(&sdata->vif, peer);
+	if (!sta || !sta->tdls) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	tdls_dbg(sdata, "disconnected from TDLS peer %pM (Reason: %u=%s)\n",
+		 peer, reason,
+		 ieee80211_get_reason_code_string(reason));
+
+	ieee80211_tdls_oper_request(&sdata->vif, peer,
+				    NL80211_TDLS_TEARDOWN,
+				    WLAN_REASON_TDLS_TEARDOWN_UNREACHABLE,
+				    GFP_ATOMIC);
+}
-- 
2.7.4

