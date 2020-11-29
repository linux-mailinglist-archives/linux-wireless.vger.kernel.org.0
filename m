Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAE42C79C1
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgK2Pbv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:51 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33556 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728008AbgK2Pbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:51 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfH-0035ld-S0; Sun, 29 Nov 2020 17:31:04 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:51 +0200
Message-Id: <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/13] cfg80211: Save the regulatory domain when setting custom regulatory
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When custom regulatory was set, only the channels setting was updated, but
the regulatory domain was not saved. Fix it by saving it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/reg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index a04fdfb35f07..094492b62f8a 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2547,6 +2547,7 @@ static void handle_band_custom(struct wiphy *wiphy,
 void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
 				   const struct ieee80211_regdomain *regd)
 {
+	const struct ieee80211_regdomain *new_regd, *tmp;
 	enum nl80211_band band;
 	unsigned int bands_set = 0;
 
@@ -2566,6 +2567,13 @@ void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
 	 * on your device's supported bands.
 	 */
 	WARN_ON(!bands_set);
+	new_regd = reg_copy_regd(regd);
+	if (IS_ERR(new_regd))
+		return;
+
+	tmp = get_wiphy_regdom(wiphy);
+	rcu_assign_pointer(wiphy->regd, new_regd);
+	rcu_free_regdom(tmp);
 }
 EXPORT_SYMBOL(wiphy_apply_custom_regulatory);
 
-- 
2.29.2

