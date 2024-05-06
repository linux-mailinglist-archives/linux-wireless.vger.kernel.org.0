Return-Path: <linux-wireless+bounces-7198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA928BC7FE
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C92F1F22157
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEBC4F20E;
	Mon,  6 May 2024 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEnuNCKP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698D4F88E
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979072; cv=none; b=CriG9jHhk5InVgw0PwjHBgjnveXYDRroAlO+UJlzuDtHbFDyGOh5GgMP6V/30BCssgcARg3ire5aDZvfWjJnT6MFuTJ21yiYgbtH1ASZb10oKvKp0E0UwifpXpH64nOkHPmkRF2UulORUj9X7STLpCo11rTj9MAc9ua8uCxy2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979072; c=relaxed/simple;
	bh=ZLoTURKTxY74alA2+UqptR0K2hc7FGiSBgbZayJb6aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tw9mlqZhFShjZ9KAD8dfrN14j8OuOI8WhBcN23KcEUL2FxqUtT8fwSL8Gp3lhGul8ZURv1TxIeQ5BW/bXZ2Pjmn4yBFaAtRv9zW3iu9zrSxrDVYtEhIyiMMh+BLZ9ovP1QBVSEfxa4ZmRGQ9Hd7drkWr6w671x6weINxWa/GX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEnuNCKP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979071; x=1746515071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLoTURKTxY74alA2+UqptR0K2hc7FGiSBgbZayJb6aA=;
  b=BEnuNCKPISwHQgFufbUOnLYF7Q76yOwqX6SCJIa9RrKOc1qzrA+xbGds
   ZYFU4XYGdckyInHA6EZHast9X1PBVpIOLgnMOjZZRDmFRlXxWc95WmlS+
   DBjIOcsWwhtVQu1dXbj3/eIKWP9hqPRQiLSGCJRGmHcWDVOEUf4iwrNHW
   Ke+8FT0cGslfKx4YPJme4b3lrxNXBLtkeFKNOOZHN/8v2yQPFVd1esVnL
   J7OtArEpeRKbHogCpXQis27jhaLwNdIFTPtXxep2R8CD01MaO9utKIWsE
   hG5vfO5LvFA48Ial/f9fyqv2JGJUFsmTXzQLcGpHoknF3qN9DmnZGUrfZ
   A==;
X-CSE-ConnectionGUID: +J7JuTGkQNWo3v6ee119Kg==
X-CSE-MsgGUID: dFJKzMLnTFa2XLExJWWMjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638136"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638136"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:30 -0700
X-CSE-ConnectionGUID: pJU3m0HMS9SQfkX+1PQmZg==
X-CSE-MsgGUID: UpRc3/37TxuJu8U2MK6AOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264837"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: mvm: use already determined cmd_id
Date: Mon,  6 May 2024 10:04:05 +0300
Message-Id: <20240506095953.f894ede03b26.I18f03c272b1c0807767f2713f3ffbb2941c57d9b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In iwl_mvm_rs_fw_rate_init() we have a variable cmd_id that
holds the command ID, so we can just use that instead of the
various calculations of it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 00860feefa7a..3ba62fb2c85e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -654,10 +654,7 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	 */
 	sta->deflink.agg.max_amsdu_len = max_amsdu_len;
 
-	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-					WIDE_ID(DATA_PATH_GROUP,
-						TLC_MNG_CONFIG_CMD),
-					0);
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 0);
 	IWL_DEBUG_RATE(mvm, "TLC CONFIG CMD, sta_id=%d, max_ch_width=%d, mode=%d\n",
 		       cfg_cmd.sta_id, cfg_cmd.max_ch_width, cfg_cmd.mode);
 	IWL_DEBUG_RATE(mvm, "TLC CONFIG CMD, chains=0x%X, ch_wid_supp=%d, flags=0x%X\n",
@@ -693,9 +690,7 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 		u16 cmd_size = sizeof(cfg_cmd_v3);
 
 		/* In old versions of the API the struct is 4 bytes smaller */
-		if (iwl_fw_lookup_cmd_ver(mvm->fw,
-					  WIDE_ID(DATA_PATH_GROUP,
-						  TLC_MNG_CONFIG_CMD), 0) < 3)
+		if (iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 0) < 3)
 			cmd_size -= 4;
 
 		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, cmd_size,
-- 
2.34.1


