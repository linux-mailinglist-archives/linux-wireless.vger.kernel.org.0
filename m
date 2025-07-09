Return-Path: <linux-wireless+bounces-25038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1AEAFDEF2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDF7583F80
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2991CAA85;
	Wed,  9 Jul 2025 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGzIel5S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D61EF1D
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037343; cv=none; b=fs7NU20qaluiJjKQbn1ECSvIuGoYCT+1wAAXxSUzxLFawqyYVS68WQSrXDZta/o99OBkvFy1lUHbe5I3Oq/oBpTljZ+3KXyU5EBen1PslCYwCO6pJNzoDZwPIUHFdsyqCilelee1DIpsTSTY+A6NUJCYfVFop8iSJ4RIgEbNf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037343; c=relaxed/simple;
	bh=uqTf8XJXulNR2HCOkIi4uLT0XQkbBHPtVixLDBo+jbk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sM2ptLLJmW5nCvQQDvRI4PWUVMdA61hhCzBsU+Ff72bBpXavu/Fb5vdP7mK+Dcr29hpnQRqmQxRvEf5Jyv7E+7KcDTBQvSgyKls/3yz4VkO9hEpjnelA0mfUdmP3lFZxtUZpOcLQDkIZdeXPY6AQdTc4Kqib5jGbiVLDK5m5lh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGzIel5S; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037342; x=1783573342;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uqTf8XJXulNR2HCOkIi4uLT0XQkbBHPtVixLDBo+jbk=;
  b=UGzIel5Sy6Olm5BOgDjoxkM/iy4cGROj46GwfjfEZ3q6cUyIxmt06DV1
   HIGSwEBvr6g/g65sM//vYbKi0JqDvc/QFZFV6LkM6e6d9a/cvBoRqncmg
   MVrVmRl98vxcdzrfda5fDa6FHXJkyLNOdRAeQKdujt3n/MAyd+qM9u00P
   Wwieupq255n3TkWSelLG9GGzBPW0yXRpJWyFzMITXOS0cy2zBvzKAYn4a
   3yVSSe+sOX34ZvFVFafGlEIDeodEugA6utSjsKaKf8rq+Dqam3tvWPiGO
   WZv610ckxmvSM4mtYBAMjh3J6Hx3nSjtq2Ur8kjSuzYJDbiaTs6KWjUgC
   A==;
X-CSE-ConnectionGUID: T5Arf3XCQKqE4jjYrXq82w==
X-CSE-MsgGUID: zYwLEdLGRSaLt98T1ueasA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501448"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501448"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:21 -0700
X-CSE-ConnectionGUID: BphkTZyyRRevPwtL2MllKw==
X-CSE-MsgGUID: GPDEhQBrRjaFYHlOURhZcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859213"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-07-09
Date: Wed,  9 Jul 2025 08:01:44 +0300
Message-Id: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
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

Features, cleanups and fixes from our internal tree.

Miri

Avraham Stern (1):
  wifi: iwlwifi: mvm: fix scan request validation

Itamar Shalev (3):
  wifi: iwlwifi: simplify iwl_poll_bits_mask return value
  wifi: iwlwifi: pcie: inform me when op mode leaving
  wifi: iwlwifi: trans: remove retake_ownership parameter from sw_reset

Johannes Berg (1):
  wifi: iwlwifi: pcie: accept new devices for MVM-only configs

Miri Korenblit (10):
  wifi: iwlwifi: handle non-overlapping API ranges
  wifi: iwlwifi: assign a FW API range for JF
  wifi: iwlwifi: bump minimum API version for SO/MA/TY
  wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v2
  wifi: iwlwifi: add a reference to iwl_wowlan_info_notif_v3
  wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v12
  wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v9
  wifi: iwlwifi: assign a FW API range for HR
  wifi: iwlwifi: assign a FW API range for GF
  wifi: iwlwifi: pcie: add a missing include

 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  24 ----
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  34 +-----
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   9 --
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    |  31 +++++
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |  49 +++++++-
 .../net/wireless/intel/iwlwifi/cfg/rf-jf.c    |  29 ++++-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  13 ---
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |  12 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 109 ------------------
 .../wireless/intel/iwlwifi/fw/api/offload.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   9 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  55 +--------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   4 +-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |   1 +
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    |  20 ++++
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |  12 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/utils.h   |   2 +
 25 files changed, 171 insertions(+), 270 deletions(-)

-- 
2.34.1


