Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACF2D04F6
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 13:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgLFMzx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 07:55:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34932 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727982AbgLFMzp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 07:55:45 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kltZ3-003AHZ-P6; Sun, 06 Dec 2020 14:54:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 14:54:47 +0200
Message-Id: <iwlwifi.20201206145305.9abf9f6b4f88.Icb6e52af586edcc74f1f0360e8f6fc9ef2bfe8f5@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206125450.564941-1-luca@coelho.fi>
References: <20201206125450.564941-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/11] mac80211: ignore country element TX power on 6 GHz
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Updates to the 802.11ax draft are coming that deprecate the
country element in favour of the transmit power envelope
element, and make the maximum transmit power level field in
the triplets reserved, so if we parse them we'd use 0 dBm
transmit power.

Follow suit and completely ignore the element on 6 GHz for
purposes of determining TX power.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1c9cc65bccba..824dbba62794 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1560,9 +1560,17 @@ ieee80211_find_80211h_pwr_constr(struct ieee80211_sub_if_data *sdata,
 		chan_increment = 1;
 		break;
 	case NL80211_BAND_5GHZ:
-	case NL80211_BAND_6GHZ:
 		chan_increment = 4;
 		break;
+	case NL80211_BAND_6GHZ:
+		/*
+		 * In the 6 GHz band, the "maximum transmit power level"
+		 * field in the triplets is reserved, and thus will be
+		 * zero and we shouldn't use it to control TX power.
+		 * The actual TX power will be given in the transmit
+		 * power envelope element instead.
+		 */
+		return false;
 	}
 
 	/* find channel */
-- 
2.29.2

