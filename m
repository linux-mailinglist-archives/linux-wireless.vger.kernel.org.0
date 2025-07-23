Return-Path: <linux-wireless+bounces-25893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF818B0EADA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3E8580090
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9A271441;
	Wed, 23 Jul 2025 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fkc0ol6c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E72271461
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253139; cv=none; b=DCZQWZA6z+jtgYK91ni6DDBg/r4LiYZ2N0gBZfivnb0uSmqHH2nF5gNh9NV4J2UtHJ3eMVn/msY5l9lxbR6xBIN9jo4gliCFQ5Vug66wWn2+fWG2VlFjZFSNpvR1lMl9RLSuaGY+9bI4vEWQXZS4fWyWOBChTE9jr+JqzZrmM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253139; c=relaxed/simple;
	bh=1wmzOcwANkdTKjU/EyrIj9GHEU1UYylpHCZhl9Ju/9I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Iq3eNVgBqTBGVJDDTKqoxDQObrkeittO3FP/HeNZsZtWZzqG+jLmLM+nXan0wrnIEC+x5s7EZJV8fwJBS0rdBEozQP8j524RGSWZM5HFXULhYfWj6bRcdj43/64P56sFIFBjxSEFVd2VAa19bAxTFX/TLmKOeeD1JctDYomq2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fkc0ol6c; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253137; x=1784789137;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1wmzOcwANkdTKjU/EyrIj9GHEU1UYylpHCZhl9Ju/9I=;
  b=Fkc0ol6cX8CHq5aMMq+/zeFZ+xEEjs6TFPFSx+tK0JHBNHyGHR/M+u18
   6SnQsmHUH64nCMOr5pVUlHM0BYcf/W1lCX+vgypG4i2s8whdv7FnNIFeS
   wTWM7ntx/cR2MYimS1mHuEMk/ANbEvBkf0CBXZlyMk6TnTNOhorwZvVxv
   er8ul9AJYXUjqhBXnCKC7WL/ZsL3pGJSKUmcA2Q85/r51wMfts0gkD/HL
   /hF1j+EpGkyAK/f8DxafBProItsGtzzdyeIAfRyn2vtoEQLCP58z79wAS
   ip7zufYyrBknYkFyUDhTUdiMw1zN6n74GtSalDeNAdX1pchrwsr95v0Zz
   g==;
X-CSE-ConnectionGUID: L7G7PXDKTY2/+5O9w3jbPQ==
X-CSE-MsgGUID: JISsT9m4QBufjxzjPHOO0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340711"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340711"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:37 -0700
X-CSE-ConnectionGUID: wpYZIMefSbSRhKCQeeXNgQ==
X-CSE-MsgGUID: INMDYL+OR728V88GCvTNGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918067"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/14] wifi: iwlwifi: updates - 2025-07-23
Date: Wed, 23 Jul 2025 09:45:01 +0300
Message-Id: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
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

A few features, fixes and cleanups from our internal tree.

Miri
---

Avraham Stern (2):
  wifi: iwlwifi: mvm: avoid outdated reorder buffer head_sn
  wifi: iwlwifi: mld: avoid outdated reorder buffer head_sn

Benjamin Berg (2):
  wifi: iwlwifi: mld: support channel survey collection for ACS scans
  wifi: iwlwifi: mld: decode EOF bit for AMPDUs

Ilan Peer (1):
  wifi: iwlwifi: mvm: Remove NAN support

Johannes Berg (1):
  wifi: iwlwifi: disable certain features for fips_enabled

Miri Korenblit (8):
  wifi: iwlwifi: mld: disable RX aggregation if requested
  wifi: iwlwifi: remove SC2F firmware support
  wifi: iwlwifi: stop supporting iwl_omi_send_status_notif ver 1
  wifi: iwlwifi: Remove support for rx OMI bandwidth reduction
  wifi: iwlwifi: mld: use spec link id and not FW link id
  wifi: iwlwifi: don't export symbols that we shouldn't
  wifi: iwlwifi: check validity of the FW API range
  wifi: iwlwifi: Revert "wifi: iwlwifi: remove support of several
    iwl_ppag_table_cmd versions"

 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   4 -
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  26 --
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  20 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   6 -
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  25 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  16 -
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |   5 +
 .../wireless/intel/iwlwifi/mld/constants.h    |   9 -
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 389 +-----------------
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  30 --
 .../wireless/intel/iwlwifi/mld/low_latency.c  |   3 -
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  73 +---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   2 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  19 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |   9 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 156 ++++++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |  37 ++
 .../net/wireless/intel/iwlwifi/mld/stats.c    |   2 -
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  22 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |   9 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 -
 .../net/wireless/intel/iwlwifi/mvm/power.c    |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   5 +
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  28 ++
 28 files changed, 346 insertions(+), 588 deletions(-)

-- 
2.34.1


