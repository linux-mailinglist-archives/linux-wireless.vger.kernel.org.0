Return-Path: <linux-wireless+bounces-22385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE33AA85EE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC073B760B
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7717736;
	Sun,  4 May 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlWoHtTD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8B1991BF
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354408; cv=none; b=b7Eogh6GX7EK0gxglI3+LFDzc86dTlkzyV+/q02U5dS9gRoQ+0thrfE9QbXFQZ/p1Q1W924aU4xoSINHtxHGpQAOpMZJZV85s9MCyYbHN5a0s3PdZT+5ZhfELJQ+uIQ+V85X0uQjVuJPFVCGkw3WutO9GBa+ZAP1c3JVML25XCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354408; c=relaxed/simple;
	bh=bZRsHimx09iY+VMxnycbJKtFudz4fz8+i026ggyyrHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QvPegk3udllPHbZpVQJ6SpDdY+OJUoEXFYVgAiMQQwRYL+rvmYLjz9urlkuNc4Nr3WKnNOSB/KUDPax6TNRyAtf1b4YW9DzKWdvJiLq8i+Gb9o0DOzuGN6hDJJBdm1dUktoyNO3QJhGAVZCsdMdOWYAxIDPF161nmNMxiSR5vRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlWoHtTD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354406; x=1777890406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bZRsHimx09iY+VMxnycbJKtFudz4fz8+i026ggyyrHE=;
  b=TlWoHtTDpEREjjPVwd7AklRcEp0GEkJzt6eSTFQWeMR/+9IrDeBD7Ld4
   Y+PM3DgTUqFmJV9WQPTyfaufNlo0/XVt8hStQJnOTn+C1CkMv/LMMScGV
   x4fQEM62+GVdh7V27ADAVJVmPVTLzu5iULBvfO1DIPPinOvskK7FmCxMq
   shuvwDo+YaxVYptXazNuGb3YBXtCgPXYMxRgu4HZ7/ncNXKOweKdBeRfv
   sJfhdEBPMdj2YtLP7WlONss/D2ZVaaW8ch0VqsTh5ZfvjGbq/NSZVwY7k
   NogaKaGe3ztGbLamOdvMHg3MMbqi2TMynxyjzyiqgEbxYRrBB+AQVETJu
   A==;
X-CSE-ConnectionGUID: z6K5QK+OT0m4OJ7CbhcdHg==
X-CSE-MsgGUID: DceLlVOuQFuC9WrLDvDNbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511476"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511476"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:45 -0700
X-CSE-ConnectionGUID: btBEV381TMaRkEvZMpczLA==
X-CSE-MsgGUID: z51SWxWNTjSV8wo1DUJReg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778852"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-04
Date: Sun,  4 May 2025 13:26:15 +0300
Message-Id: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
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

A few features, cleanups and fixes from our internal tree.

Thanks,
Miri
---

Johannes Berg (14):
  wifi: iwlwifi: rework transport configuration
  wifi: iwlwifi: move STEP config into trans->conf
  wifi: iwlwifi: trans: move ext_32khz_clock_valid to config
  wifi: iwlwifi: remove sku_id from trans
  wifi: iwlwifi: fw: remove RATE_MCS_NSS_POS
  wifi: iwlwifi: rename modulation type values
  wifi: iwlwifi: mld: build HT/VHT injected rate in v2
  wifi: iwlwifi: mld: don't report bad EHT rate to mac80211
  wifi: iwlwifi: mvm: don't report bad EHT rate to mac80211
  wifi: iwlwifi: mvm: remove HT greenfield support
  wifi: iwlwifi: tests: allow same config for different MACs
  wifi: iwlwifi: cfg: use minimum API version 97 for Sc/Dr
  wifi: iwlwifi: tests: simplify devinfo_no_trans_cfg_dups()
  wifi: iwlwifi: dvm: pair transport op-mode enter/leave

Miri Korenblit (1):
  wifi: iwlwifi: bump FW API to 99 for BZ/SC/DR devices

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 48 +++++------
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 18 ++--
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 49 ++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |  5 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  6 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    | 49 ++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 22 ++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  6 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  2 -
 .../net/wireless/intel/iwlwifi/iwl-devtrace.h |  9 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 28 +++---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 63 ++++++--------
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   | 33 ++++---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  | 59 ++++++-------
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 28 +++---
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 15 ++--
 .../wireless/intel/iwlwifi/mld/tests/hcmd.c   |  6 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 52 +++++------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 16 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 16 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 45 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  2 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 32 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 46 +++-------
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  4 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 17 ++--
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  4 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    | 30 +------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 13 ++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 43 +++-------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 22 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 62 ++++++-------
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 86 ++++++-------------
 40 files changed, 436 insertions(+), 528 deletions(-)

-- 
2.34.1


