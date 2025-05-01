Return-Path: <linux-wireless+bounces-22292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1329AA5CD3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 11:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206FD4A579B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA8421422B;
	Thu,  1 May 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IytOyv39"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A67126C05
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093594; cv=none; b=ZCCxyXisAnVR+6CCFq3DMAxffZ6uqdt7etT+K8JVsEYvenGnxb8ASkte9B9aOjdTKUNd3KYGbXCUWxAA4Td+sE2tbqW4YD71x2emx8V5YzpaliLAO0hOWpeWGsoD18iMtlFDmUT667wTQcmXt9gPApLoMp0VP+CikkxG9mv80mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093594; c=relaxed/simple;
	bh=8D9vzmng1l0/4Y/Qb4/TMas0PqcsBxaXn9pioGQgQgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NqHmbf/XMeXCPw8wLQzJgY5gs7k2FTOPa0O4e+tk+Bn5fBMcjbwV+4HcHJT3N1p+kdPUUEgXZXj0X8xEDC5sxnYY/tC83EVrsEsjx56bRhuCEI+uokooDnKkz22Eb0TYxJ5NCiDzCRYj226r+qHprRrCKztWMcc90gCIDxcMhFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IytOyv39; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093592; x=1777629592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8D9vzmng1l0/4Y/Qb4/TMas0PqcsBxaXn9pioGQgQgk=;
  b=IytOyv396O9/uPfl9P7vZSEDkegI50+LNKXEFjCKGMHRWH9fd68halEc
   XEnOQjVS5StLaMQk0UOgeJ1F1KcAc/3nBa89b5J0eNYa0ujYrKEVprbrd
   mETFi67oRSWhlmZIHinGY2C11lQPs7yYwDRbNOvlO+js5ZUC9KnDDvIiM
   XBC9d2V7DVnuRZA/GYzb1UU5GNN0HQeMbAWdb2i3wZ2s2DMEP/rPQqzyA
   cUysdNbK8bIYpeOpEhpywgjSgYAtxQMUjsiwRc7JZ0WrPO7L2UQDQEfRe
   JhviD8HWBUHykmQctBv1SzTlkPfBe7z9iwKDxQwUv5eTKAielFGQldJmM
   Q==;
X-CSE-ConnectionGUID: PIOBQfMUQe6qr2fLmYMo8Q==
X-CSE-MsgGUID: sLU6SPo3Q8+KIqC6o3mbDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962812"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962812"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:59:51 -0700
X-CSE-ConnectionGUID: wr3s4kkhTImzBf4azDCa/w==
X-CSE-MsgGUID: O3KAOx0TThW8ItLTRXWg3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135317924"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:59:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-01
Date: Thu,  1 May 2025 12:59:22 +0300
Message-Id: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
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

A few cleanups and features from our internal tree.

Thanks,
Miri

Johannes Berg (13):
  wifi: iwlwifi: clean up config macro
  wifi: iwlwifi: remove TH/TH1 RF types
  wifi: iwlwifi: unify some configurations
  wifi: iwlwifi: pcie: add entry for Killer AX1650i on AdL-P
  wifi: iwlwifi: tests: check for device names
  wifi: iwlwifi: cfg: remove fw_name_mac
  wifi: iwlwifi: cfg: unify Qu/QuZ configs
  wifi: iwlwifi: cfg: unify Killer 1650s/i with Qu/Hr
  wifi: iwlwifi: cfg: remove unused config externs
  wifi: iwlwifi: cfg: remove max_tx_agg_size
  wifi: iwlwifi: cfg: remove iwl_ax201_cfg_qu_hr
  wifi: iwlwifi: cfg: remove duplicated iwl_cfg_gl
  wifi: iwlwifi: cfg: remove duplicated Sc device configs

Miri Korenblit (1):
  wifi: iwlwifi: remove duplicated line

Somashekhar Puttagangaiah (1):
  wifi: iwlwifi: pcie: Add support for new device ids

 drivers/net/wireless/intel/iwlwifi/Makefile   |    3 +
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  208 +--
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |    3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |    9 -
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |    2 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   12 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   34 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   56 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |    5 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1205 ++++++++---------
 .../wireless/intel/iwlwifi/tests/devinfo.c    |   12 +
 11 files changed, 617 insertions(+), 932 deletions(-)

-- 
2.34.1


