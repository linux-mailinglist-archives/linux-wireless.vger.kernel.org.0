Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CF22DCAD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfE2MZs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:25:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54278 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726842AbfE2MZs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:25:48 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVxeM-0007wy-52; Wed, 29 May 2019 15:25:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>,
        Dan Carpented <dan.carpenter@oracle.com>
Subject: [PATCH 02/10] cfg80211: use BIT_ULL in cfg80211_parse_mbssid_data()
Date:   Wed, 29 May 2019 15:25:29 +0300
Message-Id: <20190529122537.8564-3-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529122537.8564-1-luca@coelho.fi>
References: <20190529122537.8564-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The seen_indices variable is u64 and in other parts of the code we
assume mbssid_index_ie[2] can be up to 45, so we should use the 64-bit
versions of BIT, namely, BIT_ULL().

Reported-by: Dan Carpented <dan.carpenter@oracle.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index f347387f195a..2ea268ef1c43 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1602,12 +1602,12 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 				continue;
 			}
 
-			if (seen_indices & BIT(mbssid_index_ie[2]))
+			if (seen_indices & BIT_ULL(mbssid_index_ie[2]))
 				/* We don't support legacy split of a profile */
 				net_dbg_ratelimited("Partial info for BSSID index %d\n",
 						    mbssid_index_ie[2]);
 
-			seen_indices |= BIT(mbssid_index_ie[2]);
+			seen_indices |= BIT_ULL(mbssid_index_ie[2]);
 
 			non_tx_data->bssid_index = mbssid_index_ie[2];
 			non_tx_data->max_bssid_indicator = elem->data[0];
-- 
2.20.1

