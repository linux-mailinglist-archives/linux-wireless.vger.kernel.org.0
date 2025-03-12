Return-Path: <linux-wireless+bounces-20269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F32EA5E741
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A473B174420
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496B4685;
	Wed, 12 Mar 2025 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ryxq2Xie"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3D1F099D
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818179; cv=none; b=SOUua1HXV6CXYI7+fVB91VqQ0t1ieLVZgVxQZV866YupamT8SMkbhV2KctY8hctBT7gCERN5EdWXxpxIiwzqs4yfLhyEmdwWPia1b1pLqlnV+BCJh3xrgPY2xdXSu/y9nLFFwvNCyjPxiS0mzYSGck/vooVp6/0qFIF5TbDXFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818179; c=relaxed/simple;
	bh=Dn/ax1irzS5AuPc6I9bQel9sdgfhuHRAnvv5rAqgpgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQIwaGiobdzEswYx4Frsx/IuJmk6CsreerC3mSm+ygutHQR3mCfWaGLdF1lrwVmtaYjlM7EnZTO6JQp9lCTcAuhzQ6rbHKN9pe7VTqmYk8uIEVlMogQx+1hrt0uOSgaUUS74NqVETYBA6yshR3oLz6Qi+kvpdv4cNdCyhkGr5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ryxq2Xie; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818178; x=1773354178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dn/ax1irzS5AuPc6I9bQel9sdgfhuHRAnvv5rAqgpgk=;
  b=Ryxq2XieWfdmsYc22OAhcGPdHbbDnTGL5O2fEXAY06EkpFRnL3HzrHgj
   LUNAnoS3MRxROKq16hGJQsqMRDBlO4CH0mYgEx2dTIG5Co3dbiOi119aP
   MdWWmyIKoBAiGDIsC1k05ujLGl7h9GBPk6th0pTG7KVv7PA1BgSEhrN2g
   6fITIbYHa+prb8DOO2IVPegJ2zTeyavE3gvYzvQRX6wV0CelXqJqTWAis
   l3GVFlWI2C2G05041XDe2mHNc2VfwVYqitwn4qgjJh1vw6fnM6Ocpndil
   6MpI774Vzu7y5IR0nSg0w+ublMJnh0D9jsnCsJ0gDKAaUrLBeuhUYFPgi
   A==;
X-CSE-ConnectionGUID: 3S4r63crTbK/Xw6QuxkA1A==
X-CSE-MsgGUID: bMAu3NWGROKx6mJL9SANsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826741"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826741"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:58 -0700
X-CSE-ConnectionGUID: NSC6li0BSXa9+pvRzT5Jlw==
X-CSE-MsgGUID: zMvHS5DFR+K2oEp+O4Fknw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267360"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: iwlwifi: mld: add support for DHC_TOOLS_UMAC_GET_TAS_STATUS command
Date: Thu, 13 Mar 2025 00:22:27 +0200
Message-Id: <20250313002008.66524c6ea198.I1625135284fc075148a55dd9ac629e94ca881fe4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add debugfs file in mld to retrieve TAS status per radio, TAS block list,
current mcc, OEM name and OEM allowed list. This will add ability to get
TAS status to user application via debugfs and required for debugging.

Add the required API definitions and some debug host command utils.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/dhc.h   |  97 ++++++++
 .../net/wireless/intel/iwlwifi/fw/dhc-utils.h |  75 ++++++
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  | 232 ++++++++++++++++++
 3 files changed, 404 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
index dbe06f3fc662..b6d79c678cd8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
@@ -15,6 +15,19 @@ enum iwl_dhc_table_id {
 	 * @DHC_TABLE_INTEGRATION: select the integration table
 	 */
 	DHC_TABLE_INTEGRATION	= 2 << DHC_TABLE_MASK_POS,
+	/**
+	 * @DHC_TABLE_TOOLS: select the tools table
+	 */
+	DHC_TABLE_TOOLS		= 0,
+};
+
+/**
+ * enum iwl_dhc_umac_tools_table - tools operations
+ * @DHC_TOOLS_UMAC_GET_TAS_STATUS: Get TAS status.
+ *	See @struct iwl_dhc_tas_status_resp
+ */
+enum iwl_dhc_umac_tools_table {
+	DHC_TOOLS_UMAC_GET_TAS_STATUS = 0,
 };
 
 /**
@@ -58,6 +71,90 @@ struct iwl_dhc_cmd {
 	__le32 data[];
 } __packed; /* DHC_CMD_API_S */
 
