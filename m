Return-Path: <linux-wireless+bounces-21979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F79A9ADA6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF5B3A8EDA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4921143C69;
	Thu, 24 Apr 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnkuRblh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB71DEFC8
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498328; cv=none; b=CgaVfMbPqXAxiGd3QNxcn6kFUKPyjLT23ZDf/OHo0UM1G/jEgrQcH0eG/uFHwxY29NQa+b5PuxIru3GDrTDrYG5AmTEwmCLJdlRlH3ai+3gMNF12ryNho4OB8pYD8sqhRLYt/wHeHWLq3cUlakNH91uAz+uBwB5FXDaRlUHkl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498328; c=relaxed/simple;
	bh=UVjxZaQ+aPXPY1TTOdf+Ng8ky1T69KLYEURiDzetda4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZeCj7N1mgTSH+tiGnR86mNg62+z01wgeX3NHYz+4xl7E2m75nVm+EY4PAt24oUBak5kpUWnIVc9Od8y69UTST2a0E5idzsgMb15C0sssqcSondo++2zHs6tmmS+a1WM5hvA0vRsJMEinPkW0xbdrJlr7VbVNmNL3aAbwhj62t2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnkuRblh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498327; x=1777034327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UVjxZaQ+aPXPY1TTOdf+Ng8ky1T69KLYEURiDzetda4=;
  b=DnkuRblhPNXCFOqgY8NzYWver14FW95Fd4rxM/0fNeWMdWOV7k6HpOxU
   ldxEWsZzE/oZfA2r2V+ZB6vp6NUBigpc4/KHHbBa5Vdl2+2i1a9xGUbak
   smgVrJIqqSLFnzlfEL8TkBDfPkxYdAyVX+L7+7tSNH4QFudKw9GNf7Y+I
   bqRq7lDJJoqHrmRDnJZGqC1uNOq5RtBk8OfgqLqA8KgiMAS9ENKUGGmWm
   1zU1NmTZmy1MR8xtICsJwQlMQmGOMYBjhFiZ3NDzxllkpKejF9muJgIkS
   2WucLCm+qrH2ZFdMSm4P/DK+q7uPtDs8xat8lFD9FuYiJeR535DLmSk4y
   g==;
X-CSE-ConnectionGUID: Hq6FsXXVSAiVj7PDfj1/Pw==
X-CSE-MsgGUID: JjkN2k7bQzeg8LZri47KMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302399"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302399"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:46 -0700
X-CSE-ConnectionGUID: jsBMar3DTnipiWhnr3pBsA==
X-CSE-MsgGUID: vHWvKV+pQPemnh4SXKOfiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137370"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/14] wifi: iwlwifi: updates - 2025-04-24
Date: Thu, 24 Apr 2025 15:38:17 +0300
Message-Id: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
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
A few cleanups, features and fixes from our internal tree.

Thanks,
Miri

Emmanuel Grumbach (1):
  wifi: iwlwifi: pcie: add support for the reset handshake in MSI

Johannes Berg (10):
  wifi: iwlwifi: mld: clarify variable type
  wifi: iwlwifi: mld: fix iwl_mld_emlsr_disallowed_with_link() return
  wifi: iwlwifi: mld: use cfg80211_chandef_get_width()
  wifi: iwlwifi: mld: allow EMLSR on separated 5 GHz subbands
  wifi: iwlwifi: define API for external FSEQ images
  wifi: iwlwifi: mld: skip unknown FW channel load values
  wifi: iwlwifi: clean up band in RX metadata
  wifi: iwlwifi: mld: rx: simplify channel handling
  wifi: iwlwifi: mld: simplify iwl_mld_rx_fill_status()
  wifi: iwlwifi: clean up config macro

Miri Korenblit (3):
  wifi: iwlwifi: add definitions for iwl_mac_power_cmd version 2
  wifi: iwlwifi: pcie: make sure to lock rxq->read
  wifi: iwlwifi: move phy_filters to fw_runtime

 drivers/net/wireless/intel/iwlwifi/Makefile   |    2 +
 .../net/wireless/intel/iwlwifi/fw/api/power.h |    7 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |   16 +-
 .../net/wireless/intel/iwlwifi/fw/api/stats.h |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   21 +
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |    6 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |   17 +-
 .../wireless/intel/iwlwifi/iwl-context-info.h |   10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   20 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   35 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |   97 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |    4 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |    5 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   21 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1175 ++++++++---------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   14 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   18 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |    6 +
 22 files changed, 759 insertions(+), 744 deletions(-)

-- 
2.34.1


