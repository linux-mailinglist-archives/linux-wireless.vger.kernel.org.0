Return-Path: <linux-wireless+bounces-480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E0806A1D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8102D1C2146B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844171A73E;
	Wed,  6 Dec 2023 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CONdxmTq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8837710EB
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852597; x=1733388597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1tAPfprFcqc/8EVMzk0W63CvNgwtslkDUikG3RQIBts=;
  b=CONdxmTqdfsjceZTqgvE07KkubGYMkWqZIAEisocnP8TLV0CsXjTM6ZT
   I8jWMURr/P60+AswUhwmf5R3jyXAfU4on7roeqUgx264UJgfYdQBMgPZp
   yAfrijfVMJgUWrp5n1ni4zYFlgrhprAAC5njpXCUbwMXIVnYkp0EIqgm/
   VHsxOyw5TRTOrRELI17AtOEcGus1E+0bTgAfceNODy+T05pZN7ifJapkU
   Pdj5rG19FFbS6f9Umwl7pP2Q6PlLpsqplTz8/JtLz4jC/wLvbZhZXR8j5
   CQeN61vDoXmc9tJhr03BXIOLRsW4c1CkI2x1b01WR9fDyWDN4O6O+gmCw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916557"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916557"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575405"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575405"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:55 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 07/13] wifi: iwlwifi: pcie: dump CSRs before removal
Date: Thu,  7 Dec 2023 04:50:12 +0200
Message-Id: <20231207044813.a0e2198e9afd.I3bf737ba5ec1b3013218001e808f6bae0c834543@changeid>
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

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 31a6e34b33ff..eb77575f5b12 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2144,6 +2144,7 @@ void iwl_trans_pcie_remove(struct iwl_trans *trans, bool rescan)
 		return;
 
 	IWL_ERR(trans, "Device gone - scheduling removal!\n");
+	iwl_pcie_dump_csr(trans);
 
 	/*
 	 * get a module reference to avoid doing this
-- 
2.34.1


