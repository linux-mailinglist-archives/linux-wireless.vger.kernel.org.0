Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600533AC926
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhFRKv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:51:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48232 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232315AbhFRKv4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:51:56 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwz-001YXx-Ui; Fri, 18 Jun 2021 13:42:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:41 +0300
Message-Id: <iwlwifi.20210618133832.218df9d3203c.Ice0f7a2f6a65f1f9710b7898591481baeefaf490@changeid>
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
Subject: [PATCH 16/31] cfg80211: Support hidden AP discovery over 6GHz band
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

To discover a hidden AP on the 6GHz band, the probe request
sent to the AP needs to include the AP's SSID, as some APs
would not respond with a probe response based only on short
SSID match.

To support hidden AP discovery over the 6GHz band,
when constructing the specific 6GHz band scan also include
SSIDs that were part of the original scan request, so these
can be used in the probe requests transmitted during scan.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/scan.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 4f06c1825029..86cd66952131 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -5,7 +5,7 @@
  * Copyright 2008 Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2016	Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -757,7 +757,8 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	}
 
 	request = kzalloc(struct_size(request, channels, n_channels) +
-			  sizeof(*request->scan_6ghz_params) * count,
+			  sizeof(*request->scan_6ghz_params) * count +
+			  sizeof(*request->ssids) * rdev_req->n_ssids,
 			  GFP_KERNEL);
 	if (!request) {
 		cfg80211_free_coloc_ap_list(&coloc_ap_list);
@@ -848,9 +849,18 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 	if (request->n_channels) {
 		struct cfg80211_scan_request *old = rdev->int_scan_req;
-
 		rdev->int_scan_req = request;
 
+		/*
+		 * Add the ssids from the parent scan request to the new scan
+		 * request, so the driver would be able to use them in its
+		 * probe requests to discover hidden APs on PSC channels.
+		 */
+		request->ssids = (void *)&request->channels[request->n_channels];
+		request->n_ssids = rdev_req->n_ssids;
+		memcpy(request->ssids, rdev_req->ssids, sizeof(*request->ssids) *
+		       request->n_ssids);
+
 		/*
 		 * If this scan follows a previous scan, save the scan start
 		 * info from the first part of the scan
-- 
2.32.0

