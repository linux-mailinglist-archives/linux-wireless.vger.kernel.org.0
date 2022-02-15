Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745964B6660
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiBOIoB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 03:44:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiBOIn7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 03:43:59 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF7111DFD
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 00:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644914630; x=1676450630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iSfWR1zZLuPXVLfsryJMksusx1cFvAT3XIXOwbIuu0=;
  b=TZC9Shz5kOa0IgZsZK+PGMXa+qHOdkN6GQbWZG2e6lw8MSEkUc8STsh4
   5k1jB/ShSCneQXFT7SauqQChSxO0LnkFF2X9QR6UmQ+vGPlZtIxatIB3a
   1CKgAjRw7etT7ot8PvMxPKWSN9d/TdgiONBGzCf+fS0tBYnwcHpwwJjtK
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 15 Feb 2022 00:43:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:43:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 00:43:49 -0800
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 00:43:47 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht duplicate transmission
Date:   Tue, 15 Feb 2022 14:13:00 +0530
Message-ID: <1644914581-21682-2-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
References: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A 6GHz AP can decide to transmit Beacon, Broadcast probe response
and FILS discovery frames in a non-HT duplicate PPDU when
operating in non 20MHz Bandwidth to enhance its discoverability.
(IEEE Std 802.11ax‐2021-26.17.2.2)

Add changes to configure 6GHz non-HT duplicate beacon transmission
based on Duplicate Beacon subfield of 6GHz Operation Information
field of the HE Operation element in Beacon.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 include/net/mac80211.h |  1 +
 net/mac80211/cfg.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c50221d..a4b1efb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -704,6 +704,7 @@ struct ieee80211_bss_conf {
 	struct cfg80211_he_bss_color he_bss_color;
 	struct ieee80211_fils_discovery fils_discovery;
 	u32 unsol_bcast_probe_resp_interval;
+	bool he_6g_nonht_dup_beacon_set;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
 	enum ieee80211_ap_reg_power power_type;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87a2080..9b6f55e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -997,6 +997,9 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
 	int size, err;
+	const struct element *cap;
+	struct ieee80211_he_operation *he_oper;
+	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
 	u32 changed = BSS_CHANGED_BEACON;
 
 	old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -1084,6 +1087,20 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		changed |= BSS_CHANGED_FTM_RESPONDER;
 	}
 
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION,
+				     params->tail, params->tail_len);
+	if (cap && cap->datalen >= sizeof(*he_oper) + 1) {
+		he_oper = (void *)(cap->data + 1);
+		he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
+		if (he_6ghz_oper) {
+			sdata->vif.bss_conf.he_6g_nonht_dup_beacon_set = false;
+			if (u8_get_bits(he_6ghz_oper->control,
+					IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON)) {
+				sdata->vif.bss_conf.he_6g_nonht_dup_beacon_set = true;
+			}
+		}
+	}
+
 	rcu_assign_pointer(sdata->u.ap.beacon, new);
 
 	if (old)
-- 
2.7.4

