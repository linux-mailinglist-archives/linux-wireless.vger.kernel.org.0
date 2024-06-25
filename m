Return-Path: <linux-wireless+bounces-9549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0249916E86
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C52E1F21FCB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F95176231;
	Tue, 25 Jun 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EX5dgtgc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79017C7AE
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334317; cv=none; b=tnv8uSA3IsyC2mOd/WFoYxj31I2094Wbr4XtvVJAYYiUKjkbr/gXrRWIgsR9ZlUGBFclo6MqUx/ngdATvTJNxhqg6C2csrrfAJBwROnDCS6YYAiyAeGJFGv5p/kYgdphszKfIYyrA/rrRzWrAbACLaXtRrt5p+/x/Atq+XfCZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334317; c=relaxed/simple;
	bh=ZnqXAxP0jeYHy42k3p4zhfP7TfHdqPzWg3X7yC+nHHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MATdZABCcFrmFA+z+qe/DoSC70R0ovv1DZyghXa6uMTdheGswcp8XCLvTX+nDq6+k/IsfE0skNRjtk5jSY6XQNJHEUUo7iSFJ7CqnHh1mQQVu3MCcplWIhZPT0wLa62Mvxxdcn3sovxAln1GPEpz7k4YAte6f7SAXHXvVokejMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EX5dgtgc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334312; x=1750870312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZnqXAxP0jeYHy42k3p4zhfP7TfHdqPzWg3X7yC+nHHg=;
  b=EX5dgtgcLjj5OARmKmCSd4nXqXUaCnIy9PsRntogDlPA89Lv5JKwIWdi
   tHDDEZdcJR+MgtX211TidcbZhfXNnThZJoy+/b2yEACe16OzCGV3N41dB
   V8E9W8Qr2pZTrc4oGHd2S3RDUGeScQJu0sLMy85G4TiVhWUHwRaf18QiI
   W+Q10rjFcgCO1qsLv5EofnxRUWzb7djgp7FpXCY771shvW5VkS5h4+2Kg
   VIYaTTZAMPNHTm2YOcuSnk74L+34CmdT5j5z4g/fuGn/ZqU4VM0CYOcQz
   mqxBLP+qTb63rSscR1/PtTzNNXd+vo80LqsYOEBkCqdiUIqYUZzRsV7wt
   w==;
X-CSE-ConnectionGUID: R/aabMf8RgG+hdeCM/yyBg==
X-CSE-MsgGUID: cx3vTbGOSii5+gonWKtmTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594784"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594784"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:52 -0700
X-CSE-ConnectionGUID: HDC6IBrsQlCdL1xMCBywbg==
X-CSE-MsgGUID: yzRgiXNbQde5z+CxalnjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632813"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/17] wifi: iwlwifi: fix kernel-doc in iwl-fh.h
Date: Tue, 25 Jun 2024 19:51:19 +0300
Message-Id: <20240625194805.16865e5503ac.I5401edbf9ecbc25e07aad929bb56255410173711@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some blocks aren't really kernel-doc, and some are misformatted
or with mismatched names. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h | 34 ++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index 6ba374efaacb..5c8f1868db64 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -15,7 +15,7 @@
 /* Flow Handler Definitions */
 /****************************/
 
-/**
+/*
  * This I/O area is directly read/writable by driver (e.g. Linux uses writel())
  * Addresses are offsets from device's PCI hardware base address.
  */
@@ -24,7 +24,7 @@
 #define FH_MEM_LOWER_BOUND_GEN2              (0xa06000)
 #define FH_MEM_UPPER_BOUND_GEN2              (0xa08000)
 
-/**
+/*
  * Keep-Warm (KW) buffer base address.
  *
  * Driver must allocate a 4KByte buffer that is for keeping the
@@ -44,7 +44,7 @@
 #define FH_KW_MEM_ADDR_REG		     (FH_MEM_LOWER_BOUND + 0x97C)
 
 
-/**
+/*
  * TFD Circular Buffers Base (CBBC) addresses
  *
  * Device has 16 base pointer registers, one for each of 16 host-DRAM-resident
@@ -143,7 +143,7 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
  */
 #define TFH_SRV_DMA_CHNL0_BC	(0x1F70)
 
-/**
+/*
  * Rx SRAM Control and Status Registers (RSCSR)
  *
  * These registers provide handshake between driver and device for the Rx queue
@@ -216,21 +216,21 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 #define FH_MEM_RSCSR_UPPER_BOUND	(FH_MEM_LOWER_BOUND + 0xC00)
 #define FH_MEM_RSCSR_CHNL0		(FH_MEM_RSCSR_LOWER_BOUND)
 
-/**
+/*
  * Physical base address of 8-byte Rx Status buffer.
  * Bit fields:
  *  31-0: Rx status buffer physical base address [35:4], must 16-byte aligned.
  */
 #define FH_RSCSR_CHNL0_STTS_WPTR_REG	(FH_MEM_RSCSR_CHNL0)
 
