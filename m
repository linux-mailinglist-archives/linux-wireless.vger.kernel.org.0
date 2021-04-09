Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CBB359B04
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhDIKHN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 06:07:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44296 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233445AbhDIKDg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 06:03:36 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUnd1-000ELR-IK; Fri, 09 Apr 2021 12:40:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:26 +0300
Message-Id: <iwlwifi.20210409123755.d2588ebb1974.I9424c8ade13c4c938cb9999d8ce99d0d4c1cc198@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 13/15] ieee80211: add the values of ranging parameters max LTF total field
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add an enum with the values of the ranging parameters max LTF total
field, as defined in IEEE802.11az_D2.6, table Table 9-322h23fc.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/linux/ieee80211.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 63252fba3f90..2967437f1b11 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3859,4 +3859,11 @@ struct ieee80211_neighbor_ap_info {
        u8 channel;
 } __packed;
 
+enum ieee80211_range_params_max_total_ltf {
+	IEEE80211_RANGE_PARAMS_MAX_TOTAL_LTF_4 = 0,
+	IEEE80211_RANGE_PARAMS_MAX_TOTAL_LTF_8,
+	IEEE80211_RANGE_PARAMS_MAX_TOTAL_LTF_16,
+	IEEE80211_RANGE_PARAMS_MAX_TOTAL_LTF_UNSPECIFIED,
+};
+
 #endif /* LINUX_IEEE80211_H */
-- 
2.31.0

