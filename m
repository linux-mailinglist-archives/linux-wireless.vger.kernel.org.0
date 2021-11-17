Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD2454540
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 11:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhKQLAh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 06:00:37 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:65332 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231591AbhKQLAh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 06:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637146659; x=1668682659;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=rwOghEdIOZFFoUvd3qik+5gdYmk9jrDqI3waHq523wA=;
  b=PaPaAvi/gi7yLxa2D7u0NTysueG2/qqNCmARv7e4VfLfUFzQ+GYR7qvu
   emdV8+nxG0ydsHRJA1DUaS3Dkp+bWWCPmSQH3eFGF5DlByamn2Rg3193J
   lun1zaf6Dvwh1U6JoYPssq/YLLCBCzTJKQ5CeUs9uuy7dvF4Z/3zPFqxm
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Nov 2021 02:57:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 02:57:37 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 17 Nov 2021 02:57:36 -0800
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 17 Nov 2021 02:57:34 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_ramess@quicinc.com>
Subject: [PATCH] mac80211: notify non-transmitting BSS of color changes
Date:   Wed, 17 Nov 2021 16:27:27 +0530
Message-ID: <1637146647-16282-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

When color change is triggered in multiple bssid case, allow
only for transmitting BSS, and when it changes its bss color,
notify the non transmitting BSSs also of the new bss color.

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

---
 net/mac80211/cfg.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e2b791c..f36f249 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4264,6 +4264,21 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_sub_if_data *sdata,
 	changed |= BSS_CHANGED_HE_BSS_COLOR;
 
 	ieee80211_bss_info_change_notify(sdata, changed);
+
+	if (!sdata->vif.bss_conf.nontransmitted && sdata->vif.mbssid_tx_vif) {
+		struct ieee80211_sub_if_data *child;
+
+		mutex_lock(&sdata->local->iflist_mtx);
+		list_for_each_entry(child, &sdata->local->interfaces, list) {
+			if (child != sdata && child->vif.mbssid_tx_vif == &sdata->vif) {
+				child->vif.bss_conf.he_bss_color.color = color;
+				child->vif.bss_conf.he_bss_color.enabled = enable;
+				ieee80211_bss_info_change_notify(child,
+								 BSS_CHANGED_HE_BSS_COLOR);
+			}
+		}
+		mutex_unlock(&sdata->local->iflist_mtx);
+	}
 }
 
 static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
@@ -4348,6 +4363,9 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 
 	sdata_assert_lock(sdata);
 
+	if (sdata->vif.bss_conf.nontransmitted)
+		return -EINVAL;
+
 	mutex_lock(&local->mtx);
 
 	/* don't allow another color change if one is already active or if csa
-- 
2.7.4

