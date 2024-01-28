Return-Path: <linux-wireless+bounces-2606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D7F83F469
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264ED284085
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9A8F6F;
	Sun, 28 Jan 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jX56C7Jf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B28F6E
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424861; cv=none; b=rGO6ulUsT9I6u+NMZsrB+tkjx+kDtgUxza27C2cJDvnbHVKJRfIKppQJMt97amE8/YLlhFc7tSICOCXKwmSxMtnMosR73FGtOyED/4ULIMTvsmrU6ws+2Oq40l/dHrJPOwkWyVVvL9IKoM9xbqDwMPd/cp+ysdJoACoALZ4nfCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424861; c=relaxed/simple;
	bh=hHRHiKT/X2IzHNwbWYk7KvRzljXA8pXB+hLNohK5C9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m5bTiTHKwI0eB2aGVqLT/A+1d2TfXrdVvPpRdcGTjpcjYmPXlCWDexiU1a4WVoSWRw/u0IhMzNKGEdvpn3mOu4XODTXUjg+M38Gf9so3qFxFXCC5fwfiuofPT6Od0e9itYpAcuoaG4mKE5UzD2D7kZfp4X7dJncDYUF+Xa5+WY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jX56C7Jf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424859; x=1737960859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hHRHiKT/X2IzHNwbWYk7KvRzljXA8pXB+hLNohK5C9c=;
  b=jX56C7Jft9/+F6L0EAVJ+zt3aIBOKOT7np6lm4alWwN68NfLdFrPfSb+
   GzdJzhnCkpsEHiD+ot+q9xqq4FBE/e/O23YPiYLxDPH3BgV1wBYYrzkwY
   ZUoYxhBX0KOEN41kvDtNmdQJtwpk2K7m5ZnYqOm7MWGI3xpxPDjF5bCKV
   is7422vJRNWTRob0tRT+CAE+K5KDlZ3tqxpmMEFGG5pesqpfRXZX5XMr0
   tmFHlZa9EIMWr4AhBlOb4NuR7HkI28dVklCdCFVHM/pY+9XFS0fPOgMo4
   P+e2DINik4wzgfDbvDPEyebyRhbYxIFp/53MaqRD+7A7UNc0Yxkh6EE7K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217611"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217611"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833282"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:54:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/14] wifi: iwlwifi: updates - 2024-01-28
Date: Sun, 28 Jan 2024 08:53:46 +0200
Message-Id: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.9. It contains a
few features, bugfixes and cleanups.

Thanks,
Miri


Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: disconnect station vifs if recovery failed
  wifi: iwlwifi: mvm: fix a battery life regression

Johannes Berg (9):
  wifi: iwlwifi: mvm: report beacon protection failures
  wifi: iwlwifi: mvm: d3: disconnect on GTK rekey failure
  wifi: iwlwifi: fix some kernel-doc issues
  wifi: iwlwifi: dbg-tlv: avoid extra allocation/copy
  wifi: iwlwifi: dbg-tlv: use struct_size() for allocation
  wifi: iwlwifi: dbg-tlv: ensure NUL termination
  wifi: iwlwifi: fw: dbg: ensure correct config name sizes
  wifi: iwlwifi: acpi: fix WPFC reading
  wifi: iwlwifi: mvm: initialize rates in FW earlier

Miri Korenblit (3):
  wifi: iwlwifi: disable eSR when BT is active
  wifi: iwlwifi: implement GLAI ACPI table loading
  wifi: iwlwifi: cleanup uefi variables loading

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  45 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  15 +-
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  |  14 +-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  20 ++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   4 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 128 +++++++-----------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  57 ++++----
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 124 +++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/constants.h    |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  16 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  13 ++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 107 ++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  21 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  26 ++--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   2 +
 21 files changed, 483 insertions(+), 143 deletions(-)

-- 
2.34.1


