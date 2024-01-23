Return-Path: <linux-wireless+bounces-2395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1785C839746
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C369028D1E5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389681ACD;
	Tue, 23 Jan 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0jrgYYf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930A81AC1
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033319; cv=none; b=SzfQY6QuXB6uLy0XSN6/f7lYCTiBoW7tnQYcjY8dmkbJFMy0KtpSCKOLwJ9OateVk3rjpLT2GHK/P4iBjthMVyZSyVsgkbGiaLEJVjJqeS2pVJQuRgMpi0xQSnqbMGzSZHEpADzfqZV8pRE37XjsK29QKiMjACQrT3eCrlAWPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033319; c=relaxed/simple;
	bh=Ve+nak7rQTyE7MVRNIfZ+X2EJbhYgJVclObF6oWLRf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mygPMQUy6XX4Us5XE9syEOObptVSdxVVMxo3jouktA99/0iz5yoCz59zVuniQVD1jDl3mt00tGVje73cZy6U9YiLo4YBYkW50cUWoLww4tgIVZ1WQM9NPH/Zad8EXJDtVztwJGp1QunEM8ViPerej0iHc6pAfSjDu0NX+1YIIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0jrgYYf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033318; x=1737569318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ve+nak7rQTyE7MVRNIfZ+X2EJbhYgJVclObF6oWLRf8=;
  b=V0jrgYYfWp61hMlLClwNNtDBeGFowZZlyNTsGv3d1hxC4rDegqQU4Lt2
   vhMJHot7od71Fr/01EC4yWXsfO7GAAbjSsKTLowbFqOaeq4I81rIup0/L
   hL5RaiuCJbv5sxRbwJe7HDwemXaQI9q19Fn6E+kL4rx0wdhCCMdYVQmXy
   nDPYnbut9reePlBTcdxmGBhfSNuUhWMQ8JanYcB8x52NYHLPkZqGZtfV2
   Yq8HM+rAyXS+Scj/e8lPqnm8u9evuXmzBHRqFLRIkjBGRFSUGST57nX5m
   ut78fYjonueTwlP9S2R6EpMNCfdZAgW7iyINgJaoHjFMJy95LTmtupOGF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501632"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501632"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666415"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:08:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2022-01-23
Date: Tue, 23 Jan 2024 20:08:08 +0200
Message-Id: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This patch set includes iwlwifi patches intended for v6.9 It contains a
few features, bugfixes and cleanups.

Thanks,
Miri

Benjamin Berg (2):
  wifi: iwlwifi: skip affinity setting on non-SMP
  wifi: iwlwifi: mvm: skip adding debugfs symlink for reconfig

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: introduce PHY_CONTEXT_CMD_API_VER_5

Gregory Greenman (1):
  wifi: iwlwifi: bump FW API to 87 for AX/BZ/SC devices

Johannes Berg (6):
  wifi: iwlwifi: add kunit test for devinfo ordering
  wifi: iwlwifi: fix double-free bug
  wifi: iwlwifi: make TB reallocation a debug message
  wifi: iwlwifi: mvm: limit EHT 320 MHz MCS for STEP URM
  wifi: iwlwifi: remove retry loops in start
  wifi: iwlwifi: nvm-parse: advertise common packet padding

Miri Korenblit (3):
  wifi: iwlwifi: change link id in time event to s8
  wifi: iwlwifi: implement can_activate_links callback
  wifi: iwlwifi: add support for a wiphy_work rx handler

Mukesh Sisodiya (2):
  wifi: iwlwifi: Add support for new 802.11be device
  wifi: iwlwifi: disable 160Mhz based on SSID

 drivers/net/wireless/intel/iwlwifi/Kconfig    | 10 +++
 drivers/net/wireless/intel/iwlwifi/Makefile   |  2 +
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  | 16 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 13 ++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 14 +++++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 29 +++------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  | 10 ++-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 39 ++++++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  3 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  5 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  5 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 17 ++----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 21 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 61 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  8 +--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 19 +++++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 +
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  7 ++-
 .../net/wireless/intel/iwlwifi/tests/Makefile |  7 +++
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 54 ++++++++++++++++
 .../net/wireless/intel/iwlwifi/tests/module.c | 10 +++
 26 files changed, 292 insertions(+), 74 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/module.c

-- 
2.34.1


