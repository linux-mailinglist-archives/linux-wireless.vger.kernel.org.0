Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF50CAA447
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbfIENWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:22:53 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41162 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388825AbfIENWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:22:52 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5ril-00062D-Lq; Thu, 05 Sep 2019 16:22:44 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:22:15 +0300
Message-Id: <20190905132220.23970-17-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905132220.23970-1-luca@coelho.fi>
References: <20190905132220.23970-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 16/21] iwlwifi: add iwl_tlv_array_len()
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Allows to easily calculate array length at the end of a TLV.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 329b00e90fa4..1bdcab9b9275 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -972,4 +972,19 @@ struct iwl_fw_cmd_version {
 	u8 notif_ver;
 } __packed;
 
+static inline size_t _iwl_tlv_array_len(const struct iwl_ucode_tlv *tlv,
+					size_t fixed_size, size_t var_size)
+{
+	size_t var_len = le32_to_cpu(tlv->length) - fixed_size;
+
+	if (WARN_ON(var_len % var_size))
+		return 0;
+
+	return var_len / var_size;
+}
+
+#define iwl_tlv_array_len(_tlv_ptr, _struct_ptr, _memb)			\
+	_iwl_tlv_array_len((_tlv_ptr), sizeof(*(_struct_ptr)),		\
+			   sizeof(_struct_ptr->_memb[0]))
+
 #endif  /* __iwl_fw_file_h__ */
-- 
2.23.0.rc1

