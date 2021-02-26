Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4253265E6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 17:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBZQyW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 11:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBZQyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 11:54:14 -0500
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41977C061756
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 08:53:31 -0800 (PST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 56F9076277;
        Fri, 26 Feb 2021 16:53:10 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DnG1f1Q3Nz4YH5;
        Fri, 26 Feb 2021 16:53:10 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (cross.sbone.de [195.201.62.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id D747F25D0;
        Fri, 26 Feb 2021 16:53:09 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id A4CA58D4A15C;
        Fri, 26 Feb 2021 16:53:07 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id 3A3B2E707FF;
        Fri, 26 Feb 2021 16:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id 6iLtYMjg5Hfu; Fri, 26 Feb 2021 16:52:47 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id B6BB2E707D9;
        Fri, 26 Feb 2021 16:52:47 +0000 (UTC)
Date:   Fri, 26 Feb 2021 16:52:47 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH iwlwifi-next] iwlwifi: propagate (const) type qualifier
Message-ID: <alpine.BSF.2.00.2102261652110.72241@ai.fobar.qr>
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

Sponsored-by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
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
@@ -33,132 +33,132 @@ static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
  static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
  				   size_t len)
  {
-	struct iwl_ucode_tlv *tlv;
+	const struct iwl_ucode_tlv *tlv;
  	u32 sha1 = 0;
  	u16 mac_type = 0, rf_id = 0;
  	u8 *pnvm_data = NULL, *tmp;
  	u32 size = 0;
  	int ret;

  	IWL_DEBUG_FW(trans, "Handling PNVM section\n");

  	while (len >= sizeof(*tlv)) {
  		u32 tlv_len, tlv_type;

  		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;

  		tlv_len = le32_to_cpu(tlv->length);
  		tlv_type = le32_to_cpu(tlv->type);

  		if (len < tlv_len) {
  			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
  				len, tlv_len);
  			ret = -EINVAL;
  			goto out;
  		}

  		data += sizeof(*tlv);

  		switch (tlv_type) {
  		case IWL_UCODE_TLV_PNVM_VERSION:
  			if (tlv_len < sizeof(__le32)) {
  				IWL_DEBUG_FW(trans,
  					     "Invalid size for IWL_UCODE_TLV_PNVM_VERSION (expected %zd, got %d)\n",
  					     sizeof(__le32), tlv_len);
  				break;
  			}

-			sha1 = le32_to_cpup((__le32 *)data);
+			sha1 = le32_to_cpup((const __le32 *)data);

  			IWL_DEBUG_FW(trans,
  				     "Got IWL_UCODE_TLV_PNVM_VERSION %0x\n",
  				     sha1);
  			break;
  		case IWL_UCODE_TLV_HW_TYPE:
  			if (tlv_len < 2 * sizeof(__le16)) {
  				IWL_DEBUG_FW(trans,
  					     "Invalid size for IWL_UCODE_TLV_HW_TYPE (expected %zd, got %d)\n",
  					     2 * sizeof(__le16), tlv_len);
  				break;
  			}

-			mac_type = le16_to_cpup((__le16 *)data);
-			rf_id = le16_to_cpup((__le16 *)(data + sizeof(__le16)));
+			mac_type = le16_to_cpup((const __le16 *)data);
+			rf_id = le16_to_cpup((const __le16 *)(data + sizeof(__le16)));

  			IWL_DEBUG_FW(trans,
  				     "Got IWL_UCODE_TLV_HW_TYPE mac_type 0x%0x rf_id 0x%0x\n",
  				     mac_type, rf_id);

  			if (mac_type != CSR_HW_REV_TYPE(trans->hw_rev) ||
  			    rf_id != CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
  				IWL_DEBUG_FW(trans,
  					     "HW mismatch, skipping PNVM section, mac_type 0x%0x, rf_id 0x%0x.\n",
  					     CSR_HW_REV_TYPE(trans->hw_rev), trans->hw_rf_id);
  				ret = -ENOENT;
  				goto out;
  			}

  			break;
  		case IWL_UCODE_TLV_SEC_RT: {
-			struct iwl_pnvm_section *section = (void *)data;
+			const struct iwl_pnvm_section *section = (const void *)data;
  			u32 data_len = tlv_len - sizeof(*section);

  			IWL_DEBUG_FW(trans,
  				     "Got IWL_UCODE_TLV_SEC_RT len %d\n",
  				     tlv_len);

  			/* TODO: remove, this is a deprecated separator */
-			if (le32_to_cpup((__le32 *)data) == 0xddddeeee) {
+			if (le32_to_cpup((const __le32 *)data) == 0xddddeeee) {
  				IWL_DEBUG_FW(trans, "Ignoring separator.\n");
  				break;
  			}

  			IWL_DEBUG_FW(trans, "Adding data (size %d)\n",
  				     data_len);

  			tmp = krealloc(pnvm_data, size + data_len, GFP_KERNEL);
  			if (!tmp) {
  				IWL_DEBUG_FW(trans,
  					     "Couldn't allocate (more) pnvm_data\n");

  				ret = -ENOMEM;
  				goto out;
  			}

  			pnvm_data = tmp;

  			memcpy(pnvm_data + size, section->data, data_len);

  			size += data_len;

  			break;
  		}
  		case IWL_UCODE_TLV_PNVM_SKU:
  			IWL_DEBUG_FW(trans,
  				     "New PNVM section started, stop parsing.\n");
  			goto done;
  		default:
  			IWL_DEBUG_FW(trans, "Found TLV 0x%0x, len %d\n",
  				     tlv_type, tlv_len);
  			break;
  		}

  		len -= ALIGN(tlv_len, 4);
  		data += ALIGN(tlv_len, 4);
  	}

  done:
  	if (!size) {
  		IWL_DEBUG_FW(trans, "Empty PNVM, skipping.\n");
  		ret = -ENOENT;
  		goto out;
  	}

  	IWL_INFO(trans, "loaded PNVM version 0x%0x\n", sha1);

  	ret = iwl_trans_set_pnvm(trans, pnvm_data, size);
  out:
  	kfree(pnvm_data);
  	return ret;
  }
@@ -166,71 +166,71 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
  static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
  			  size_t len)
  {
-	struct iwl_ucode_tlv *tlv;
+	const struct iwl_ucode_tlv *tlv;

  	IWL_DEBUG_FW(trans, "Parsing PNVM file\n");

  	while (len >= sizeof(*tlv)) {
  		u32 tlv_len, tlv_type;

  		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;

  		tlv_len = le32_to_cpu(tlv->length);
  		tlv_type = le32_to_cpu(tlv->type);

  		if (len < tlv_len) {
  			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
  				len, tlv_len);
  			return -EINVAL;
  		}

  		if (tlv_type == IWL_UCODE_TLV_PNVM_SKU) {
-			struct iwl_sku_id *sku_id =
-				(void *)(data + sizeof(*tlv));
+			const struct iwl_sku_id *sku_id =
+				(const void *)(data + sizeof(*tlv));

  			IWL_DEBUG_FW(trans,
  				     "Got IWL_UCODE_TLV_PNVM_SKU len %d\n",
  				     tlv_len);
  			IWL_DEBUG_FW(trans, "sku_id 0x%0x 0x%0x 0x%0x\n",
  				     le32_to_cpu(sku_id->data[0]),
  				     le32_to_cpu(sku_id->data[1]),
  				     le32_to_cpu(sku_id->data[2]));

  			data += sizeof(*tlv) + ALIGN(tlv_len, 4);
  			len -= ALIGN(tlv_len, 4);

  			if (trans->sku_id[0] == le32_to_cpu(sku_id->data[0]) &&
  			    trans->sku_id[1] == le32_to_cpu(sku_id->data[1]) &&
  			    trans->sku_id[2] == le32_to_cpu(sku_id->data[2])) {
  				int ret;

  				ret = iwl_pnvm_handle_section(trans, data, len);
  				if (!ret)
  					return 0;
  			} else {
  				IWL_DEBUG_FW(trans, "SKU ID didn't match!\n");
  			}
  		} else {
  			data += sizeof(*tlv) + ALIGN(tlv_len, 4);
  			len -= ALIGN(tlv_len, 4);
  		}
  	}

  	return -ENOENT;
  }

  /*
   * This is known to be broken on v4.19 and to work on v5.4.  Until we
   * figure out why this is the case and how to make it work, simply
   * disable the feature in old kernels.
   */
  #if defined(CONFIG_EFI)

  #define IWL_EFI_VAR_GUID EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
  				  0xb2, 0xec, 0xf5, 0xa3,	\
  				  0x59, 0x4f, 0x4a, 0xea)

  #define IWL_UEFI_OEM_PNVM_NAME	L"UefiCnvWlanOemSignedPnvm"

  #define IWL_HARDCODED_PNVM_SIZE 4096
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 579bc81cc0ae..187de7262f09 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -398,25 +398,25 @@ void iwl_dbg_tlv_free(struct iwl_trans *trans)
  static int iwl_dbg_tlv_parse_bin(struct iwl_trans *trans, const u8 *data,
  				 size_t len)
  {
  	const struct iwl_ucode_tlv *tlv;
  	u32 tlv_len;

  	while (len >= sizeof(*tlv)) {
  		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;

  		tlv_len = le32_to_cpu(tlv->length);

  		if (len < tlv_len) {
  			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
  				len, tlv_len);
  			return -EINVAL;
  		}
  		len -= ALIGN(tlv_len, 4);
  		data += sizeof(*tlv) + ALIGN(tlv_len, 4);

  		iwl_dbg_tlv_alloc(trans, tlv, true);
  	}

  	return 0;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index eb168dc535d4..79939f257c65 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -236,25 +236,25 @@ struct iwl_tlv_calib_data {
  struct iwl_firmware_pieces {
  	struct fw_img_parsing img[IWL_UCODE_TYPE_MAX];

  	u32 init_evtlog_ptr, init_evtlog_size, init_errlog_ptr;
  	u32 inst_evtlog_ptr, inst_evtlog_size, inst_errlog_ptr;

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
  };

  /*
   * These functions are just to extract uCode section data from the pieces
   * structure.
   */
@@ -325,76 +325,77 @@ static void set_sec_offset(struct iwl_firmware_pieces *pieces,
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
  		return -EINVAL;

  	for (i = 0, j = 0; i < IWL_UCODE_MAX_CS && i < l->size; i++) {
  		fwcs = &l->cs[j];

  		/* we skip schemes with zero cipher suite selector */
  		if (!fwcs->cipher)
  			continue;

  		fw->cs[j++] = *fwcs;
  	}

  	return 0;
  }

  /*
   * Gets uCode section from tlv.
   */
  static int iwl_store_ucode_sec(struct iwl_firmware_pieces *pieces,
  			       const void *data, enum iwl_ucode_type type,
  			       int size)
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

  	alloc_size = sizeof(*img->sec) * (img->sec_counter + 1);
  	sec = krealloc(img->sec, alloc_size, GFP_KERNEL);
  	if (!sec)
  		return -ENOMEM;
  	img->sec = sec;

  	sec = &img->sec[img->sec_counter];

  	sec->offset = le32_to_cpu(sec_parse->offset);
  	sec->data = sec_parse->data;
  	sec->size = size - sizeof(sec_parse->offset);

  	++img->sec_counter;

  	return 0;
  }

  static int iwl_set_default_calib(struct iwl_drv *drv, const u8 *data)
  {
-	struct iwl_tlv_calib_data *def_calib =
-					(struct iwl_tlv_calib_data *)data;
+	const struct iwl_tlv_calib_data *def_calib =
+					(const struct iwl_tlv_calib_data *)data;
  	u32 ucode_type = le32_to_cpu(def_calib->ucode_type);
  	if (ucode_type >= IWL_UCODE_TYPE_MAX) {
  		IWL_ERR(drv, "Wrong ucode_type %u for default calibration.\n",
  			ucode_type);
  		return -EINVAL;
  	}
  	drv->fw.default_calib[ucode_type].flow_trigger =
  		def_calib->calib.flow_trigger;
  	drv->fw.default_calib[ucode_type].event_trigger =
  		def_calib->calib.event_trigger;

  	return 0;
  }
