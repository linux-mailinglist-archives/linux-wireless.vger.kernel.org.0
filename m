Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437B73E13C4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbhHELWW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51308 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241010AbhHELWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRt-00243p-85; Thu, 05 Aug 2021 14:22:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:52 +0300
Message-Id: <iwlwifi.20210805141826.0a387598eef1.I3be0bbf603ef95c644218be8a12b329411f11646@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805112158.460799-1-luca@coelho.fi>
References: <20210805112158.460799-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 06/12] iwlwifi: mvm: support version 11 of wowlan statuses notification
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

The new version of the command has same size and layout as
version 10. It just sends corresponding station id in one
of the reserved fields. It's not used in the driver, so just
be ready to accept version 11.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 00403b337060..0e97d5e6c644 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1933,9 +1933,12 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 
 		status->gtk[0] = v7->gtk[0];
 		status->igtk[0] = v7->igtk[0];
-	} else if (notif_ver == 9 || notif_ver == 10) {
+	} else if (notif_ver == 9 || notif_ver == 10 || notif_ver == 11) {
 		struct iwl_wowlan_status_v9 *v9 = (void *)cmd.resp_pkt->data;
 
+		/* these three command versions have same layout and size, the
+		 * difference is only in a few not used (reserved) fields.
+		 */
 		status = iwl_mvm_parse_wowlan_status_common_v9(mvm,
 							       cmd.resp_pkt->data,
 							       len);
-- 
2.32.0

