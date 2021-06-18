Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662E53AC943
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhFRK6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:58:41 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48248 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229550AbhFRK6k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:58:40 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBxC-001YXx-VN; Fri, 18 Jun 2021 13:42:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:56 +0300
Message-Id: <iwlwifi.20210618133832.853ffdd6c62b.I63e37b2ab184ee3653686e4df4dd23eb303687d2@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 31/31] cfg80211: reg: improve bad regulatory warning
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's a WARN_ON here but it says nothing, and the later
dump of the regdomain aren't usually printed. As a first
step, include the regdomain code in the WARN_ON message,
just like in other similar instances.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/reg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0df048bd4b84..c2d0ff7f089f 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3975,7 +3975,9 @@ static int __regulatory_set_wiphy_regd(struct wiphy *wiphy,
 		 "wiphy should have REGULATORY_WIPHY_SELF_MANAGED\n"))
 		return -EPERM;
 
-	if (WARN(!is_valid_rd(rd), "Invalid regulatory domain detected\n")) {
+	if (WARN(!is_valid_rd(rd),
+		 "Invalid regulatory domain detected: %c%c\n",
+		 rd->alpha2[0], rd->alpha2[1])) {
 		print_regdomain_info(rd);
 		return -EINVAL;
 	}
-- 
2.32.0

