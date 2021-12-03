Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636A9467137
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 05:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244402AbhLCEpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 23:45:49 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:25595 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbhLCEps (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 23:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638506545; x=1670042545;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=L7S6oop29zMntPxyWF9hADZj3qkdZirmfuChH+1doTA=;
  b=ZzDGat39okGdP6YHrKspMiFcwwomzqQDi7fx3kFlaqGIT2vpLYVcwTDn
   m1znzXxRB7nOlmbwYckuYQlstiO7icRmWbWE5VDZ0/DP/KFFZ+OHYD/Dp
   eaBDWQpM9WIIZFFHSAJw5S3Sju2O3uzpbdnwQ8vzTiTBDojwLhz/bcCYf
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 02 Dec 2021 20:42:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 20:42:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 20:42:24 -0800
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 20:42:22 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH] mac80211: disable BSS color collision detection in case of no free colors
Date:   Fri, 3 Dec 2021 10:11:47 +0530
Message-ID: <1638506507-21139-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lavanya Suresh <lavaks@codeaurora.org>

AP may run out of BSS color after color collision
detection event from driver.
Disable BSS color collision detection if no free colors are available
based on bss color disabled bit of he_oper_params in beacon.
It can be reenabled once new color is available.

Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 include/linux/ieee80211.h |  1 +
 net/mac80211/cfg.c        | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 11d7af2..cc629d7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1874,6 +1874,7 @@ struct ieee80211_he_mcs_nss_supp {
 	__le16 tx_mcs_80p80;
 } __packed;
 
+#define HE_OPERATION_BSS_COLOR_DISABLED		((u32)BIT(31))
 /**
  * struct ieee80211_he_operation - HE capabilities element
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f36f249..eaa04b7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -995,6 +995,8 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
 	int size, err;
+	const u8 *cap;
+	struct ieee80211_he_operation *he_oper = NULL;
 	u32 changed = BSS_CHANGED_BEACON;
 
 	old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -1082,6 +1084,27 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		changed |= BSS_CHANGED_FTM_RESPONDER;
 	}
 
+	if (sdata->vif.bss_conf.he_support) {
+		cap = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_OPERATION,
+					   params->tail, params->tail_len);
+		if (cap && cap[1] >= sizeof(*he_oper) + 1)
+			he_oper = (void *)(cap + 3);
+
+		if (he_oper) {
+			if (he_oper->he_oper_params & HE_OPERATION_BSS_COLOR_DISABLED) {
+				if (sdata->vif.bss_conf.he_bss_color.enabled) {
+					sdata->vif.bss_conf.he_bss_color.enabled = false;
+					changed |= BSS_CHANGED_HE_BSS_COLOR;
+				}
+			} else {
+				if (!sdata->vif.bss_conf.he_bss_color.enabled) {
+					sdata->vif.bss_conf.he_bss_color.enabled = true;
+					changed |= BSS_CHANGED_HE_BSS_COLOR;
+				}
+			}
+		}
+	}
+
 	rcu_assign_pointer(sdata->u.ap.beacon, new);
 
 	if (old)
-- 
2.7.4

