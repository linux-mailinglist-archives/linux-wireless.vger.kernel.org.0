Return-Path: <linux-wireless+bounces-13671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA9A993DF7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A131F24A79
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE6137772;
	Tue,  8 Oct 2024 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPbAX/kK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA411311B6
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361554; cv=none; b=UlPq4oGy8zb6IExpjgnS/ImMlq98FfU9J3FT94DSCmdnnlPNV+rbC68a7zrKhsuDyl9vn6JqijM/2LZFRB0ntUmUmrQjFlsRf09+CgV7MVRoiTOeuEl6LVLw653S+d9QP8r+dLIlIR/7f5xe8OPGFlT5fkgsW4mt+RNgajePkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361554; c=relaxed/simple;
	bh=HsAW6HKzcDhAOJKjsI3rXNTpJKq5S/6d4a6QXRHdds4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e2Zlqg8wz8W5NHfuA/Qv4jBMJR1ttkAl3a9FcEnogtOhbhPG67W4bTSPCZtE2orhyoUdpEsY+OnnzP6IQiBiznf0mnt9tgauuNWch42i+J0m9H6yHXRQWOoYTBvSzPq6+AKgOVZT7S7vWitpnFTSd5h06qJsegUckXo8hhet424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPbAX/kK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361553; x=1759897553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HsAW6HKzcDhAOJKjsI3rXNTpJKq5S/6d4a6QXRHdds4=;
  b=WPbAX/kKJeC1jG7lU2z4pPIKbLCOen51t8zESirkSvb/2ybGm4liqTGK
   j8WL3xWK6TB69mZWeUX1SLYCiM4DVNcSO9cSS3cFrCFJHybZsRmvlrrQM
   21+onPL1H6bL3/ncksSOV7YhEX9NfdL9nXi2PU8EY0YjsisGAIBoxAd+2
   vhfms8ftkfOWZHjrExOpWvhXs0YCOaQg4PPDi/06K/W09teBghZwaV4tK
   YSb3Unw5qubyJ0V/GR3PN8ayTDUD7L4DHsl08YsvG2k1gG1+noAbFuUrp
   5ZfNzy/2WfGNoWm7STqbZrJsDOUoRPLuiN/zNuzqv1MFu3D5EFNhh9zwj
   w==;
X-CSE-ConnectionGUID: I2jgcaG3TcyRmMFtLy6/SA==
X-CSE-MsgGUID: kKDWIlybSiW4rUczBUfZyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024284"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024284"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:53 -0700
X-CSE-ConnectionGUID: Fez4XLm0QC+06BSAHd1e0Q==
X-CSE-MsgGUID: fhz1BcTZT5yOB6TzZnOhog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486357"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: mvm: Remove redundant rcu_read_lock() in reorder buffer
Date: Tue,  8 Oct 2024 07:25:22 +0300
Message-Id: <20241008072037.8f229e1b08b7.I31a371f635d84db300ad16ce6170cc07a8b154fb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

iwl_mvm_reorder() is already called within a rcu-read section.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index fdbd63ff91ef..a2f16bfaec44 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -773,9 +773,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 		return false;
 	}
 
-	rcu_read_lock();
 	sta_mask = iwl_mvm_sta_fw_id_mask(mvm, sta, -1);
-	rcu_read_unlock();
 
 	if (IWL_FW_CHECK(mvm,
 			 tid != baid_data->tid ||
-- 
2.34.1


