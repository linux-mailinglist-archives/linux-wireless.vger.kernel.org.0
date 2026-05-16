Return-Path: <linux-wireless+bounces-36530-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OntKtrPCGqA6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36530-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:13:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BE355DA4A
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0035C302C91B
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8F29A32D;
	Sat, 16 May 2026 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dl6SeIiX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04DE35C1B2
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962331; cv=none; b=u3Mx1M6W3LuVjkA34Z08sNDj4jL2se6LZbJeHHeBEBJkNeN5ymwIN4nIzqFeiuCI4jfz58iS0/MLAS1xVy1qDyZOYf3JKyHt/To2dFCWaOt+hodALJs4wyt2W8MBl6nVhlbM+hSxftF/yvP3lUeZWuBZe4S6HkPfSXwMD7uTqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962331; c=relaxed/simple;
	bh=aVvN7l/cv+cS3SACNrVPV0+d0dDH2qI1BNo5effPBKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ni0QyFiZX9mh3zPmTkS5ujUE7aBuXOf85Zyx/8LiQcSXmo75QAD+mfUL++B4bxZPKEm1bfyJphUoceGtp2Z0oe4lzMKkHb6Q6b5tFVwvIyJO+ZutkiTe3nQ+TBq1UIJLzu+JIhVGHoiKDJePEhXLCGA3++WqtTVoO/a5BXP90RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dl6SeIiX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962330; x=1810498330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aVvN7l/cv+cS3SACNrVPV0+d0dDH2qI1BNo5effPBKM=;
  b=Dl6SeIiXg2gC6PRoBoDWCmbM/E9oEjCJMAmKloCeEv1WZG8JEWRQZMqX
   Zy+9Ifbu2wx9bbILB6x1Hq2Es9tkp67O7LJgLQnwNPWC4F4Pcfz92jw8H
   vmYw+BmxHGXDec0O9tuBq+a68ZYwrwrk0B7KsakLZinaVxWPLvF3UtOQF
   VBx4Q54XaUNdyG1k4p34S1FN2bWygppVrovkLoY7WpisVwqSxlLUVAhzL
   YfD37B+9YT69Sho0oSzMLjk5XBf1hTYJ1zmTuWyZnRy3KaPEiDvnQghz+
   DB2DghH3a3go1BO3JBlS4/6CPqHZWFbscZAtsKS3hascJdcAeNCTo9yDD
   w==;
X-CSE-ConnectionGUID: CFGjWNrOQt6tpFxMo/yhog==
X-CSE-MsgGUID: oPe5YKkGQ+udNi8iHdI/4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845733"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845733"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:10 -0700
X-CSE-ConnectionGUID: ksqh6LJnRBm5s62frAFddw==
X-CSE-MsgGUID: MpJe4XZ5Q3+95SE32RGrng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130925"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:12:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 12/15] wifi: iwlwifi: fw: dbg: always use non-tracing PRPH access
Date: Sat, 16 May 2026 23:11:34 +0300
Message-Id: <20260516230843.bbc7623a0348.I827729916da8f264befbcb90ac6509c359ee97a3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
References: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50BE355DA4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36530-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The iwl_{read,write}_prph_no_grab() functions will trace each
access, but in debug dump a lot of accesses already use the
transport versions of these functions directly. Since the data
(register addresses and their content) is going into the dump
file, tracing isn't really needed. Use the transport functions
in all places.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 63 +++++++++++----------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 886c8e6ef48e..18667de4915f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -46,8 +46,8 @@ static void iwl_read_radio_regs(struct iwl_fw_runtime *fwrt,
 		u32 rd_cmd = RADIO_RSP_RD_CMD;
 
 		rd_cmd |= i << RADIO_RSP_ADDR_POS;
-		iwl_write_prph_no_grab(fwrt->trans, RSP_RADIO_CMD, rd_cmd);
-		*pos = (u8)iwl_read_prph_no_grab(fwrt->trans, RSP_RADIO_RDDAT);
+		iwl_trans_write_prph(fwrt->trans, RSP_RADIO_CMD, rd_cmd);
+		*pos = (u8)iwl_trans_read_prph(fwrt->trans, RSP_RADIO_RDDAT);
 
 		pos++;
 	}
