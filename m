Return-Path: <linux-wireless+bounces-25275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F1B02082
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C73B3A8A31
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31D2D9798;
	Fri, 11 Jul 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqA3uKZ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8EF1DBB3A
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248093; cv=none; b=X/W/v5ItTQYjJ5PAYRRo98dU3w07ysKUs5Z7TxVDhRc0edNtnxEDv5RQztnnYl6oQLruhuVjphAZxg8uqYtiBnl0NXuaryPE47CGzvXkALh+fAtaIw73yzdFF79e2Td93pEHtHY9zV1QyPfOWEey4L0VoxbmYA4IltAz5A24kCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248093; c=relaxed/simple;
	bh=WEukoCV8JhGnLNWBmK6u2qKXKRVjv1TOX1KGKow0uWU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qCbo503dURiyBL28RimQykFxT3w3HIbfecDRNigi5zmtRfqrDpq+seOjAL/2GNJfHxkvlvgZ5kjH7Enx6NFMjGm6Fze++/UcPj8vXH+t0K5/DPlu8mqtpig5ensoa/6giiPRxGTI7p06gnalgSF5GQ5v+y2dqIRDDOowXUh/uZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqA3uKZ3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248091; x=1783784091;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WEukoCV8JhGnLNWBmK6u2qKXKRVjv1TOX1KGKow0uWU=;
  b=dqA3uKZ3Ut04h6txxWXeV6UGCFhgdgV/nhFqqQuIMM1gDN6kt57ED7Os
   W2r6NWNyaZpnTjKqZ51l7hsBtHTLx9cdm69rITpnNizh/3xoF95ff/ney
   xefETMYZYOtKs860IQM2gjQ78nqXAgVskWdXNB03e6Gwa9XZszpm8VytU
   g4e3tl99CBexAUPTtgRSAw+zNhyZnv7o6IMpVck15euJQIzrXrrgDJswa
   sWXRI1+7V5XJ2wYJfoRLF5Pa2F8Xrttfv0TXGDWtdTsd2d2vPfssdCet9
   TNVLSzQUphGGNGnOL915y/3fYmj/yH5tZL08U0et0oscgKYzZz6vR8W00
   Q==;
X-CSE-ConnectionGUID: 4mwg3xfeSlW+6djRba46zA==
X-CSE-MsgGUID: RGDoj0WaSqaTOxujE3GrOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264148"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264148"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:51 -0700
X-CSE-ConnectionGUID: TbdZc0BET2mOiPCZlNr+jw==
X-CSE-MsgGUID: UsISCyGORwm+O8Yp7/b9WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485068"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-07-11
Date: Fri, 11 Jul 2025 18:34:14 +0300
Message-Id: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
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
---

Emmanuel Grumbach (1):
  wifi: iwlwifi: mld: support iwl_omi_send_status_notif version 2

Johannes Berg (2):
  wifi: iwlwifi: mvm: remove extra link ID
  wifi: iwlwifi: mvm/mld: use average RSSI for beacons

Miri Korenblit (10):
  wifi: iwlwifi: mvm: remove support for REDUCE_TX_POWER_CMD ver 6 and 7
  wifi: iwlwifi: mld: remove support for REDUCE_TX_POWER_CMD ver 9
  wifi: iwlwifi: remove an unused struct
  wifi: iwlwifi: mld: remove support for iwl_geo_tx_power_profiles_cmd
    version 4
  wifi: iwlwifi: mld: Revert "wifi: iwlwifi: mld: add kunit test for
    emlsr with bt on"
  wifi: iwlwifi: mld: Revert "wifi: iwlwifi: mld: allow EMLSR with 2.4
    GHz when BT is ON"
  wifi: iwlwifi: mld: remove support for iwl_mcc_update_resp versions
  wifi: iwlwifi: remove support of versions 4 and 5 of iwl_alive_ntf
  wifi: iwlwifi: remove support of version 4 of
    iwl_wowlan_rsc_tsc_params_cmd
  wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions

Pagadala Yesu Anjaneyulu (2):
  wifi: iwlwifi: mvm: remove IWL_MVM_ESR_EXIT_FAIL_ENTRY
  wifi: iwlwifi: mvm: Add dump handler to iwl_mvm

 .../net/wireless/intel/iwlwifi/fw/api/alive.h |  15 --
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |   5 -
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  18 ++-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  81 +---------
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  24 ++-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  20 +--
 drivers/net/wireless/intel/iwlwifi/mld/coex.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  50 ++++++-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   6 +
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c  |  52 +------
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  68 ++-------
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   4 -
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   7 +-
 .../net/wireless/intel/iwlwifi/mld/power.c    |  10 +-
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  72 ++-------
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  73 ++++++++-
 .../wireless/intel/iwlwifi/mld/tests/Makefile |   2 +-
 .../intel/iwlwifi/mld/tests/emlsr_with_bt.c   | 140 ------------------
 .../intel/iwlwifi/mld/tests/link-selection.c  |   6 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  29 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  67 +++------
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  62 +-------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  34 ++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  30 +---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  60 +++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  24 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  91 +++++++++++-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  25 +---
 31 files changed, 391 insertions(+), 708 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c

-- 
2.34.1


