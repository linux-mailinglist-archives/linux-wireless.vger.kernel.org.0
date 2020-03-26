Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2B193F7C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgCZNKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:10:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44360 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727752AbgCZNKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:10:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHSGl-00044K-AG; Thu, 26 Mar 2020 15:09:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:09:39 +0200
Message-Id: <iwlwifi.20200326150855.d70a1450d83f.I6e6ce5efda351a8544c0e7bfeee260fe3360d401@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326130943.623208-1-luca@coelho.fi>
References: <20200326130943.623208-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 08/12] mac80211: Fail association when AP has no legacy rates
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The MLME logic had a workaround that allowed to continue an
association with an AP even if the AP did not provide any basic
rates in its supported rates in the association response, assuming
that the first (non basic) legacy rate could be used as a basic rate.
However, this did not consider the case where the AP (which is
obviously buggy) did not provide any legacy rate.

Fix this by failing the association, as this can result in
an unexpected failure in the low level driver and FW, e.g., in
rate scale logic etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 04ed883339c7..2b57c53ab070 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5037,8 +5037,16 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		 * doesn't happen any more, but keep the workaround so
 		 * in case some *other* APs are buggy in different ways
 		 * we can connect -- with a warning.
+		 * Allow this workaround only in case the AP provided at least
+		 * one rate.
 		 */
-		if (!basic_rates && min_rate_index >= 0) {
+		if (min_rate_index < 0) {
+			sdata_info(sdata,
+				   "No legacy rates in association response\n");
+
+			sta_info_free(local, new_sta);
+			return -EINVAL;
+		} else if (!basic_rates) {
 			sdata_info(sdata,
 				   "No basic rates, using min rate instead\n");
 			basic_rates = BIT(min_rate_index);
-- 
2.25.1

