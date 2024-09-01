Return-Path: <linux-wireless+bounces-12290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837449674ED
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0138DB21609
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 04:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302FE286A2;
	Sun,  1 Sep 2024 04:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAWzxrsd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E21C36
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 04:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164290; cv=none; b=bbAtOqj4Tb2SzR3RPxZHK19wPAW79MF3N2j1H4R7MK+AdJAZ3/PVslm2Iu9qu5eVqyzD991UbfL5IUmSrknZXyYvdBR+6TnDCc9/LZfGdSLaQ/m8gCiZpPbW5sipNW3iSv+honNXcGclZ7DTp5d2M19qY3JWqlwE7gADN0USGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164290; c=relaxed/simple;
	bh=v9b3EzFyfP75OdFC8AUp5dDcm8j2DlrBTGwGJZLUvUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cGaJP/GpCgLqCsQJm0G9GiJSg/D2Tdb3pxlPa8bkHLIYxToRbsdVaTZ5GndiLGaGUVuUUzUm8efl1k8KlraK0+qM9PxPDdHAwd6TFdm21lwonY9DwQ3gf9QED/1dctwzKKNjArOMEQ+VQrtb9IVrcbbk6zMVemF/XFH2NY3Pzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAWzxrsd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164288; x=1756700288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v9b3EzFyfP75OdFC8AUp5dDcm8j2DlrBTGwGJZLUvUg=;
  b=SAWzxrsd0MvRa2Se36lOiE7cyJlzm23ps7ykErB9ABCgnmmz7X7RHKG+
   wuWhnZb31L7z1KzR1GCozOBsLiTJqUXtm4KAUP25MaVJOaV8tqitAP5pP
   PCa6mZe7c8fv4D9D+qV2e0CV0VNd96vjGt+aiCTgqeXx25SzXgzzLQtQJ
   eTvinEo1j50l9rbnO+7zsBpdIIGLRkGlrHU3kGJDf+WdeChKtZEGpI1ZX
   lAXbSiUG9k95luLmjPNgKw1DO+2TDNnykssZWnVTbBsGtrzGz4T1Z6yFU
   JpUUd3DL9JvLf2b0wXHaGe5G8WJqN220N0TNBwSflVx7nhm/Kx72lnahp
   g==;
X-CSE-ConnectionGUID: /BNAkPBXSV+Ot/0lR6201g==
X-CSE-MsgGUID: Ic5RigYKSXi0r7zDzta7sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27559510"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="27559510"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:07 -0700
X-CSE-ConnectionGUID: WrJNtylbSkmP8OkGB+pNHA==
X-CSE-MsgGUID: q4FJ6TUnTqeTZiqX4IB52g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64276273"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] iwlwifi updates - 01-09-2024
Date: Sun,  1 Sep 2024 07:17:49 +0300
Message-Id: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
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

A few features, cleanups and one bugfix from our internal tree.

Miri

Daniel Gabay (1):
  wifi: iwlwifi: mvm: Remove unused last_sub_index from reorder buffer

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: tell the firmware about CSA with mode=1

Johannes Berg (1):
  wifi: iwlwifi: mvm: refactor scan channel description a bit

Miri Korenblit (5):
  wifi: iwlwifi: s/IWL_MVM_STATION_COUNT_MAX/IWL_STATION_COUNT_MAX
  wifi: iwlwifi: STA command structure shouldn't be mvm specific
  wifi: iwlwifi: s/iwl_mvm_remove_sta_cmd/iwl_remove_sta_cmd
  wifi: iwlwifi: mvm: remove mvm prefix from iwl_mvm_tx_resp*
  wifi: iwlwifi: mvm: properly set the rates in link cmd

 .../wireless/intel/iwlwifi/fw/api/commands.h  |  4 +--
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 22 ++++++++-----
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 33 +++++++++++--------
 .../net/wireless/intel/iwlwifi/fw/api/stats.h | 10 +++---
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 12 +++----
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 11 +++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 19 +++++------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 16 +++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  8 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 14 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  6 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  8 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  8 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 12 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 12 +++----
 19 files changed, 117 insertions(+), 88 deletions(-)

-- 
2.34.1


