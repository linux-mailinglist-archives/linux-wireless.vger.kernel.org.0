Return-Path: <linux-wireless+bounces-21881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA4A97EFC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1980A170B88
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40257266B54;
	Wed, 23 Apr 2025 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhznKqKU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A51F30DD
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389017; cv=none; b=gryS9VyR8KNtV2kPALYfW3TkJBwOHlknvzv8rPeVpkyEJnZOLnrcd+G7Kv1Lk5ea3nVMfRT6juzP1PUSvp+EfN3jPRrfqmkaYIjcZV+jexWAeBeatX6zot2AVG2sf+WUY4WSDYcjQRk9VrVL14g1tweUvZvr7T3LxWYxSluQPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389017; c=relaxed/simple;
	bh=rigmn0c/093phkPPhSjSuFc82wZroVcs/VMWJ2V5o4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kcwaFjIxo6koUuViZA7mEzy5BuryRrCDOVOKR+ZLu84Ki1wFsTfLN4z092FGoIfw2Y5rULvoErmEWqEI3gN3BUfS9OwyStbvKLYFscMqJanJgJBSPXoD6oM3IeDtWWYu2RaY/3Rxn7J7vKTDiMZ9pASsHsMt9FfmIvtOYeI+Dus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhznKqKU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389015; x=1776925015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rigmn0c/093phkPPhSjSuFc82wZroVcs/VMWJ2V5o4c=;
  b=PhznKqKUclJ/EXb081gK6M22Ep8VF2N0mgnSmtYZk5IL5bPzW/RI/tGU
   +kkervS3Blb/FzT4O1rVKwzQzSUe77iXCy7rRLJyPXJO2wNFLnyjmns9b
   hzXTku4H8REkCueJa61I2PvY2Yg0/6I1v9Yggzfb0AkFLCNwx88QsRup9
   hvmGwH4z4I7SxXbMuYLXaZM4IpA0/7gHOVXVSTM6X75LpnRVsorKv5O+T
   cWlC4vOQmUHGA1wtCwpZD+ovCLtoTzFOTtAaA/RXUUDj3ByLCa6E8XyYT
   xEXxv0+ZWJE88r3iZcgQoGZ+jyS+YwZLQVci1ms0gC5AcASsUS1fZagbt
   A==;
X-CSE-ConnectionGUID: uBrbb07oR5SnJNnWKHrYZQ==
X-CSE-MsgGUID: ioWTU7aZTwm9sYGDm+YPNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843612"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843612"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:16:54 -0700
X-CSE-ConnectionGUID: HtTJfulFTau1zt/5tRgoRQ==
X-CSE-MsgGUID: 2LdtxzDpTQ+c/9FPvjHnTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269002"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:16:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/15] wifi: iwlwifi: updates - 2025-04-23
Date: Wed, 23 Apr 2025 09:16:26 +0300
Message-Id: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
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
Resending a smaller series and fixing the tree name.

Thanks,
Miri

Anjaneyulu (1):
  wifi: iwlwifi: parse active and 20 MHz AP NVM channel flag

Emmanuel Grumbach (2):
  wifi: iwlwifi: mld: remove stored_beacon support
  wifi: iwlwifi: update the PHY_CONTEXT_CMD API

Johannes Berg (4):
  wifi: iwlwifi: mvm: remove IWL_EMPTYING_HW_QUEUE_DELBA state
  wifi: iwlwifi: fw: do reset handshake during assert if needed
  wifi: iwlwifi: mld: remove P2P powersave tracking
  wifi: iwlwifi: mld: tests: simplify le32 bitfield handling

Miri Korenblit (8):
  wifi: iwlwifi: re-add IWL_AMSDU_8K case
  wifi: iwlwifi: mld: avoid memory leak if mcc_init fails
  wifi: iwlwifi: mld: stop hw if mcc_init fails
  wifi: iwlwifi: mld: don't do iwl_trans_stop_device twice
  wifi: iwlwifi: mld: refactor purging async notifications
  wifi: iwlwifi: mld: properly handle async notification in op mode
    start
  wifi: iwlwifi: mld: inform trans on init failure
  wifi: iwlwifi: set step_urm in transport and not in the opmodes

 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  8 +--
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  9 ++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 15 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  7 +++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 36 ++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |  2 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   | 48 ++++++-----------
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  5 --
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  9 ----
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  | 25 +++++++--
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  5 --
 .../net/wireless/intel/iwlwifi/mld/notif.c    | 51 ++-----------------
 .../net/wireless/intel/iwlwifi/mld/notif.h    |  2 +-
 .../wireless/intel/iwlwifi/mld/tests/agg.c    | 14 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  5 --
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 14 +----
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  5 ++
 19 files changed, 112 insertions(+), 154 deletions(-)

-- 
2.34.1


