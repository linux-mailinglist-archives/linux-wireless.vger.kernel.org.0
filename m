Return-Path: <linux-wireless+bounces-25815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD19B0D49A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C6B163F6F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85FC289E29;
	Tue, 22 Jul 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzS5T1lH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E105222D9E6
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172974; cv=none; b=VnEtzbj96m3vScFPk2L5tqsjqaK8ZMEvPQS+t1TPSVYe9/1ScfhXlkVtkhx9NZFGV6UWPxGCO0bReTUiER7DlK2wGeBpdJFrKnWk8AqqgGloX22KyXAab8uW72k1oD1pt07zk/S2gCfQZq2oCyMqvOi7O388W7DC7kN48Gi7Qdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172974; c=relaxed/simple;
	bh=LWDOLWrKj4z8Z5fP5c1Gdj9MHw3nxiRQtT0rkebxNgk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Lu4yelNXK7yjFETA8ZfTzCi+hAB2dgvQ+xhhr114ak8mOb6oTVGJ43qwHjHuTKs+8E3PUl1MpSpKeK7BslgOEmY7t6dM3l7l1su+bcq4RD3bESO0yBn2LL2nkkwef6qP/o9kmMQvvMAxByQoKkrYiuW+h71B/x/uSPbuu0dSq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzS5T1lH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172973; x=1784708973;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LWDOLWrKj4z8Z5fP5c1Gdj9MHw3nxiRQtT0rkebxNgk=;
  b=IzS5T1lHB4QfLApI/NdQ5jDlCsQT4sTZZlxiGy9czAMmkxibRTsM7yzB
   6VIIWjGUFpffMY5eYEpCEctcWMOdZuzfwJ0UFHpjtk+Xf5fVmCz7amMY4
   ZbOLK6o3Fqu9M3RkO+ynkIwXqtgOfO+IL99sXQi5Pq886r04Iack8jit9
   4AN3i+vXcJPJ/pI38kOG9bNmdIhoOf1VskmJR47gmCUNHUONVI7CnXdcQ
   eud52H92Y4FmTQvQUQnsBsilOqZyhTm2lLov0NGC3UhskBPmPPBs/vIvT
   gT+wTHHu8G+V19QVdax80lq/ahkxSeA635U8xgdj0ycgPS/+niSHEXgaq
   Q==;
X-CSE-ConnectionGUID: /qZrSJKpThGvy79EPGmLqQ==
X-CSE-MsgGUID: lFSV9vG/QSeYhpSa/gMJAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569811"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569811"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:33 -0700
X-CSE-ConnectionGUID: KrSAIIGTTL+VfCz1wn3jLg==
X-CSE-MsgGUID: NQGKABzhRjWI8cIpAShxdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124230"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-07-22
Date: Tue, 22 Jul 2025 11:28:55 +0300
Message-Id: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi

Features, cleanup and fixes from our internal tree.

Miri
---

Avraham Stern (2):
  wifi: iwlwifi: mvm: avoid outdated reorder buffer head_sn
  wifi: iwlwifi: mld: avoid outdated reorder buffer head_sn

Benjamin Berg (2):
  wifi: iwlwifi: mld: support channel survey collection for ACS scans
  wifi: iwlwifi: mld: decode EOF bit for AMPDUs

Ilan Peer (1):
  wifi: iwlwifi: mvm: Remove NAN support

Johannes Berg (1):
  wifi: iwlwifi: disable certain features for fips_enabled

Miri Korenblit (9):
  wifi: iwlwifi: make ppag versioning clear
  wifi: iwlwifi: mld: don't consider old versions of PPAG
  wifi: iwlwifi: mld: disable RX aggregation if requested
  wifi: iwlwifi: remove SC2F firmware support
  wifi: iwlwifi: stop supporting iwl_omi_send_status_notif ver 1
  wifi: iwlwifi: Remove support for rx OMI bandwidth reduction
  wifi: iwlwifi: mld: use spec link id and not FW link id
  wifi: iwlwifi: don't export symbols that we shouldn't
  wifi: iwlwifi: check validity of the FW API range

 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   4 -
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  26 --
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  18 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   6 -
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  25 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  16 -
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |   5 +
 .../wireless/intel/iwlwifi/mld/constants.h    |   9 -
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 389 +-----------------
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  30 --
 .../wireless/intel/iwlwifi/mld/low_latency.c  |   3 -
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  73 +---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   2 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  19 +-
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  28 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |   9 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 156 ++++++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |  37 ++
 .../net/wireless/intel/iwlwifi/mld/stats.c    |   2 -
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  22 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |   9 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 -
 .../net/wireless/intel/iwlwifi/mvm/power.c    |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   5 +
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  28 ++
 29 files changed, 356 insertions(+), 604 deletions(-)

-- 
2.34.1