@@ -402,20 +403,20 @@ static int iwl_set_default_calib(struct iwl_drv *drv, const u8 *data)
  static void iwl_set_ucode_api_flags(struct iwl_drv *drv, const u8 *data,
  				    struct iwl_ucode_capabilities *capa)
  {
-	const struct iwl_ucode_api *ucode_api = (void *)data;
+	const struct iwl_ucode_api *ucode_api = (const void *)data;
  	u32 api_index = le32_to_cpu(ucode_api->api_index);
  	u32 api_flags = le32_to_cpu(ucode_api->api_flags);
  	int i;

  	if (api_index >= DIV_ROUND_UP(NUM_IWL_UCODE_TLV_API, 32)) {
  		IWL_WARN(drv,
  			 "api flags index %d larger than supported by driver\n",
  			 api_index);
  		return;
  	}

  	for (i = 0; i < 32; i++) {
  		if (api_flags & BIT(i))
  			__set_bit(i + 32 * api_index, capa->_api);
  	}
  }
@@ -423,20 +424,20 @@ static void iwl_set_ucode_api_flags(struct iwl_drv *drv, const u8 *data,
  static void iwl_set_ucode_capabilities(struct iwl_drv *drv, const u8 *data,
  				       struct iwl_ucode_capabilities *capa)
  {
-	const struct iwl_ucode_capa *ucode_capa = (void *)data;
+	const struct iwl_ucode_capa *ucode_capa = (const void *)data;
  	u32 api_index = le32_to_cpu(ucode_capa->api_index);
  	u32 api_flags = le32_to_cpu(ucode_capa->api_capa);
  	int i;

  	if (api_index >= DIV_ROUND_UP(NUM_IWL_UCODE_TLV_CAPA, 32)) {
  		IWL_WARN(drv,
  			 "capa flags index %d larger than supported by driver\n",
  			 api_index);
  		return;
  	}

  	for (i = 0; i < 32; i++) {
  		if (api_flags & BIT(i))
  			__set_bit(i + 32 * api_index, capa->_capa);
  	}
  }
@@ -454,100 +455,100 @@ static const char *iwl_reduced_fw_name(struct iwl_drv *drv)
  static int iwl_parse_v1_v2_firmware(struct iwl_drv *drv,
  				    const struct firmware *ucode_raw,
  				    struct iwl_firmware_pieces *pieces)
  {
-	struct iwl_ucode_header *ucode = (void *)ucode_raw->data;
+	const struct iwl_ucode_header *ucode = (const void *)ucode_raw->data;
  	u32 api_ver, hdr_size, build;
  	char buildstr[25];
  	const u8 *src;

  	drv->fw.ucode_ver = le32_to_cpu(ucode->ver);
  	api_ver = IWL_UCODE_API(drv->fw.ucode_ver);

  	switch (api_ver) {
  	default:
  		hdr_size = 28;
  		if (ucode_raw->size < hdr_size) {
  			IWL_ERR(drv, "File size too small!\n");
  			return -EINVAL;
  		}
  		build = le32_to_cpu(ucode->u.v2.build);
  		set_sec_size(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_INST,
  			     le32_to_cpu(ucode->u.v2.inst_size));
  		set_sec_size(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_DATA,
  			     le32_to_cpu(ucode->u.v2.data_size));
  		set_sec_size(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_INST,
  			     le32_to_cpu(ucode->u.v2.init_size));
  		set_sec_size(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_DATA,
  			     le32_to_cpu(ucode->u.v2.init_data_size));
  		src = ucode->u.v2.data;
  		break;
  	case 0:
  	case 1:
  	case 2:
  		hdr_size = 24;
  		if (ucode_raw->size < hdr_size) {
  			IWL_ERR(drv, "File size too small!\n");
  			return -EINVAL;
  		}
  		build = 0;
  		set_sec_size(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_INST,
  			     le32_to_cpu(ucode->u.v1.inst_size));
  		set_sec_size(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_DATA,
  			     le32_to_cpu(ucode->u.v1.data_size));
  		set_sec_size(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_INST,
  			     le32_to_cpu(ucode->u.v1.init_size));
  		set_sec_size(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_DATA,
  			     le32_to_cpu(ucode->u.v1.init_data_size));
  		src = ucode->u.v1.data;
  		break;
  	}

  	if (build)
  		sprintf(buildstr, " build %u", build);
  	else
  		buildstr[0] = '\0';

  	snprintf(drv->fw.fw_version,
  		 sizeof(drv->fw.fw_version),
  		 "%u.%u.%u.%u%s %s",
  		 IWL_UCODE_MAJOR(drv->fw.ucode_ver),
  		 IWL_UCODE_MINOR(drv->fw.ucode_ver),
  		 IWL_UCODE_API(drv->fw.ucode_ver),
  		 IWL_UCODE_SERIAL(drv->fw.ucode_ver),
  		 buildstr, iwl_reduced_fw_name(drv));

  	/* Verify size of file vs. image size info in file's header */

  	if (ucode_raw->size != hdr_size +
  	    get_sec_size(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_INST) +
  	    get_sec_size(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_DATA) +
  	    get_sec_size(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_INST) +
  	    get_sec_size(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_DATA)) {

  		IWL_ERR(drv,
  			"uCode file size %d does not match expected size\n",
  			(int)ucode_raw->size);
  		return -EINVAL;
  	}


  	set_sec_data(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_INST, src);
  	src += get_sec_size(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_INST);
  	set_sec_offset(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_INST,
  		       IWLAGN_RTC_INST_LOWER_BOUND);
  	set_sec_data(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_DATA, src);
  	src += get_sec_size(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_DATA);
  	set_sec_offset(pieces, IWL_UCODE_REGULAR, IWL_UCODE_SECTION_DATA,
  		       IWLAGN_RTC_DATA_LOWER_BOUND);
  	set_sec_data(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_INST, src);
  	src += get_sec_size(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_INST);
  	set_sec_offset(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_INST,
  		       IWLAGN_RTC_INST_LOWER_BOUND);
  	set_sec_data(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_DATA, src);
  	src += get_sec_size(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_DATA);
  	set_sec_offset(pieces, IWL_UCODE_INIT, IWL_UCODE_SECTION_DATA,
  		       IWLAGN_RTC_DATA_LOWER_BOUND);
  	return 0;
  }

  #define FW_ADDR_CACHE_CONTROL 0xC0000000
@@ -555,633 +556,634 @@ static int iwl_parse_v1_v2_firmware(struct iwl_drv *drv,
  static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
  				const struct firmware *ucode_raw,
  				struct iwl_firmware_pieces *pieces,
  				struct iwl_ucode_capabilities *capa,
  				bool *usniffer_images)
  {
-	struct iwl_tlv_ucode_header *ucode = (void *)ucode_raw->data;
+	const struct iwl_tlv_ucode_header *ucode = (const void *)ucode_raw->data;
  	const struct iwl_ucode_tlv *tlv;
  	size_t len = ucode_raw->size;
  	const u8 *data;
  	u32 tlv_len;
  	u32 usniffer_img;
  	enum iwl_ucode_tlv_type tlv_type;
  	const u8 *tlv_data;
  	char buildstr[25];
  	u32 build, paging_mem_size;
  	int num_of_cpus;
  	bool usniffer_req = false;

  	if (len < sizeof(*ucode)) {
  		IWL_ERR(drv, "uCode has invalid length: %zd\n", len);
  		return -EINVAL;
  	}

  	if (ucode->magic != cpu_to_le32(IWL_TLV_UCODE_MAGIC)) {
  		IWL_ERR(drv, "invalid uCode magic: 0X%x\n",
  			le32_to_cpu(ucode->magic));
  		return -EINVAL;
  	}

  	drv->fw.ucode_ver = le32_to_cpu(ucode->ver);
  	memcpy(drv->fw.human_readable, ucode->human_readable,
  	       sizeof(drv->fw.human_readable));
  	build = le32_to_cpu(ucode->build);

  	if (build)
  		sprintf(buildstr, " build %u", build);
  	else
  		buildstr[0] = '\0';

  	snprintf(drv->fw.fw_version,
  		 sizeof(drv->fw.fw_version),
  		 "%u.%u.%u.%u%s %s",
  		 IWL_UCODE_MAJOR(drv->fw.ucode_ver),
  		 IWL_UCODE_MINOR(drv->fw.ucode_ver),
  		 IWL_UCODE_API(drv->fw.ucode_ver),
  		 IWL_UCODE_SERIAL(drv->fw.ucode_ver),
  		 buildstr, iwl_reduced_fw_name(drv));

  	data = ucode->data;

  	len -= sizeof(*ucode);

  	while (len >= sizeof(*tlv)) {
  		len -= sizeof(*tlv);
-		tlv = (void *)data;
+		tlv = (const void *)data;

  		tlv_len = le32_to_cpu(tlv->length);
  		tlv_type = le32_to_cpu(tlv->type);
  		tlv_data = tlv->data;

  		if (len < tlv_len) {
  			IWL_ERR(drv, "invalid TLV len: %zd/%u\n",
  				len, tlv_len);
  			return -EINVAL;
  		}
  		len -= ALIGN(tlv_len, 4);
  		data += sizeof(*tlv) + ALIGN(tlv_len, 4);

  		switch (tlv_type) {
  		case IWL_UCODE_TLV_INST:
  			set_sec_data(pieces, IWL_UCODE_REGULAR,
  				     IWL_UCODE_SECTION_INST, tlv_data);
  			set_sec_size(pieces, IWL_UCODE_REGULAR,
  				     IWL_UCODE_SECTION_INST, tlv_len);
  			set_sec_offset(pieces, IWL_UCODE_REGULAR,
  				       IWL_UCODE_SECTION_INST,
  				       IWLAGN_RTC_INST_LOWER_BOUND);
  			break;
  		case IWL_UCODE_TLV_DATA:
  			set_sec_data(pieces, IWL_UCODE_REGULAR,
  				     IWL_UCODE_SECTION_DATA, tlv_data);
  			set_sec_size(pieces, IWL_UCODE_REGULAR,
  				     IWL_UCODE_SECTION_DATA, tlv_len);
  			set_sec_offset(pieces, IWL_UCODE_REGULAR,
  				       IWL_UCODE_SECTION_DATA,
  				       IWLAGN_RTC_DATA_LOWER_BOUND);
  			break;
  		case IWL_UCODE_TLV_INIT:
  			set_sec_data(pieces, IWL_UCODE_INIT,
  				     IWL_UCODE_SECTION_INST, tlv_data);
  			set_sec_size(pieces, IWL_UCODE_INIT,
  				     IWL_UCODE_SECTION_INST, tlv_len);
  			set_sec_offset(pieces, IWL_UCODE_INIT,
  				       IWL_UCODE_SECTION_INST,
  				       IWLAGN_RTC_INST_LOWER_BOUND);
  			break;
  		case IWL_UCODE_TLV_INIT_DATA:
  			set_sec_data(pieces, IWL_UCODE_INIT,
  				     IWL_UCODE_SECTION_DATA, tlv_data);
  			set_sec_size(pieces, IWL_UCODE_INIT,
  				     IWL_UCODE_SECTION_DATA, tlv_len);
  			set_sec_offset(pieces, IWL_UCODE_INIT,
  				       IWL_UCODE_SECTION_DATA,
  				       IWLAGN_RTC_DATA_LOWER_BOUND);
  			break;
  		case IWL_UCODE_TLV_BOOT:
  			IWL_ERR(drv, "Found unexpected BOOT ucode\n");
  			break;
  		case IWL_UCODE_TLV_PROBE_MAX_LEN:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			capa->max_probe_length =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_PAN:
  			if (tlv_len)
  				goto invalid_tlv_len;
  			capa->flags |= IWL_UCODE_TLV_FLAGS_PAN;
  			break;
  		case IWL_UCODE_TLV_FLAGS:
  			/* must be at least one u32 */
  			if (tlv_len < sizeof(u32))
  				goto invalid_tlv_len;
  			/* and a proper number of u32s */
  			if (tlv_len % sizeof(u32))
  				goto invalid_tlv_len;
  			/*
  			 * This driver only reads the first u32 as
  			 * right now no more features are defined,
  			 * if that changes then either the driver
  			 * will not work with the new firmware, or
  			 * it'll not take advantage of new features.
  			 */
-			capa->flags = le32_to_cpup((__le32 *)tlv_data);
+			capa->flags = le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_API_CHANGES_SET:
  			if (tlv_len != sizeof(struct iwl_ucode_api))
  				goto invalid_tlv_len;
  			iwl_set_ucode_api_flags(drv, tlv_data, capa);
  			break;
  		case IWL_UCODE_TLV_ENABLED_CAPABILITIES:
  			if (tlv_len != sizeof(struct iwl_ucode_capa))
  				goto invalid_tlv_len;
  			iwl_set_ucode_capabilities(drv, tlv_data, capa);
  			break;
  		case IWL_UCODE_TLV_INIT_EVTLOG_PTR:
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
  				goto invalid_tlv_len;
  			drv->fw.enhance_sensitivity_table = true;
  			break;
  		case IWL_UCODE_TLV_WOWLAN_INST:
  			set_sec_data(pieces, IWL_UCODE_WOWLAN,
  				     IWL_UCODE_SECTION_INST, tlv_data);
  			set_sec_size(pieces, IWL_UCODE_WOWLAN,
  				     IWL_UCODE_SECTION_INST, tlv_len);
  			set_sec_offset(pieces, IWL_UCODE_WOWLAN,
  				       IWL_UCODE_SECTION_INST,
  				       IWLAGN_RTC_INST_LOWER_BOUND);
  			break;
  		case IWL_UCODE_TLV_WOWLAN_DATA:
  			set_sec_data(pieces, IWL_UCODE_WOWLAN,
  				     IWL_UCODE_SECTION_DATA, tlv_data);
  			set_sec_size(pieces, IWL_UCODE_WOWLAN,
  				     IWL_UCODE_SECTION_DATA, tlv_len);
  			set_sec_offset(pieces, IWL_UCODE_WOWLAN,
  				       IWL_UCODE_SECTION_DATA,
  				       IWLAGN_RTC_DATA_LOWER_BOUND);
  			break;
  		case IWL_UCODE_TLV_PHY_CALIBRATION_SIZE:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			capa->standard_phy_calibration_size =
-					le32_to_cpup((__le32 *)tlv_data);
+					le32_to_cpup((const __le32 *)tlv_data);
  			break;
  		case IWL_UCODE_TLV_SEC_RT:
  			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_REGULAR,
  					    tlv_len);
  			drv->fw.type = IWL_FW_MVM;
  			break;
  		case IWL_UCODE_TLV_SEC_INIT:
  			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_INIT,
  					    tlv_len);
  			drv->fw.type = IWL_FW_MVM;
  			break;
  		case IWL_UCODE_TLV_SEC_WOWLAN:
  			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_WOWLAN,
  					    tlv_len);
  			drv->fw.type = IWL_FW_MVM;
  			break;
  		case IWL_UCODE_TLV_DEF_CALIB:
  			if (tlv_len != sizeof(struct iwl_tlv_calib_data))
  				goto invalid_tlv_len;
  			if (iwl_set_default_calib(drv, tlv_data))
  				goto tlv_error;
  			break;
  		case IWL_UCODE_TLV_PHY_SKU:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
-			drv->fw.phy_config = le32_to_cpup((__le32 *)tlv_data);
+			drv->fw.phy_config = le32_to_cpup((const __le32 *)tlv_data);
  			drv->fw.valid_tx_ant = (drv->fw.phy_config &
  						FW_PHY_CFG_TX_CHAIN) >>
  						FW_PHY_CFG_TX_CHAIN_POS;
  			drv->fw.valid_rx_ant = (drv->fw.phy_config &
  						FW_PHY_CFG_RX_CHAIN) >>
  						FW_PHY_CFG_RX_CHAIN_POS;
  			break;
  		case IWL_UCODE_TLV_SECURE_SEC_RT:
  			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_REGULAR,
  					    tlv_len);
  			drv->fw.type = IWL_FW_MVM;
  			break;
  		case IWL_UCODE_TLV_SECURE_SEC_INIT:
  			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_INIT,
  					    tlv_len);
  			drv->fw.type = IWL_FW_MVM;
  			break;
  		case IWL_UCODE_TLV_SECURE_SEC_WOWLAN:
  			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_WOWLAN,
  					    tlv_len);
  			drv->fw.type = IWL_FW_MVM;
  			break;
  		case IWL_UCODE_TLV_NUM_OF_CPU:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
  			num_of_cpus =
