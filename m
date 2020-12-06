Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3552D0192
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgLFIWz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 03:22:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34656 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726068AbgLFIWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 03:22:52 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klpIz-003A2r-P3; Sun, 06 Dec 2020 10:22:06 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 10:21:52 +0200
Message-Id: <iwlwifi.20201206100942.e81718752085.If5ce9e8abd5034496e98e97a53c446f045438388@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206082159.440198-1-luca@coelho.fi>
References: <20201206082159.440198-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] iwlwifi: fix typo in comment
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Change "anntena" to "antenna" in a comment in stats.h.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index d41cab4016fe..66c93b18adb1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -95,7 +95,7 @@ struct mvm_statistics_div {
  * @interference_data_flag: flag for interference data availability. 1 when data
  *	is available.
  * @channel_load: counts RX Enable time in uSec
- * @beacon_rssi_a: beacon RSSI on anntena A
+ * @beacon_rssi_a: beacon RSSI on antenna A
  * @beacon_rssi_b: beacon RSSI on antenna B
  * @beacon_rssi_c: beacon RSSI on antenna C
  * @beacon_energy_a: beacon energy on antenna A
-- 
2.29.2

