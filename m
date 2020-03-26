Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF73193E7C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgCZMBB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:01:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44098 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727991AbgCZMBA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:01:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHRBz-0003we-0t; Thu, 26 Mar 2020 14:00:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:00:33 +0200
Message-Id: <20200326120042.578777-4-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326120042.578777-1-luca@coelho.fi>
References: <20200326120042.578777-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] mac80211: Don't destroy auth data in case of anti-clogging
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

SAE AP may reject authentication with WLAN_STATUS_ANTI_CLOG_REQUIRED.
As the user space will immediately continue the authentication flow,
there is no need to destroy the authentication data in this case.
This saves unneeded station removal and releasing the channel.

Change-Id: I8040a842874aaf6d209df3fc8a2acb97a0bf508b
Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f1f518790c12..a0de21a51f65 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2948,10 +2948,15 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (status_code != WLAN_STATUS_SUCCESS) {
+		cfg80211_rx_mlme_mgmt(sdata->dev, (u8 *)mgmt, len);
+
+		if (auth_alg == WLAN_AUTH_SAE &&
+		    status_code == WLAN_STATUS_ANTI_CLOG_REQUIRED)
+			return;
+
 		sdata_info(sdata, "%pM denied authentication (status %d)\n",
 			   mgmt->sa, status_code);
 		ieee80211_destroy_auth_data(sdata, false);
-		cfg80211_rx_mlme_mgmt(sdata->dev, (u8 *)mgmt, len);
 		event.u.mlme.status = MLME_DENIED;
 		event.u.mlme.reason = status_code;
 		drv_event_callback(sdata->local, sdata, &event);
-- 
2.25.1

