Return-Path: <linux-wireless+bounces-22326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC669AA7193
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F3716E12F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3327C253B65;
	Fri,  2 May 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wz23TpAY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018323C4EF
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188447; cv=none; b=pBbUGgBP+1NVBUQ42tpVhlHOSBXxdEsouwOf10Z/85aREHmdrXSkrLsaiabIPhJ9T6Ed2W2oODJMAsJ2mv1xycbodUJsiMRSAw3V3kX/1WL9vaJoZ8HsghxDN9RDG97R42K+xBv1jp5E7hJd7zvEDQ/ip4JQQ72QZ4THP7kXcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188447; c=relaxed/simple;
	bh=KspXDldN3ct18xU/DLaB8KfiuT15jzJwoL45krXK3Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lkb5VkeGS04vNwFuWbvHsqxj9zdsPZvfdNCUnwS8Gg0JoX+xpQj8wGoygHLGapmf+y8Op92p+fJKp7RW3+d2u9fY0VGzzFODqqzpoR+//Z0+s4om1Xd+NXFm1+hfLc9lGAt+2XuuUdc/fiDH7bcReEvoWGgwDNCRr51jXgNfx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wz23TpAY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188445; x=1777724445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KspXDldN3ct18xU/DLaB8KfiuT15jzJwoL45krXK3Tg=;
  b=Wz23TpAYkDqCPnrKLw0XTUnwzeomz1ymJ8DI9j5jUS7cnA1f4PrjPoXK
   V8Qv5w7VqJeS4EXrf2zIm3X8nbVt5c7mywuUxSakjB4foJeH9uKlSsdQ6
   RoTyiZqk7+X3LczyIKDl+zwiA0FVA68sYD3RCLWAOG/WaY7ICPZT0qK0V
   Ztjoe/YG+0XPK9YsW85ZoF+IEmDbnkv34p4LtHTBaXc8HDoCOgsswS5wN
   KRvbn2Y6OKaZIB6nd2IbwTX2xq/ebPGEymOlaLJ0rp+Ne17foZAO5gAoc
   J3OxoyiWR4ZxQgUC03mwrdLlhomK2e+Gtu52Qaaid/E1xzmWEOJFGvL9T
   w==;
X-CSE-ConnectionGUID: LVexcgfgQyqFTsvodwqxwA==
X-CSE-MsgGUID: Oj5daL/BSmWyIIQAa4YElA==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010346"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010346"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:44 -0700
X-CSE-ConnectionGUID: os+eFeChQpC3b8CfwpJ4KQ==
X-CSE-MsgGUID: Xx5y4B/NR1yOEE4qw6LxJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586088"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 00/15] wifi: iwlwifi: wifi: iwlwifi: updates - 2025-05-01
Date: Fri,  2 May 2025 15:20:15 +0300
Message-Id: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
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

resending this with a small fix to one of the pacthes

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
---
v2: remove pointless SUBDEV(IWL_CFG_ANY)
-- 
2.34.1


