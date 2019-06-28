Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4E959751
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfF1JUl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:41 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54764 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726667AbfF1JUl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:41 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3S-0001ny-W1; Fri, 28 Jun 2019 12:20:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 15/20] iwlwifi: support FSEQ TLV even when FMAC is not compiled
Date:   Fri, 28 Jun 2019 12:20:03 +0300
Message-Id: <20190628092008.11049-16-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

FSEQ TLV should be parsed and read even when FMAC is not compiled.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 63da2c781d12..b35fee492786 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1105,6 +1105,18 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				le32_to_cpu(recov_info->buf_size);
 			}
 			break;
+		case IWL_UCODE_TLV_FW_FSEQ_VERSION: {
+			struct {
+				u8 version[32];
+				u8 sha1[20];
+			} *fseq_ver = (void *)tlv_data;
+
+			if (tlv_len != sizeof(*fseq_ver))
+				goto invalid_tlv_len;
+			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %s\n",
+				 fseq_ver->version);
+			}
+			break;
 		case IWL_UCODE_TLV_UMAC_DEBUG_ADDRS: {
 			struct iwl_umac_debug_addrs *dbg_ptrs =
 				(void *)tlv_data;
-- 
2.20.1

