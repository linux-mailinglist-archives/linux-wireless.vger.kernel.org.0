Return-Path: <linux-wireless+bounces-16847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627829FDC2F
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4171614F8
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005FF1925A2;
	Sat, 28 Dec 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQs5bA44"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097081991A1
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418082; cv=none; b=Y/62Cyp5aP/PA5v78QjftDIRWxIjPioXI5SDM2wD0DBqxRlAnmq+MKBqNm7crezRcyn9tjuLGeukEToj/QkOt2JqDHG7YPfr0wPF1MXXPWGrIcxQhELedaoMfRfeKW+777IyHVANk3UPS0IbYyrRLXBy3CISrICwKmZNX4HD3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418082; c=relaxed/simple;
	bh=1ozWsU+w1RVlHu+IJ5lF2Bt633QkVu65bnlspGZvhFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TK3kZDE0Tdzh1bGyn+4uCOjNF9cUeLkd4PjgKdtbQvyPWrXEBf/387M0oRRJkzKCZhDfU4xwmAah9haHOwb/PxpJPkcNg9psXrq+TbmWvTiKZsLgmc12yRiNDG769xJIglD/Pjg0vnLnNyO0hb7iTBUGx0Ei+RvSqhQMwQedTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQs5bA44; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418081; x=1766954081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ozWsU+w1RVlHu+IJ5lF2Bt633QkVu65bnlspGZvhFA=;
  b=ZQs5bA44qbXzMeVq/SGOltb8UdO8G8VaWNLJqdQ2wALsqwDIUBXzNa22
   n+u6EwNFEOGDl59ThfljtMYjKkzkjJewbP8x0coK75dz3g4lYj72RrkeI
   0eyZ3MOF+jHmBgZiZyhDhBXBcfIXGGtty9w7ZUwYdcX3SoRlPaTsVOhvw
   drqoNtm08/6mrHvTC6hB4gypiP62pxXaRjEpBVafYTinlPJ0VcGHmPvTx
   Edvbvg0DwM1oOqhq6Cp2hyWfV/OG7Q7068HNxwryvne/RBHYVwtGBnA0M
   HSQiGl5rW8Jq4H88Abvrwj1gx7WAF+l35evqEBwT6dHX8ilaIRT5QXS69
   w==;
X-CSE-ConnectionGUID: 4KEYhaauTHW67NHcldpzow==
X-CSE-MsgGUID: Yo7w+NRKSsSLvSc6FY3kgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479760"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479760"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:41 -0800
X-CSE-ConnectionGUID: 3MJaKHj8SQ+uzKG2xTt2Kw==
X-CSE-MsgGUID: SA7Go/tZQYeAThVwJWE3zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488391"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: iwl-drv: refactor image loading a bit
Date: Sat, 28 Dec 2024 22:34:09 +0200
Message-Id: <20241228223206.224ac6599bbe.Iadc1974d633eec09797522f7d3fa543ea18bd7f6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Refactor some parts of the image loading to be able to
extend the code for external FSEQ image loading more
easily.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 78 +++++++++-----------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 61ac62591161..fba9feee923d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -137,8 +137,7 @@ static void iwl_dealloc_ucode(struct iwl_drv *drv)
 	memset(&drv->fw, 0, sizeof(drv->fw));
 }
 
-static int iwl_alloc_fw_desc(struct iwl_drv *drv, struct fw_desc *desc,
-			     struct fw_sec *sec)
+static int iwl_alloc_fw_desc(struct fw_desc *desc, struct fw_sec *sec)
 {
 	void *data;
 
@@ -318,17 +317,6 @@ struct iwl_firmware_pieces {
 	size_t n_mem_tlv;
 };
 
-/*
- * These functions are just to extract uCode section data from the pieces
- * structure.
- */
-static struct fw_sec *get_sec(struct iwl_firmware_pieces *pieces,
-			      enum iwl_ucode_type type,
-			      int  sec)
-{
-	return &pieces->img[type].sec[sec];
-}
-
 static void alloc_sec_data(struct iwl_firmware_pieces *pieces,
 			   enum iwl_ucode_type type,
 			   int sec)
@@ -389,22 +377,18 @@ static void set_sec_offset(struct iwl_firmware_pieces *pieces,
 /*
  * Gets uCode section from tlv.
  */
-static int iwl_store_ucode_sec(struct iwl_firmware_pieces *pieces,
-			       const void *data, enum iwl_ucode_type type,
-			       int size)
+static int iwl_store_ucode_sec(struct fw_img_parsing *img,
+			       const void *data, int size)
 {
-	struct fw_img_parsing *img;
 	struct fw_sec *sec;
 	const struct fw_sec_parsing *sec_parse;
 	size_t alloc_size;
 
-	if (WARN_ON(!pieces || !data || type >= IWL_UCODE_TYPE_MAX))
-		return -1;
+	if (WARN_ON(!img || !data))
+		return -EINVAL;
 
 	sec_parse = (const struct fw_sec_parsing *)data;
 
-	img = &pieces->img[type];
-
 	alloc_size = sizeof(*img->sec) * (img->sec_counter + 1);
 	sec = krealloc(img->sec, alloc_size, GFP_KERNEL);
 	if (!sec)
@@ -900,18 +884,18 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 					le32_to_cpup((const __le32 *)tlv_data);
 			break;
 		case IWL_UCODE_TLV_SEC_RT:
-			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_REGULAR,
-					    tlv_len);
+			iwl_store_ucode_sec(&pieces->img[IWL_UCODE_REGULAR],
+					    tlv_data, tlv_len);
 			drv->fw.type = IWL_FW_MVM;
 			break;
 		case IWL_UCODE_TLV_SEC_INIT:
-			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_INIT,
-					    tlv_len);
+			iwl_store_ucode_sec(&pieces->img[IWL_UCODE_INIT],
+					    tlv_data, tlv_len);
 			drv->fw.type = IWL_FW_MVM;
 			break;
 		case IWL_UCODE_TLV_SEC_WOWLAN:
-			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_WOWLAN,
-					    tlv_len);
+			iwl_store_ucode_sec(&pieces->img[IWL_UCODE_WOWLAN],
+					    tlv_data, tlv_len);
 			drv->fw.type = IWL_FW_MVM;
 			break;
 		case IWL_UCODE_TLV_DEF_CALIB:
