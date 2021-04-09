Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F08E359975
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhDIJkt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 05:40:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44248 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230181AbhDIJks (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 05:40:48 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUncv-000ELR-4r; Fri, 09 Apr 2021 12:40:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:18 +0300
Message-Id: <iwlwifi.20210409123755.ba2ea961f4ae.I8fde32d3196e860efa3b4ec464c42194195b42ec@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 05/15] cfg80211: don't WARN if a self-managed device doesn't have a regdom
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This can happen if it booted in RF-Kill and didn't have a
chance to get its regulatory domain yet.
This can happen for example if hostapd is started on a device
that is blocked by RF-Kill.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/nl80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 521d36bb0803..f56307185b8a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7742,8 +7742,8 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
 			       REGULATORY_WIPHY_SELF_MANAGED;
 		regdom = get_wiphy_regdom(wiphy);
 
-		/* a self-managed-reg device must have a private regdom */
-		if (WARN_ON(!regdom && self_managed)) {
+		/* a self-managed-reg device should have a private regdom */
+		if (!regdom && self_managed) {
 			nlmsg_free(msg);
 			rtnl_unlock();
 			return -EINVAL;
-- 
2.31.0

