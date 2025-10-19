Return-Path: <linux-wireless+bounces-28055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF708BEE0E0
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADB514E23DA
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6F230264;
	Sun, 19 Oct 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLerHJ8H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93A1E1DE5
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863530; cv=none; b=cLTHH9q/kEPT7Y1a76OZgir+TgfgQVwzArlk+reDgk0a1B1q5BfSL8hN6n2/YXJDJbQeba8pCJzmE/2jldW++yGkpVpM2R6aOnOK7PnLeZr+GFS6kErRZzLprdr35IBozdFtvsP9Es/qDIvnaBNou8YNKwaGg+ugwa5bJNJtc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863530; c=relaxed/simple;
	bh=fUALxToEvJEZimGqW+1DCabffhSKi9BEWGWHn1HijMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pdc0xP0UHhX4KHrOqCqenrck2GR100nEuYXi8k3LNKJX96f9tE7WzQ/S+k3y/WWHFMcJSsCLdziia8CtiXjFoJLpEWCsJS1bzb9J49rY+TJ4yALlO18z4H/KW/6jVQ+CYXYUPPd2mEc2XYgyrLgms+mFhvsr5nQD1lEZwznAkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLerHJ8H; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863528; x=1792399528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fUALxToEvJEZimGqW+1DCabffhSKi9BEWGWHn1HijMo=;
  b=XLerHJ8HlO1HM1Gg2krz+GV3UjqAbkOjv0ugFFPDoL+ELAXRw9B/ovib
   r9r4Rmw31ZVIz7/ZUzFDkKxJ5RCP+w3zGRPK+gMg4iRfBO6gcQQS5RSc4
   06+M86glQ+m+i5wjZBFxdscsMwy+6c6IdSxWGc0r+G4vKjQfjS/5w5dw3
   hNz6kClTjlXoLIE1JVCas+8NMxVhWRbo8Xh8BMvZfxeKKu2P2xA6zM393
   n+SQyAjvX2/qCBl5XCAMRcTRgSuEN+knAwScXYsdKyAOyvVlu9Te8qSEF
   8IhfrcVm6PHSNH42X7TPsyez0KRsY/JwP0uxPkfBBNZiTD5Ead5BT3nOh
   w==;
X-CSE-ConnectionGUID: /SITpLOQRm+sU4+XHt98bQ==
X-CSE-MsgGUID: OUsOjZAqSWCYrSmvQjv+bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363178"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363178"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:28 -0700
X-CSE-ConnectionGUID: /cL74Ld3RTGku+siMi83vg==
X-CSE-MsgGUID: L11QWfGmT0mA9wI67q99dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279848"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-10-19
Date: Sun, 19 Oct 2025 11:45:01 +0300
Message-Id: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
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
---

Emmanuel Grumbach (4):
  wifi: iwlwifi: be more chatty when we fail to find a wifi7 device
  wifi: iwlwifi: stop checking the firmware's error pointer
  wifi: iwlwifi: disable EHT if the device doesn't allow it
  wifi: iwlwifi: mld: check for NULL pointer after kmalloc

Johannes Berg (8):
  wifi: iwlwifi: mld: update to new sniffer API
  wifi: iwlwifi: mld: include raw PHY notification in radiotap
  wifi: iwlwifi: fix build when mvm/mld not configured
  wifi: iwlwifi: bump core version for BZ/SC/DR
  wifi: iwlwifi: mvm/mld: report non-HT frames as 20 MHz
  wifi: iwlwifi: mld: use FW_CHECK on bad ROC notification
  wifi: iwlwifi: bump core version for BZ/SC/DR
  wifi: iwlwifi: cfg: fix a few device names

Miri Korenblit (1):
  wifi: iwlwifi: mld: check the validity of noa_len

Nidhish A N (2):
  wifi: iwlwifi: fw: remove support of several
    iwl_lari_config_change_cmd versions
  wifi: iwlwifi: mld: Move EMLSR prints to IWL_DL_EHT

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |    1 -
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |    3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |    3 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |    1 +
 .../net/wireless/intel/iwlwifi/cfg/rf-pe.c    |    1 +
 .../net/wireless/intel/iwlwifi/cfg/rf-wh.c    |   23 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |    3 +-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |    5 +
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  134 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  286 +++
 .../wireless/intel/iwlwifi/fw/regulatory.c    |   26 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   11 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |    6 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |   13 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   16 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |    1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   10 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   97 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c  |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 1691 +++++++++--------
 drivers/net/wireless/intel/iwlwifi/mld/rx.h   |    5 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |    2 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   13 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |    9 +
 .../wireless/intel/iwlwifi/tests/devinfo.c    |    2 +
 34 files changed, 1357 insertions(+), 1047 deletions(-)

-- 
2.34.1