-				le32_to_cpup((__le32 *)tlv_data);
+				le32_to_cpup((const __le32 *)tlv_data);

  			if (num_of_cpus == 2) {
  				drv->fw.img[IWL_UCODE_REGULAR].is_dual_cpus =
  					true;
  				drv->fw.img[IWL_UCODE_INIT].is_dual_cpus =
  					true;
  				drv->fw.img[IWL_UCODE_WOWLAN].is_dual_cpus =
  					true;
  			} else if ((num_of_cpus > 2) || (num_of_cpus < 1)) {
  				IWL_ERR(drv, "Driver support upto 2 CPUs\n");
  				return -EINVAL;
  			}
  			break;
  		case IWL_UCODE_TLV_CSCHEME:
  			if (iwl_store_cscheme(&drv->fw, tlv_data, tlv_len))
  				goto invalid_tlv_len;
  			break;
  		case IWL_UCODE_TLV_N_SCAN_CHANNELS:
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

  			if (tlv_len != sizeof(u32) * 3)
  				goto invalid_tlv_len;

  			major = le32_to_cpup(ptr++);
  			minor = le32_to_cpup(ptr++);
  			local_comp = le32_to_cpup(ptr);

  			if (major >= 35)
  				snprintf(drv->fw.fw_version,
  					 sizeof(drv->fw.fw_version),
  					"%u.%08x.%u %s", major, minor,
  					local_comp, iwl_reduced_fw_name(drv));
  			else
  				snprintf(drv->fw.fw_version,
  					 sizeof(drv->fw.fw_version),
  					"%u.%u.%u %s", major, minor,
  					local_comp, iwl_reduced_fw_name(drv));
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
  					*pieces->dbg_dest_ver);
  				break;
  			}

  			if (pieces->dbg_dest_tlv_init) {
  				IWL_ERR(drv,
  					"dbg destination ignored, already exists\n");
  				break;
  			}

  			pieces->dbg_dest_tlv_init = true;

  			if (dest_v1) {
  				pieces->dbg_dest_tlv_v1 = dest_v1;
  				mon_mode = dest_v1->monitor_mode;
  			} else {
  				pieces->dbg_dest_tlv = dest;
  				mon_mode = dest->monitor_mode;
  			}

  			IWL_INFO(drv, "Found debug destination: %s\n",
  				 get_fw_dbg_mode_string(mon_mode));

  			drv->fw.dbg.n_dest_reg = (dest_v1) ?
  				tlv_len -
  				offsetof(struct iwl_fw_dbg_dest_tlv_v1,
  					 reg_ops) :
  				tlv_len -
  				offsetof(struct iwl_fw_dbg_dest_tlv,
  					 reg_ops);

  			drv->fw.dbg.n_dest_reg /=
  				sizeof(drv->fw.dbg.dest_tlv->reg_ops[0]);

  			break;
  			}
  		case IWL_UCODE_TLV_FW_DBG_CONF: {
-			struct iwl_fw_dbg_conf_tlv *conf = (void *)tlv_data;
+			const struct iwl_fw_dbg_conf_tlv *conf =
+				(const void *)tlv_data;

  			if (!pieces->dbg_dest_tlv_init) {
  				IWL_ERR(drv,
  					"Ignore dbg config %d - no destination configured\n",
  					conf->id);
  				break;
  			}

  			if (conf->id >= ARRAY_SIZE(drv->fw.dbg.conf_tlv)) {
  				IWL_ERR(drv,
  					"Skip unknown configuration: %d\n",
  					conf->id);
  				break;
  			}

  			if (pieces->dbg_conf_tlv[conf->id]) {
  				IWL_ERR(drv,
  					"Ignore duplicate dbg config %d\n",
  					conf->id);
  				break;
  			}

  			if (conf->usniffer)
  				usniffer_req = true;

  			IWL_INFO(drv, "Found debug configuration: %d\n",
  				 conf->id);

  			pieces->dbg_conf_tlv[conf->id] = conf;
  			pieces->dbg_conf_tlv_len[conf->id] = tlv_len;
  			break;
  			}
  		case IWL_UCODE_TLV_FW_DBG_TRIGGER: {
-			struct iwl_fw_dbg_trigger_tlv *trigger =
-				(void *)tlv_data;
+			const struct iwl_fw_dbg_trigger_tlv *trigger =
+				(const void *)tlv_data;
  			u32 trigger_id = le32_to_cpu(trigger->id);

  			if (trigger_id >= ARRAY_SIZE(drv->fw.dbg.trigger_tlv)) {
  				IWL_ERR(drv,
  					"Skip unknown trigger: %u\n",
  					trigger->id);
  				break;
  			}

  			if (pieces->dbg_trigger_tlv[trigger_id]) {
  				IWL_ERR(drv,
  					"Ignore duplicate dbg trigger %u\n",
  					trigger->id);
  				break;
  			}

  			IWL_INFO(drv, "Found debug trigger: %u\n", trigger->id);

  			pieces->dbg_trigger_tlv[trigger_id] = trigger;
  			pieces->dbg_trigger_tlv_len[trigger_id] = tlv_len;
  			break;
  			}
  		case IWL_UCODE_TLV_FW_DBG_DUMP_LST: {
  			if (tlv_len != sizeof(u32)) {
  				IWL_ERR(drv,
  					"dbg lst mask size incorrect, skip\n");
  				break;
  			}

  			drv->fw.dbg.dump_mask =
-				le32_to_cpup((__le32 *)tlv_data);
+				le32_to_cpup((const __le32 *)tlv_data);
  			break;
  			}
  		case IWL_UCODE_TLV_SEC_RT_USNIFFER:
  			*usniffer_images = true;
  			iwl_store_ucode_sec(pieces, tlv_data,
  					    IWL_UCODE_REGULAR_USNIFFER,
  					    tlv_len);
  			break;
  		case IWL_UCODE_TLV_PAGING:
  			if (tlv_len != sizeof(u32))
  				goto invalid_tlv_len;
