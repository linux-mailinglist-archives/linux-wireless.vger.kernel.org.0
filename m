Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B25C3AC94D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFRLDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:03:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48260 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229550AbhFRLDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:03:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx4-001YXx-UW; Fri, 18 Jun 2021 13:42:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:47 +0300
Message-Id: <iwlwifi.20210618133832.dc22c48985fa.I4bf5fbc17ec783c21d4b50c8c35b1de390896ccd@changeid>
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
Subject: [PATCH 22/31] mac80211: improve AP disconnect message
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the AP changes capability/bandwidth in some fashion, the
message might be somewhat misleading and we don't know what
really changed. Modify the message to speak about "caps/bw"
instead of just "bandwidth", and print out the flags.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5c58eae7ef4b..3eee75571650 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -444,8 +444,8 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 				      IEEE80211_STA_DISABLE_160MHZ)) ||
 	    !cfg80211_chandef_valid(&chandef)) {
 		sdata_info(sdata,
-			   "AP %pM changed bandwidth in a way we can't support - disconnect\n",
-			   ifmgd->bssid);
+			   "AP %pM changed caps/bw in a way we can't support (0x%x/0x%x) - disconnect\n",
+			   ifmgd->bssid, flags, ifmgd->flags);
 		return -EINVAL;
 	}
 
-- 
2.32.0

