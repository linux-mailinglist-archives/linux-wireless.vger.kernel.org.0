Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE58346169B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346967AbhK2Ni3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:29 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49814 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242398AbhK2NgV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:21 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgmD-0012xo-FT; Mon, 29 Nov 2021 15:33:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:41 +0200
Message-Id: <iwlwifi.20211129152938.4ef43aff0c5d.I96dcb743bcd4f387ba4cfaa61987aeb642ad762b@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/16] cfg80211: Fix order of enum nl80211_band_iftype_attr documentation
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

And fix the comment.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/uapi/linux/nl80211.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5ab616dc363e..a8e20d25252b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3754,13 +3754,12 @@ enum nl80211_mpath_info {
  *     capabilities IE
  * @NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE: HE PPE thresholds information as
  *     defined in HE capabilities IE
- * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band HE capability attribute currently
- *     defined
  * @NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA: HE 6GHz band capabilities (__le16),
  *	given for all 6 GHz band channels
  * @NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS: vendor element capabilities that are
  *	advertised on this band/for this iftype (binary)
  * @__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST: internal use
+ * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band attribute currently defined
  */
 enum nl80211_band_iftype_attr {
 	__NL80211_BAND_IFTYPE_ATTR_INVALID,
-- 
2.33.1