-			paging_mem_size = le32_to_cpup((__le32 *)tlv_data);
+			paging_mem_size = le32_to_cpup((const __le32 *)tlv_data);

  			IWL_DEBUG_FW(drv,
  				     "Paging: paging enabled (size = %u bytes)\n",
  				     paging_mem_size);

  			if (paging_mem_size > MAX_PAGING_IMAGE_SIZE) {
  				IWL_ERR(drv,
  					"Paging: driver supports up to %lu bytes for paging image\n",
  					MAX_PAGING_IMAGE_SIZE);
  				return -EINVAL;
  			}

  			if (paging_mem_size & (FW_PAGING_SIZE - 1)) {
  				IWL_ERR(drv,
  					"Paging: image isn't multiple %lu\n",
  					FW_PAGING_SIZE);
  				return -EINVAL;
  			}

  			drv->fw.img[IWL_UCODE_REGULAR].paging_mem_size =
  				paging_mem_size;
  			usniffer_img = IWL_UCODE_REGULAR_USNIFFER;
  			drv->fw.img[usniffer_img].paging_mem_size =
  				paging_mem_size;
  			break;
  		case IWL_UCODE_TLV_FW_GSCAN_CAPA:
  			/* ignored */
  			break;
  		case IWL_UCODE_TLV_FW_MEM_SEG: {
-			struct iwl_fw_dbg_mem_seg_tlv *dbg_mem =
-				(void *)tlv_data;
+			const struct iwl_fw_dbg_mem_seg_tlv *dbg_mem =
+				(const void *)tlv_data;
  			size_t size;
  			struct iwl_fw_dbg_mem_seg_tlv *n;

  			if (tlv_len != (sizeof(*dbg_mem)))
  				goto invalid_tlv_len;

  			IWL_DEBUG_INFO(drv, "Found debug memory segment: %u\n",
  				       dbg_mem->data_type);

  			size = sizeof(*pieces->dbg_mem_tlv) *
  			       (pieces->n_mem_tlv + 1);
  			n = krealloc(pieces->dbg_mem_tlv, size, GFP_KERNEL);
  			if (!n)
  				return -ENOMEM;
  			pieces->dbg_mem_tlv = n;
  			pieces->dbg_mem_tlv[pieces->n_mem_tlv] = *dbg_mem;
  			pieces->n_mem_tlv++;
  			break;
  			}
  		case IWL_UCODE_TLV_IML: {
  			drv->fw.iml_len = tlv_len;
  			drv->fw.iml = kmemdup(tlv_data, tlv_len, GFP_KERNEL);
  			if (!drv->fw.iml)
  				return -ENOMEM;
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
  			capa->error_log_addr =
  				le32_to_cpu(recov_info->buf_addr);
  			capa->error_log_size =
  				le32_to_cpu(recov_info->buf_size);
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
  			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %s\n",
  				 fseq_ver->version);
  			}
  			break;
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
  			if (drv->trans->trans_cfg->device_family <
  			    IWL_DEVICE_FAMILY_22000)
  				break;
  			drv->trans->dbg.umac_error_event_table =
  				le32_to_cpu(dbg_ptrs->error_info_addr) &
  				~FW_ADDR_CACHE_CONTROL;
  			drv->trans->dbg.error_event_table_tlv_status |=
  				IWL_ERROR_EVENT_TABLE_UMAC;
  			break;
  			}
  		case IWL_UCODE_TLV_LMAC_DEBUG_ADDRS: {
-			struct iwl_lmac_debug_addrs *dbg_ptrs =
-				(void *)tlv_data;
+			const struct iwl_lmac_debug_addrs *dbg_ptrs =
+				(const void *)tlv_data;

  			if (tlv_len != sizeof(*dbg_ptrs))
  				goto invalid_tlv_len;
  			if (drv->trans->trans_cfg->device_family <
  			    IWL_DEVICE_FAMILY_22000)
  				break;
  			drv->trans->dbg.lmac_error_event_table[0] =
  				le32_to_cpu(dbg_ptrs->error_event_table_ptr) &
  				~FW_ADDR_CACHE_CONTROL;
  			drv->trans->dbg.error_event_table_tlv_status |=
  				IWL_ERROR_EVENT_TABLE_LMAC1;
  			break;
  			}
  		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
  		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
  		case IWL_UCODE_TLV_TYPE_HCMD:
  		case IWL_UCODE_TLV_TYPE_REGIONS:
  		case IWL_UCODE_TLV_TYPE_TRIGGERS:
  			if (iwlwifi_mod_params.enable_ini)
  				iwl_dbg_tlv_alloc(drv->trans, tlv, false);
  			break;
  		case IWL_UCODE_TLV_CMD_VERSIONS:
  			if (tlv_len % sizeof(struct iwl_fw_cmd_version)) {
  				IWL_ERR(drv,
  					"Invalid length for command versions: %u\n",
  					tlv_len);
  				tlv_len /= sizeof(struct iwl_fw_cmd_version);
  				tlv_len *= sizeof(struct iwl_fw_cmd_version);
  			}
  			if (WARN_ON(capa->cmd_versions))
  				return -EINVAL;
  			capa->cmd_versions = kmemdup(tlv_data, tlv_len,
  						     GFP_KERNEL);
  			if (!capa->cmd_versions)
  				return -ENOMEM;
  			capa->n_cmd_versions =
  				tlv_len / sizeof(struct iwl_fw_cmd_version);
  			break;
  		case IWL_UCODE_TLV_PHY_INTEGRATION_VERSION:
  			if (drv->fw.phy_integration_ver) {
  				IWL_ERR(drv,
  					"phy integration str ignored, already exists\n");
  				break;
  			}

  			drv->fw.phy_integration_ver =
  				kmemdup(tlv_data, tlv_len, GFP_KERNEL);
  			if (!drv->fw.phy_integration_ver)
  				return -ENOMEM;
  			drv->fw.phy_integration_ver_len = tlv_len;
  			break;
  		default:
  			IWL_DEBUG_INFO(drv, "unknown TLV: %d\n", tlv_type);
  			break;
  		}
  	}

  	if (!fw_has_capa(capa, IWL_UCODE_TLV_CAPA_USNIFFER_UNIFIED) &&
  	    usniffer_req && !*usniffer_images) {
  		IWL_ERR(drv,
  			"user selected to work with usniffer but usniffer image isn't available in ucode package\n");
  		return -EINVAL;
  	}

  	if (len) {
  		IWL_ERR(drv, "invalid TLV after parsing: %zd\n", len);
  		iwl_print_hex_dump(drv, IWL_DL_FW, (u8 *)data, len);
  		return -EINVAL;
  	}

  	return 0;

   invalid_tlv_len:
  	IWL_ERR(drv, "TLV %d has invalid size: %u\n", tlv_type, tlv_len);
   tlv_error:
  	iwl_print_hex_dump(drv, IWL_DL_FW, tlv_data, tlv_len);

  	return -EINVAL;
  }
