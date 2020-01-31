Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1D14EB86
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgAaLN0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:26 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55856 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728325AbgAaLN0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:26 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEi-0002GC-Dg; Fri, 31 Jan 2020 13:13:20 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:52 +0200
Message-Id: <20200131111300.891737-16-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 15/23] mac80211: update condition for HE disablement
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Daniel Gabay <daniel.gabay@intel.com>

Disable HE if the beacon does not contain an HE operation IE.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f78e7aa67991..9ab0842a7c37 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -313,8 +313,8 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		ret |= ieee80211_chandef_downgrade(chandef);
 	}
 
-	if (!cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
-				     IEEE80211_CHAN_NO_HE))
+	if (!he_oper || !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
+						 IEEE80211_CHAN_NO_HE))
 		ret |= IEEE80211_STA_DISABLE_HE;
 
 	if (chandef->width != vht_chandef.width && !tracking)
-- 
2.24.1

