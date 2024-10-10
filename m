Return-Path: <linux-wireless+bounces-13842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38173998465
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 13:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFBD1F212A8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9861C2327;
	Thu, 10 Oct 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnJfK529"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468841BFE12
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558324; cv=none; b=afkSloNUuw4n/Ya8noAZL0PF833NDvb1fmoFnCVq5Hp4sLybbT/UOXPUKVT9bhzE9wqQ6oKh6CChK6uqwmTVYKKlijkurAeiDk0CWTCva1/xnZ8rlR0iOK3p1qyxVCMXGmh0EDWbb3A64/VJCx3uSgEjP0grsS7qzDJ6U73VhZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558324; c=relaxed/simple;
	bh=5thz95aXwLQjhkuul7TBnGA1Nce+q+xED8Aq4bUeLcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0aFHmxsG1XOhictEt9UuZ6u8aLIiWG/kLRgDMACQjrHb8LQ+7Tv3YPHmFMiJZzfvEMuZVPiGru26erC8GCKQyvlVBZQWey53+hDsOk7Ng10GjLXsqbzH33FsFZ96fL77Dffmoy6R95lqco6yGtodPknz+B0Y8a7zNegLAmYWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnJfK529; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728558322; x=1760094322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5thz95aXwLQjhkuul7TBnGA1Nce+q+xED8Aq4bUeLcA=;
  b=JnJfK529cWcZkcsRIfp7PWvRDTjtlWVNCjeZxpJ9azeoGF3mU9sfkG3p
   loCiMpTqR48tRhNslwkfalVChdz+Og+ywZd64hJK10vV7MZ4NqpawGAVd
   0p7/fSsPBAFE04F45kiJrl12JTNHqPN1cP8d0v+3OpPhb+eUOMURz1D+2
   iWt77KCIg1LBuZKXNXOJLFhMtv+jCvx3RERejRhYHEjngk7nmnNmVVURl
   rpMwAJMs2Bh4TT0P1B5Ph9w42WrNCk8r8XKWzJyPIIf6FyS/WJgZVffge
   KFVSrGhXbQMfnh18FpL+LXQJFJLX1AIDqd6z/AqKLPR+7aFPrPsHv0DGL
   w==;
X-CSE-ConnectionGUID: zGrO5JnTSKGpCiKwrcewFw==
X-CSE-MsgGUID: +dMKl4HaTZ6RNDl+SNYKyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31697725"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31697725"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:21 -0700
X-CSE-ConnectionGUID: V2uTGbfVQYuFVVXaNQWf/w==
X-CSE-MsgGUID: 95q/PpLERfu7dllOcJ3xZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81362296"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/9] [wireless] iwlwifi bugfixes - 10-10-2024
Date: Thu, 10 Oct 2024 14:04:58 +0300
Message-Id: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi,

A few bugfixes from our internal tree.

Thanks,
Miri

Anjaneyulu (1):
  wifi: iwlwifi: mvm: SAR table alignment

Daniel Gabay (2):
  wifi: iwlwifi: mvm: Use the sync timepoint API in suspend
  wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()

Emmanuel Grumbach (4):
  wifi: iwlwifi: mvm: don't leak a link on AP removal
  wifi: iwlwifi: allow fast resume on ax200
  wifi: iwlwifi: mvm: don't add default link in fw restart flow
  wifi: iwlwifi: mvm: tell iwlmei when we finished suspending

Johannes Berg (1):
  wifi: iwlwifi: mvm: remove STARTING state

Miri Korenblit (1):
  wifi: iwlwifi: mvm: really send iwl_txpower_constraints_cmd

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 96 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 10 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 23 ++---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 34 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 -
 8 files changed, 97 insertions(+), 78 deletions(-)

-- 
2.34.1