@@ -1298,312 +1300,312 @@ static void _iwl_op_mode_stop(struct iwl_drv *drv)
  /*
   * iwl_req_fw_callback - callback when firmware was loaded
   *
   * If loaded successfully, copies the firmware into buffers
   * for the card to fetch (via DMA).
   */
  static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
  {
  	struct iwl_drv *drv = context;
  	struct iwl_fw *fw = &drv->fw;
-	struct iwl_ucode_header *ucode;
+	const struct iwl_ucode_header *ucode;
  	struct iwlwifi_opmode_table *op;
  	int err;
  	struct iwl_firmware_pieces *pieces;
  	const unsigned int api_max = drv->trans->cfg->ucode_api_max;
  	const unsigned int api_min = drv->trans->cfg->ucode_api_min;
  	size_t trigger_tlv_sz[FW_DBG_TRIGGER_MAX];
  	u32 api_ver;
  	int i;
  	bool load_module = false;
  	bool usniffer_images = false;

  	fw->ucode_capa.max_probe_length = IWL_DEFAULT_MAX_PROBE_LENGTH;
  	fw->ucode_capa.standard_phy_calibration_size =
  			IWL_DEFAULT_STANDARD_PHY_CALIBRATE_TBL_SIZE;
  	fw->ucode_capa.n_scan_channels = IWL_DEFAULT_SCAN_CHANNELS;
  	fw->ucode_capa.num_stations = IWL_MVM_STATION_COUNT_MAX;
  	/* dump all fw memory areas by default */
  	fw->dbg.dump_mask = 0xffffffff;

  	pieces = kzalloc(sizeof(*pieces), GFP_KERNEL);
  	if (!pieces)
  		goto out_free_fw;

  	if (!ucode_raw)
  		goto try_again;

  	IWL_DEBUG_FW_INFO(drv, "Loaded firmware file '%s' (%zd bytes).\n",
  			  drv->firmware_name, ucode_raw->size);

  	/* Make sure that we got at least the API version number */
  	if (ucode_raw->size < 4) {
  		IWL_ERR(drv, "File size way too small!\n");
  		goto try_again;
  	}

  	/* Data from ucode file:  header followed by uCode images */
-	ucode = (struct iwl_ucode_header *)ucode_raw->data;
+	ucode = (const struct iwl_ucode_header *)ucode_raw->data;

  	if (ucode->ver)
  		err = iwl_parse_v1_v2_firmware(drv, ucode_raw, pieces);
  	else
  		err = iwl_parse_tlv_firmware(drv, ucode_raw, pieces,
  					     &fw->ucode_capa, &usniffer_images);

  	if (err)
  		goto try_again;

  	if (fw_has_api(&drv->fw.ucode_capa, IWL_UCODE_TLV_API_NEW_VERSION))
  		api_ver = drv->fw.ucode_ver;
  	else
  		api_ver = IWL_UCODE_API(drv->fw.ucode_ver);

  	/*
  	 * api_ver should match the api version forming part of the
  	 * firmware filename ... but we don't check for that and only rely
  	 * on the API version read from firmware header from here on forward
  	 */
  	if (api_ver < api_min || api_ver > api_max) {
  		IWL_ERR(drv,
  			"Driver unable to support your firmware API. "
  			"Driver supports v%u, firmware is v%u.\n",
  			api_max, api_ver);
  		goto try_again;
  	}

  	/*
  	 * In mvm uCode there is no difference between data and instructions
  	 * sections.
  	 */
  	if (fw->type == IWL_FW_DVM && validate_sec_sizes(drv, pieces,
  							 drv->trans->cfg))
  		goto try_again;

  	/* Allocate ucode buffers for card's bus-master loading ... */

  	/* Runtime instructions and 2 copies of data:
  	 * 1) unmodified from disk
  	 * 2) backup cache for save/restore during power-downs
  	 */
  	for (i = 0; i < IWL_UCODE_TYPE_MAX; i++)
  		if (iwl_alloc_ucode(drv, pieces, i))
  			goto out_free_fw;

  	if (pieces->dbg_dest_tlv_init) {
  		size_t dbg_dest_size = sizeof(*drv->fw.dbg.dest_tlv) +
  			sizeof(drv->fw.dbg.dest_tlv->reg_ops[0]) *
  			drv->fw.dbg.n_dest_reg;

  		drv->fw.dbg.dest_tlv = kmalloc(dbg_dest_size, GFP_KERNEL);

  		if (!drv->fw.dbg.dest_tlv)
  			goto out_free_fw;

  		if (*pieces->dbg_dest_ver == 0) {
  			memcpy(drv->fw.dbg.dest_tlv, pieces->dbg_dest_tlv_v1,
  			       dbg_dest_size);
  		} else {
  			struct iwl_fw_dbg_dest_tlv_v1 *dest_tlv =
  				drv->fw.dbg.dest_tlv;

  			dest_tlv->version = pieces->dbg_dest_tlv->version;
  			dest_tlv->monitor_mode =
  				pieces->dbg_dest_tlv->monitor_mode;
  			dest_tlv->size_power =
  				pieces->dbg_dest_tlv->size_power;
  			dest_tlv->wrap_count =
  				pieces->dbg_dest_tlv->wrap_count;
  			dest_tlv->write_ptr_reg =
  				pieces->dbg_dest_tlv->write_ptr_reg;
  			dest_tlv->base_shift =
  				pieces->dbg_dest_tlv->base_shift;
  			memcpy(dest_tlv->reg_ops,
  			       pieces->dbg_dest_tlv->reg_ops,
  			       sizeof(drv->fw.dbg.dest_tlv->reg_ops[0]) *
  			       drv->fw.dbg.n_dest_reg);

  			/* In version 1 of the destination tlv, which is
  			 * relevant for internal buffer exclusively,
  			 * the base address is part of given with the length
  			 * of the buffer, and the size shift is give instead of
  			 * end shift. We now store these values in base_reg,
  			 * and end shift, and when dumping the data we'll
  			 * manipulate it for extracting both the length and
  			 * base address */
  			dest_tlv->base_reg = pieces->dbg_dest_tlv->cfg_reg;
  			dest_tlv->end_shift =
  				pieces->dbg_dest_tlv->size_shift;
  		}
  	}

  	for (i = 0; i < ARRAY_SIZE(drv->fw.dbg.conf_tlv); i++) {
  		if (pieces->dbg_conf_tlv[i]) {
  			drv->fw.dbg.conf_tlv[i] =
  				kmemdup(pieces->dbg_conf_tlv[i],
  					pieces->dbg_conf_tlv_len[i],
  					GFP_KERNEL);
  			if (!drv->fw.dbg.conf_tlv[i])
  				goto out_free_fw;
  		}
  	}

  	memset(&trigger_tlv_sz, 0xff, sizeof(trigger_tlv_sz));

  	trigger_tlv_sz[FW_DBG_TRIGGER_MISSED_BEACONS] =
  		sizeof(struct iwl_fw_dbg_trigger_missed_bcon);
  	trigger_tlv_sz[FW_DBG_TRIGGER_CHANNEL_SWITCH] = 0;
  	trigger_tlv_sz[FW_DBG_TRIGGER_FW_NOTIF] =
  		sizeof(struct iwl_fw_dbg_trigger_cmd);
  	trigger_tlv_sz[FW_DBG_TRIGGER_MLME] =
  		sizeof(struct iwl_fw_dbg_trigger_mlme);
  	trigger_tlv_sz[FW_DBG_TRIGGER_STATS] =
  		sizeof(struct iwl_fw_dbg_trigger_stats);
  	trigger_tlv_sz[FW_DBG_TRIGGER_RSSI] =
  		sizeof(struct iwl_fw_dbg_trigger_low_rssi);
  	trigger_tlv_sz[FW_DBG_TRIGGER_TXQ_TIMERS] =
  		sizeof(struct iwl_fw_dbg_trigger_txq_timer);
  	trigger_tlv_sz[FW_DBG_TRIGGER_TIME_EVENT] =
  		sizeof(struct iwl_fw_dbg_trigger_time_event);
  	trigger_tlv_sz[FW_DBG_TRIGGER_BA] =
  		sizeof(struct iwl_fw_dbg_trigger_ba);
  	trigger_tlv_sz[FW_DBG_TRIGGER_TDLS] =
  		sizeof(struct iwl_fw_dbg_trigger_tdls);

  	for (i = 0; i < ARRAY_SIZE(drv->fw.dbg.trigger_tlv); i++) {
  		if (pieces->dbg_trigger_tlv[i]) {
  			/*
  			 * If the trigger isn't long enough, WARN and exit.
  			 * Someone is trying to debug something and he won't
  			 * be able to catch the bug he is trying to chase.
  			 * We'd better be noisy to be sure he knows what's
  			 * going on.
  			 */
  			if (WARN_ON(pieces->dbg_trigger_tlv_len[i] <
  				    (trigger_tlv_sz[i] +
  				     sizeof(struct iwl_fw_dbg_trigger_tlv))))
  				goto out_free_fw;
  			drv->fw.dbg.trigger_tlv_len[i] =
  				pieces->dbg_trigger_tlv_len[i];
  			drv->fw.dbg.trigger_tlv[i] =
  				kmemdup(pieces->dbg_trigger_tlv[i],
  					drv->fw.dbg.trigger_tlv_len[i],
  					GFP_KERNEL);
  			if (!drv->fw.dbg.trigger_tlv[i])
  				goto out_free_fw;
  		}
  	}

  	/* Now that we can no longer fail, copy information */

  	drv->fw.dbg.mem_tlv = pieces->dbg_mem_tlv;
  	pieces->dbg_mem_tlv = NULL;
  	drv->fw.dbg.n_mem_tlv = pieces->n_mem_tlv;

  	/*
  	 * The (size - 16) / 12 formula is based on the information recorded
  	 * for each event, which is of mode 1 (including timestamp) for all
  	 * new microcodes that include this information.
  	 */
  	fw->init_evtlog_ptr = pieces->init_evtlog_ptr;
  	if (pieces->init_evtlog_size)
  		fw->init_evtlog_size = (pieces->init_evtlog_size - 16)/12;
  	else
  		fw->init_evtlog_size =
  			drv->trans->trans_cfg->base_params->max_event_log_size;
  	fw->init_errlog_ptr = pieces->init_errlog_ptr;
  	fw->inst_evtlog_ptr = pieces->inst_evtlog_ptr;
  	if (pieces->inst_evtlog_size)
  		fw->inst_evtlog_size = (pieces->inst_evtlog_size - 16)/12;
  	else
  		fw->inst_evtlog_size =
  			drv->trans->trans_cfg->base_params->max_event_log_size;
  	fw->inst_errlog_ptr = pieces->inst_errlog_ptr;

  	/*
  	 * figure out the offset of chain noise reset and gain commands
  	 * base on the size of standard phy calibration commands table size
  	 */
  	if (fw->ucode_capa.standard_phy_calibration_size >
  	    IWL_MAX_PHY_CALIBRATE_TBL_SIZE)
  		fw->ucode_capa.standard_phy_calibration_size =
  			IWL_MAX_STANDARD_PHY_CALIBRATE_TBL_SIZE;

  	/* We have our copies now, allow OS release its copies */
  	release_firmware(ucode_raw);

  	mutex_lock(&iwlwifi_opmode_table_mtx);
  	switch (fw->type) {
  	case IWL_FW_DVM:
  		op = &iwlwifi_opmode_table[DVM_OP_MODE];
  		break;
  	default:
  		WARN(1, "Invalid fw type %d\n", fw->type);
  		fallthrough;
  	case IWL_FW_MVM:
  		op = &iwlwifi_opmode_table[MVM_OP_MODE];
  		break;
  	}

  	IWL_INFO(drv, "loaded firmware version %s op_mode %s\n",
  		 drv->fw.fw_version, op->name);

  	iwl_dbg_tlv_load_bin(drv->trans->dev, drv->trans);

  	/* add this device to the list of devices using this op_mode */
  	list_add_tail(&drv->list, &op->drv);

  	if (op->ops) {
  		drv->op_mode = _iwl_op_mode_start(drv, op);

  		if (!drv->op_mode) {
  			mutex_unlock(&iwlwifi_opmode_table_mtx);
  			goto out_unbind;
  		}
  	} else {
  		load_module = true;
  	}
  	mutex_unlock(&iwlwifi_opmode_table_mtx);

  	/*
  	 * Complete the firmware request last so that
  	 * a driver unbind (stop) doesn't run while we
  	 * are doing the start() above.
  	 */
  	complete(&drv->request_firmware_complete);

  	/*
  	 * Load the module last so we don't block anything
  	 * else from proceeding if the module fails to load
  	 * or hangs loading.
  	 */
  	if (load_module) {
  		request_module("%s", op->name);
  #ifdef CONFIG_IWLWIFI_OPMODE_MODULAR
  		if (err)
  			IWL_ERR(drv,
  				"failed to load module %s (error %d), is dynamic loading enabled?\n",
  				op->name, err);
  #endif
  	}
  	goto free;

   try_again:
  	/* try next, if any */
  	release_firmware(ucode_raw);
  	if (iwl_request_firmware(drv, false))
  		goto out_unbind;
  	goto free;

   out_free_fw:
  	release_firmware(ucode_raw);
   out_unbind:
  	complete(&drv->request_firmware_complete);
  	device_release_driver(drv->trans->dev);
   free:
  	if (pieces) {
  		for (i = 0; i < ARRAY_SIZE(pieces->img); i++)
  			kfree(pieces->img[i].sec);
  		kfree(pieces->dbg_mem_tlv);
  		kfree(pieces);
  	}
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index af684f80b0cc..776d524024c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -348,99 +348,99 @@ static enum nl80211_band iwl_nl80211_band_from_channel_idx(int ch_idx)
  static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
  				struct iwl_nvm_data *data,
  				const void * const nvm_ch_flags,
  				u32 sbands_flags, bool v4)
  {
  	int ch_idx;
  	int n_channels = 0;
  	struct ieee80211_channel *channel;
  	u32 ch_flags;
  	int num_of_ch;
  	const u16 *nvm_chan;

  	if (cfg->uhb_supported) {
  		num_of_ch = IWL_NVM_NUM_CHANNELS_UHB;
  		nvm_chan = iwl_uhb_nvm_channels;
  	} else if (cfg->nvm_type == IWL_NVM_EXT) {
  		num_of_ch = IWL_NVM_NUM_CHANNELS_EXT;
  		nvm_chan = iwl_ext_nvm_channels;
  	} else {
  		num_of_ch = IWL_NVM_NUM_CHANNELS;
  		nvm_chan = iwl_nvm_channels;
  	}

  	for (ch_idx = 0; ch_idx < num_of_ch; ch_idx++) {
  		enum nl80211_band band =
  			iwl_nl80211_band_from_channel_idx(ch_idx);

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
  			continue;

  		/* workaround to disable wide channels in 5GHz */
  		if ((sbands_flags & IWL_NVM_SBANDS_FLAGS_NO_WIDE_IN_5GHZ) &&
  		    band == NL80211_BAND_5GHZ) {
  			ch_flags &= ~(NVM_CHANNEL_40MHZ |
  				     NVM_CHANNEL_80MHZ |
  				     NVM_CHANNEL_160MHZ);
  		}

  		if (ch_flags & NVM_CHANNEL_160MHZ)
  			data->vht160_supported = true;

  		if (!(sbands_flags & IWL_NVM_SBANDS_FLAGS_LAR) &&
  		    !(ch_flags & NVM_CHANNEL_VALID)) {
  			/*
  			 * Channels might become valid later if lar is
  			 * supported, hence we still want to add them to
  			 * the list of supported channels to cfg80211.
  			 */
  			iwl_nvm_print_channel_flags(dev, IWL_DL_EEPROM,
  						    nvm_chan[ch_idx], ch_flags);
  			continue;
  		}

  		channel = &data->channels[n_channels];
  		n_channels++;

  		channel->hw_value = nvm_chan[ch_idx];
  		channel->band = band;
  		channel->center_freq =
  			ieee80211_channel_to_frequency(
  				channel->hw_value, channel->band);

  		/* Initialize regulatory-based run-time data */

  		/*
  		 * Default value - highest tx power value.  max_power
  		 * is not used in mvm, and is used for backwards compatibility
  		 */
  		channel->max_power = IWL_DEFAULT_MAX_TX_POWER;

  		/* don't put limitations in case we're using LAR */
  		if (!(sbands_flags & IWL_NVM_SBANDS_FLAGS_LAR))
  			channel->flags = iwl_get_channel_flags(nvm_chan[ch_idx],
  							       ch_idx, band,
  							       ch_flags, cfg);
  		else
  			channel->flags = 0;

  		/* TODO: Don't put limitations on UHB devices as we still don't
  		 * have NVM for them
  		 */
  		if (cfg->uhb_supported)
  			channel->flags = 0;
  		iwl_nvm_print_channel_flags(dev, IWL_DL_EEPROM,
  					    channel->hw_value, ch_flags);
  		IWL_DEBUG_EEPROM(dev, "Ch. %d: %ddBm\n",
  				 channel->hw_value, channel->max_power);
  	}

  	return n_channels;
  }
