Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3882DCB1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfE2MZy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 08:25:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54316 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726996AbfE2MZv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 08:25:51 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVxeP-0007wy-MJ; Wed, 29 May 2019 15:25:49 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 09/10] mac80211: fill low rate even for HAS_RATE_CONTROL
Date:   Wed, 29 May 2019 15:25:36 +0300
Message-Id: <20190529122537.8564-10-luca@coelho.fi>
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

If HW advertises it has rate control, we skip all of the
rate control assignments, but sometimes the data we have
here is useful, especially so that we don't have to do
the lookups again on which rates are configured and are
supported.

So do the low rate assignment anyway to help out drivers
that might need it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/rate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 8747231f7aa3..5d94576dd683 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -893,10 +893,10 @@ void rate_control_get_rate(struct ieee80211_sub_if_data *sdata,
 		info->control.rates[i].count = 0;
 	}
 
-	if (ieee80211_hw_check(&sdata->local->hw, HAS_RATE_CONTROL))
+	if (rate_control_send_low(sta ? &sta->sta : NULL, txrc))
 		return;
 
-	if (rate_control_send_low(sta ? &sta->sta : NULL, txrc))
+	if (ieee80211_hw_check(&sdata->local->hw, HAS_RATE_CONTROL))
 		return;
 
 	if (sta && test_sta_flag(sta, WLAN_STA_RATE_CONTROL)) {
-- 
2.20.1

