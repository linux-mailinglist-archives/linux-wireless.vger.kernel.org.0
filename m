Return-Path: <linux-wireless+bounces-2721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CAE84133D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0442C2835A0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0E11C85;
	Mon, 29 Jan 2024 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQIzcTUJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BB3C46E
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556136; cv=none; b=TwjfmIYuNoncznHjtNOI7cp+ZnD/Rm7drPbi/WXrM+dJbmuvuNUpgihwsNFrYEwkMle3IOd0DM3aJURu+em+dPmQ1v5jmCT/lEmwnjutOi78wbXPD8c/UlC3cRYU3NyiIHMnUxwy6zlEdoVTDWH5R0DOW05uoeTi1AJTob8FqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556136; c=relaxed/simple;
	bh=2GeXEVCOVNK5VvSmla+35MEJjD2KwCQ8NVUCL1gekF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VV9TwS6hPfSum9mkHYnQNVSLrJWuLEA+gUHKR+wu+48g8oL80nrbr6ae8vAnYeM9RH909tj5hQ7zhyP/uTfy1SyT2Dxy1BP9s9nZvTqLsgijdK+geGmxBmFak2SxlXrjPl+JorQp6Xl2ApaHPPV7ZkygAJorOOQAUnXBQYTZHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQIzcTUJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556135; x=1738092135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2GeXEVCOVNK5VvSmla+35MEJjD2KwCQ8NVUCL1gekF8=;
  b=WQIzcTUJRfOlMUftfZG4BMFnRW3Qv0hX6jFzxUiTXNPlkrLVX10gcVvV
   4Cqf9X9dUErAGmx+tzGHoQWRTbLv/BU83JvyIxQrkErLiagJ8yjmAobbm
   97Z6bxVIgqadEGKpkkcXrkPXrZdWvvTtOMo2W+wmWnLSMAoX3dLGenKAs
   ROoF309/ETxZ01IR2fHggKzzKBLM4rnZkFJEKZ9yPr2TWE0POu4gFyCsl
   94hUIC0+G+XcYczXsnWJZGRwUUFfWdjArLEjOn+YbXiP+VVGbz3aVhiFC
   bonJLtFMQ9D8ZbnMG8CHgJcHxeeCbpsPF/vfOeB209JhwUvFlfLVjcq3Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2942927"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2942927"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459016"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2024-01-29
Date: Mon, 29 Jan 2024 21:21:48 +0200
Message-Id: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.9. It contains a
few features, bugfixes and cleanups.

Thanks,
Miri

Ayala Beker (1):
  wifi: iwlwifi: mvm: add support for TID to link mapping neg request

Colin Ian King (1):
  wifi: iwlwifi: Fix spelling mistake "SESION" -> "SESSION"

Daniel Gabay (1):
  wifi: iwlwifi: mvm: log dropped packets due to MIC error

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: fix the TLC command after ADD_STA

Ilan Peer (2):
  wifi: iwlwifi: mvm: Fix FTM initiator flags
  wifi: iwlwifi: mvm: Add support for removing responder TKs

Johannes Berg (7):
  wifi: iwlwifi: mvm: d3: fix IPN byte order
  wifi: iwlwifi: mvm: don't set trigger frame padding in AP mode
  wifi: iwlwifi: always have 'uats_enabled'
  wifi: iwlwifi: remove Gl A-step remnants
  wifi: iwlwifi: mvm: use FW rate for non-data only on new devices
  wifi: iwlwifi: mvm: support SPP A-MSDUs
  wifi: iwlwifi: mvm: refactor duplicate chanctx condition

Miri Korenblit (1):
  wifi: iwlwifi: fix EWRD table validity check

Mukesh Sisodiya (1):
  wifi: iwlwifi: pcie: Add new PCI device id for new hardware

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  4 ---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  4 ++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 ++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  8 ++++-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  9 ++---
 .../intel/iwlwifi/mvm/ftm-responder.c         |  7 +++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 34 ++++++++++++-------
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 18 ++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 19 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 17 ++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  5 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 18 ++++------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 33 +++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  1 +
 19 files changed, 146 insertions(+), 44 deletions(-)

-- 
2.34.1


