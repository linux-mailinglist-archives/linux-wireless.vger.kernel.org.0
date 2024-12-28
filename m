Return-Path: <linux-wireless+bounces-16842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0679FDC2A
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A8C3A1450
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD478F38;
	Sat, 28 Dec 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfkSKWSV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0221E515
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418077; cv=none; b=kfhbRyLe3eusN5bIa+Ybo5JDz3PfavzO7gzTCQDAfkmFh3imn11G4mkSHmVQenyNgfSQ7BUcfDbaAEMtFPfxfrh9Dcw/zU2rxmLdmHuKSr47L+cWto40d2wWEoLN6kDo/vmlCpCD4QOGSfejYXjg7WNW1byjDD+MIRM8oEkdUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418077; c=relaxed/simple;
	bh=pulRK9txCj9jGzxSmmbXtSbbhUtRpE37hzxFpd82WZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iIjubCVFrbVoPkASa9KTQcrypd3iQW+AqQG9pVHashCrYMQrHGtd1KdE+GfYabdoQHGfz6YpCPst8XuGU+eILwJuu9h9flRyLJFL7hZgGvjxr8G+rUiAEI2RKj7k6VVWkNmrTThludN13MDtnsE4efNbCykRWPmwZFFF5z0LOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfkSKWSV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418075; x=1766954075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pulRK9txCj9jGzxSmmbXtSbbhUtRpE37hzxFpd82WZQ=;
  b=lfkSKWSVjGXPjKK45O9JdTAEKHxEwO8aU+YXiUUV8f7nV82Ad9kPh2LP
   mWasmFM1ZoWp86bWsq3G7qnjTYyY6o5ilPCN9OIaTfdGDq+BqybFjK2sO
   fdIvRhKgwsilzM+iQUvnlkeBSFv+eS+RnD+9+MBrmU1+bjjIclJhS5TST
   XWnOeyNYPz78yDFZgug1CmOQDqNdF5loVtBqLkpzRhLpjommKiyG39wnq
   f3Fi3OurqX2ja+mY+cbloEICCW6sJMq47W+fYbRPCQZhxXkMo2R6eHLo2
   hOa6mAs9KWI1fjFcnUnjVbgbPj5btzMdgGlaufeZGSeK5EHnvkuM7NP83
   w==;
X-CSE-ConnectionGUID: +YwPXbqkSjGOUJsjzRIFpg==
X-CSE-MsgGUID: aFiGW3tmRe+itLoC/5KChQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479748"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479748"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:34 -0800
X-CSE-ConnectionGUID: Qvw845VgStyCGg+BxC4jaw==
X-CSE-MsgGUID: iPMwHkM5RMujm3epBrkDPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488351"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:33 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 28-12-24
Date: Sat, 28 Dec 2024 22:34:04 +0200
Message-Id: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
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

A few features and cleanups from our internal tree.

Thanks,
Miri
---

Daniel Gabay (1):
  wifi: iwlwifi: Remove MVM prefix from TX API macros

Emmanuel Grumbach (3):
  wifi: iwlwifi: move fw_ver debugfs to firmware runtime
  wifi: iwlwifi:
    s/iwl_dts_measurement_notif_v2/iwl_dts_measurement_notif/g
  wifi: iwlwifi: move fw_dbg_collect to fw debugfs

Johannes Berg (3):
  wifi: iwlwifi: rename bits in config/boot control register
  wifi: iwlwifi: iwl-drv: refactor image loading a bit
  wifi: iwlwifi: mvm: fix add stream vs. restart race

Miri Korenblit (4):
  wifi: iwlwifi: mld: make iwl_mvm_find_ie_offset a iwlwifi util
  wifi: iwlwifi: mark that we support TX_CMD_API_S_VER_10
  wifi: iwlwifi: avoid memory leak
  wifi: iwlwifi: bump FW API to 96 for BZ/SC devices

Somashekhar(Som) (3):
  wifi: iwlwifi: Allow entering EMLSR for more band combinations
  wifi: iwlwifi: add mapping of prph register crf for PE RF
  wifi: iwlwifi: add channel_load_not_by_us in iwl_mvm_phy_ctxt

Yedidya Benshimol (1):
  wifi: iwlwifi: api: remove version number from latest
    stored_beacon_notif

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |  8 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 13 ++--
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  2 +-
 .../wireless/intel/iwlwifi/fw/api/offload.h   |  8 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |  6 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 10 +--
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 42 +++++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  | 15 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 78 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  1 +
 .../net/wireless/intel/iwlwifi/iwl-utils.h    | 20 +++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 57 +-------------
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 50 ++++--------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  9 ++-
 .../wireless/intel/iwlwifi/mvm/tests/links.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  3 +
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  6 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 18 ++---
 26 files changed, 187 insertions(+), 188 deletions(-)

-- 
2.34.1


