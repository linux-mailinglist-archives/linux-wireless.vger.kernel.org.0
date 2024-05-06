Return-Path: <linux-wireless+bounces-7197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6058BC7FD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB721C2124A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6336CDBF;
	Mon,  6 May 2024 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcUQxlI9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638A4F20E
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979070; cv=none; b=aT7UdyW6yL2F0hdCriZMAMAYosQcb087lYIehe3RhSlvBY+BOQ3bElOPmIWqd4sNIRlOF2a/z4HI3Ek/xJ1F0jd9rieHe1JKHPPM9zkfG9u2hu/xjXCtHA+aNBtJXAl4dzHwfuvrIiRKcbLnRyxRSMYDAUJKGL1vr/Pi5UgZYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979070; c=relaxed/simple;
	bh=ta9K0/HQb0UEoWJuEzMwIQOCDw2LaOw8WGUMvOwROXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SopcA4Y6lBQOMUP48lv0XNhiNyiXaqnW1e1HD+b9S8SHrRjVNs58sIfwkl13HfIyGh5qpt7bkZl/rSZBfUe01/qTJugj3cSW9nocDWVXxh7EiSzT9vvItixwdMRPyRS7X+6SRX9k/TTjv689syVWCBOlwZ53Tv9EZlNx7mHqFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcUQxlI9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979068; x=1746515068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ta9K0/HQb0UEoWJuEzMwIQOCDw2LaOw8WGUMvOwROXM=;
  b=EcUQxlI9RM5CaJBWDLVR8YLfrvT8zUZYedq5c7P/+sGLwYWwRNuQ8s82
   rYSYWKzuUrIj+ic6KQQxDvsT+RSxydpLZ3j6aHaCWRZbSihkGoxAK3fF0
   Daa6/UCefKEJyNj6u5Tzq+4EgFz5PdY61Ie3Lyt0chJtmZK7ZPd/x8oRa
   AThYCJVq/JXLIqQtq0eaBAZv7T+qQ6hVwLXbWTaFo6LtE2iNER9hMTGoP
   D6QiRZQIC8//45ShsY61ZLi+L/tqxtZB44IRIhhn+UiEOYIxlcMXaJUaT
   xhoix+q+I7PjI3E7lGN65dAZCcY5vVT7JyxSkXMFeecWWbvnT8utRauwA
   w==;
X-CSE-ConnectionGUID: 5FoJot8cQqeKt+dsENJYXA==
X-CSE-MsgGUID: hOPRmy32TJu9fONYV8hY/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638113"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638113"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:27 -0700
X-CSE-ConnectionGUID: ZLQ0NWrlSB2d2XuF5dJjaQ==
X-CSE-MsgGUID: ORG5Q4alSc2O3Gy/vyA86w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264793"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2024-05-06
Date: Mon,  6 May 2024 10:04:04 +0300
Message-Id: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.10. It contains
a few features, bugfixes and cleanups.

Thanks,
Miri

Benjamin Berg (2):
  wifi: iwlwifi: mvm: add the firmware API for channel survey
  wifi: iwlwifi: mvm: record and return channel survey information

Daniel Gabay (2):
  wifi: iwlwifi: Force SCU_ACTIVE for specific platforms
  wifi: iwlwifi: Ensure prph_mac dump includes all addresses

Ilan Peer (1):
  wifi: iwlwifi: mvm: Fix race in scan completion

Johannes Berg (2):
  wifi: iwlwifi: mvm: use already determined cmd_id
  wifi: iwlwifi: mvm: align UATS naming with firmware

Miri Korenblit (4):
  wifi: iwlwifi: mvm: fix primary link setting
  wifi: iwlwifi: bump FW API to 90 for BZ/SC devices
  wifi: iwlwifi: mvm: exit EMLSR if secondary link is not used
  wifi: iwlwifi: mvm: don't request statistics in restart

Yedidya Benshimol (3):
  wifi: iwlwifi: mvm: Add active EMLSR blocking reasons prints
  wifi: iwlwifi: mvm: add a debugfs for reading EMLSR blocking reasons
  wifi: iwlwifi: mvm: Add a print for invalid link pair due to bandwidth

striebit (1):
  wifi: iwlwifi: mvm: add beacon template version 14

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  10 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  33 ++-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  13 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   9 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   2 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |   5 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  41 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  72 +++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   7 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  72 ++++-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  41 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  32 ++-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  37 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 270 ++++++++++++++++--
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   2 +-
 .../wireless/intel/iwlwifi/mvm/tests/scan.c   | 110 +++++++
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   7 +
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  31 +-
 23 files changed, 717 insertions(+), 101 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c

-- 
2.34.1


