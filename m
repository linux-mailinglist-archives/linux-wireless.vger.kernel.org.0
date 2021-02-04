Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669E730F41F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 14:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhBDNqV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Feb 2021 08:46:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43658 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236440AbhBDNpn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Feb 2021 08:45:43 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7ew4-0044Fb-68; Thu, 04 Feb 2021 15:44:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  4 Feb 2021 15:44:39 +0200
Message-Id: <iwlwifi.20210204154439.6c884ea7281c.I257278d03b0c1ae0aa6631672cfa48f1a95d5996@changeid>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH] cfg80211: initialize reg_rule in __freq_reg_info()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Sparse started warning on this function because we can potentially
return an uninitialized value.  The reason is that if the caller
passes a min_bw value that is higher then the last value in bws[], we
will not go into the loop and reg_rule will remain initialized.  This
cannot happen because the only caller of this function uses either 1
or 20 in min_bw, but the function will be more robust if we
pre-initialize the value.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 452b698f42be..21536c48deec 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1629,7 +1629,7 @@ __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 {
 	const struct ieee80211_regdomain *regd = reg_get_regdomain(wiphy);
 	static const u32 bws[] = {0, 1, 2, 4, 5, 8, 10, 16, 20};
-	const struct ieee80211_reg_rule *reg_rule;
+	const struct ieee80211_reg_rule *reg_rule = ERR_PTR(-ERANGE);
 	int i = ARRAY_SIZE(bws) - 1;
 	u32 bw;
 
-- 
2.30.0