@@ -513,7 +513,7 @@ static void iwl_read_prph_block(struct iwl_trans *trans, u32 start,
 	u32 i;
 
 	for (i = 0; i < len_bytes; i += 4)
-		*data++ = cpu_to_le32(iwl_read_prph_no_grab(trans, start + i));
+		*data++ = cpu_to_le32(iwl_trans_read_prph(trans, start + i));
 }
 
 static void iwl_dump_prph(struct iwl_fw_runtime *fwrt,
@@ -1132,16 +1132,16 @@ static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
 			continue;
 		}
 
-		iwl_write_prph_no_grab(fwrt->trans, indirect_wr_addr,
-				       WMAL_INDRCT_CMD(addr + i));
+		iwl_trans_write_prph(fwrt->trans, indirect_wr_addr,
+				     WMAL_INDRCT_CMD(addr + i));
 
 		if (fwrt->trans->info.hw_rf_id != IWL_CFG_RF_TYPE_JF1 &&
 		    fwrt->trans->info.hw_rf_id != IWL_CFG_RF_TYPE_JF2 &&
 		    fwrt->trans->info.hw_rf_id != IWL_CFG_RF_TYPE_HR1 &&
 		    fwrt->trans->info.hw_rf_id != IWL_CFG_RF_TYPE_HR2) {
 			udelay(2);
-			prph_stts = iwl_read_prph_no_grab(fwrt->trans,
-							  WMAL_MRSPF_STTS);
+			prph_stts = iwl_trans_read_prph(fwrt->trans,
+							WMAL_MRSPF_STTS);
 
 			/* Abort dump if status is 0xA5A5A5A2 or FIFO1 empty */
 			if (prph_stts == WMAL_TIMEOUT_VAL ||
@@ -1149,8 +1149,8 @@ static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
 				break;
 		}
 
-		prph_val = iwl_read_prph_no_grab(fwrt->trans,
-						 indirect_rd_addr);
+		prph_val = iwl_trans_read_prph(fwrt->trans,
+					       indirect_rd_addr);
 		*val++ = cpu_to_le32(prph_val);
 	}
 
@@ -1410,7 +1410,7 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 	range->fifo_hdr.num_of_registers = cpu_to_le32(registers_num);
 	range->range_data_size = cpu_to_le32(iter->fifo_size + registers_size);
 
-	iwl_write_prph_no_grab(fwrt->trans, TXF_LARC_NUM + offs, iter->fifo);
+	iwl_trans_write_prph(fwrt->trans, TXF_LARC_NUM + offs, iter->fifo);
 
 	/*
 	 * read txf registers. for each register, write to the dump the
@@ -1420,8 +1420,8 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 		addr = le32_to_cpu(reg->addrs[i]) + offs;
 
 		reg_dump->addr = cpu_to_le32(addr);
-		reg_dump->data = cpu_to_le32(iwl_read_prph_no_grab(fwrt->trans,
-								   addr));
+		reg_dump->data = cpu_to_le32(iwl_trans_read_prph(fwrt->trans,
+								 addr));
 
 		reg_dump++;
 	}
@@ -1432,17 +1432,17 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 	}
 
 	/* Set the TXF_READ_MODIFY_ADDR to TXF_WR_PTR */
-	iwl_write_prph_no_grab(fwrt->trans, TXF_READ_MODIFY_ADDR + offs,
-			       TXF_WR_PTR + offs);
+	iwl_trans_write_prph(fwrt->trans, TXF_READ_MODIFY_ADDR + offs,
+			     TXF_WR_PTR + offs);
 
 	/* Dummy-read to advance the read pointer to the head */
-	iwl_read_prph_no_grab(fwrt->trans, TXF_READ_MODIFY_DATA + offs);
+	iwl_trans_read_prph(fwrt->trans, TXF_READ_MODIFY_DATA + offs);
 
 	/* Read FIFO */
 	addr = TXF_READ_MODIFY_DATA + offs;
 	data = (void *)reg_dump;
 	for (i = 0; i < iter->fifo_size; i += sizeof(*data))
