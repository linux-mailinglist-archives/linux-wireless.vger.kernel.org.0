Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47082C79BE
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgK2Pbu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:50 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33544 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727960AbgK2Pbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfG-0035ld-JI; Sun, 29 Nov 2020 17:31:02 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:49 +0200
Message-Id: <iwlwifi.20201129172929.8377d5063827.I6f2011b6017c2ad507c61a3f1ca03b7177a46e32@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/13] cfg80211: Update TSF and TSF BSSID for multi BSS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When a new BSS entry is created based on multi BSS IE, the
TSF and the TSF BSSID were not updated. Fix it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 5f92d85acf45..1b7fec3b53cd 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1899,6 +1899,9 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	tmp.pub.beacon_interval = beacon_interval;
 	tmp.pub.capability = capability;
 	tmp.ts_boottime = data->boottime_ns;
+	tmp.parent_tsf = data->parent_tsf;
+	ether_addr_copy(tmp.parent_bssid, data->parent_bssid);
+
 	if (non_tx_data) {
 		tmp.pub.transmitted_bss = non_tx_data->tx_bss;
 		ts = bss_from_pub(non_tx_data->tx_bss)->ts;
-- 
2.29.2

