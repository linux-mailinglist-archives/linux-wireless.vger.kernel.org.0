Return-Path: <linux-wireless+bounces-7523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF318C350E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C761F21257
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962991CAB2;
	Sun, 12 May 2024 04:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A06+hTwP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9D01C6A4
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488303; cv=none; b=nwN5tGQBrrYc9o7iOhGNOhr3pbnBtBr0yUbUlX7MfY9cvY3CTO2lcwNzTqsVYDvL9bLQu5qViUc4eMjfrEVhhBKIO2Hqr8qFKOGXFOnRgAmxyfOGAC+QzJ64DVqiZ8Y96dNQNbscQ0b5tngkb//X6UzMjt29G2nG/iL+nXx5w34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488303; c=relaxed/simple;
	bh=ksVa0Ef3eC9TXL960tkBKyziQJhrCRCCT3YXc2d65F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Id1Rpjw197ecnXWVbU3e/nItZ1bIecAGu6nOsr3YdSpN6PN3YdMfzrBWXtDq0tZDNo/PAz8DsLlA6eH+6U39GzOBRm1aF2jMycXHgmhJoMcDdQSNwjvjS8FbcR8ZPZ+mSV+gPGXJ7JAXlVNSSSBPDP813ZxYGQf0iIGmQI67AUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A06+hTwP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488302; x=1747024302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ksVa0Ef3eC9TXL960tkBKyziQJhrCRCCT3YXc2d65F4=;
  b=A06+hTwPwgIksYKWoPuFZLA6dsr10VTt72ApcY/Gae7oU0uFZHqlAP8q
   TSIloVzYlz3DtiZcnCEB5Z7RxLMxyL8kYA2DRs0Y7SQCdra+HXYd8+2j0
   MFO4JnY1SOFM9WgAM9Tkjm5bj/1nO4A/GHfLx0KeXAMdSoeod1ocRYqyO
   8U8ZYg+sdI/TxKIYKcLvHQgh8+JiQ78mJCsifOmxqV/NN35xcZ59dp46l
   tMd32kWolYZxzgm4d98W9xZCjWd3xMOdXZpD2ab8fbpDV5t+s99VyISUm
   xt/69wSDAngR7nbdDpNJt/eV3ZhqfpdEIA7qrbV7nfJjouujJCwFNENnp
   Q==;
X-CSE-ConnectionGUID: jLjKJsqHQTiUeIgXCyrc5g==
X-CSE-MsgGUID: nno44ic/RJa9ZW4A2lSHYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323863"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323863"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:42 -0700
X-CSE-ConnectionGUID: xMMmjbTsT9Si3/DTtL225A==
X-CSE-MsgGUID: jAn9wcx+QKO5GGXv6Fl8pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532180"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/16] wifi: iwlwifi: mvm: fix a crash on 7265
Date: Sun, 12 May 2024 07:31:06 +0300
Message-Id: <20240512072733.eb20ff5050d3.Ie4fc6f5496cd296fd6ff20d15e98676f28a3cccd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Since IWL_FW_CMD_VER_UNKNOWN = 99, then my change to consider
cmd_ver >= 7 instead of cmd_ver = 7 included also firmwares that don't
advertise the command version at all. This made us send a command with a
bad size and because of that, the firmware hit a BAD_COMMAND immediately
after handling the REDUCE_TX_POWER_CMD command.

Fixes: 8f892e225f41 ("wifi: iwlwifi: mvm: support iwl_dev_tx_power_cmd_v8")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e7f5978ef2d7..ca7fcae6995e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -895,8 +895,8 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	int ret;
 	u16 len = 0;
 	u32 n_subbands;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
-					   IWL_FW_CMD_VER_UNKNOWN);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 3);
+
 	if (cmd_ver >= 7) {
 		len = sizeof(cmd.v7);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
-- 
2.34.1


