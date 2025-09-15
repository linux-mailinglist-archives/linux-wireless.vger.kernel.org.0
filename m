Return-Path: <linux-wireless+bounces-27312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF1B57306
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205F53AC460
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0D29D260;
	Mon, 15 Sep 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWhx8HC1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF732D46BD
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925303; cv=none; b=KWq5N6cYgxHEZhnF1b2L+MoeSL+nxYA3lmVbhNcf1nuIBMedh0gO6wSQqMhlj8W0mbt4vQHmcSptKuOjmdZqrmYU3raBiLVN7zBl6Z+aUNr/5SuU3G88lRyKoZJjHJ8Nrw3olSf+KYGWelkdxDWfifZiGOcueKyweY7K5b6Gf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925303; c=relaxed/simple;
	bh=sWgzvv5t7m0e35xZZUt510iryOL1P1kFiIO+GK7vixk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mRhXNLtpQ9+vagDsbziSge35H2uN4VlN4wCJA/zcXMPeAbyYmlFYuMVJvPtWx0HC4TmOjtn0pQVDz3N6+MgZFECmfAQNPjBnhnsK+76/K9doqgYWpKSGExr64fs+nR7MLcznd69Whe4Wtm+ifF3bEIkLKlDiypKTqw+W0p8mxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWhx8HC1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925302; x=1789461302;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sWgzvv5t7m0e35xZZUt510iryOL1P1kFiIO+GK7vixk=;
  b=MWhx8HC12jxeOk7q4Q/2Z1deLkbDJYeZ+6VR4JMaj9uvGq5z0m32GmPn
   yVdlguH8GUAO+fUX3sloaGc0j1yogRQsD4PlI3PVUR+EHJEvt8lYzzj9W
   VoLPW37psof53xnFUm1On4UQDx+cxqJsyQiMJakfd1bvtaYTXHQ1Vo62y
   Fa67f9DKJZPrVMVtNCkwon8s8EvQvEKGwb/NwwiCqWPIzP18s+SbHv4In
   QB0xpkDdozYdjimccTXd+y376fl8/RON3x399mMWXOwl8zsX7k/JdONij
   awxm3KAAue/SRg9yoTmc4umYAXAG0udyv93vX3yveWTSk1lRrc2T6YlRB
   A==;
X-CSE-ConnectionGUID: 5IldY9kpThuj6hhH5qQR5g==
X-CSE-MsgGUID: 3D+drVW9Rke0n4bgrQJGlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213065"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213065"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:01 -0700
X-CSE-ConnectionGUID: W5drUNF1S9W4Vp4x0og5cQ==
X-CSE-MsgGUID: b9/Ynl38Q0y+zCFUvjhj7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569817"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/11] wifi: iwlwifi: updates - 2025-09-15
Date: Mon, 15 Sep 2025 11:34:21 +0300
Message-Id: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
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

Thanks,
Miri
---

Emmanuel Grumbach (1):
  wifi: iwlwifi: mld: support get/set_antenna

Johannes Berg (4):
  wifi: iwlwifi: mvm: move rate conversions to utils.c
  wifi: iwlwifi: cfg: add new device names
  wifi: iwlwifi: tests: check listed PCI IDs have configs
  wifi: iwlwifi: fix remaining kernel-doc warnings

Miri Korenblit (6):
  wifi: iwlwifi: align the name of iwl_alive_ntf_v6 to the convention
  wifi: iwlwifi: mld: remove support from of alive notif version 6
  wifi: iwlwifi: mld: reschedule check_tpt_wk also not in EMLSR
  wifi: iwlwifi: iwlmld is always used for wifi7 devices
  wifi: iwlwifi: mvm: cleanup unsupported phy command versions
  wifi: iwlwifi: mld: set wiphy::iftype_ext_capab dynamically

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   1 +
 .../net/wireless/intel/iwlwifi/cfg/rf-wh.c    |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   1 +
 .../net/wireless/intel/iwlwifi/fw/api/alive.h |   2 +-
 .../wireless/intel/iwlwifi/fw/api/cmdhdr.h    |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  |   4 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   2 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  14 +-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |   2 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  |   8 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |   5 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  78 +++++----
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |   6 +-
 .../net/wireless/intel/iwlwifi/fw/api/stats.h |  39 +++--
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |   2 +-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  74 ++++++--
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  12 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  22 ++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   3 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  18 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |   3 +-
 .../wireless/intel/iwlwifi/iwl-modparams.h    |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  17 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   6 +-
 .../wireless/intel/iwlwifi/mld/constants.h    |   2 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |   8 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  97 +++++++----
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  15 ++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   3 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 +
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  24 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 164 ------------------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |   3 -
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 164 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   3 +
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  27 +++
 41 files changed, 501 insertions(+), 356 deletions(-)

-- 
2.34.1


