Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9763AC918
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhFRKsf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:48:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48224 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231403AbhFRKse (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:48:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwx-001YXx-ES; Fri, 18 Jun 2021 13:42:12 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:38 +0300
Message-Id: <iwlwifi.20210618133832.c026feb3873d.I380f52a05ddb4153bc77ff7f276a3484819f69b2@changeid>
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
Subject: [PATCH 13/31] ieee80211: add defines for HE PHY cap byte 10
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

One bit out of the previously completely reserved byte 10 in
the PHY capabilities is used since 802.11ax D7.0, add a new
define for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/linux/ieee80211.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 16a3a133cd20..ab6bc225cf5d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2179,6 +2179,8 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 #define IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_RESERVED		0xc0
 #define IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_MASK			0xc0
 
+#define IEEE80211_HE_PHY_CAP10_HE_MU_M1RU_MAX_LTF			0x01
+
 /* 802.11ax HE TX/RX MCS NSS Support  */
 #define IEEE80211_TX_RX_MCS_NSS_SUPP_HIGHEST_MCS_POS			(3)
 #define IEEE80211_TX_RX_MCS_NSS_SUPP_TX_BITMAP_POS			(6)
-- 
2.32.0

