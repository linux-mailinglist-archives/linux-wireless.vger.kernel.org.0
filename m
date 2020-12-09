Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8B2D4D02
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbgLIVig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:38:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35934 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388097AbgLIVig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:38:36 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pf-003Drx-Dx; Wed, 09 Dec 2020 23:17:07 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:21 +0200
Message-Id: <iwlwifi.20201209231352.abca200b24d6.If5ce9e8abd5034496e98e97a53c446f045438388@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 17/47] iwlwifi: fix typo in comment
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

