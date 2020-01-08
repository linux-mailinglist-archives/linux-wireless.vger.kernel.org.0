Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF6134142
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 12:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgAHLzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 06:55:41 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:50295 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgAHLzl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 06:55:41 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 6A8CC58006C;
        Wed,  8 Jan 2020 12:55:39 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        stable@vger.kernel.org
Subject: [PATCH] cfg80211: fix deadlocks in autodisconnect work
Date:   Wed,  8 Jan 2020 12:55:36 +0100
Message-Id: <20200108115536.2262-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use methods which do not try to acquire the wdev lock themselves.

Cc: stable@vger.kernel.org
Fixes: 37b1c004685a3 ("cfg80211: Support all iftypes in autodisconnect_wk")
Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/wireless/sme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 7a6c38ddc65a..d32a2ec4d96a 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1307,14 +1307,14 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 	if (wdev->conn_owner_nlportid) {
 		switch (wdev->iftype) {
 		case NL80211_IFTYPE_ADHOC:
-			cfg80211_leave_ibss(rdev, wdev->netdev, false);
+			__cfg80211_leave_ibss(rdev, wdev->netdev, false);
 			break;
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_P2P_GO:
-			cfg80211_stop_ap(rdev, wdev->netdev, false);
+			__cfg80211_stop_ap(rdev, wdev->netdev, false);
 			break;
 		case NL80211_IFTYPE_MESH_POINT:
-			cfg80211_leave_mesh(rdev, wdev->netdev);
+			__cfg80211_leave_mesh(rdev, wdev->netdev);
 			break;
 		case NL80211_IFTYPE_STATION:
 		case NL80211_IFTYPE_P2P_CLIENT:
-- 
2.24.1

