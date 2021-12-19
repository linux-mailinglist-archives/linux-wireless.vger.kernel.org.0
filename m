Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C9347A027
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhLSKS1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:27 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51334 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231185AbhLSKS1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:27 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytGq-001O3b-PD; Sun, 19 Dec 2021 12:18:25 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:10 +0200
Message-Id: <iwlwifi.20211219121514.8ef59da4e05e.Ide87c2dc8fa08eae55c013a625f4ece5184b1b63@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219101820.85153-1-luca@coelho.fi>
References: <20211219101820.85153-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: mvm: handle RX checksum on Bz devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On Bz devices, the hardware checksums including the SNAP header,
starting directly after the MAC header, so we don't need the
extra checks and can just pass the checksum to mac80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index de36255997b5..5f73717f2f5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -172,8 +172,12 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	 * in the cases the hardware didn't handle, since it's rare to see
 	 * such packets, even though the hardware did calculate the checksum
 	 * in this case, just starting after the MAC header instead.
+	 *
+	 * Starting from Bz hardware, it calculates starting directly after
+	 * the MAC header, so that matches mac80211's expectation.
 	 */
-	if (skb->ip_summed == CHECKSUM_COMPLETE) {
+	if (skb->ip_summed == CHECKSUM_COMPLETE &&
+	    mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ) {
 		struct {
 			u8 hdr[6];
 			__be16 type;
-- 
2.34.1