@@ -854,39 +854,39 @@ static void iwl_init_sbands(struct iwl_trans *trans,
  static int iwl_get_sku(const struct iwl_cfg *cfg, const __le16 *nvm_sw,
  		       const __le16 *phy_sku)
  {
  	if (cfg->nvm_type != IWL_NVM_EXT)
  		return le16_to_cpup(nvm_sw + SKU);

-	return le32_to_cpup((__le32 *)(phy_sku + SKU_FAMILY_8000));
+	return le32_to_cpup((const __le32 *)(phy_sku + SKU_FAMILY_8000));
  }

  static int iwl_get_nvm_version(const struct iwl_cfg *cfg, const __le16 *nvm_sw)
  {
  	if (cfg->nvm_type != IWL_NVM_EXT)
  		return le16_to_cpup(nvm_sw + NVM_VERSION);
  	else
-		return le32_to_cpup((__le32 *)(nvm_sw +
+		return le32_to_cpup((const __le32 *)(nvm_sw +
  					       NVM_VERSION_EXT_NVM));
  }

  static int iwl_get_radio_cfg(const struct iwl_cfg *cfg, const __le16 *nvm_sw,
  			     const __le16 *phy_sku)
  {
  	if (cfg->nvm_type != IWL_NVM_EXT)
  		return le16_to_cpup(nvm_sw + RADIO_CFG);

-	return le32_to_cpup((__le32 *)(phy_sku + RADIO_CFG_FAMILY_EXT_NVM));
+	return le32_to_cpup((const __le32 *)(phy_sku + RADIO_CFG_FAMILY_EXT_NVM));

  }

  static int iwl_get_n_hw_addrs(const struct iwl_cfg *cfg, const __le16 *nvm_sw)
  {
  	int n_hw_addr;

  	if (cfg->nvm_type != IWL_NVM_EXT)
  		return le16_to_cpup(nvm_sw + N_HW_ADDRS);

-	n_hw_addr = le32_to_cpup((__le32 *)(nvm_sw + N_HW_ADDRS_FAMILY_8000));
+	n_hw_addr = le32_to_cpup((const __le32 *)(nvm_sw + N_HW_ADDRS_FAMILY_8000));

  	return n_hw_addr & N_HW_ADDR_MASK;
  }
@@ -1382,176 +1382,176 @@ IWL_EXPORT_SYMBOL(iwl_nvm_fixups);
  /*
   * Reads external NVM from a file into mvm->nvm_sections
   *
   * HOW TO CREATE THE NVM FILE FORMAT:
   * ------------------------------
   * 1. create hex file, format:
   *      3800 -> header
   *      0000 -> header
   *      5a40 -> data
   *
   *   rev - 6 bit (word1)
   *   len - 10 bit (word1)
   *   id - 4 bit (word2)
   *   rsv - 12 bit (word2)
   *
   * 2. flip 8bits with 8 bits per line to get the right NVM file format
   *
   * 3. create binary file from the hex file
   *
   * 4. save as "iNVM_xxx.bin" under /lib/firmware
   */
  int iwl_read_external_nvm(struct iwl_trans *trans,
  			  const char *nvm_file_name,
  			  struct iwl_nvm_section *nvm_sections)
  {
  	int ret, section_size;
  	u16 section_id;
  	const struct firmware *fw_entry;
  	const struct {
  		__le16 word1;
  		__le16 word2;
  		u8 data[];
  	} *file_sec;
  	const u8 *eof;
  	u8 *temp;
  	int max_section_size;
  	const __le32 *dword_buff;

  #define NVM_WORD1_LEN(x) (8 * (x & 0x03FF))
  #define NVM_WORD2_ID(x) (x >> 12)
  #define EXT_NVM_WORD2_LEN(x) (2 * (((x) & 0xFF) << 8 | (x) >> 8))
  #define EXT_NVM_WORD1_ID(x) ((x) >> 4)
  #define NVM_HEADER_0	(0x2A504C54)
  #define NVM_HEADER_1	(0x4E564D2A)
  #define NVM_HEADER_SIZE	(4 * sizeof(u32))

  	IWL_DEBUG_EEPROM(trans->dev, "Read from external NVM\n");

  	/* Maximal size depends on NVM version */
  	if (trans->cfg->nvm_type != IWL_NVM_EXT)
  		max_section_size = IWL_MAX_NVM_SECTION_SIZE;
  	else
  		max_section_size = IWL_MAX_EXT_NVM_SECTION_SIZE;

  	/*
  	 * Obtain NVM image via request_firmware. Since we already used
  	 * request_firmware_nowait() for the firmware binary load and only
  	 * get here after that we assume the NVM request can be satisfied
  	 * synchronously.
  	 */
  	ret = request_firmware(&fw_entry, nvm_file_name, trans->dev);
  	if (ret) {
  		IWL_ERR(trans, "ERROR: %s isn't available %d\n",
  			nvm_file_name, ret);
  		return ret;
  	}

  	IWL_INFO(trans, "Loaded NVM file %s (%zu bytes)\n",
  		 nvm_file_name, fw_entry->size);

  	if (fw_entry->size > MAX_NVM_FILE_LEN) {
  		IWL_ERR(trans, "NVM file too large\n");
  		ret = -EINVAL;
  		goto out;
  	}

  	eof = fw_entry->data + fw_entry->size;
-	dword_buff = (__le32 *)fw_entry->data;
+	dword_buff = (const __le32 *)fw_entry->data;

  	/* some NVM file will contain a header.
  	 * The header is identified by 2 dwords header as follow:
  	 * dword[0] = 0x2A504C54
  	 * dword[1] = 0x4E564D2A
  	 *
  	 * This header must be skipped when providing the NVM data to the FW.
  	 */
  	if (fw_entry->size > NVM_HEADER_SIZE &&
  	    dword_buff[0] == cpu_to_le32(NVM_HEADER_0) &&
  	    dword_buff[1] == cpu_to_le32(NVM_HEADER_1)) {
-		file_sec = (void *)(fw_entry->data + NVM_HEADER_SIZE);
+		file_sec = (const void *)(fw_entry->data + NVM_HEADER_SIZE);
  		IWL_INFO(trans, "NVM Version %08X\n", le32_to_cpu(dword_buff[2]));
  		IWL_INFO(trans, "NVM Manufacturing date %08X\n",
  			 le32_to_cpu(dword_buff[3]));

  		/* nvm file validation, dword_buff[2] holds the file version */
  		if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_8000 &&
  		    CSR_HW_REV_STEP(trans->hw_rev) == SILICON_C_STEP &&
  		    le32_to_cpu(dword_buff[2]) < 0xE4A) {
  			ret = -EFAULT;
  			goto out;
  		}
  	} else {
-		file_sec = (void *)fw_entry->data;
+		file_sec = (const void *)fw_entry->data;
  	}

  	while (true) {
  		if (file_sec->data > eof) {
  			IWL_ERR(trans,
  				"ERROR - NVM file too short for section header\n");
  			ret = -EINVAL;
  			break;
  		}

  		/* check for EOF marker */
  		if (!file_sec->word1 && !file_sec->word2) {
  			ret = 0;
  			break;
  		}

  		if (trans->cfg->nvm_type != IWL_NVM_EXT) {
  			section_size =
  				2 * NVM_WORD1_LEN(le16_to_cpu(file_sec->word1));
  			section_id = NVM_WORD2_ID(le16_to_cpu(file_sec->word2));
  		} else {
  			section_size = 2 * EXT_NVM_WORD2_LEN(
  						le16_to_cpu(file_sec->word2));
  			section_id = EXT_NVM_WORD1_ID(
  						le16_to_cpu(file_sec->word1));
  		}

  		if (section_size > max_section_size) {
  			IWL_ERR(trans, "ERROR - section too large (%d)\n",
  				section_size);
  			ret = -EINVAL;
  			break;
  		}

  		if (!section_size) {
  			IWL_ERR(trans, "ERROR - section empty\n");
  			ret = -EINVAL;
  			break;
  		}

  		if (file_sec->data + section_size > eof) {
  			IWL_ERR(trans,
  				"ERROR - NVM file too short for section (%d bytes)\n",
  				section_size);
  			ret = -EINVAL;
  			break;
  		}

  		if (WARN(section_id >= NVM_MAX_NUM_SECTIONS,
  			 "Invalid NVM section ID %d\n", section_id)) {
  			ret = -EINVAL;
  			break;
  		}

  		temp = kmemdup(file_sec->data, section_size, GFP_KERNEL);
  		if (!temp) {
  			ret = -ENOMEM;
  			break;
  		}

  		iwl_nvm_fixups(trans->hw_id, section_id, temp, section_size);

  		kfree(nvm_sections[section_id].data);
  		nvm_sections[section_id].data = temp;
  		nvm_sections[section_id].length = section_size;

  		/* advance to the next section */
-		file_sec = (void *)(file_sec->data + section_size);
+		file_sec = (const void *)(file_sec->data + section_size);
  	}
  out:
  	release_firmware(fw_entry);
  	return ret;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 60e0db4a5e20..3d2ce95b0421 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -182,18 +182,18 @@ IWL_EXPORT_SYMBOL(iwl_trans_send_cmd);
  /* Comparator for struct iwl_hcmd_names.
   * Used in the binary search over a list of host commands.
   *
   * @key: command_id that we're looking for.
   * @elt: struct iwl_hcmd_names candidate for match.
   *
   * @return 0 iff equal.
   */
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
@@ -597,59 +597,60 @@ static int iwl_mvm_get_ctrl_vif_queue(struct iwl_mvm *mvm,
  static void iwl_mvm_probe_resp_set_noa(struct iwl_mvm *mvm,
  				       struct sk_buff *skb)
  {
  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
  	struct iwl_mvm_vif *mvmvif =
  		iwl_mvm_vif_from_mac80211(info->control.vif);
  	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
  	int base_len = (u8 *)mgmt->u.probe_resp.variable - (u8 *)mgmt;
  	struct iwl_probe_resp_data *resp_data;
-	u8 *ie, *pos;
+	const u8 *ie;
+	u8 *pos;
  	u8 match[] = {
  		(WLAN_OUI_WFA >> 16) & 0xff,
  		(WLAN_OUI_WFA >> 8) & 0xff,
  		WLAN_OUI_WFA & 0xff,
  		WLAN_OUI_TYPE_WFA_P2P,
  	};

  	rcu_read_lock();

  	resp_data = rcu_dereference(mvmvif->probe_resp_data);
  	if (!resp_data)
  		goto out;

  	if (!resp_data->notif.noa_active)
  		goto out;

-	ie = (u8 *)cfg80211_find_ie_match(WLAN_EID_VENDOR_SPECIFIC,
+	ie = cfg80211_find_ie_match(WLAN_EID_VENDOR_SPECIFIC,
  					  mgmt->u.probe_resp.variable,
  					  skb->len - base_len,
  					  match, 4, 2);
  	if (!ie) {
  		IWL_DEBUG_TX(mvm, "probe resp doesn't have P2P IE\n");
  		goto out;
  	}

  	if (skb_tailroom(skb) < resp_data->noa_len) {
  		if (pskb_expand_head(skb, 0, resp_data->noa_len, GFP_ATOMIC)) {
  			IWL_ERR(mvm,
  				"Failed to reallocate probe resp\n");
  			goto out;
  		}
  	}

  	pos = skb_put(skb, resp_data->noa_len);

  	*pos++ = WLAN_EID_VENDOR_SPECIFIC;
  	/* Set length of IE body (not including ID and length itself) */
  	*pos++ = resp_data->noa_len - 2;
  	*pos++ = (WLAN_OUI_WFA >> 16) & 0xff;
  	*pos++ = (WLAN_OUI_WFA >> 8) & 0xff;
  	*pos++ = WLAN_OUI_WFA & 0xff;
  	*pos++ = WLAN_OUI_TYPE_WFA_P2P;

  	memcpy(pos, &resp_data->notif.noa_attr,
  	       resp_data->noa_len - sizeof(struct ieee80211_vendor_ie));

  out:
  	rcu_read_unlock();
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 1bf4c37fe960..a8025c78f80b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -665,56 +665,56 @@ static int iwl_pcie_load_firmware_chunk(struct iwl_trans *trans,
  static int iwl_pcie_load_section(struct iwl_trans *trans, u8 section_num,
  			    const struct fw_desc *section)
  {
  	u8 *v_addr;
  	dma_addr_t p_addr;
  	u32 offset, chunk_sz = min_t(u32, FH_MEM_TB_MAX_LENGTH, section->len);
  	int ret = 0;

  	IWL_DEBUG_FW(trans, "[%d] uCode section being loaded...\n",
  		     section_num);

  	v_addr = dma_alloc_coherent(trans->dev, chunk_sz, &p_addr,
  				    GFP_KERNEL | __GFP_NOWARN);
  	if (!v_addr) {
  		IWL_DEBUG_INFO(trans, "Falling back to small chunks of DMA\n");
  		chunk_sz = PAGE_SIZE;
  		v_addr = dma_alloc_coherent(trans->dev, chunk_sz,
  					    &p_addr, GFP_KERNEL);
  		if (!v_addr)
  			return -ENOMEM;
  	}

  	for (offset = 0; offset < section->len; offset += chunk_sz) {
  		u32 copy_size, dst_addr;
  		bool extended_addr = false;

  		copy_size = min_t(u32, chunk_sz, section->len - offset);
  		dst_addr = section->offset + offset;

  		if (dst_addr >= IWL_FW_MEM_EXTENDED_START &&
  		    dst_addr <= IWL_FW_MEM_EXTENDED_END)
  			extended_addr = true;

  		if (extended_addr)
  			iwl_set_bits_prph(trans, LMPM_CHICK,
  					  LMPM_CHICK_EXTENDED_ADDR_SPACE);

-		memcpy(v_addr, (u8 *)section->data + offset, copy_size);
+		memcpy(v_addr, (const u8 *)section->data + offset, copy_size);
  		ret = iwl_pcie_load_firmware_chunk(trans, dst_addr, p_addr,
  						   copy_size);

  		if (extended_addr)
  			iwl_clear_bits_prph(trans, LMPM_CHICK,
  					    LMPM_CHICK_EXTENDED_ADDR_SPACE);

  		if (ret) {
  			IWL_ERR(trans,
  				"Could not load the [%d] uCode section\n",
  				section_num);
  			break;
  		}
  	}

  	dma_free_coherent(trans->dev, chunk_sz, v_addr, p_addr);
  	return ret;
  }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 9073a7e551dc..6e02c8b294ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -867,47 +867,47 @@ void iwl_trans_pcie_txq_set_shared_mode(struct iwl_trans *trans, u32 txq_id,
  void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
  				bool configure_scd)
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  	u32 stts_addr = trans_pcie->scd_base_addr +
  			SCD_TX_STTS_QUEUE_OFFSET(txq_id);
  	static const u32 zero_val[4] = {};

  	trans->txqs.txq[txq_id]->frozen_expiry_remainder = 0;
  	trans->txqs.txq[txq_id]->frozen = false;

  	/*
  	 * Upon HW Rfkill - we stop the device, and then stop the queues
  	 * in the op_mode. Just for the sake of the simplicity of the op_mode,
  	 * allow the op_mode to call txq_disable after it already called
  	 * stop_device.
  	 */
  	if (!test_and_clear_bit(txq_id, trans->txqs.queue_used)) {
  		WARN_ONCE(test_bit(STATUS_DEVICE_ENABLED, &trans->status),
  			  "queue %d not used", txq_id);
  		return;
  	}

  	if (configure_scd) {
  		iwl_scd_txq_set_inactive(trans, txq_id);

-		iwl_trans_write_mem(trans, stts_addr, (void *)zero_val,
+		iwl_trans_write_mem(trans, stts_addr, zero_val,
  				    ARRAY_SIZE(zero_val));
  	}

  	iwl_pcie_txq_unmap(trans, txq_id);
  	trans->txqs.txq[txq_id]->ampdu = false;

  	IWL_DEBUG_TX_QUEUES(trans, "Deactivate queue %d\n", txq_id);
  }

  /*************** HOST COMMAND QUEUE FUNCTIONS   *****/

  /*
   * iwl_pcie_enqueue_hcmd - enqueue a uCode command
   * @priv: device private data point
   * @cmd: a pointer to the ucode command structure
   *
   * The function returns < 0 values to indicate the operation
   * failed. On success, it returns the index (>= 0) of command in the
   * command queue.
   */
