Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148F95286E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfFYJpC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54612 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727768AbfFYJpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0Z-0007Nv-Li; Tue, 25 Jun 2019 12:44:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 04/12] iwlwifi: update CSI API
Date:   Tue, 25 Jun 2019 12:44:44 +0300
Message-Id: <20190625094452.19034-5-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Update the CSI API to the new version supported by the firmware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 8d78b0e671c0..ec864c7b497f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -937,8 +937,13 @@ struct iwl_ftm_responder_stats {
 	__le16 reserved;
 } __packed; /* TOF_RESPONDER_STATISTICS_NTFY_S_VER_2 */
 
-#define IWL_CSI_CHUNK_CTL_NUM_MASK	0x3
-#define IWL_CSI_CHUNK_CTL_IDX_MASK	0xc
+#define IWL_CSI_MAX_EXPECTED_CHUNKS		16
+
+#define IWL_CSI_CHUNK_CTL_NUM_MASK_VER_1	0x0003
+#define IWL_CSI_CHUNK_CTL_IDX_MASK_VER_1	0x000c
+
+#define IWL_CSI_CHUNK_CTL_NUM_MASK_VER_2	0x00ff
+#define IWL_CSI_CHUNK_CTL_IDX_MASK_VER_2	0xff00
 
 struct iwl_csi_chunk_notification {
 	__le32 token;
@@ -946,6 +951,6 @@ struct iwl_csi_chunk_notification {
 	__le16 ctl;
 	__le32 size;
 	u8 data[];
-} __packed; /* CSI_CHUNKS_HDR_NTFY_API_S_VER_1 */
+} __packed; /* CSI_CHUNKS_HDR_NTFY_API_S_VER_1/VER_2 */
 
 #endif /* __iwl_fw_api_location_h__ */
-- 
2.20.1

