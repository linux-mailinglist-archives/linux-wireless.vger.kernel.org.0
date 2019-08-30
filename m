Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F056FA35DD
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 13:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfH3LlE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 07:41:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39488 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727522AbfH3LlE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 07:41:04 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i3fH3-0001na-JL; Fri, 30 Aug 2019 14:41:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:40:57 +0300
Message-Id: <20190830114057.22197-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190830112451.21655-3-luca@coelho.fi>
References: <20190830112451.21655-3-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2] mac80211: vht: add support VHT EXT NSS BW in parsing VHT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This fixes was missed in parsing the vht capabilities max bw
support.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Fixes: e80d642552a3 ("mac80211: copy VHT EXT NSS BW Support/Capable data to station")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---

Fixed the subject in v2 (no idea what happened there).


net/mac80211/vht.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index b20ff28d9f30..ccdcb9ad9ac7 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -349,6 +349,14 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 	    cap_width == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
 		return IEEE80211_STA_RX_BW_160;
 
+	/*
+	 * If this is non-zero, then it does support 160 MHz after all,
+	 * in one form or the other. We don't distinguish here (or even
+	 * above) between 160 and 80+80 yet.
+	 */
+	if (vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK)
+		return IEEE80211_STA_RX_BW_160;
+
 	return IEEE80211_STA_RX_BW_80;
 }
 
-- 
2.23.0.rc1

