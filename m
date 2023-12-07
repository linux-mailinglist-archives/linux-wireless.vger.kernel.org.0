Return-Path: <linux-wireless+bounces-482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101DB806A1F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53B41F21C74
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62DC2D04D;
	Wed,  6 Dec 2023 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsdUIZdC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45592688
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852602; x=1733388602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l46o3zGvA0qQFk1E1X6W/S3RFaABpV9jWyvdkaqvHHg=;
  b=XsdUIZdC24dgXCCWGwJBjND55scMDIfHrIVLA6si1Iuk8AAQBxjgsXj4
   8Il5N7Ar9W6NNL3adwIc0Q8n2TJnH4Z4HKwScJT2jJqUpHQ//J1QcY6iO
   G61WWhB67Zu+uJt6imdbLo3esormQ5OPE0Qa0Ue/7FbZbHSycTfOjF02w
   FjubEosCOPcgihym+SDutpxxYzPnzp0dU2EdxqyC5QwE9ILVd+N5VnfEb
   497m4bF4dJuS0R45XHZQVqVYqicK70Zxlj7DKviL+5i90dedhvNdts8uc
   byzMOKExxfD0HtTf+T1czUAgAzmD/GO0zcgpancsLDHEMpFJKdMfmK7hz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916580"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916580"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575412"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575412"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:50:00 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 09/13] wifi: iwlwifi: fw: file: don't use [0] for variable arrays
Date: Thu,  7 Dec 2023 04:50:14 +0200
Message-Id: <20231207044813.367a2c77b9be.I4964ec8ca1d30c7c3163f9873814c8205a1a14eb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Johannes Berg <johannes.berg@intel.com>

This causes fortify warnings when compiled against recent kernels
with recent compilers, and generally is not supported in the kernel
anymore.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 03f6e520145f..7bbc55ccc3ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -20,7 +20,7 @@ struct iwl_ucode_header {
 			__le32 init_size;	/* bytes of init code */
 			__le32 init_data_size;	/* bytes of init data */
 			__le32 boot_size;	/* bytes of bootstrap code */
-			u8 data[0];		/* in same order as sizes */
+			u8 data[];		/* in same order as sizes */
 		} v1;
 		struct {
 			__le32 build;		/* build number */
@@ -29,7 +29,7 @@ struct iwl_ucode_header {
 			__le32 init_size;	/* bytes of init code */
 			__le32 init_data_size;	/* bytes of init data */
 			__le32 boot_size;	/* bytes of bootstrap code */
-			u8 data[0];		/* in same order as sizes */
+			u8 data[];		/* in same order as sizes */
 		} v2;
 	} u;
 };
-- 
2.34.1


