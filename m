Return-Path: <linux-wireless+bounces-18662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796A3A2DDCA
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9501886E80
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EDC243378;
	Sun,  9 Feb 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZENKoijH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68541E522
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104513; cv=none; b=EGmP5ZwfZ94Zq/+uGEeJuc9DT1q/uJFbpLgmE3VLw1WUPDNDBIT7AieseTvnu3EAy/NIecpemT9rBuxPV9tHtNP2cB4hMhJMKOZKRkdWo/SLOBZMlwYzXuUUIEP1VzqlAzAFgQtKO6QmPtwWuGO1ld3JXs/1IuR1NF5/kHux9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104513; c=relaxed/simple;
	bh=hdkIGlsnICz2snWfPuikGBreRjs/R6Z4WJCl7hlg5tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uc45ZISKSsN/q+nM25h8DkpXfREFCthyn+M/YT7YS3cJta1tz/kUJQpRe6qP3yxhPr+KBFph8VgGJdr1LLW4RmQeykpNVkjX4iVXUT+E0U5QLo89C/mI9PLuawvt/Gv8KCrgu34Hvb6Q10clq+3bkuO36nXWeEnrjTEl+VbVNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZENKoijH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104512; x=1770640512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hdkIGlsnICz2snWfPuikGBreRjs/R6Z4WJCl7hlg5tU=;
  b=ZENKoijHXFBWsRdF9+lDbvvEF2H02kzrI+NRAkJ7ODT3pXKsCDo2LOw2
   oTiJOggMS7bbhC/kIyidqDEBbztCaLde+UVobOaPr8YUce3onsR7Nsch9
   f5aCIF19RbXHTh0IKjutS2LBWzWEeKBF2MZtUGPwd1/aRvgZPMKFYSFOY
   k/bC3SdYonjUpAh2vAWWWQCNRONZf36Jcq7x7t4T77TRLESLUIGxRa1BM
   1g+r4/8lQMsmzP/s67V5IpM3fPVPpKcFHhHadln4vBetyAJKh2uH9CXwE
   E6tKpnikHqeY9i3bWBymaCviQ1VQYKQPKWC2sk5gnML7OSwnC+exqoEtN
   A==;
X-CSE-ConnectionGUID: kkrI0RQaTnC/e95WZh2qng==
X-CSE-MsgGUID: kcUSHrN0Ruy1ncXh/4kcCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125970"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125970"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:11 -0800
X-CSE-ConnectionGUID: JyH6gTH/RROst+G2mCfIZQ==
X-CSE-MsgGUID: 70pCRVe2QQqzQrY/VCF1NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782399"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/9] wifi: iwlwifi: fw: allocate chained SG tables for dump
Date: Sun,  9 Feb 2025 14:34:45 +0200
Message-Id: <20250209143303.697c7a465ac9.Iea982df46b5c075bfb77ade36f187d99a70c63db@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
References: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The firmware dumps can be pretty big, and since we use single
pages for each SG table entry, even the table itself may end
up being an order-5 allocation. Build chained tables so that
we need not allocate a higher-order table here.

This could be improved and cleaned up, e.g. by using the SG
pool code or simply kvmalloc(), but all of that would require
also updating the devcoredump first since that frees it all,
so we need to be more careful. SG pool might also run against
the CONFIG_ARCH_NO_SG_CHAIN limitation, which is irrelevant
here.

Also use _devcd_free_sgtable() for the error paths now, much
simpler especially since it's in two places now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 86 ++++++++++++++-------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index fb2ea38e89ac..6594216f873c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -558,41 +558,71 @@ static void iwl_dump_prph(struct iwl_fw_runtime *fwrt,
 }
 
 /*
- * alloc_sgtable - allocates scallerlist table in the given size,
- * fills it with pages and returns it
+ * alloc_sgtable - allocates (chained) scatterlist in the given size,
+ *	fills it with pages and returns it
  * @size: the size (in bytes) of the table
-*/
-static struct scatterlist *alloc_sgtable(int size)
+ */
+static struct scatterlist *alloc_sgtable(ssize_t size)
 {
-	int alloc_size, nents, i;
-	struct page *new_page;
-	struct scatterlist *iter;
-	struct scatterlist *table;
+	struct scatterlist *result = NULL, *prev;
+	int nents, i, n_prev;
 
 	nents = DIV_ROUND_UP(size, PAGE_SIZE);
-	table = kcalloc(nents, sizeof(*table), GFP_KERNEL);
-	if (!table)
-		return NULL;
-	sg_init_table(table, nents);
-	iter = table;
-	for_each_sg(table, iter, sg_nents(table), i) {
-		new_page = alloc_page(GFP_KERNEL);
-		if (!new_page) {
-			/* release all previous allocated pages in the table */
-			iter = table;
-			for_each_sg(table, iter, sg_nents(table), i) {
-				new_page = sg_page(iter);
-				if (new_page)
-					__free_page(new_page);
-			}
-			kfree(table);
+
+#define N_ENTRIES_PER_PAGE (PAGE_SIZE / sizeof(*result))
+	/*
+	 * We need an additional entry for table chaining,
+	 * this ensures the loop can finish i.e. we can
+	 * fit at least two entries per page (obviously,
+	 * many more really fit.)
+	 */
+	BUILD_BUG_ON(N_ENTRIES_PER_PAGE < 2);
+
+	while (nents > 0) {
+		struct scatterlist *new, *iter;
+		int n_fill, n_alloc;
+
+		if (nents <= N_ENTRIES_PER_PAGE) {
+			/* last needed table */
+			n_fill = nents;
+			n_alloc = nents;
+			nents = 0;
+		} else {
+			/* fill a page with entries */
+			n_alloc = N_ENTRIES_PER_PAGE;
+			/* reserve one for chaining */
+			n_fill = n_alloc - 1;
+			nents -= n_fill;
+		}
+
+		new = kcalloc(n_alloc, sizeof(*new), GFP_KERNEL);
+		if (!new) {
+			if (result)
+				_devcd_free_sgtable(result);
 			return NULL;
 		}
-		alloc_size = min_t(int, size, PAGE_SIZE);
-		size -= PAGE_SIZE;
-		sg_set_page(iter, new_page, alloc_size, 0);
+		sg_init_table(new, n_alloc);
+
+		if (!result)
+			result = new;
+		else
+			sg_chain(prev, n_prev, new);
+		prev = new;
+		n_prev = n_alloc;
+
+		for_each_sg(new, iter, n_fill, i) {
+			struct page *new_page = alloc_page(GFP_KERNEL);
+
+			if (!new_page) {
+				_devcd_free_sgtable(result);
+				return NULL;
+			}
+
+			sg_set_page(iter, new_page, PAGE_SIZE, 0);
+		}
 	}
-	return table;
+
+	return result;
 }
 
 static void iwl_fw_get_prph_len(struct iwl_fw_runtime *fwrt,
-- 
2.34.1


