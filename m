Return-Path: <linux-wireless+bounces-19944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC74FA5594E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404CB1897C97
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB85207DEB;
	Thu,  6 Mar 2025 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLRgBfWG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560341E5B86
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298709; cv=none; b=NVLJpO33roYuC00UKAq/veQ4SbanCS6DWqEy2ysvNgfyCEI5Wk5RZrB5hDwquRZ6vH6dIAMiEKNW1RM4eKY/BC9N592ltBnlpex4hDQx/AsuE48KdmHVAm65JSNXybYH70XAFcR7Uq2/CrmyTyqU9PETcQl+fFDmnLAWeFuDX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298709; c=relaxed/simple;
	bh=UJlyJteyQTyR7obN4mtETOuT1wefwGthfq7F1Cw5OYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clft/ew1ZHpBUlpJ5jgZ8MprNsu5tI1YwWIef3NmvTZtgA87fYkc1NwjFHySXe/H7Q8F1VhXk+tAbOVmRQ8+lm7vwdyzSozCskDVmmSSZGfNZffWwmU2/kzVAdRIK1TQCIPLj9qQnvLO0CBEW3NiO6u7E9cnJgHY0o6H0UK5G80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLRgBfWG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298707; x=1772834707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UJlyJteyQTyR7obN4mtETOuT1wefwGthfq7F1Cw5OYw=;
  b=WLRgBfWG69TYZ/C/AluL8daU5tN9qbSR8kpNl3a7jlkH42N+EH/tIF6s
   zsNLKIGFvm0lIvU4VGRhYCnMohyGxSqUwmgG9cpE7wQSXcUPzCzorfeBo
   5nHVog8z4mXRlEF/KLOSlbuPsTRheZQL27hkVII6A2YnbZmUHGZSM1Cgc
   nZgSXrZEBecy5U6IACY0riOJ4xL8+HSkQWbmLWZHOWXCajYeZdV7zpClj
   Mxh263jxX2kRCVJMKM7QMtsaeGdwPYcJ2KJCU4jgMil1zEzwbrkA88yT+
   zL/D9uBX2sRz5+iu/5E8pzCpEIc6zKPdTwWlTIHyHK6De3+b/nVJ27CFA
   w==;
X-CSE-ConnectionGUID: KLrlookpRzKPJyMTniRfTQ==
X-CSE-MsgGUID: NDFULhMHQ5mHyGptD5saYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474234"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474234"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:06 -0800
X-CSE-ConnectionGUID: sKv6pe0AS0iavmOV40E2ew==
X-CSE-MsgGUID: A8kgkFrJQeqANu/4Wk9Haw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061849"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/15] wifi: iwlwifi: updates - 2025-03-07
Date: Fri,  7 Mar 2025 00:04:39 +0200
Message-Id: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
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
Features, cleanups and bugfixes from our internal tree.
Resending this series with less patches (15).

Thanks,
Miri
---

Avraham Stern (1):
  wifi: iwlwifi: mvm: fix setting the TK when associated

Daniel Gabay (1):
  wifi: iwlwifi: w/a FW SMPS mode selection

Emmanuel Grumbach (3):
  wifi: iwlwifi: add support for BE213
  wifi: iwlwifi: fix the ECKV UEFI variable name
  wifi: iwlwifi: fix print for ECKV

Johannes Berg (2):
  wifi: iwlwifi: mark Br device not integrated
  wifi: iwlwifi: fix debug actions order

Miri Korenblit (4):
  wifi: iwlwifi: bump FW API to 97 for BZ/SC/DC devices
  wifi: iwlwifi: bump FW API to 98 for BZ/SC/DR devices
  wifi: iwlwifi: bump minimum API version in BZ/SC to 93
  wifi: iwlwifi: don't warn when if there is a FW error

Pagadala Yesu Anjaneyulu (3):
  wifi: iwlwifi: mvm: cleanup of TAS structure and enums
  wifi: iwlwifi: Add new TAS disable reason for invalid table source
  wifi: iwlwifi: mvm: Fix bit size calculation in
    iwl_dbgfs_tas_get_status_read

nerrera (1):
  wifi: iwlwifi: add restricted TWT capability

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  8 ++--
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 42 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 10 +++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 10 ++---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 17 ++++++--
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  5 ++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 38 +++++++----------
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  4 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 15 +++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 21 ++++++++--
 17 files changed, 121 insertions(+), 76 deletions(-)

-- 
2.34.1


