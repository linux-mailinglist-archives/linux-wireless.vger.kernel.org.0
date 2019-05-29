Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641482DCB2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfE2MZz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:25:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54332 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727034AbfE2MZy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:25:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVxeQ-0007wy-5T; Wed, 29 May 2019 15:25:50 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 10/10] mac80211: extend __rate_control_send_low warning
Date:   Wed, 29 May 2019 15:25:37 +0300
Message-Id: <20190529122537.8564-11-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529122537.8564-1-luca@coelho.fi>
References: <20190529122537.8564-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This appears to happen occasionally, and if it does we
really want even more information than we have now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/rate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 5d94576dd683..d298bb222491 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -358,8 +358,10 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 		break;
 	}
 	WARN_ONCE(i == sband->n_bitrates,
-		  "no supported rates (0x%x) in rate_mask 0x%x with flags 0x%x\n",
+		  "no supported rates for sta %pM (0x%x, band %d) in rate_mask 0x%x with flags 0x%x\n",
+		  sta ? sta->addr : NULL,
 		  sta ? sta->supp_rates[sband->band] : -1,
+		  sband->band,
 		  rate_mask, rate_flags);
 
 	info->control.rates[0].count =
-- 
2.20.1

