Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678A83AC91E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhFRKuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:50:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48228 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233147AbhFRKuP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:50:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwz-001YXx-2Z; Fri, 18 Jun 2021 13:42:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:40 +0300
Message-Id: <iwlwifi.20210618133832.b5513f2af335.Ic01862678712ae4238cea43ad2185928865efad2@changeid>
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
Subject: [PATCH 15/31] mac80211: conditionally advertise HE in probe requests
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

While building probe requests, only enable HE capability if
there are actually any channels in the band with HE enabled,
otherwise we're not really capable. We're doing the same in
association requests, so doing it here makes it consistent.

This also makes HE not appear available if it isn't due to
regulatory constraints.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0f6fd90f6696..22cab76a9c2f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1938,7 +1938,9 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	}
 
 	he_cap = ieee80211_get_he_sta_cap(sband);
-	if (he_cap) {
+	if (he_cap &&
+	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
+					 IEEE80211_CHAN_NO_HE)) {
 		pos = ieee80211_ie_build_he_cap(pos, he_cap, end);
 		if (!pos)
 			goto out_err;
-- 
2.32.0

