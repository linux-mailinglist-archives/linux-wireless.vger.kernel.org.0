Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81244473A7
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfFPHeQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:34:16 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:36718 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbfFPHeP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:34:15 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:15 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499831"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:10 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 01/11] wil6210: do not reset FW in STA to P2P client interface switch
Date:   Sun, 16 Jun 2019 10:25:57 +0300
Message-Id: <1560669967-23706-2-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alexei Avshalom Lazar <ailizaro@codeaurora.org>

Currently the FW is reset on every interface type change, because
of various FW bugs.
FW reset is not required when switching from STA to P2P client, hence
can be skipped.

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index e9780fc..1a4223f 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -643,6 +643,16 @@ static int wil_cfg80211_del_iface(struct wiphy *wiphy,
 	return rc;
 }
 
+static bool wil_is_safe_switch(enum nl80211_iftype from,
+			       enum nl80211_iftype to)
+{
+	if (from == NL80211_IFTYPE_STATION &&
+	    to == NL80211_IFTYPE_P2P_CLIENT)
+		return true;
+
+	return false;
+}
+
 static int wil_cfg80211_change_iface(struct wiphy *wiphy,
 				     struct net_device *ndev,
 				     enum nl80211_iftype type,
@@ -668,7 +678,8 @@ static int wil_cfg80211_change_iface(struct wiphy *wiphy,
 	 * because it can cause significant disruption
 	 */
 	if (!wil_has_other_active_ifaces(wil, ndev, true, false) &&
-	    netif_running(ndev) && !wil_is_recovery_blocked(wil)) {
+	    netif_running(ndev) && !wil_is_recovery_blocked(wil) &&
+	    !wil_is_safe_switch(wdev->iftype, type)) {
 		wil_dbg_misc(wil, "interface is up. resetting...\n");
 		mutex_lock(&wil->mutex);
 		__wil_down(wil);
-- 
1.9.1