+/**
+ * struct iwl_dhc_payload_hdr - DHC payload header
+ * @version: a version of a payload
+ * @reserved: reserved for alignment
+ */
+struct iwl_dhc_payload_hdr {
+	u8 version;
+	u8 reserved[3];
+} __packed; /* DHC_PAYLOAD_HDR_API_S_VER_1 */
+
+/**
+ * struct iwl_dhc_tas_status_per_radio - TAS status per radio
+ * @band: &PHY_BAND_5 for high band, PHY_BAND_24 for low band and
+ *	&PHY_BAND_6 for ultra high band.
+ * @static_status: TAS statically enabled or disabled
+ * @static_disable_reason: TAS static disable reason, uses
+ *	&enum iwl_tas_statically_disabled_reason
+ * @near_disconnection: is TAS currently near disconnection per radio
+ * @dynamic_status_ant_a: Antenna A current TAS status.
+ *	uses &enum iwl_tas_dyna_status
+ * @dynamic_status_ant_b: Antenna B current TAS status.
+ *	uses &enum iwl_tas_dyna_status
+ * @max_reg_pwr_limit_ant_a: Antenna A regulatory power limits in dBm
+ * @max_reg_pwr_limit_ant_b: Antenna B regulatory power limits in dBm
+ * @sar_limit_ant_a: Antenna A SAR limit per radio in dBm
+ * @sar_limit_ant_b: Antenna B SAR limit per radio in dBm
+ * @reserved: reserved for alignment
+ */
+struct iwl_dhc_tas_status_per_radio {
+	u8 band;
+	u8 static_status;
+	u8 static_disable_reason;
+	u8 near_disconnection;
+	u8 dynamic_status_ant_a;
+	u8 dynamic_status_ant_b;
+	__le16 max_reg_pwr_limit_ant_a;
+	__le16 max_reg_pwr_limit_ant_b;
+	__le16 sar_limit_ant_a;
+	__le16 sar_limit_ant_b;
+	u8 reserved[2];
+} __packed; /* DHC_TAS_STATUS_PER_RADIO_S_VER_1 */
+
+/**
+ * struct iwl_dhc_tas_status_resp - Response to DHC_TOOLS_UMAC_GET_TAS_STATUS
+ * @header: DHC payload header, uses &struct iwl_dhc_payload_hdr
+ * @tas_config_info: see @struct bios_value_u32
+ * @mcc_block_list: block listed country codes
+ * @tas_status_radio: TAS status, uses &struct iwl_dhc_tas_status_per_radio
+ * @curr_mcc: current mcc
+ * @valid_radio_mask: represent entry in tas_status_per_radio is valid.
+ * @reserved: reserved for alignment
+ */
+struct iwl_dhc_tas_status_resp {
+	struct iwl_dhc_payload_hdr header;
+	struct bios_value_u32 tas_config_info;
+	__le16 mcc_block_list[IWL_WTAS_BLACK_LIST_MAX];
+	struct iwl_dhc_tas_status_per_radio tas_status_radio[2];
+	__le16 curr_mcc;
+	u8 valid_radio_mask;
+	u8 reserved;
+} __packed; /* DHC_TAS_STATUS_RSP_API_S_VER_1 */
+
+/**
+ * struct iwl_dhc_cmd_resp_v1 - debug host command response
+ * @status: status of the command
+ * @data: the response data
+ */
+struct iwl_dhc_cmd_resp_v1 {
+	__le32 status;
+	__le32 data[];
+} __packed; /* DHC_RESP_API_S_VER_1 */
+
+/**
+ * struct iwl_dhc_cmd_resp - debug host command response
+ * @status: status of the command
+ * @descriptor: command descriptor (index_and_mask) returned
+ * @data: the response data
+ */
+struct iwl_dhc_cmd_resp {
+	__le32 status;
+	__le32 descriptor;
+	__le32 data[];
+} __packed; /* DHC_RESP_API_S_VER_2 and DHC_RESP_API_S_VER_3 */
+
 /**
  * enum iwl_dhc_twt_operation_type - describes the TWT operation type
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h b/drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h
new file mode 100644
index 000000000000..983acee5cd7d
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2021, 2025 Intel Corporation
+ */
+#ifndef __iwl_fw_dhc_utils_h__
+#define __iwl_fw_dhc_utils_h__
+
+#include <linux/types.h>
+#include "fw/img.h"
+#include "api/commands.h"
+#include "api/dhc.h"
+
+/**
+ * iwl_dhc_resp_status - return status of DHC response
+ * @fw: firwmware image information
+ * @pkt: response packet, must not be %NULL
+ *
+ * Returns: the status value of the DHC command or (u32)-1 if the
+ *	    response was too short.
+ */
+static inline u32 iwl_dhc_resp_status(const struct iwl_fw *fw,
+				      struct iwl_rx_packet *pkt)
+{
+	if (iwl_fw_lookup_notif_ver(fw, IWL_ALWAYS_LONG_GROUP,
+				    DEBUG_HOST_COMMAND, 1) >= 2) {
+		struct iwl_dhc_cmd_resp *resp = (void *)pkt->data;
+
+		if (iwl_rx_packet_payload_len(pkt) < sizeof(*resp))
+			return (u32)-1;
+
+		return le32_to_cpu(resp->status);
+	} else {
+		struct iwl_dhc_cmd_resp_v1 *resp = (void *)pkt->data;
+
+		if (iwl_rx_packet_payload_len(pkt) < sizeof(*resp))
+			return (u32)-1;
+
+		return le32_to_cpu(resp->status);
+	}
+}
+
+/**
+ * iwl_dhc_resp_data - return data pointer of DHC response
+ * @fw: firwmware image information
+ * @pkt: response packet, must not be %NULL
+ * @len: where to store the length
+ *
+ * Returns: The data pointer, or an ERR_PTR() if the data was
+ *	    not valid (too short).
+ */
+static inline void *iwl_dhc_resp_data(const struct iwl_fw *fw,
+				      struct iwl_rx_packet *pkt,
+				      unsigned int *len)
+{
+	if (iwl_fw_lookup_notif_ver(fw, IWL_ALWAYS_LONG_GROUP,
+				    DEBUG_HOST_COMMAND, 1) >= 2) {
+		struct iwl_dhc_cmd_resp *resp = (void *)pkt->data;
+
+		if (iwl_rx_packet_payload_len(pkt) < sizeof(*resp))
+			return ERR_PTR(-EINVAL);
+
+		*len = iwl_rx_packet_payload_len(pkt) - sizeof(*resp);
+		return (void *)&resp->data;
+	} else {
+		struct iwl_dhc_cmd_resp_v1 *resp = (void *)pkt->data;
+
+		if (iwl_rx_packet_payload_len(pkt) < sizeof(*resp))
+			return ERR_PTR(-EINVAL);
+
+		*len = iwl_rx_packet_payload_len(pkt) - sizeof(*resp);
+		return (void *)&resp->data;
+	}
+}
+
+#endif  /* __iwl_fw_dhc_utils_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index c67dbbf575d7..14330daa6d13 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -21,6 +21,8 @@
 #include "fw/api/rs.h"
 #include "fw/api/dhc.h"
 #include "fw/api/rfi.h"
