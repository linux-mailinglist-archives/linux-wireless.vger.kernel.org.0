Return-Path: <linux-wireless+bounces-2868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9E8438E1
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6D1F29013
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AACF5A0E4;
	Wed, 31 Jan 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2Ir/52f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82257895
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689503; cv=none; b=nx4ap/hXrep2U0ZfXSgIvnm9t7/KRGVNHiUPl1vIkQItgBOKcg8Q7I2p0qfVWlF9Yteqr5c5ip1T/f3XcXaE3fx39x34Nafsxgq+jDug8sdjg2gBfJMR09NuFsuBi32+vdSx14AC4Wg80Q4wg43vYvS00ScvkCWYTczjvo5ZyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689503; c=relaxed/simple;
	bh=gXY9ytuTzWcNZ7gQ3DB+5dJldFRb1yQO08Y8sLiZQHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eb8pdJy78LJ3wCOQDN60nuYJs+DUW/wd9/UUUkGyWTC+1/aLpB8kso5F/57UFajLdNgMu2b8FPX3SS8x9bkELdTBjW+5rnYKmA2FlTIdDIdTu6e4PjBK3d3JSkVn4/3Kaf8BRUy+3MhQTCJpV9AfGh81PvmNnwR0IgGsPU/+mSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2Ir/52f; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689500; x=1738225500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gXY9ytuTzWcNZ7gQ3DB+5dJldFRb1yQO08Y8sLiZQHU=;
  b=D2Ir/52foDnmjUeQv2zxT5CUSFzBqzw0qtbjm8K2P8cr56ip4IPNtd4l
   czRNNtZEgjDm74ZpfUI0gtkI09xp06sQFUduoW4RyWKNO5XEApp382XwZ
   CQPN241s4fbENc4AOGgBqhPLQjlUjG9LQaobeTwss3AarJxFPmuzLOcx7
   qzkn7veuZq7rYkOwcwXNr1FNHdWD/lkZk0Gc1D+JnD4m0DLj8GURrz6YO
   B0rBhzy2oWmnSzA7YvQgncM/nYyKDNZX4qfLJ5q/Cgvh6oDssd8xAJz9W
   iHyIxJc9DjK47wBHSUHZpWOzANnuWk8orql/5SZcUUw9tRK0AqDpwZhZ1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249878"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249878"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968783"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:24:59 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/14] wifi: iwlwifi: read BIOS PNVM only for non-Intel SKU
Date: Wed, 31 Jan 2024 10:24:34 +0200
Message-Id: <20240131091413.3625cf1223d3.Ieffda5f506713b1c979388dd7a0e1c1a0145cfca@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
References: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The driver is supposed to read the PNVM from BIOS only for non-Intel
SKUs. For Intel SKUs the OEM ID will be 0.
Read BIOS PNVM only when a non-Intel SKU is indicated.

Fixes: b99e32cbfdf6 ("wifi: iwlwifi: Take loading and setting of pnvm image out of parsing part")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 30 ++++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index d467ec0e3552..053174f00e49 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -268,21 +268,27 @@ static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len)
 	struct pnvm_sku_package *package;
 	u8 *image = NULL;
 
-	/* First attempt to get the PNVM from BIOS */
-	package = iwl_uefi_get_pnvm(trans_p, len);
-	if (!IS_ERR_OR_NULL(package)) {
-		if (*len >= sizeof(*package)) {
-			/* we need only the data */
-			*len -= sizeof(*package);
-			image = kmemdup(package->data, *len, GFP_KERNEL);
+	/* Get PNVM from BIOS for non-Intel SKU */
+	if (trans_p->sku_id[2]) {
+		package = iwl_uefi_get_pnvm(trans_p, len);
+		if (!IS_ERR_OR_NULL(package)) {
+			if (*len >= sizeof(*package)) {
+				/* we need only the data */
+				*len -= sizeof(*package);
+				image = kmemdup(package->data,
+						*len, GFP_KERNEL);
+			}
+			/*
+			 * free package regardless of whether kmemdup
+			 * succeeded
+			 */
+			kfree(package);
+			if (image)
+				return image;
 		}
-		/* free package regardless of whether kmemdup succeeded */
-		kfree(package);
-		if (image)
-			return image;
 	}
 
-	/* If it's not available, try from the filesystem */
+	/* If it's not available, or for Intel SKU, try from the filesystem */
 	if (iwl_pnvm_get_from_fs(trans_p, &image, len))
 		return NULL;
 	return image;
-- 
2.34.1