-		*data++ = cpu_to_le32(iwl_read_prph_no_grab(fwrt->trans, addr));
+		*data++ = cpu_to_le32(iwl_trans_read_prph(fwrt->trans, addr));
 
 	if (fwrt->sanitize_ops && fwrt->sanitize_ops->frob_txf)
 		fwrt->sanitize_ops->frob_txf(fwrt->sanitize_ctx,
@@ -1487,12 +1487,12 @@ iwl_dump_ini_prph_snps_dphyip_iter(struct iwl_fw_runtime *fwrt,
 			continue;
 		}
 
-		iwl_write_prph_no_grab(fwrt->trans, indirect_rd_wr_addr,
-				       addr + i);
+		iwl_trans_write_prph(fwrt->trans, indirect_rd_wr_addr,
+				     addr + i);
 		/* wait a bit for value to be ready in register */
 		udelay(1);
-		prph_val = iwl_read_prph_no_grab(fwrt->trans,
-						 indirect_rd_wr_addr);
+		prph_val = iwl_trans_read_prph(fwrt->trans,
+					       indirect_rd_wr_addr);
 		*val++ = cpu_to_le32((prph_val & DPHYIP_INDIRECT_RD_MSK) >>
 				     DPHYIP_INDIRECT_RD_SHIFT);
 	}
@@ -1601,8 +1601,8 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 		addr = le32_to_cpu(reg->addrs[i]) + offs;
 
 		reg_dump->addr = cpu_to_le32(addr);
-		reg_dump->data = cpu_to_le32(iwl_read_prph_no_grab(fwrt->trans,
-								   addr));
+		reg_dump->data = cpu_to_le32(iwl_trans_read_prph(fwrt->trans,
+								 addr));
 
 		reg_dump++;
 	}
@@ -1615,18 +1615,17 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 	offs = rxf_data.offset;
 
 	/* Lock fence */
-	iwl_write_prph_no_grab(fwrt->trans, RXF_SET_FENCE_MODE + offs, 0x1);
+	iwl_trans_write_prph(fwrt->trans, RXF_SET_FENCE_MODE + offs, 0x1);
 	/* Set fence pointer to the same place like WR pointer */
-	iwl_write_prph_no_grab(fwrt->trans, RXF_LD_WR2FENCE + offs, 0x1);
+	iwl_trans_write_prph(fwrt->trans, RXF_LD_WR2FENCE + offs, 0x1);
 	/* Set fence offset */
-	iwl_write_prph_no_grab(fwrt->trans, RXF_LD_FENCE_OFFSET_ADDR + offs,
-			       0x0);
+	iwl_trans_write_prph(fwrt->trans, RXF_LD_FENCE_OFFSET_ADDR + offs, 0x0);
 
 	/* Read FIFO */
 	addr =  RXF_FIFO_RD_FENCE_INC + offs;
 	data = (void *)reg_dump;
 	for (i = 0; i < rxf_data.size; i += sizeof(*data))
-		*data++ = cpu_to_le32(iwl_read_prph_no_grab(fwrt->trans, addr));
+		*data++ = cpu_to_le32(iwl_trans_read_prph(fwrt->trans, addr));
 
 out:
 	iwl_trans_release_nic_access(fwrt->trans);
@@ -1690,9 +1689,11 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 
 	range->range_data_size = reg->dev_addr.size;
 	for (i = 0; i < (le32_to_cpu(reg->dev_addr.size) / 4); i++) {
-		prph_data = iwl_read_prph_no_grab(fwrt->trans, (i % 2) ?
-					  DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
-					  DBGI_SRAM_TARGET_ACCESS_RDATA_LSB);
+		prph_data =
+			iwl_trans_read_prph(fwrt->trans,
+					    (i % 2) ?
+						DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
+						DBGI_SRAM_TARGET_ACCESS_RDATA_LSB);
 		if (iwl_trans_is_hw_error_value(prph_data)) {
 			iwl_trans_release_nic_access(fwrt->trans);
 			return -EBUSY;
@@ -1791,7 +1792,7 @@ static __le32 iwl_get_mon_reg(struct iwl_fw_runtime *fwrt, u32 alloc_id,
 	if (!reg_info || !reg_info->addr || !reg_info->mask)
 		return 0;
 
-	val = iwl_read_prph_no_grab(fwrt->trans, reg_info->addr + offs);
+	val = iwl_trans_read_prph(fwrt->trans, reg_info->addr + offs);
 
 	return cpu_to_le32(mask_apply_and_normalize(val, reg_info->mask));
 }
-- 
2.34.1


