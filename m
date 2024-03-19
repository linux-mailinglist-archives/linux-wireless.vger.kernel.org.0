Return-Path: <linux-wireless+bounces-4880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772387F90D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598D21C21320
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D0651C5F;
	Tue, 19 Mar 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYzCgYob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B424537FC
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835840; cv=none; b=pLrDkFB1LMev5t/YN7Pz4/sqiAXKupbZYUPdbZGqA5PG3eZ0LMySG9Nt4wY1LBIfxK4zBlP8Lq1vNvgR5gp3t2zdENiG6Re0/umK/S/BI+3U/7b25KeccYTkpPsDpDHQsox2UWAGq/F4SnmwanhdA8Y3ym4H6WSUhsA7FQda8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835840; c=relaxed/simple;
	bh=mUXggOdFT5GLQU5y/yrKLkERejIU78AHSpU6MVCkrJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vFO1DGipDBV3SJReMObUaxVuIcD3opZixfPQKy8gtxqrE4mXzHPeWj1/L+6Z+c0f5ERb0BrzPvXpBqKJ0G167OT/g9j0c4GB6zQ8tE1Ouhg5tAmFFNRITldKh5M9tNxwhXKzSf0s+cHIxSc/dE85BLUnRtmI8VvqS8tSn7/lJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYzCgYob; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835838; x=1742371838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mUXggOdFT5GLQU5y/yrKLkERejIU78AHSpU6MVCkrJo=;
  b=MYzCgYobeTYAdApG19PPUq2RzG3mQeMGd9mzn0Ul7gsUzXmxM1GGC4gA
   1fvb1SIRVqvQrku55o5xlXXaMat5BDhYFnK7h2MyJszV9Tt3hDNorEbdQ
   WcGDkjmuQisH1fZOP6zUQtKRw4GAmNXqg/6dt+PzLwAoQKcc2+GsjibF+
   xfDJ4HMqIqAiVdJrIkaggXSGfTNU+EFUMoj4LF/s5FdNiw93/zYWAUnXd
   qkDnqHFozCOD1fvKb08ecJQbqGFfhTpr5kKvm8QKTVQM3du5x0OqVLrm+
   M08PXcY6eqgaT7I2jWGUEhuLSxtjcRuvau20ihl414VNd6IvTldFvNVHS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810512"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810512"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447556"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2024-03-19
Date: Tue, 19 Mar 2024 10:10:12 +0200
Message-Id: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.10. It contains a
few features, bugfixes and cleanups.

Thanks,

Avraham Stern (1):
  wifi: iwlwifi: mvm: add debugfs for forcing unprotected ranging
    request

Benjamin Berg (1):
  wifi: iwlwifi: mvm: always apply 6 GHz probe limitations

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: support iwl_dev_tx_power_cmd_v8

Ilan Peer (3):
  wifi: iwlwifi: mvm: Introduce internal MLO passive scan
  wifi: iwlwifi: mvm: Add debugfs entry for triggering internal MLO scan
  wifi: iwlwifi: mvm: Do not warn on invalid link on scan complete

Johannes Berg (9):
  wifi: iwlwifi: add a kunit test for PCI table duplicates
  wifi: iwlwifi: mvm: rfi: fix potential response leaks
  wifi: iwlwifi: fw: don't always use FW dump trig
  wifi: iwlwifi: fw: add clarifying comments about iwl_fwrt_dump_data
  wifi: iwlwifi: read txq->read_ptr under lock
  wifi: iwlwifi: mvm: don't support puncturing in 5 GHz
  wifi: iwlwifi: remove 6 GHz NVM override
  wifi: iwlwifi: enable monitor on passive/inactive channels
  wifi: iwlwifi: mvm: allocate STA links only for active links

 .../net/wireless/intel/iwlwifi/fw/api/power.h |  30 +++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  16 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   5 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   2 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  17 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  58 ++++
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  11 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 247 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   3 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |   2 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  26 +-
 17 files changed, 361 insertions(+), 103 deletions(-)

-- 
2.34.1


