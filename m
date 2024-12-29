Return-Path: <linux-wireless+bounces-16873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C2A9FDF4A
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6943A0FB1
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8910A1607B7;
	Sun, 29 Dec 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEE3A2/O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0E192598
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483527; cv=none; b=ZTzmnfC5nDkr2pLAJviEqoGnefWymBveLqX17xxqjHVe+UVX2sgoPsa6R8Xp4G2h7kHvOHVObozwwonVEYV2oBRKy/yqqpqDUfUAgk8LyAYjYmQ1qjLgh4J8cqf6YEoVtLm8dd6dvvzA2CDDo9Ir497t+YCDSrtUPw09YWjmrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483527; c=relaxed/simple;
	bh=9hVgdxZwZatw2wmwvxjUIB8dpsOq42FdWVlDY8lR/Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gig8dScHkiFQIIC8Mhh8IoF1lsgyA6NY5R6PtvmoNu+ei028xtPAlLiWzCIlM7643YIHSCTrk5hcO6bDEjm2ajl/6P+PdeDN57Zohut0NY8WR/o7jy/8z+8zolTX2WukY/6WM92Vke7ZdVKhDGDh9miknAO6mGWlyHuzDQfTW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEE3A2/O; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483526; x=1767019526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9hVgdxZwZatw2wmwvxjUIB8dpsOq42FdWVlDY8lR/Gg=;
  b=cEE3A2/OMC8Jjh+IYMv0+veT1yY/+J/aj/uMmY3CbS9yf+EWfsLsvCLd
   9IYW15uswxUodAfu7gfCSSFohM1ik6ziP/rcEGXb4Oo+BXHFQ1SGFxU2T
   nRs2Sf+Mkhl1s/BEB23aB/u2wS/DuhVPxEgjELwH3pQp1VV3BaGyKeulz
   MCNvjOByYHCO+ofLnJyborl1VSYZzkWVOFJeVH4ACJby94aE94FJUOW8K
   BbJc9jbswJWT/CHhOa31atESS3uZtdF6XDaroFOD/SYwzaQ3H/1inNFvS
   FL24sra3iCzQcBXvY/8L33zy9WFMc/U6+pJBTG7x2e/9rQwWoJ6o00G9N
   g==;
X-CSE-ConnectionGUID: i7gLXLIwRcWXde55suXW5A==
X-CSE-MsgGUID: htZG3xXYQv+40WP1n4KUew==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572458"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572458"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:26 -0800
X-CSE-ConnectionGUID: Idbs8qazSE2OTD5GjFNzhg==
X-CSE-MsgGUID: e4ans1BST1GoOTRn9U59iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656972"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	shitao <shitao@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH 12/17] wifi: iwlwifi: Fix spelling typo in comment
Date: Sun, 29 Dec 2024 16:44:47 +0200
Message-Id: <20241229164246.c79c132f811b.Ie07a0007b96359b3552878e23c4b9efeb07bba8d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: shitao <shitao@kylinos.cn>

Fix spelling typo in iwl-context-info.h comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: shitao <shitao@kylinos.cn>
Link: https://msgid.link/20231212093424.3104329-1-shitao@kylinos.cn
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-context-info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index 7abd153d56f9..dfd44fabf237 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -6,7 +6,7 @@
 #ifndef __iwl_context_info_file_h__
 #define __iwl_context_info_file_h__
 
-/* maximmum number of DRAM map entries supported by FW */
+/* maximum number of DRAM map entries supported by FW */
 #define IWL_MAX_DRAM_ENTRY	64
 #define CSR_CTXT_INFO_BA	0x40
 
-- 
2.34.1


