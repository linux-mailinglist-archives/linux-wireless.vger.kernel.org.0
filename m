Return-Path: <linux-wireless+bounces-25779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF6B0D06C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC3F543C62
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3D8EEDE;
	Tue, 22 Jul 2025 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHJs7npg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC481876
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155709; cv=none; b=CAPBVVcsAzotRs6HeamQtv9sAytqdGhxD6UF599lCR45/l384qnxeeRuXn+nZZy1Wf26NgHIib4elvm6NhV8nqINqYEoQH6I2by2swsuId/BRHBDURBDfaZjwN5sP0HR6oAdCsnUC2V95azz/wdmK2r/OUtvxBa2mBz+gSYetAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155709; c=relaxed/simple;
	bh=LWDOLWrKj4z8Z5fP5c1Gdj9MHw3nxiRQtT0rkebxNgk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JGiYzZ1Jl+1boCgdTwV9w9WAlcZPvDGbfCSZpUqWiDm30y5teo8dosK6ZY4fQlV6h6pkNqGg6hTAXThvx7s7rSJmXGDopltWae1jGLelSa4TUKuDbKbGxiMpDLar3VG38++KQWgxRYQ2t2SMx8caeIYlPckhFa0tyJdbx3MF7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHJs7npg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155708; x=1784691708;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LWDOLWrKj4z8Z5fP5c1Gdj9MHw3nxiRQtT0rkebxNgk=;
  b=dHJs7npgFZiDeiTE+2FhnqDDqnkpYruCO/y+XgMg9iVXF9wqcpndaGwd
   uD63FA9/nvW/84P7vvpb/aG58ScuKRfl49UQ7FqT2K4XZKMQyYhJ7wrRU
   nK4tgN9s+Lda7HGg+0et7ilDdGrdvfQR8HhvtHrxXySXxVv/1HIEsGC0G
   /FzX95GiJarkATjM+yLPen8uczGHc5ATPV5vRYpEVhRIVZFUpkZccSzD2
   8VZIRnPa324OawWDri7kBLiRCZpOR/M+0oRMA+xMHJb4/txygxzjocDZA
   2NE44S9pK46Tr3e59+4cMeuPIS/tVwjuBSjweoZ9tE0aI8tYgaYwLRLcv
   w==;
X-CSE-ConnectionGUID: TXcDSMMhQ3WPZP06G5WP8Q==
X-CSE-MsgGUID: AHhPdghTQMWWrUxpX7mReQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006148"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006148"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:47 -0700
X-CSE-ConnectionGUID: fAGGxQWUSmOTuEjwRgYtiA==
X-CSE-MsgGUID: DdCUuSsYR327+GR1lXYQ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338042"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-07-22
Date: Tue, 22 Jul 2025 06:41:10 +0300
Message-Id: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
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


