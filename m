Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646A533407B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 15:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhCJOkT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 09:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhCJOjv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 09:39:51 -0500
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064EEC061760
        for <linux-wireless@vger.kernel.org>; Wed, 10 Mar 2021 06:39:51 -0800 (PST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id AA39B7B923;
        Wed, 10 Mar 2021 14:39:45 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DwZV94168z3Npb;
        Wed, 10 Mar 2021 14:39:45 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 32C651B24;
        Wed, 10 Mar 2021 14:39:45 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id DB3FD8D4A157;
        Wed, 10 Mar 2021 14:39:41 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id 7612FE707DF;
        Wed, 10 Mar 2021 14:39:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id f3yjG8zHBOh0; Wed, 10 Mar 2021 14:39:33 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id 35627E707B5;
        Wed, 10 Mar 2021 14:39:33 +0000 (UTC)
Date:   Wed, 10 Mar 2021 14:39:32 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH v2 iwlwifi-next] iwlwifi: propagate (const) type qualifier
Message-ID: <alpine.BSF.2.00.2103101439240.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Most of this change is a continuation of commit 403ea939ea6a
(iwlwifi: dbg: Mark ucode tlv data as const) propagating the
(const) type qualifier for ucode based tlv data to avoid having
the impression that it is writeable.
The other part of of the change preserves the (const) type qualifier
over casts and function calls where it was previously lost.
Both changes are needed to avoid compile time errors on system with
more strict error settings, in this case found with clang on FreeBSD.

Sponsored by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
changes since v1 - reduce diff context
---
  drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  22 ++--
  .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   2 +-
  drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 110 +++++++++---------
  .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  20 ++--
  .../net/wireless/intel/iwlwifi/iwl-trans.c    |   4 +-
  drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   5 +-
  .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +-
  drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   2 +-
  8 files changed, 85 insertions(+), 82 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 2cd07d2690e0..267a1efd2364 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -33,7 +33,7 @@ static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
  static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
  				   size_t len)
  {
-	struct iwl_ucode_tlv *tlv;
+	const struct iwl_ucode_tlv *tlv;
  	u32 sha1 = 0;
  	u16 mac_type = 0, rf_id = 0;
  	u8 *pnvm_data = NULL, *tmp;
@@ -46,7 +46,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
  		u32 tlv_len, tlv_type;

  		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;

  		tlv_len = le32_to_cpu(tlv->length);
  		tlv_type = le32_to_cpu(tlv->type);
@@ -69,7 +69,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
  				break;
  			}

-			sha1 = le32_to_cpup((__le32 *)data);
+			sha1 = le32_to_cpup((const __le32 *)data);

  			IWL_DEBUG_FW(trans,
  				     "Got IWL_UCODE_TLV_PNVM_VERSION %0x\n",
@@ -83,8 +83,8 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
  				break;
  			}

