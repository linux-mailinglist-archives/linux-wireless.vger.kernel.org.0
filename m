Return-Path: <linux-wireless+bounces-7211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E498BC80D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F69B21871
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD101411DE;
	Mon,  6 May 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acA9Ygrd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2F140370
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979106; cv=none; b=t6VsoPiPXnytnspusW6umUdehKvCKUl/ZQFA+IEDNW5O+2Qw+/iAR5EFvuXTNLCD2G93ZO7Z2lLOz7vKh6o2ctuIfnTigechr+30FsRkAvIA6FBqIuybbjWs4Ww8hGL3fdMCYd70LNGLU271ubudSORBYjZw01ClMXt2N4fwwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979106; c=relaxed/simple;
	bh=Wk9y+J+sqxjHcaiMv9mqpmeWgO4t83WZipC7Zie8W6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FdB8zOUSZxDp4cgZMEpFeq2zJcrl84jYSRXU/Il3QKK8qAnJoQgjN0lreOGndnzRzb2uIGcGujQn7nMWK6tIV9QT6Tc2pfx1EkTVXRQ+C1TDooDekUZAkM1m3axdKL7dvGReTpUewHpHwX6Qh01PqW0E88lQLybQkhpvp7+Fjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acA9Ygrd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979105; x=1746515105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wk9y+J+sqxjHcaiMv9mqpmeWgO4t83WZipC7Zie8W6s=;
  b=acA9YgrdXhBWfKxCc1KMjuJq+BXRzNH5V0+IoP/w+rHolYGWfmMm/s66
   zAnnXBhk9xT8iiH55RpevYVV6dt9Rrhvgnp7dJVaLCz2PRjN3s1jcjV7D
   7ByYrhBu1fyjIQRaplMd3NRfvRorfL2++3KNvrYwmR5bOCnvRa/vHaD8C
   CCaMJZV2vnHJ+ZOumfdmhEzxRK68XUmmp1AmoIzINkbSLGN3EeqVyPsdq
   wg2PE7Cg7mRXSjbdfZDvNvYWR4PUQ80OtD1WmpPgsfgfWTExCtCP61QQ7
   FAMTlUGqlpIGoPEj1X18lrDRM6kI8XYf6ZIJmLJDq+ZhV44RQisofdxJu
   g==;
X-CSE-ConnectionGUID: YU1fe8F2TgmkLzWWWz8sXg==
X-CSE-MsgGUID: lIvntxz9RrOwInJADrSggQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638261"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638261"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:52 -0700
X-CSE-ConnectionGUID: EebA4DnRQ+OaYmgGzjus4A==
X-CSE-MsgGUID: nGBknR/PSTCJ/kjZikhlIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59265007"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: don't request statistics in restart
Date: Mon,  6 May 2024 10:04:18 +0300
Message-Id: <20240506095953.16638dec9f7b.I093514312179bae566ad8d73ffb0355c6eee288a@changeid>
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

During restart mac80211 notifies the driver about the association,
(if we was associated before the restart) which causes the driver to
request statistics from the FW. This causes to an immediate exit from
EMLSR after the restart is done, when the statistics notif is handled.
(too low TPT). There is no point in requesting statistics wnyway, since
the FW just started and don't have any.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 74452b2112b0..47283a358ffd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -435,6 +435,13 @@ int iwl_mvm_request_statistics(struct iwl_mvm *mvm, bool clear)
 					   IWL_FW_CMD_VER_UNKNOWN);
 	int ret;
 
+	/*
+	 * Don't request statistics during restart, they'll not have any useful
+	 * information right after restart, nor is clearing needed
+	 */
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		return 0;
+
 	if (cmd_ver != IWL_FW_CMD_VER_UNKNOWN)
 		return iwl_mvm_request_system_statistics(mvm, clear, cmd_ver);
 
-- 
2.34.1


