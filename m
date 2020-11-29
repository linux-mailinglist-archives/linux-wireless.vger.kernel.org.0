Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5EE2C79C0
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgK2Pbu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:50 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33550 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727879AbgK2Pbu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:50 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfH-0035ld-7V; Sun, 29 Nov 2020 17:31:03 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:50 +0200
Message-Id: <iwlwifi.20201129172929.9491a12f9226.Ia9c5b24fcefc5ce5592537507243391633a27e5f@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/13] nl80211: always accept scan request with the duration set
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Accept a scan request with the duration set even if the driver
does not support setting the scan dwell. The duration can be used
as a hint to the driver, but the driver may use its internal logic
for setting the scan dwell.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/nl80211.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 643000200a1b..67c52f4b45fa 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8243,12 +8243,6 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_MEASUREMENT_DURATION]) {
-		if (!wiphy_ext_feature_isset(wiphy,
-					NL80211_EXT_FEATURE_SET_SCAN_DWELL)) {
-			err = -EOPNOTSUPP;
-			goto out_free;
-		}
-
 		request->duration =
 			nla_get_u16(info->attrs[NL80211_ATTR_MEASUREMENT_DURATION]);
 		request->duration_mandatory =
-- 
2.29.2