@@ -932,18 +916,18 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 						FW_PHY_CFG_RX_CHAIN_POS;
 			break;
 		case IWL_UCODE_TLV_SECURE_SEC_RT:
-			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_REGULAR,
-					    tlv_len);
+			iwl_store_ucode_sec(&pieces->img[IWL_UCODE_REGULAR],
+					    tlv_data, tlv_len);
 			drv->fw.type = IWL_FW_MVM;
 			break;
 		case IWL_UCODE_TLV_SECURE_SEC_INIT:
-			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_INIT,
-					    tlv_len);
+			iwl_store_ucode_sec(&pieces->img[IWL_UCODE_INIT],
+					    tlv_data, tlv_len);
 			drv->fw.type = IWL_FW_MVM;
 			break;
 		case IWL_UCODE_TLV_SECURE_SEC_WOWLAN:
-			iwl_store_ucode_sec(pieces, tlv_data, IWL_UCODE_WOWLAN,
-					    tlv_len);
+			iwl_store_ucode_sec(&pieces->img[IWL_UCODE_WOWLAN],
+					    tlv_data, tlv_len);
 			drv->fw.type = IWL_FW_MVM;
 			break;
 		case IWL_UCODE_TLV_NUM_OF_CPU:
@@ -1110,9 +1094,8 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			}
 		case IWL_UCODE_TLV_SEC_RT_USNIFFER:
 			*usniffer_images = true;
-			iwl_store_ucode_sec(pieces, tlv_data,
-					    IWL_UCODE_REGULAR_USNIFFER,
-					    tlv_len);
+			iwl_store_ucode_sec(&pieces->img[IWL_UCODE_REGULAR_USNIFFER],
+					    tlv_data, tlv_len);
 			break;
 		case IWL_UCODE_TLV_PAGING:
 			if (tlv_len != sizeof(u32))
@@ -1337,26 +1320,31 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 	return -EINVAL;
 }
 
-static int iwl_alloc_ucode(struct iwl_drv *drv,
-			   struct iwl_firmware_pieces *pieces,
-			   enum iwl_ucode_type type)
+static int iwl_alloc_ucode_mem(struct fw_img *out, struct fw_img_parsing *img)
 {
-	int i;
 	struct fw_desc *sec;
 
-	sec = kcalloc(pieces->img[type].sec_counter, sizeof(*sec), GFP_KERNEL);
+	sec = kcalloc(img->sec_counter, sizeof(*sec), GFP_KERNEL);
 	if (!sec)
 		return -ENOMEM;
-	drv->fw.img[type].sec = sec;
-	drv->fw.img[type].num_sec = pieces->img[type].sec_counter;
 
-	for (i = 0; i < pieces->img[type].sec_counter; i++)
-		if (iwl_alloc_fw_desc(drv, &sec[i], get_sec(pieces, type, i)))
+	out->sec = sec;
+	out->num_sec = img->sec_counter;
+
+	for (int i = 0; i < out->num_sec; i++)
+		if (iwl_alloc_fw_desc(&sec[i], &img->sec[i]))
 			return -ENOMEM;
 
 	return 0;
 }
 
+static int iwl_alloc_ucode(struct iwl_drv *drv,
+			   struct iwl_firmware_pieces *pieces,
+			   enum iwl_ucode_type type)
+{
+	return iwl_alloc_ucode_mem(&drv->fw.img[type], &pieces->img[type]);
+}
+
 static int validate_sec_sizes(struct iwl_drv *drv,
 			      struct iwl_firmware_pieces *pieces,
 			      const struct iwl_cfg *cfg)
-- 
2.34.1


