Return-Path: <linux-wireless+bounces-24054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77FAD6F65
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86603AF118
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F69218E9F;
	Thu, 12 Jun 2025 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msFeOM06"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D811230BD0
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728960; cv=none; b=OhJi0Ih7OoqGI8yhSrOa3jgaEZjSA5LpCx4gAeJL9B0uvfMiheJGcL6zjoBApH7s+lbc1nTS3sA0fPPCdBiDs5CC/2vC5GpTriWofh5g0e0dCkIxZJSIK2gCAtoNRb/EkY6jikN6pfEVAqQxPIgZAG3Nu+gk3IQUXg7WslTx+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728960; c=relaxed/simple;
	bh=LJMUfeRDvb7hjd6CWDbTHr7VURr5qGGF9jPiqGlLiyE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=lH9fTG6uod//ye/l2zHmEsqQKNZik/DMP62RSdjcmSzBxe4erhGtmhxkzcvB1dN+9hMaTOVilZYnbsrbtmGYGeSx349CVdImJ7G/XnAng2WZMVQy4BnJzsVEEi5SFDB2Taz3yg9/6v1A9ux5SILBS184a22Q8z9YO0A155yQ3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msFeOM06; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728959; x=1781264959;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LJMUfeRDvb7hjd6CWDbTHr7VURr5qGGF9jPiqGlLiyE=;
  b=msFeOM06TOS+LfoWBCr13Mo9fSz4J7NXS6UnoSh7M/vIcwBnMKtFLVAQ
   ZZveJYpY1SHTqTFM9EgjaO6wQZquu2jmQEnpkSJNGh+haIMpyWPd+tcdc
   9wGRFWxJvcrCq/tfrEdARQ8Ob+4iJvLZe5FxLuSAv7EBHUzoCbsVciZWm
   MKU9HoacdjrfHtjfktLdL1f99K/vLllnkE+zvvOj6AxRyVZNHQExtM9qp
   VsQgxPtis/9aYvjGNAAWFqv3i+v9Yn0EU9PB1ZkuIoKGxL52rQYcyB4bS
   QEjHxFhUfOrhZFZt8ZzVtpfboh4dxSgkk2Y+k5zWEstLU8jL5sNgqGjo2
   A==;
X-CSE-ConnectionGUID: 2rKW+B4sTi+uV0hMHj2dwA==
X-CSE-MsgGUID: PsL6Z0LfRemqCvldO6Dl9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248322"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248322"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:17 -0700
X-CSE-ConnectionGUID: rEJ5W1awRdCWkMBlpPMsSw==
X-CSE-MsgGUID: 3i2b1p/nToadOy1MYNO9+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382086"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/13] wifi: iwlwifi: updates - 2025-06-10
Date: Thu, 12 Jun 2025 14:48:46 +0300
Message-Id: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
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

Features, cleanups, and bugfixes from our internal tree.

Thanks,
Miri
---

Benjamin Berg (2):
  wifi: iwlwifi: mld: use the correct struct size for tracing
  wifi: iwlwifi: mld: advertise support for TTLM changes

Ilan Peer (1):
  wifi: iwlwifi: mld: Block EMLSR when scanning on P2P Device

Johannes Berg (3):
  wifi: iwlwifi: make FSEQ version a debug message
  wifi: iwlwifi: add HE 1024QAM for <242-tone RU for PE
  wifi: iwlwifi: pcie: fix non-MSIX handshake register

Miri Korenblit (4):
  wifi: iwlwifi: support RZL platform device ID
  wifi: iwlwifi: mld: make iwl_mld_add_all_rekeys void
  wifi: iwlwifi: mld: don't exit EMLSR when we shouldn't
  wifi: iwlwifi: bump FW API to 101 for BZ/SC/DR devices

Rotem Kerem (3):
  wifi: iwlwifi: pcie: move iwl_trans_pcie_dump_regs() to utils.c
  wifi: iwlwifi: move iwl_trans_pcie_write_mem to iwl-trans.c
  wifi: iwlwifi: move _iwl_trans_set_bits_mask utilities

 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  14 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |  10 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   3 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  46 +++---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  38 ++++-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |   4 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   1 +
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  32 ----
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    |   2 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 147 +++---------------
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |  16 +-
 .../net/wireless/intel/iwlwifi/pcie/utils.c   | 104 +++++++++++++
 .../net/wireless/intel/iwlwifi/pcie/utils.h   |  38 +++++
 21 files changed, 259 insertions(+), 213 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/utils.h

-- 
2.34.1


