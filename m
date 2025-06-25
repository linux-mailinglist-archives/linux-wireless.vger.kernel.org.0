Return-Path: <linux-wireless+bounces-24497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2FAAE8BAF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 19:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8667C177D2C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325E53074AC;
	Wed, 25 Jun 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VF3tt9Nq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261E29E111
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873363; cv=none; b=Pkfpkv9EW4yZ5KnYaJmehU6QnZghmjIRUlp1yOpGXXQZmDOPMkVjD+/vYCnb/a6V7d3D5mHC6MC7sbvJbdeWoDTbTE7lpi2XqOM3FlpmHEkQPFL3V94AdN7ZcjABXM54yWkw6ND7E4sYZI7IzpTdj4OPhuVyi5rPuezHKLOPGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873363; c=relaxed/simple;
	bh=X0GS0DlkZRj/i5tPtnmJ6po1Afn03LhXekfbiFBRSnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5iNDFyzdkgG/ho89/fXXBU3ONcIq6fyseBtVWERdvN1w9AAB8KuDT0yCuAklhjee2uGG6nO/e1jXdkYMLrz729YwBkjmUQ7usq3egN7kzhrI54xdzG/pcAn3CR69bISkU6KA2t6dFQwVm8CzBJiEQTR+va5sWzR7zpfyBaecdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VF3tt9Nq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750873361; x=1782409361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X0GS0DlkZRj/i5tPtnmJ6po1Afn03LhXekfbiFBRSnM=;
  b=VF3tt9NqRHci2FBuwEg0O95l9mQAAQfSjLk/mh8GftrfyrjTQBsCJ4SQ
   PLAcnf6vYbT23QM1+AbTFzPkRIo2dEEk/vk1CpNiUqcV1s6Pi4f3+TDtf
   wnDPIY72qOHa+bGUT799q4JLpes4c6afgogku9pNvzmocpqc+hC4Ovy/H
   7Ijjhi9u/GM/+YltWQit/gV2lyp8KjsIG2J9J43CTY3WceCuHGlst//Ql
   nK0+yB9hNESjcBCtUKmDvjm/NHdKVJGIWSDAgaZSZZl2gUQbJ1fcJ9nLI
   x9WPOj3u3vNTqwnNXKke6Z6SoDr5hDzFe4A/YPHQfXyCdHEv4RW99YktX
   g==;
X-CSE-ConnectionGUID: xA+v+8sFTGyvmAkkSUs9cg==
X-CSE-MsgGUID: ocCMNlsoQ2STRbmWjORNJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="40771620"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="40771620"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:42:40 -0700
X-CSE-ConnectionGUID: +D3ez9nVTU+Bo+D+1Fofcw==
X-CSE-MsgGUID: m628M+eKQhOpa8bqOqfEeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="151804479"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:42:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: pcie: fix locking on invalid TOP reset
Date: Wed, 25 Jun 2025 20:42:21 +0300
Message-Id: <20250625204210.19a0378838b1.I6bdc58d4996e995e1358ad94d4cc5017f3abf47b@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If a TOP reset were to ever be erroneously requested on HW
prior to SC, the code warns and returns, but doesn't take
care to unlock the mutex in this case. Fix that.

Fixes: 909e1be65462 ("wifi: iwlwifi: implement TOP reset")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202506100707.WAnP5ePA-lkp@intel.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index c8f4f3a1d2eb..5a9c3b7976a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -546,8 +546,10 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	}
 
 	if (WARN_ON(trans->do_top_reset &&
-		    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC))
-		return -EINVAL;
+		    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* we need to wait later - set state */
 	if (trans->do_top_reset)
-- 
2.34.1


