Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C736F4E2033
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 06:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbiCUFpR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 01:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbiCUFpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 01:45:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68523467E
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 22:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647841432; x=1679377432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bX/wltRAcwz+t1OSIXOTT7Xb0j5/zg7RTcvJPFmWv4=;
  b=HGuh1kheyWCzgKwHH3P0cBqTvD0/oPPUwMe+WG9f2zvG5gUCiTCa+M/0
   yfaa5Lnub2E2OONdpB1TWeUHYXIUvVDzJbYutn9EHW+zOKrEMsqw/1gjL
   muGXT5nCYuUhRbeVZRSsmNLmUKe1vKBoszGOuaabOhvEb0Muo9DLmY39v
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 20 Mar 2022 22:43:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 22:43:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 20 Mar 2022 22:43:50 -0700
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 20 Mar 2022 22:43:48 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 1/2] mac80211: add support to configure 6GHz non-ht duplicate transmission
Date:   Mon, 21 Mar 2022 11:13:14 +0530
Message-ID: <1647841395-20213-2-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647841395-20213-1-git-send-email-quic_ramess@quicinc.com>
References: <1647841395-20213-1-git-send-email-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
 include/net/mac80211.h |  3 +++
 net/mac80211/cfg.c     | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c50221d..1472ca0 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -630,6 +630,8 @@ struct ieee80211_fils_discovery {
  * @unsol_bcast_probe_resp_interval: Unsolicited broadcast probe response
  *	interval.
  * @s1g: BSS is S1G BSS (affects Association Request format).
+ * @he_6g_nonht_dup_beacon_set: if set, indicates that HE 6GHz non-HT duplicate
+ *	beacon transmission is enabled for this BSS.
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
  * @power_type: power type of BSS for 6 GHz
@@ -704,6 +706,7 @@ struct ieee80211_bss_conf {
 	struct cfg80211_he_bss_color he_bss_color;
 	struct ieee80211_fils_discovery fils_discovery;
 	u32 unsol_bcast_probe_resp_interval;
+	bool he_6g_nonht_dup_beacon_set;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
 	enum ieee80211_ap_reg_power power_type;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87a2080..077e1bd 100644
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
@@ -1084,6 +1087,18 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		changed |= BSS_CHANGED_FTM_RESPONDER;
 	}
 
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION,
+				     params->tail, params->tail_len);
+	if (cap && cap->datalen >= sizeof(*he_oper) + 1) {
+		he_oper = (void *)(cap->data + 1);
+		he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
+		if (he_6ghz_oper) {
+			sdata->vif.bss_conf.he_6g_nonht_dup_beacon_set = false;
+			if (he_6ghz_oper->control & IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON)
+				sdata->vif.bss_conf.he_6g_nonht_dup_beacon_set = true;
+		}
+	}
+
 	rcu_assign_pointer(sdata->u.ap.beacon, new);
 
 	if (old)
-- 
2.7.4