-			mac_type = le16_to_cpup((__le16 *)data);
-			rf_id = le16_to_cpup((__le16 *)(data + sizeof(__le16)));
+			mac_type = le16_to_cpup((const __le16 *)data);
+			rf_id = le16_to_cpup((const __le16 *)(data + sizeof(__le16)));

  			IWL_DEBUG_FW(trans,
  				     "Got IWL_UCODE_TLV_HW_TYPE mac_type 0x%0x rf_id 0x%0x\n",
@@ -101,7 +101,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,

  			break;
  		case IWL_UCODE_TLV_SEC_RT: {
-			struct iwl_pnvm_section *section = (void *)data;
+			const struct iwl_pnvm_section *section = (const void *)data;
  			u32 data_len = tlv_len - sizeof(*section);

  			IWL_DEBUG_FW(trans,
@@ -109,7 +109,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
  				     tlv_len);

  			/* TODO: remove, this is a deprecated separator */
-			if (le32_to_cpup((__le32 *)data) == 0xddddeeee) {
+			if (le32_to_cpup((const __le32 *)data) == 0xddddeeee) {
  				IWL_DEBUG_FW(trans, "Ignoring separator.\n");
  				break;
  			}
@@ -166,7 +166,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
  static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
  			  size_t len)
  {
-	struct iwl_ucode_tlv *tlv;
+	const struct iwl_ucode_tlv *tlv;

  	IWL_DEBUG_FW(trans, "Parsing PNVM file\n");

@@ -174,7 +174,7 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
  		u32 tlv_len, tlv_type;

  		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;

  		tlv_len = le32_to_cpu(tlv->length);
  		tlv_type = le32_to_cpu(tlv->type);
@@ -186,8 +186,8 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
  		}

  		if (tlv_type == IWL_UCODE_TLV_PNVM_SKU) {
-			struct iwl_sku_id *sku_id =
-				(void *)(data + sizeof(*tlv));
+			const struct iwl_sku_id *sku_id =
+				(const void *)(data + sizeof(*tlv));

  			IWL_DEBUG_FW(trans,
  				     "Got IWL_UCODE_TLV_PNVM_SKU len %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 579bc81cc0ae..187de7262f09 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -403,7 +403,7 @@ static int iwl_dbg_tlv_parse_bin(struct iwl_trans *trans, const u8 *data,

  	while (len >= sizeof(*tlv)) {
  		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;

  		tlv_len = le32_to_cpu(tlv->length);

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index eb168dc535d4..79939f257c65 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -241,14 +241,14 @@ struct iwl_firmware_pieces {

  	/* FW debug data parsed for driver usage */
  	bool dbg_dest_tlv_init;
-	u8 *dbg_dest_ver;
+	const u8 *dbg_dest_ver;
  	union {
-		struct iwl_fw_dbg_dest_tlv *dbg_dest_tlv;
-		struct iwl_fw_dbg_dest_tlv_v1 *dbg_dest_tlv_v1;
+		const struct iwl_fw_dbg_dest_tlv *dbg_dest_tlv;
+		const struct iwl_fw_dbg_dest_tlv_v1 *dbg_dest_tlv_v1;
  	};
-	struct iwl_fw_dbg_conf_tlv *dbg_conf_tlv[FW_DBG_CONF_MAX];
+	const struct iwl_fw_dbg_conf_tlv *dbg_conf_tlv[FW_DBG_CONF_MAX];
  	size_t dbg_conf_tlv_len[FW_DBG_CONF_MAX];
-	struct iwl_fw_dbg_trigger_tlv *dbg_trigger_tlv[FW_DBG_TRIGGER_MAX];
+	const struct iwl_fw_dbg_trigger_tlv *dbg_trigger_tlv[FW_DBG_TRIGGER_MAX];
  	size_t dbg_trigger_tlv_len[FW_DBG_TRIGGER_MAX];
  	struct iwl_fw_dbg_mem_seg_tlv *dbg_mem_tlv;
  	size_t n_mem_tlv;
@@ -325,8 +325,9 @@ static void set_sec_offset(struct iwl_firmware_pieces *pieces,
  static int iwl_store_cscheme(struct iwl_fw *fw, const u8 *data, const u32 len)
  {
  	int i, j;
-	struct iwl_fw_cscheme_list *l = (struct iwl_fw_cscheme_list *)data;
-	struct iwl_fw_cipher_scheme *fwcs;
+	const struct iwl_fw_cscheme_list *l =
+		(const struct iwl_fw_cscheme_list *)data;
+	const struct iwl_fw_cipher_scheme *fwcs;

  	if (len < sizeof(*l) ||
  	    len < sizeof(l->size) + l->size * sizeof(l->cs[0]))
@@ -354,13 +355,13 @@ static int iwl_store_ucode_sec(struct iwl_firmware_pieces *pieces,
  {
  	struct fw_img_parsing *img;
  	struct fw_sec *sec;
-	struct fw_sec_parsing *sec_parse;
+	const struct fw_sec_parsing *sec_parse;
  	size_t alloc_size;

  	if (WARN_ON(!pieces || !data || type >= IWL_UCODE_TYPE_MAX))
  		return -1;

-	sec_parse = (struct fw_sec_parsing *)data;
+	sec_parse = (const struct fw_sec_parsing *)data;

  	img = &pieces->img[type];

@@ -383,8 +384,8 @@ static int iwl_store_ucode_sec(struct iwl_firmware_pieces *pieces,

  static int iwl_set_default_calib(struct iwl_drv *drv, const u8 *data)
  {
-	struct iwl_tlv_calib_data *def_calib =
-					(struct iwl_tlv_calib_data *)data;
+	const struct iwl_tlv_calib_data *def_calib =
+					(const struct iwl_tlv_calib_data *)data;
  	u32 ucode_type = le32_to_cpu(def_calib->ucode_type);
  	if (ucode_type >= IWL_UCODE_TYPE_MAX) {
  		IWL_ERR(drv, "Wrong ucode_type %u for default calibration.\n",
@@ -402,7 +403,7 @@ static int iwl_set_default_calib(struct iwl_drv *drv, const u8 *data)
  static void iwl_set_ucode_api_flags(struct iwl_drv *drv, const u8 *data,
  				    struct iwl_ucode_capabilities *capa)
  {
-	const struct iwl_ucode_api *ucode_api = (void *)data;
+	const struct iwl_ucode_api *ucode_api = (const void *)data;
  	u32 api_index = le32_to_cpu(ucode_api->api_index);
  	u32 api_flags = le32_to_cpu(ucode_api->api_flags);
  	int i;
@@ -423,7 +424,7 @@ static void iwl_set_ucode_api_flags(struct iwl_drv *drv, const u8 *data,
  static void iwl_set_ucode_capabilities(struct iwl_drv *drv, const u8 *data,
  				       struct iwl_ucode_capabilities *capa)
  {
-	const struct iwl_ucode_capa *ucode_capa = (void *)data;
+	const struct iwl_ucode_capa *ucode_capa = (const void *)data;
  	u32 api_index = le32_to_cpu(ucode_capa->api_index);
  	u32 api_flags = le32_to_cpu(ucode_capa->api_capa);
  	int i;
@@ -455,7 +456,7 @@ static int iwl_parse_v1_v2_firmware(struct iwl_drv *drv,
  				    const struct firmware *ucode_raw,
  				    struct iwl_firmware_pieces *pieces)
  {
-	struct iwl_ucode_header *ucode = (void *)ucode_raw->data;
+	const struct iwl_ucode_header *ucode = (const void *)ucode_raw->data;
  	u32 api_ver, hdr_size, build;
  	char buildstr[25];
  	const u8 *src;
@@ -558,7 +559,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  				struct iwl_ucode_capabilities *capa,
  				bool *usniffer_images)
  {
-	struct iwl_tlv_ucode_header *ucode = (void *)ucode_raw->data;
+	const struct iwl_tlv_ucode_header *ucode = (const void *)ucode_raw->data;
  	const struct iwl_ucode_tlv *tlv;
  	size_t len = ucode_raw->size;
  	const u8 *data;
@@ -607,7 +608,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,

  	while (len >= sizeof(*tlv)) {
  		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;

  		tlv_len = le32_to_cpu(tlv->length);
  		tlv_type = le32_to_cpu(tlv->type);
@@ -665,7 +666,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			capa->max_probe_length =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_PAN:
  			if (tlv_len)
@@ -686,7 +687,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			 * will not work with the new firmware, or
  			 * it'll not take advantage of new features.
  			 */
-			capa->flags = le32_to_cpup((__le32 *)tlv_data);
+			capa->flags = le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_API_CHANGES_SET:
  			if (tlv_len != sizeof(struct iwl_ucode_api))
@@ -702,37 +703,37 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			pieces->init_evtlog_ptr =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_INIT_EVTLOG_SIZE:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			pieces->init_evtlog_size =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_INIT_ERRLOG_PTR:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			pieces->init_errlog_ptr =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_RUNT_EVTLOG_PTR:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			pieces->inst_evtlog_ptr =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_RUNT_EVTLOG_SIZE:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			pieces->inst_evtlog_size =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_RUNT_ERRLOG_PTR:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			pieces->inst_errlog_ptr =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_ENHANCE_SENS_TBL:
  			if (tlv_len)
@@ -761,7 +762,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			capa->standard_phy_calibration_size =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_SEC_RT:
  			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_REGULAR,
@@ -787,7 +788,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  		case IWL_UCODE_TLV_PHY_SKU:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
-			drv->fw.phy_config = le32_to_cpup((__le32 *)tlv_data);
+			drv->fw.phy_config = le32_to_cpup((const __le32 *)tlv_data);
  			drv->fw.valid_tx_ant = (drv->fw.phy_config &
  						FW_PHY_CFG_TX_CHAIN) >>
  						FW_PHY_CFG_TX_CHAIN_POS;
@@ -814,7 +815,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			num_of_cpus =
-				le32_to_cpup((__le32 *)tlv_data);
+				le32_to_cpup((const __le32 *)tlv_data);

  			if (num_of_cpus == 2) {
  				drv->fw.img[IWL_UCODE_REGULAR].is_dual_cpus =
@@ -836,10 +837,10 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			capa->n_scan_channels =
-				le32_to_cpup((__le32 *)tlv_data);
+				le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_FW_VERSION: {
-			__le32 *ptr = (void *)tlv_data;
+			const __le32 *ptr = (const __le32 *)tlv_data;
  			u32 major, minor;
  			u8 local_comp;

@@ -863,15 +864,15 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			break;
  			}
  		case IWL_UCODE_TLV_FW_DBG_DEST: {
-			struct iwl_fw_dbg_dest_tlv *dest = NULL;
-			struct iwl_fw_dbg_dest_tlv_v1 *dest_v1 = NULL;
+			const struct iwl_fw_dbg_dest_tlv *dest = NULL;
+			const struct iwl_fw_dbg_dest_tlv_v1 *dest_v1 = NULL;
  			u8 mon_mode;

-			pieces->dbg_dest_ver = (u8 *)tlv_data;
+			pieces->dbg_dest_ver = (const u8 *)tlv_data;
  			if (*pieces->dbg_dest_ver == 1) {
-				dest = (void *)tlv_data;
+				dest = (const void *)tlv_data;
  			} else if (*pieces->dbg_dest_ver == 0) {
-				dest_v1 = (void *)tlv_data;
+				dest_v1 = (const void *)tlv_data;
  			} else {
  				IWL_ERR(drv,
  					"The version is %d, and it is invalid\n",
@@ -912,7 +913,8 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			break;
  			}
  		case IWL_UCODE_TLV_FW_DBG_CONF: {
-			struct iwl_fw_dbg_conf_tlv *conf = (void *)tlv_data;
+			const struct iwl_fw_dbg_conf_tlv *conf =
+				(const void *)tlv_data;

  			if (!pieces->dbg_dest_tlv_init) {
  				IWL_ERR(drv,
@@ -946,8 +948,8 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			break;
  			}
  		case IWL_UCODE_TLV_FW_DBG_TRIGGER: {
-			struct iwl_fw_dbg_trigger_tlv *trigger =
-				(void *)tlv_data;
+			const struct iwl_fw_dbg_trigger_tlv *trigger =
+				(const void *)tlv_data;
  			u32 trigger_id = le32_to_cpu(trigger->id);

  			if (trigger_id >= ARRAY_SIZE(drv->fw.dbg.trigger_tlv)) {
@@ -978,7 +980,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			}

  			drv->fw.dbg.dump_mask =
-				le32_to_cpup((__le32 *)tlv_data);
+				le32_to_cpup((const __le32 *)tlv_data);
  			break;
  			}
  		case IWL_UCODE_TLV_SEC_RT_USNIFFER:
@@ -990,7 +992,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  		case IWL_UCODE_TLV_PAGING:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
-			paging_mem_size = le32_to_cpup((__le32 *)tlv_data);
+			paging_mem_size = le32_to_cpup((const __le32 *)tlv_data);

  			IWL_DEBUG_FW(drv,
  				     "Paging: paging enabled (size = %u bytes)\n",
@@ -1020,8 +1022,8 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			/* ignored */
  			break;
  		case IWL_UCODE_TLV_FW_MEM_SEG: {
-			struct iwl_fw_dbg_mem_seg_tlv *dbg_mem =
-				(void *)tlv_data;
+			const struct iwl_fw_dbg_mem_seg_tlv *dbg_mem =
+				(const void *)tlv_data;
  			size_t size;
  			struct iwl_fw_dbg_mem_seg_tlv *n;

@@ -1049,10 +1051,10 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			break;
  			}
  		case IWL_UCODE_TLV_FW_RECOVERY_INFO: {
-			struct {
+			const struct {
  				__le32 buf_addr;
  				__le32 buf_size;
-			} *recov_info = (void *)tlv_data;
+			} *recov_info = (const void *)tlv_data;

  			if (tlv_len != sizeof(*recov_info))
  				goto invalid_tlv_len;
@@ -1063,10 +1065,10 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			}
  			break;
  		case IWL_UCODE_TLV_FW_FSEQ_VERSION: {
-			struct {
+			const struct {
  				u8 version[32];
  				u8 sha1[20];
-			} *fseq_ver = (void *)tlv_data;
+			} *fseq_ver = (const void *)tlv_data;

  			if (tlv_len != sizeof(*fseq_ver))
  				goto invalid_tlv_len;
@@ -1077,19 +1079,19 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  		case IWL_UCODE_TLV_FW_NUM_STATIONS:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
-			if (le32_to_cpup((__le32 *)tlv_data) >
+			if (le32_to_cpup((const __le32 *)tlv_data) >
  			    IWL_MVM_STATION_COUNT_MAX) {
  				IWL_ERR(drv,
  					"%d is an invalid number of station\n",
-					le32_to_cpup((__le32 *)tlv_data));
+					le32_to_cpup((const __le32 *)tlv_data));
  				goto tlv_error;
  			}
  			capa->num_stations =
-				le32_to_cpup((__le32 *)tlv_data);
+				le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_UMAC_DEBUG_ADDRS: {
-			struct iwl_umac_debug_addrs *dbg_ptrs =
-				(void *)tlv_data;
+			const struct iwl_umac_debug_addrs *dbg_ptrs =
+				(const void *)tlv_data;

  			if (tlv_len != sizeof(*dbg_ptrs))
  				goto invalid_tlv_len;
@@ -1104,8 +1106,8 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  			break;
  			}
  		case IWL_UCODE_TLV_LMAC_DEBUG_ADDRS: {
-			struct iwl_lmac_debug_addrs *dbg_ptrs =
-				(void *)tlv_data;
+			const struct iwl_lmac_debug_addrs *dbg_ptrs =
+				(const void *)tlv_data;

  			if (tlv_len != sizeof(*dbg_ptrs))
  				goto invalid_tlv_len;
@@ -1305,7 +1307,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
  {
  	struct iwl_drv *drv = context;
  	struct iwl_fw *fw = &drv->fw;
-	struct iwl_ucode_header *ucode;
+	const struct iwl_ucode_header *ucode;
  	struct iwlwifi_opmode_table *op;
  	int err;
  	struct iwl_firmware_pieces *pieces;
@@ -1342,7 +1344,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
  	}

  	/* Data from ucode file:  header followed by uCode images */
-	ucode = (struct iwl_ucode_header *)ucode_raw->data;
+	ucode = (const struct iwl_ucode_header *)ucode_raw->data;

  	if (ucode->ver)
  		err = iwl_parse_v1_v2_firmware(drv, ucode_raw, pieces);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index af684f80b0cc..776d524024c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -374,10 +374,10 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,

  		if (v4)
  			ch_flags =
-				__le32_to_cpup((__le32 *)nvm_ch_flags + ch_idx);
+				__le32_to_cpup((const __le32 *)nvm_ch_flags + ch_idx);
  		else
  			ch_flags =
-				__le16_to_cpup((__le16 *)nvm_ch_flags + ch_idx);
+				__le16_to_cpup((const __le16 *)nvm_ch_flags + ch_idx);

  		if (band == NL80211_BAND_5GHZ &&
  		    !data->sku_cap_band_52ghz_enable)
@@ -857,7 +857,7 @@ static int iwl_get_sku(const struct iwl_cfg *cfg, const __le16 *nvm_sw,
  	if (cfg->nvm_type != IWL_NVM_EXT)
  		return le16_to_cpup(nvm_sw + SKU);

-	return le32_to_cpup((__le32 *)(phy_sku + SKU_FAMILY_8000));
+	return le32_to_cpup((const __le32 *)(phy_sku + SKU_FAMILY_8000));
  }

  static int iwl_get_nvm_version(const struct iwl_cfg *cfg, const __le16 *nvm_sw)
@@ -865,7 +865,7 @@ static int iwl_get_nvm_version(const struct iwl_cfg *cfg, const __le16 *nvm_sw)
  	if (cfg->nvm_type != IWL_NVM_EXT)
  		return le16_to_cpup(nvm_sw + NVM_VERSION);
  	else
-		return le32_to_cpup((__le32 *)(nvm_sw +
+		return le32_to_cpup((const __le32 *)(nvm_sw +
  					       NVM_VERSION_EXT_NVM));
  }

@@ -875,7 +875,7 @@ static int iwl_get_radio_cfg(const struct iwl_cfg *cfg, const __le16 *nvm_sw,
  	if (cfg->nvm_type != IWL_NVM_EXT)
  		return le16_to_cpup(nvm_sw + RADIO_CFG);

-	return le32_to_cpup((__le32 *)(phy_sku + RADIO_CFG_FAMILY_EXT_NVM));
+	return le32_to_cpup((const __le32 *)(phy_sku + RADIO_CFG_FAMILY_EXT_NVM));

  }

@@ -886,7 +886,7 @@ static int iwl_get_n_hw_addrs(const struct iwl_cfg *cfg, const __le16 *nvm_sw)
  	if (cfg->nvm_type != IWL_NVM_EXT)
  		return le16_to_cpup(nvm_sw + N_HW_ADDRS);

-	n_hw_addr = le32_to_cpup((__le32 *)(nvm_sw + N_HW_ADDRS_FAMILY_8000));
+	n_hw_addr = le32_to_cpup((const __le32 *)(nvm_sw + N_HW_ADDRS_FAMILY_8000));

  	return n_hw_addr & N_HW_ADDR_MASK;
  }
@@ -1456,7 +1456,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
  	}

  	eof = fw_entry->data + fw_entry->size;
-	dword_buff = (__le32 *)fw_entry->data;
+	dword_buff = (const __le32 *)fw_entry->data;

  	/* some NVM file will contain a header.
  	 * The header is identified by 2 dwords header as follow:
@@ -1468,7 +1468,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
  	if (fw_entry->size > NVM_HEADER_SIZE &&
  	    dword_buff[0] == cpu_to_le32(NVM_HEADER_0) &&
  	    dword_buff[1] == cpu_to_le32(NVM_HEADER_1)) {
-		file_sec = (void *)(fw_entry->data + NVM_HEADER_SIZE);
+		file_sec = (const void *)(fw_entry->data + NVM_HEADER_SIZE);
  		IWL_INFO(trans, "NVM Version %08X\n", le32_to_cpu(dword_buff[2]));
  		IWL_INFO(trans, "NVM Manufacturing date %08X\n",
  			 le32_to_cpu(dword_buff[3]));
@@ -1481,7 +1481,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
  			goto out;
  		}
  	} else {
-		file_sec = (void *)fw_entry->data;
+		file_sec = (const void *)fw_entry->data;
  	}

  	while (true) {
@@ -1549,7 +1549,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
  		nvm_sections[section_id].length = section_size;

  		/* advance to the next section */
-		file_sec = (void *)(file_sec->data + section_size);
+		file_sec = (const void *)(file_sec->data + section_size);
  	}
  out:
  	release_firmware(fw_entry);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 60e0db4a5e20..3d2ce95b0421 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -190,10 +190,10 @@ IWL_EXPORT_SYMBOL(iwl_trans_send_cmd);
  static int iwl_hcmd_names_cmp(const void *key, const void *elt)
  {
  	const struct iwl_hcmd_names *name = elt;
-	u8 cmd1 = *(u8 *)key;
+	const u8 *cmd1 = key;
  	u8 cmd2 = name->cmd_id;

-	return (cmd1 - cmd2);
+	return (*cmd1 - cmd2);
  }

  const char *iwl_get_cmd_string(struct iwl_trans *trans, u32 id)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1ad621d13ad3..ace6f2c76747 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -603,7 +603,8 @@ static void iwl_mvm_probe_resp_set_noa(struct iwl_mvm *mvm,
  	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
  	int base_len = (u8 *)mgmt->u.probe_resp.variable - (u8 *)mgmt;
  	struct iwl_probe_resp_data *resp_data;
-	u8 *ie, *pos;
+	const u8 *ie;
+	u8 *pos;
  	u8 match[] = {
  		(WLAN_OUI_WFA >> 16) & 0xff,
  		(WLAN_OUI_WFA >> 8) & 0xff,
@@ -620,7 +621,7 @@ static void iwl_mvm_probe_resp_set_noa(struct iwl_mvm *mvm,
  	if (!resp_data->notif.noa_active)
  		goto out;

-	ie = (u8 *)cfg80211_find_ie_match(WLAN_EID_VENDOR_SPECIFIC,
+	ie = cfg80211_find_ie_match(WLAN_EID_VENDOR_SPECIFIC,
  					  mgmt->u.probe_resp.variable,
  					  skb->len - base_len,
  					  match, 4, 2);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 1bf4c37fe960..a8025c78f80b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -699,7 +699,7 @@ static int iwl_pcie_load_section(struct iwl_trans *trans, u8 section_num,
  			iwl_set_bits_prph(trans, LMPM_CHICK,
  					  LMPM_CHICK_EXTENDED_ADDR_SPACE);

-		memcpy(v_addr, (u8 *)section->data + offset, copy_size);
+		memcpy(v_addr, (const u8 *)section->data + offset, copy_size);
  		ret = iwl_pcie_load_firmware_chunk(trans, dst_addr, p_addr,
  						   copy_size);

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 6fd4c68a4a49..94ff80a2b8cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -890,7 +890,7 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
  	if (configure_scd) {
  		iwl_scd_txq_set_inactive(trans, txq_id);

-		iwl_trans_write_mem(trans, stts_addr, (void *)zero_val,
+		iwl_trans_write_mem(trans, stts_addr, zero_val,
  				    ARRAY_SIZE(zero_val));
  	}

