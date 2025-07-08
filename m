Return-Path: <linux-wireless+bounces-24977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD9AFD792
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3851887E39
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375617CA17;
	Tue,  8 Jul 2025 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9hFPdOj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793971DDA24
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004277; cv=none; b=nEYiK6VJWJLmwjbL+trNw0glgFa9qYJknxbtX9E6yxH3Gh5RQ4YcxigNcszVW+tOjildnxJooDxXJ24QA2clzsyACoX0i+orm2PhvYUackwU0sA5tKhhAOjJFg7xNqhOeglcvpHcDeV6rrign6L7IvmgVmeLTXFBr4vDB3e1xwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004277; c=relaxed/simple;
	bh=k3Vr5J+tc1GWOOahwoTSKnOVdbTerYX6qQV4QCXlCFE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=P8WRPBGNVDxC30KzNccc1ckpnsApPKBsvUb2/ymjVLAHZ/Cgcc94AJR5IDaVdlQDh7THILefmChtXjrGdnQnsN1LrooHyyARKHpBeKGefDvM9bovM/TqyldDROabe9TnqJTuIh9ep79Tm6YNIsgI6DhIqP+BZzMXVWyOnnZVTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9hFPdOj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004275; x=1783540275;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k3Vr5J+tc1GWOOahwoTSKnOVdbTerYX6qQV4QCXlCFE=;
  b=a9hFPdOj0JZfJFb6kFRqbfTMafCcTI0ngBL8fX3HmnF5e36/qMTaJOJf
   fPnaCeiH5biWYy7bYRQryPTppCDLQDlpaQ2ush08YyJQes2ykLM4bkH8Z
   ZBn5ReA7/JSx5TTyibntp3Nj2q+vbw24ky7nZnBsFqfNhcX/9qhCRhb+w
   +pFIP5lzZ5vEcZqPyH4MWQZZnJSIEHGEHEgFmDTDRYpzP5oL5z45P/Et3
   XOQhdIIzRawloIUAGdlNq+u2OqQo8aOM6Mhl841NCweLprw2aHSaKxE51
   D69HdFAo5QFdt0RrQME+RorRQkj5i2xUgT/PQxcKiSZ7Ndu/KEmS5pd86
   w==;
X-CSE-ConnectionGUID: 0QJhvKyrTEOLsXqtd86Wog==
X-CSE-MsgGUID: olAk+C/fR9SohL0M/RYd8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229705"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229705"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:14 -0700
X-CSE-ConnectionGUID: 1DqPUHxXR9ShQvJI25ZN8w==
X-CSE-MsgGUID: FI8qmH0ETnyvnNzCJBJSGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155668885"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-07-08
Date: Tue,  8 Jul 2025 22:50:38 +0300
Message-Id: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
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
features, cleanups and fixes from our internal tree.

Miri

Johannes Berg (5):
  wifi: iwlwifi: use PNVM data embedded in .ucode files
  wifi: iwlwifi: mvm/mld: make PHC messages debug messages
  wifi: iwlwifi: remove Intel driver load message
  wifi: iwlwifi: match discrete/integrated to fix some names
  wifi: iwlwifi: pcie: rename iwl_pci_gen1_2_probe() argument

Miri Korenblit (7):
  wifi: iwlwifi: bump FW API to 102 for BZ/SC/DR
  wifi: iwlwifi: pcie move common probe logic
  wifi: iwlwifi: trans: remove iwl_trans_init
  wifi: iwlwifi: mvm: remove MLO GTK rekey code
  wifi: iwlwifi: mvm: remove unneeded argument
  wifi: iwlwifi: bump minimum API version in BZ
  wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v4

Rotem Kerem (1):
  wifi: iwlwifi: Add an helper function for polling bits

Yedidya Benshimol (2):
  wifi: iwlwifi: pcie move gen1_2 probe to gen1_2/trans.c
  wifi: iwlwifi: pcie: Move txcmd size/align calculation to callers

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |  21 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  13 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  32 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |   9 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  37 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 232 +---------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 350 ++-------------
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |   8 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 416 ++++++++++++++++--
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |   2 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  45 +-
 25 files changed, 564 insertions(+), 691 deletions(-)

-- 
2.34.1


