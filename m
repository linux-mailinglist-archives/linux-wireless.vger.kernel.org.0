Return-Path: <linux-wireless+bounces-22205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE75FAA1B99
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E9B7A4EBF
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3C25F963;
	Tue, 29 Apr 2025 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8QLV4Pe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E226159A
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956442; cv=none; b=G/A1bbGHyxY0fWTjrcbz7UIsjgYkFgWoKw4OK53McBP80OqNVkY4IFd34MzCUwHmqm8Wfa/gEH8KZmyNgVFch228rcrWaUjC+2cqXsxx0/3ZEioeNYZLgna3bF4iIawoPo78FwpjtkZNjkqKwV1Q2SOZiePKOLMUU9r3cV/lg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956442; c=relaxed/simple;
	bh=yy5/btAZjhH3IgcDAQCX4fp1D0d6oy2YCEPs/O8sN7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HpG6ikA3dYnrHzJGiB59YxHyLJ1sIBH2xRfDneVB3WZQExw9c2UC1vHvA1H12NyHUVRuyxD/sMyhYoiaA1t4bsn5NvGXJ13uFpkdGb8PWguGlwAadUPzFAr7j4eh5BOyAUM6kav4Dcvfv/ps20XqKg1QRE7Yri8NxSS9nt3Y4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8QLV4Pe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956441; x=1777492441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yy5/btAZjhH3IgcDAQCX4fp1D0d6oy2YCEPs/O8sN7Y=;
  b=M8QLV4Pem0wHqwfMRLzNMMO0zleRGXQkxLG5xPE7E2ZmFOSwiNPEaX/D
   DzJ10ALMo9/+7U0Fh3qFuN7IPlowQpuc7yvi63QI7M2IsVo+eFSdeppIt
   GAb3cUdBNq16lz56uWPGbHwmfNyNx1j7fN5lXbHzOwHMzJ8wiyKfpLXk/
   6M+7cY1ygPanQtVvhl9vL+MY87nCe831z7CUmiHilIVvH0rz+MkkjdBpe
   XfaMYDm531/eKQQzU3t1QUU3zQcYj7EJ6QJlfgMlS5vVx6pRDPIUXW8Ta
   yNFuOjOwGJY9cp9kuWEOYTq3yO8HbKa2ZR2A7Ip6v/h3x7FN/tpIKIFDr
   g==;
X-CSE-ConnectionGUID: 7sGp4AJCRLKYE6NNn3P8xA==
X-CSE-MsgGUID: sgtMgTboTLiITGSZq4IXxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713461"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713461"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:01 -0700
X-CSE-ConnectionGUID: kfRf0zO+RP2XrFpE4WvF0A==
X-CSE-MsgGUID: OxJukvt+SeePpA1aETFgfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171154965"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/14] wifi: iwlwifi: updates - 2025-04-29
Date: Tue, 29 Apr 2025 22:53:30 +0300
Message-Id: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
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

Features, fixes and cleanups from our internal tree

Thanks,
Miri
---

Johannes Berg (5):
  wifi: iwlwifi: mld: refactor tests to use chandefs
  wifi: iwlwifi: mld: tests: extend link pair tests
  wifi: iwlwifi: avoid scheduling restart during restart
  wifi: iwlwifi: back off on continuous errors
  wifi: iwlwifi: implement TOP reset follower

Miri Korenblit (5):
  wifi: iwlwifi: prepare for reading WPFC from UEFI
  wifi: iwlwifi: read WPFC also from UEFI
  wifi: iwlwifi: mld: send the WPFC table to the FW
  wifi: iwlwifi: mld: check for NULL before referencing a pointer
  wifi: iwlwifi: mld: don't return an error if the FW is dead

Pagadala Yesu Anjaneyulu (3):
  wifi: iwlwifi: rename ppag_ver to ppag_bios_rev
  wifi: iwlwifi: fw: support reading PPAG BIOS table revision 4
  wifi: iwlwifi: fw: support PPAG command version 7

Somashekhar Puttagangaiah (1):
  wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  28 ++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  11 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  32 +++-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  37 +++--
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  13 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  33 +++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  21 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   7 +
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   7 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  85 +++++++----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  16 +-
 drivers/net/wireless/intel/iwlwifi/mld/coex.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |  12 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  14 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  85 ++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c  |  29 ++++
 drivers/net/wireless/intel/iwlwifi/mld/phy.h  |   2 +
 .../wireless/intel/iwlwifi/mld/regulatory.c   |   2 +
 .../intel/iwlwifi/mld/tests/link-selection.c  | 144 +++++++++++-------
 .../wireless/intel/iwlwifi/mld/tests/link.c   |   4 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  37 ++++-
 .../wireless/intel/iwlwifi/mld/tests/utils.h  |  84 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  60 +++++++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   3 +-
 28 files changed, 573 insertions(+), 221 deletions(-)

-- 
2.34.1


