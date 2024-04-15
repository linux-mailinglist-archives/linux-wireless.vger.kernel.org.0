Return-Path: <linux-wireless+bounces-6308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048D8A4AEA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5D01F2139A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED23FB89;
	Mon, 15 Apr 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nm/pJbaQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724A3FB96
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171294; cv=none; b=b+ES5roqNrazOdg6C/nn1rtbPKOZ5kkk+2d0mfZj/9wuaD2r0o9NYUxhhdxkvAzIFtlthJASWQ9IJEiuVFRYUQM1h4iUPt7gQICPSPf+KU3vVkQo9/D50uq29wQwD3aAOljI+cpevqxfnb0fWmq7A8v60BkFK7xbc5EXqJMX1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171294; c=relaxed/simple;
	bh=VKgS8iY4f72bv55+bYginsCtjkbtXjfWJKwA9SOPTc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m9ODXGZAWx+HsrxIx1F3CPjdUtTGAjvdPyPx9bn3S+yRtufEeUsx5QZ1iow71GX5cF3NIAQfdZJjzv+TS/ZbNnrYJ9aoBpZPT9M829pRTh3WBP/Qa7Alcr2J3QzD+biXdy+tEv/JTN1M0gAd1WZMjnxmkjH4hQjKP3WhfrHaRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nm/pJbaQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171293; x=1744707293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VKgS8iY4f72bv55+bYginsCtjkbtXjfWJKwA9SOPTc8=;
  b=nm/pJbaQ0X33CdrhoarQ7P2QVOr5LUCeLLUDkuu4NPvaCaYkmWEbc8fA
   nQTLoHxewDSiwbELF8uRz+7sNGYZgsprVz5JLY6cTzhQSDayTkoksD1h3
   nzT6vIaBwPEj8/ns5cbtNUW2tZQF1qvNXu5AhOyDjj1NFgM7YtKZc1HPP
   HYsbpouObLaiPmiReE36KGm5RsWfTpJkRbm0haegULPuZjP6Oc0tCUobL
   Az0mmTum1I4NduqQhovCcO6+TwBQyFrQZ4G03wScfalxpYCJm7SIpgu8e
   Q0A9q5RrjLTrASmOoevtJhe9lInjZ/OxVAhmfA608ukup1XT2Sa6V3wTj
   w==;
X-CSE-ConnectionGUID: kVg/1qLcRau8IV8NZ7mnyQ==
X-CSE-MsgGUID: 2bVR8TDaSI+xF6e3y0xvIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100569"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100569"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:54:52 -0700
X-CSE-ConnectionGUID: tYDDghP7QIeZZ3/YEgCReQ==
X-CSE-MsgGUID: dbmtPIgMSgixsYOjN2tPRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21767899"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:54:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/11] wifi: iwlwifi: updates - 2024-04-15
Date: Mon, 15 Apr 2024 11:54:33 +0300
Message-Id: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.10. It contains
a few features, bugfixes and cleanups.

Thanks,
Miri

Anjaneyulu (4):
  wifi: iwlwifi: move WTAS macro to api file
  wifi: iwlwifi: move lari_config handlig to regulatory
  wifi: iwlwifi: mvm: Add support for PPAG cmd v6
  wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v10

Avraham Stern (1):
  wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Benjamin Berg (1):
  wifi: iwlwifi: mvm: move phy band to nl80211 band helper

Emmanuel Grumbach (1):
  wifi: iwlwifi: add a device ID for BZ-W

Ilan Peer (1):
  wifi: iwlwifi: mvm: Refactor tracking of scan UIDs

Johannes Berg (1):
  wifi: iwlwifi: mvm: extend STEP URM workaround for new devices

Miri Korenblit (2):
  wifi: iwlwifi: bump FW API to 91 for BZ/SC devices
  wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  36 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  16 +++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  46 ++++++-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |   2 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 127 +++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  23 ++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  24 +++-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  97 +------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  15 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  17 +--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  26 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   1 +
 16 files changed, 306 insertions(+), 137 deletions(-)

-- 
2.34.1


