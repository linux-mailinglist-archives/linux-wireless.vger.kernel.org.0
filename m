Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761392D4CB1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbgLIVSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:18:16 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35614 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388099AbgLIVRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:17:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pU-003Drx-RV; Wed, 09 Dec 2020 23:16:57 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:08 +0200
Message-Id: <iwlwifi.20201209231352.a595be52af22.I1843c3c4f9fb32fa8d439052bd0a5ad230f292e2@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 04/47] iwlwifi: mvm: fix sar profile printing issue
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Janie Tu <janiex.tu@intel.com>

The profile shows an invalid value because the wrong format was used.
A u8 value should use by %hhu, not %hhd.  Fix thisit by changing it to
%hhu.

Signed-off-by: Janie Tu <janiex.tu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 3395c4675988..b33d82e025b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -381,10 +381,10 @@ static ssize_t iwl_dbgfs_sar_geo_profile_read(struct file *file,
 		pos += scnprintf(buf + pos, bufsz - pos,
 				 "Use geographic profile %d\n", tbl_idx);
 		pos += scnprintf(buf + pos, bufsz - pos,
-				 "2.4GHz:\n\tChain A offset: %hhd dBm\n\tChain B offset: %hhd dBm\n\tmax tx power: %hhd dBm\n",
+				 "2.4GHz:\n\tChain A offset: %hhu dBm\n\tChain B offset: %hhu dBm\n\tmax tx power: %hhu dBm\n",
 				 value[1], value[2], value[0]);
 		pos += scnprintf(buf + pos, bufsz - pos,
-				 "5.2GHz:\n\tChain A offset: %hhd dBm\n\tChain B offset: %hhd dBm\n\tmax tx power: %hhd dBm\n",
+				 "5.2GHz:\n\tChain A offset: %hhu dBm\n\tChain B offset: %hhu dBm\n\tmax tx power: %hhu dBm\n",
 				 value[4], value[5], value[3]);
 	}
 	mutex_unlock(&mvm->mutex);
-- 
2.29.2

