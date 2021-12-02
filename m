Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D248465BC4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 02:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbhLBBm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 20:42:59 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27427 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344264AbhLBBmw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 20:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638409171; x=1669945171;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5Jpoy9R7KH6gf19AqIhqPt4IRn3a6PsmW6x2DFRclW8=;
  b=GXr2iZrwbtPmm5eUOEmueU0Rihfh9r6MCDgVXz3GuOK8l7lupLqaiyLX
   MBfTlEJ6WTtTpkPKyt3vMLaueO0B/cu6OTMzfnpaqhUAkACP3jMGyxioM
   +Xj4OM+p2AJax3n0R94o5Fw5syugX67wOGhKeGwOYD9t3/nvEQ8TcdHBz
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 Dec 2021 17:39:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 17:39:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 17:39:29 -0800
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 17:39:27 -0800
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH] cfg80211: Enable regulatory enforcement checks for drivers supporting mesh iface
Date:   Thu, 2 Dec 2021 07:08:40 +0530
Message-ID: <1638409120-28997-1-git-send-email-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently cfg80211 checks for invalid channels whenever there is a
regulatory update and stops the active interfaces if it is operating on
an unsupported channel in the new regulatory domain.

This is done based on a regulatory flag REGULATORY_IGNORE_STALE_KICKOFF
set during wiphy registration which disables this enforcement when
unsupported interface modes are supported by driver.

Add support to enable this enforcement when Mesh Point interface type
is advertised by drivers.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 net/wireless/core.c | 1 +
 net/wireless/reg.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index c4ea903..f244f15 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -736,6 +736,7 @@ int wiphy_register(struct wiphy *wiphy)
 	if (wiphy->interface_modes & ~(BIT(NL80211_IFTYPE_STATION) |
 				       BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				       BIT(NL80211_IFTYPE_AP) |
+				       BIT(NL80211_IFTYPE_MESH_POINT) |
 				       BIT(NL80211_IFTYPE_P2P_GO) |
 				       BIT(NL80211_IFTYPE_ADHOC) |
 				       BIT(NL80211_IFTYPE_P2P_DEVICE) |
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index df87c7f..58e4b33 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2349,6 +2349,7 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	switch (iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_MESH_POINT:
 		if (!wdev->beacon_interval)
 			goto wdev_inactive_unlock;
 		chandef = wdev->chandef;
@@ -2387,6 +2388,7 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_MESH_POINT:
 		return cfg80211_reg_can_beacon_relax(wiphy, &chandef, iftype);
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-- 
2.7.4

