Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7DF3AC906
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhFRKoP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:44:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48132 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233678AbhFRKoO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:44:14 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwo-001YXx-JI; Fri, 18 Jun 2021 13:42:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:28 +0300
Message-Id: <iwlwifi.20210618133832.b75f40765538.I92b50e43e29272c97d17ed5f37f216f4caf0f205@changeid>
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
Subject: [PATCH 03/31] ieee80211: define timing measurement in extended capabilities IE
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Krishnanand Prabhu <krishnanand.prabhu@intel.com>

Define the bit used for timing measurement support in extended
capabilities IE, used for time synchronization.

Signed-off-by: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/linux/ieee80211.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2967437f1b11..16a3a133cd20 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2020 Intel Corporation
+ * Copyright (c) 2018 - 2021 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_H
@@ -3110,6 +3110,11 @@ enum ieee80211_tdls_actioncode {
  */
 #define WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT	BIT(6)
 
+/* Timing Measurement protocol for time sync is set in the 7th bit of 3rd byte
+ * of the @WLAN_EID_EXT_CAPABILITY information element
+ */
+#define WLAN_EXT_CAPA3_TIMING_MEASUREMENT_SUPPORT	BIT(7)
+
 /* TDLS capabilities in the 4th byte of @WLAN_EID_EXT_CAPABILITY */
 #define WLAN_EXT_CAPA4_TDLS_BUFFER_STA		BIT(4)
 #define WLAN_EXT_CAPA4_TDLS_PEER_PSM		BIT(5)
-- 
2.32.0