+#include "fw/dhc-utils.h"
+#include <linux/dmi.h>
 
 #define MLD_DEBUGFS_READ_FILE_OPS(name, bufsz)				\
 	_MLD_DEBUGFS_READ_FILE_OPS(name, bufsz, struct iwl_mld)
@@ -206,11 +208,240 @@ iwl_dbgfs_he_sniffer_params_read(struct iwl_mld *mld, char *buf, size_t count)
 #define IWL_RFI_BUF_SIZE (IWL_RFI_DDR_BUF_SIZE + IWL_RFI_DLVR_BUF_SIZE +\
 				IWL_RFI_DESENSE_BUF_SIZE + 32)
 
+static size_t iwl_mld_dump_tas_resp(struct iwl_dhc_tas_status_resp *resp,
+				    size_t count, u8 *buf)
+{
+	const char * const tas_dis_reason[TAS_DISABLED_REASON_MAX] = {
+		[TAS_DISABLED_DUE_TO_BIOS] =
+			"Due To BIOS",
+		[TAS_DISABLED_DUE_TO_SAR_6DBM] =
+			"Due To SAR Limit Less Than 6 dBm",
+		[TAS_DISABLED_REASON_INVALID] =
+			"N/A",
+		[TAS_DISABLED_DUE_TO_TABLE_SOURCE_INVALID] =
+			"Due to table source invalid"
+	};
+	const char * const tas_current_status[TAS_DYNA_STATUS_MAX] = {
+		[TAS_DYNA_INACTIVE] = "INACTIVE",
+		[TAS_DYNA_INACTIVE_MVM_MODE] =
+			"inactive due to mvm mode",
+		[TAS_DYNA_INACTIVE_TRIGGER_MODE] =
+			"inactive due to trigger mode",
+		[TAS_DYNA_INACTIVE_BLOCK_LISTED] =
+			"inactive due to block listed",
+		[TAS_DYNA_INACTIVE_UHB_NON_US] =
+			"inactive due to uhb non US",
+		[TAS_DYNA_ACTIVE] = "ACTIVE",
+	};
+	ssize_t pos = 0;
+
+	if (resp->header.version != 1) {
+		pos += scnprintf(buf + pos, count - pos,
+				 "Unsupported TAS response version:%d",
+				 resp->header.version);
+		return pos;
+	}
+
+	pos += scnprintf(buf + pos, count - pos, "TAS Report\n");
+	switch (resp->tas_config_info.table_source) {
+	case BIOS_SOURCE_NONE:
+		pos += scnprintf(buf + pos, count - pos,
+				 "BIOS SOURCE NONE ");
+		break;
+	case BIOS_SOURCE_ACPI:
+		pos += scnprintf(buf + pos, count - pos,
+				 "BIOS SOURCE ACPI ");
+		break;
+	case BIOS_SOURCE_UEFI:
+		pos += scnprintf(buf + pos, count - pos,
+				 "BIOS SOURCE UEFI ");
+		break;
+	default:
+		pos += scnprintf(buf + pos, count - pos,
+				 "BIOS SOURCE UNKNOWN (%d) ",
+				 resp->tas_config_info.table_source);
+		break;
+	}
+
+	pos += scnprintf(buf + pos, count - pos,
+			 "revision is: %d data is: 0x%08x\n",
+			 resp->tas_config_info.table_revision,
+			 resp->tas_config_info.value);
+	pos += scnprintf(buf + pos, count - pos, "Current MCC: 0x%x\n",
+			 le16_to_cpu(resp->curr_mcc));
+
+	pos += scnprintf(buf + pos, count - pos, "Block list entries:");
+	for (int i = 0; i < ARRAY_SIZE(resp->mcc_block_list); i++)
+		pos += scnprintf(buf + pos, count - pos, " 0x%x",
+				 le16_to_cpu(resp->mcc_block_list[i]));
+
+	pos += scnprintf(buf + pos, count - pos,
+			 "\nDo TAS Support Dual Radio?: %s\n",
+			 hweight8(resp->valid_radio_mask) > 1 ?
+			 "TRUE" : "FALSE");
+
+	for (int i = 0; i < ARRAY_SIZE(resp->tas_status_radio); i++) {
+		int tmp;
+		unsigned long dynamic_status;
+
+		if (!(resp->valid_radio_mask & BIT(i)))
+			continue;
+
+		pos += scnprintf(buf + pos, count - pos,
+				 "TAS report for radio:%d\n", i + 1);
+		pos += scnprintf(buf + pos, count - pos,
+				 "Static status: %sabled\n",
+				 resp->tas_status_radio[i].static_status ?
+				 "En" : "Dis");
+		if (!resp->tas_status_radio[i].static_status) {
+			u8 static_disable_reason =
+				resp->tas_status_radio[i].static_disable_reason;
+
+			pos += scnprintf(buf + pos, count - pos,
+					 "\tStatic Disabled Reason: ");
+			if (static_disable_reason >= TAS_DISABLED_REASON_MAX) {
+				pos += scnprintf(buf + pos, count - pos,
+						 "unsupported value (%d)\n",
+						 static_disable_reason);
+				continue;
+			}
+
+			pos += scnprintf(buf + pos, count - pos,
+					 "%s (%d)\n",
+					 tas_dis_reason[static_disable_reason],
+					 static_disable_reason);
+			continue;
+		}
+
+		pos += scnprintf(buf + pos, count - pos, "\tANT A %s and ",
+				 (resp->tas_status_radio[i].dynamic_status_ant_a
+				  & BIT(TAS_DYNA_ACTIVE)) ? "ON" : "OFF");
+
+		pos += scnprintf(buf + pos, count - pos, "ANT B %s for ",
+				 (resp->tas_status_radio[i].dynamic_status_ant_b
+				  & BIT(TAS_DYNA_ACTIVE)) ? "ON" : "OFF");
+
+		switch (resp->tas_status_radio[i].band) {
+		case PHY_BAND_5:
+			pos += scnprintf(buf + pos, count - pos, "HB\n");
+			break;
+		case PHY_BAND_24:
+			pos += scnprintf(buf + pos, count - pos, "LB\n");
+			break;
+		case PHY_BAND_6:
+			pos += scnprintf(buf + pos, count - pos, "UHB\n");
+			break;
+		default:
+			pos += scnprintf(buf + pos, count - pos,
+					 "Unsupported band (%d)\n",
+					 resp->tas_status_radio[i].band);
+			break;
+		}
+
+		pos += scnprintf(buf + pos, count - pos,
+				 "Is near disconnection?: %s\n",
+				 resp->tas_status_radio[i].near_disconnection ?
+				 "True" : "False");
+
+		pos += scnprintf(buf + pos, count - pos,
+				 "Dynamic status antenna A:\n");
+		dynamic_status = resp->tas_status_radio[i].dynamic_status_ant_a;
+		for_each_set_bit(tmp, &dynamic_status, TAS_DYNA_STATUS_MAX) {
+			pos += scnprintf(buf + pos, count - pos, "\t%s (%d)\n",
+					 tas_current_status[tmp], tmp);
+		}
+		pos += scnprintf(buf + pos, count - pos,
+				 "\nDynamic status antenna B:\n");
+		dynamic_status = resp->tas_status_radio[i].dynamic_status_ant_b;
+		for_each_set_bit(tmp, &dynamic_status, TAS_DYNA_STATUS_MAX) {
+			pos += scnprintf(buf + pos, count - pos, "\t%s (%d)\n",
+					 tas_current_status[tmp], tmp);
+		}
+
+		tmp = le16_to_cpu(resp->tas_status_radio[i].max_reg_pwr_limit_ant_a);
+		pos += scnprintf(buf + pos, count - pos,
+				 "Max antenna A regulatory pwr limit (dBm): %d.%03d\n",
+				 tmp / 8, 125 * (tmp % 8));
+		tmp = le16_to_cpu(resp->tas_status_radio[i].max_reg_pwr_limit_ant_b);
+		pos += scnprintf(buf + pos, count - pos,
+				 "Max antenna B regulatory pwr limit (dBm): %d.%03d\n",
+				 tmp / 8, 125 * (tmp % 8));
+
+		tmp = le16_to_cpu(resp->tas_status_radio[i].sar_limit_ant_a);
+		pos += scnprintf(buf + pos, count - pos,
+				 "Antenna A SAR limit (dBm): %d.%03d\n",
+				 tmp / 8, 125 * (tmp % 8));
+		tmp = le16_to_cpu(resp->tas_status_radio[i].sar_limit_ant_b);
+		pos += scnprintf(buf + pos, count - pos,
+				 "Antenna B SAR limit (dBm): %d.%03d\n",
+				 tmp / 8, 125 * (tmp % 8));
+	}
+
+	return pos;
+}
+
+static ssize_t iwl_dbgfs_tas_get_status_read(struct iwl_mld *mld, char *buf,
+					     size_t count)
+{
+	struct iwl_dhc_cmd cmd = {
+		.index_and_mask = cpu_to_le32(DHC_TABLE_TOOLS |
+					      DHC_TARGET_UMAC |
+					      DHC_TOOLS_UMAC_GET_TAS_STATUS),
+	};
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(LEGACY_GROUP, DEBUG_HOST_COMMAND),
+		.flags = CMD_WANT_SKB,
+		.len[0] = sizeof(cmd),
+		.data[0] = &cmd,
+	};
+	struct iwl_dhc_tas_status_resp *resp = NULL;
+	ssize_t pos = 0;
+	u32 resp_len;
+	u32 status;
+	int ret;
+
+	if (iwl_mld_dbgfs_fw_cmd_disabled(mld))
+		return -EIO;
+
+	ret = iwl_mld_send_cmd(mld, &hcmd);
+	if (ret)
+		return ret;
+
+	pos += scnprintf(buf + pos, count - pos, "\nOEM name: %s\n",
+			 dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>");
+	pos += scnprintf(buf + pos, count - pos,
+			 "\tVendor In Approved List: %s\n",
+			 iwl_is_tas_approved() ? "YES" : "NO");
+
+	status = iwl_dhc_resp_status(mld->fwrt.fw, hcmd.resp_pkt);
+	if (status != 1) {
+		pos += scnprintf(buf + pos, count - pos,
+				 "response status is not success: %d\n",
+				 status);
+		goto out;
+	}
+
+	resp = iwl_dhc_resp_data(mld->fwrt.fw, hcmd.resp_pkt, &resp_len);
+	if (IS_ERR(resp) || resp_len != sizeof(*resp)) {
+		pos += scnprintf(buf + pos, count - pos,
+			"Invalid size for TAS response (%u instead of %zd)\n",
+			resp_len, sizeof(*resp));
+		goto out;
+	}
+
+	pos += iwl_mld_dump_tas_resp(resp, count - pos, buf + pos);
+
+out:
+	iwl_free_resp(&hcmd);
+	return pos;
+}
+
 WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(fw_nmi, 10);
 WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(fw_restart, 10);
 WIPHY_DEBUGFS_READ_WRITE_FILE_OPS_MLD(he_sniffer_params, 32);
 WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(fw_dbg_clear, 10);
 WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(send_echo_cmd, 8);
+WIPHY_DEBUGFS_READ_FILE_OPS_MLD(tas_get_status, 2048);
 
 static ssize_t iwl_dbgfs_wifi_6e_enable_read(struct iwl_mld *mld,
 					     size_t count, u8 *buf)
@@ -307,6 +538,7 @@ iwl_mld_add_debugfs_files(struct iwl_mld *mld, struct dentry *debugfs_dir)
 	MLD_DEBUGFS_ADD_FILE(he_sniffer_params, debugfs_dir, 0600);
 	MLD_DEBUGFS_ADD_FILE(fw_dbg_clear, debugfs_dir, 0200);
 	MLD_DEBUGFS_ADD_FILE(send_echo_cmd, debugfs_dir, 0200);
+	MLD_DEBUGFS_ADD_FILE(tas_get_status, debugfs_dir, 0400);
 #ifdef CONFIG_THERMAL
 	MLD_DEBUGFS_ADD_FILE(start_ctdp, debugfs_dir, 0200);
 	MLD_DEBUGFS_ADD_FILE(stop_ctdp, debugfs_dir, 0200);
-- 
2.34.1


