Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968C03166C7
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBJMdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:33:08 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45090 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231926AbhBJMae (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:30:34 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9ocf-0049Yg-3k; Wed, 10 Feb 2021 14:29:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 14:29:21 +0200
Message-Id: <iwlwifi.20210210142629.e098026e83ad.I8870fcbc504a74cab6a50134b3df1131d6da946d@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210122927.315774-1-luca@coelho.fi>
References: <20210210122927.315774-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 06/12] iwlwifi: queue: add fake tx time point
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In case we get TX sequence number out of range, trigger fake tx time
point to collect FW debug data.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 3cac83be596f..833f43d1ca7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1577,6 +1577,10 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 			__func__, txq_id, last_to_free,
 			trans->trans_cfg->base_params->max_tfd_queue_size,
 			txq->write_ptr, txq->read_ptr);
+
+		iwl_op_mode_time_point(trans->op_mode,
+				       IWL_FW_INI_TIME_POINT_FAKE_TX,
+				       NULL);
 		goto out;
 	}
 
-- 
2.30.0