-/**
+/*
  * Physical base address of Rx Buffer Descriptor Circular Buffer.
  * Bit fields:
  *  27-0:  RBD CD physical base address [35:8], must be 256-byte aligned.
  */
 #define FH_RSCSR_CHNL0_RBDCB_BASE_REG	(FH_MEM_RSCSR_CHNL0 + 0x004)
 
-/**
+/*
  * Rx write pointer (index, really!).
  * Bit fields:
  *  11-0:  Index of driver's most recent prepared-to-be-filled RBD, + 1.
@@ -242,7 +242,7 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 #define FW_RSCSR_CHNL0_RXDCB_RDPTR_REG	(FH_MEM_RSCSR_CHNL0 + 0x00c)
 #define FH_RSCSR_CHNL0_RDPTR		FW_RSCSR_CHNL0_RXDCB_RDPTR_REG
 
-/**
+/*
  * Rx Config/Status Registers (RCSR)
  * Rx Config Reg for channel 0 (only channel used)
  *
@@ -300,7 +300,7 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 #define FH_RCSR_CHNL0_RX_CONFIG_IRQ_DEST_NO_INT_VAL    (0x00000000)
 #define FH_RCSR_CHNL0_RX_CONFIG_IRQ_DEST_INT_HOST_VAL  (0x00001000)
 
-/**
+/*
  * Rx Shared Status Registers (RSSR)
  *
  * After stopping Rx DMA channel (writing 0 to
@@ -356,7 +356,7 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 #define RFH_RBDBUF_RBD0_LSB 0xA08300
 #define RFH_RBDBUF_RBD_LSB(q) (RFH_RBDBUF_RBD0_LSB + (q) * 8)
 
-/**
+/*
  * RFH Status Register
  *
  * Bit fields:
@@ -440,7 +440,7 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 #define FH_TFDIB_CTRL0_REG(_chnl)  (FH_TFDIB_LOWER_BOUND + 0x8 * (_chnl))
 #define FH_TFDIB_CTRL1_REG(_chnl)  (FH_TFDIB_LOWER_BOUND + 0x8 * (_chnl) + 0x4)
 
-/**
+/*
  * Transmit DMA Channel Control/Status Registers (TCSR)
  *
  * Device has one configuration register for each of 8 Tx DMA/FIFO channels
@@ -501,7 +501,7 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 #define FH_TCSR_CHNL_TX_BUF_STS_REG_POS_TB_NUM		(20)
 #define FH_TCSR_CHNL_TX_BUF_STS_REG_POS_TB_IDX		(12)
 
-/**
+/*
  * Tx Shared Status Registers (TSSR)
  *
  * After stopping Tx DMA channel (writing 0 to
@@ -518,7 +518,7 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 
 #define FH_TSSR_TX_STATUS_REG		(FH_TSSR_LOWER_BOUND + 0x010)
 
-/**
+/*
  * Bit fields for TSSR(Tx Shared Status & Control) error status register:
  * 31:  Indicates an address error when accessed to internal memory
  *	uCode/driver must write "1" in order to clear this flag
@@ -634,7 +634,7 @@ enum iwl_tfd_tb_hi_n_len {
 };
 
 /**
- * struct iwl_tfd_tb transmit buffer descriptor within transmit frame descriptor
+ * struct iwl_tfd_tb - transmit buffer descriptor within transmit frame descriptor
  *
  * This structure contains dma address and length of transmission address
  *
@@ -648,7 +648,7 @@ struct iwl_tfd_tb {
 } __packed;
 
 /**
- * struct iwl_tfh_tb transmit buffer descriptor within transmit frame descriptor
+ * struct iwl_tfh_tb - transmit buffer descriptor within transmit frame descriptor
  *
  * This structure contains dma address and length of transmission address
  *
@@ -717,7 +717,7 @@ struct iwl_tfh_tfd {
 /* Fixed (non-configurable) rx data from phy */
 
 /**
- * struct iwlagn_schedq_bc_tbl scheduler byte count table
+ * struct iwlagn_scd_bc_tbl - scheduler byte count table
  *	base physical address provided by SCD_DRAM_BASE_ADDR
  * For devices up to 22000:
  * @tfd_offset:
@@ -734,7 +734,7 @@ struct iwlagn_scd_bc_tbl {
 } __packed;
 
 /**
- * struct iwl_gen3_bc_tbl_entry scheduler byte count table entry gen3
+ * struct iwl_gen3_bc_tbl_entry - scheduler byte count table entry gen3
  * For AX210 and on:
  * @tfd_offset: 0-12 - tx command byte count
  *		12-13 - number of 64 byte chunks
-- 
2.34.1


