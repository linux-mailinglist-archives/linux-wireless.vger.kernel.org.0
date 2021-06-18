Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3040A3AC909
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhFRKoS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:44:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48150 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233678AbhFRKoR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:44:17 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwr-001YXx-KO; Fri, 18 Jun 2021 13:42:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:31 +0300
Message-Id: <iwlwifi.20210618133832.1fbef57e269a.I00294bebdb0680b892f8d1d5c871fd9dbe785a5e@changeid>
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
Subject: [PATCH 06/31] cfg80211: avoid double free of PMSR request
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

If cfg80211_pmsr_process_abort() moves all the PMSR requests that
need to be freed into a local list before aborting and freeing them.
As a result, it is possible that cfg80211_pmsr_complete() will run in
parallel and free the same PMSR request.

Fix it by freeing the request in cfg80211_pmsr_complete() only if it
is still in the original pmsr list.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/pmsr.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 6bdd96408022..d245968b74cb 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -334,6 +334,7 @@ void cfg80211_pmsr_complete(struct wireless_dev *wdev,
 			    gfp_t gfp)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	struct cfg80211_pmsr_request *tmp, *prev, *to_free = NULL;
 	struct sk_buff *msg;
 	void *hdr;
 
@@ -364,9 +365,20 @@ void cfg80211_pmsr_complete(struct wireless_dev *wdev,
 	nlmsg_free(msg);
 free_request:
 	spin_lock_bh(&wdev->pmsr_lock);
-	list_del(&req->list);
+	/*
+	 * cfg80211_pmsr_process_abort() may have already moved this request
+	 * to the free list, and will free it later. In this case, don't free
+	 * it here.
+	 */
+	list_for_each_entry_safe(tmp, prev, &wdev->pmsr_list, list) {
+		if (tmp == req) {
+			list_del(&req->list);
+			to_free = req;
+			break;
+		}
+	}
 	spin_unlock_bh(&wdev->pmsr_lock);
-	kfree(req);
+	kfree(to_free);
 }
 EXPORT_SYMBOL_GPL(cfg80211_pmsr_complete);
 
-- 
2.32.0

