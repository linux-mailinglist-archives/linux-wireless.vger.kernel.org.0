Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85E193E84
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgCZMBK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:01:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44160 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727998AbgCZMBJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:01:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHRC5-0003we-RK; Thu, 26 Mar 2020 14:01:06 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:00:42 +0200
Message-Id: <20200326120042.578777-13-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326120042.578777-1-luca@coelho.fi>
References: <20200326120042.578777-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH 12/12] cfg80211: Do not warn on same channel at the end of CSA
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When cfg80211_update_assoc_bss_entry() is called, there is a
verification that the BSS channel actually changed. As some APs use
CSA also for bandwidth changes, this would result with a kernel
warning.

Fix this by removing the WARN_ON().

Change-Id: I6710376b1b4257e5f4712fc7ab16e2b638d512aa
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/scan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index dd41e41f9d26..4000382aef48 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2019,7 +2019,11 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 
 	spin_lock_bh(&rdev->bss_lock);
 
-	if (WARN_ON(cbss->pub.channel == chan))
+	/*
+	 * Some APs use CSA also for bandwidth changes, i.e., without actually
+	 * changing the control channel, so no need to update in such a case.
+	 */
+	if (cbss->pub.channel == chan)
 		goto done;
 
 	/* use transmitting bss */
-- 
2.25.1

