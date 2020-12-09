Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD672D450F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgLIPGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:10 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35502 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730313AbgLIPGJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:09 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn11u-003Dg4-AH; Wed, 09 Dec 2020 17:05:22 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 17:05:12 +0200
Message-Id: <iwlwifi.20201209170243.18167ac20ddd.I99d8085cccc8687805781ccc43e189dbcef0e63b@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209150514.944056-1-luca@coelho.fi>
References: <20201209150514.944056-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/11] iwlwifi: mvm: check that statistics TLV version match struct version
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

FW now puts in the struct version, the TLV version so we also check
it to make sure it matches.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 79d1778e6bc0..b562e07a5f22 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -707,7 +707,8 @@ iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
 	stats = (void *)&pkt->data;
 
 	if (WARN_ONCE(stats->hdr.type != FW_STATISTICS_OPERATIONAL ||
-		      stats->hdr.version != 1,
+		      stats->hdr.version !=
+		      iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, STATISTICS_CMD, 0),
 		      "received unsupported hdr type %d, version %d\n",
 		      stats->hdr.type, stats->hdr.version))
 		return;
-- 
2.29.2

