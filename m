Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7DC2C79BF
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgK2Pbu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:50 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33540 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727739AbgK2Pbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfF-0035ld-Up; Sun, 29 Nov 2020 17:31:02 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:48 +0200
Message-Id: <iwlwifi.20201129172929.736415a9ca5d.If5b3578ae85e11a707a5da07e66ba85928ba702c@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/13] cfg80211: scan PSC channels in case of scan with wildcard SSID
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

In case of scan request with wildcard SSID, or in case of more
than one SSID in scan request, need to scan PSC channels even though
all the co-located APs found during the legacy bands scan indicated
that all the APs in their ESS are co-located, as we might find different
networks on the PSC channels.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/scan.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 3409f37d838b..5f92d85acf45 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -726,7 +726,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	int n_channels, count = 0, err;
 	struct cfg80211_scan_request *request, *rdev_req = rdev->scan_req;
 	LIST_HEAD(coloc_ap_list);
-	bool need_scan_psc;
+	bool need_scan_psc = true;
 	const struct ieee80211_sband_iftype_data *iftd;
 
 	rdev_req->scan_6ghz = true;
@@ -770,20 +770,18 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		(void *)&request->channels[n_channels];
 
 	/*
-	 * PSC channels should not be scanned if all the reported co-located APs
-	 * are indicating that all APs in the same ESS are co-located
+	 * PSC channels should not be scanned in case of direct scan with 1 SSID
+	 * and at least one of the reported co-located APs with same SSID
+	 * indicating that all APs in the same ESS are co-located
 	 */
-	if (count) {
-		need_scan_psc = false;
-
+	if (count && request->n_ssids == 1 && request->ssids[0].ssid_len) {
 		list_for_each_entry(ap, &coloc_ap_list, list) {
-			if (!ap->colocated_ess) {
-				need_scan_psc = true;
+			if (ap->colocated_ess &&
+			    cfg80211_find_ssid_match(ap, request)) {
+				need_scan_psc = false;
 				break;
 			}
 		}
-	} else {
-		need_scan_psc = true;
 	}
 
 	/*
-- 
2.29.2

