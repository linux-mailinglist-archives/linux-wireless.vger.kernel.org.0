Return-Path: <linux-wireless+bounces-20076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB2A580A4
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C0C16B935
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D3A42AA5;
	Sun,  9 Mar 2025 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFbmKrVL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5BC133
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498629; cv=none; b=BTNA1IzuUHo0Y2cWfrYJooRoJwQCAtUCML06HXYrIHgOuFE1ga317b8GH9B0bqPFI8A8NDsLdaltmWpEqlKFxB2fxkQWtQGPXgr9t+tgDg9AjDHhLZx6lD0G5ZX8aYG8ELcG90ducv/ZNOCmUA4sUqJBETfh1vKYQm/DZkEmOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498629; c=relaxed/simple;
	bh=5p+q+ara0rYcOpDShJpL2XM3eNuhzdnkeBgd1EnYN7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g0stD1Lyx3B7M1InOm4F+d/xr73mQAVkZ1Yh6QbryFpuTOuMap5rqIbs9ZwMj/XqygDnGvv0U5+iEMLsG9ji0n+wIWbwKZTZGm57VAnD7qJzu5L8X+U7aKRS7WmmyD4lDSHwmoMTRn9caeoTg4XQDarlDSyAzcWiZ9ybgFRcAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFbmKrVL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498627; x=1773034627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5p+q+ara0rYcOpDShJpL2XM3eNuhzdnkeBgd1EnYN7M=;
  b=CFbmKrVLMkQF0cYGhc8u/66ikS4wlX/kjCSh6ggZtlAa1+n2kCFLtmKc
   PzmW2omOaCANz30EC+f1l4wAyQLnPZWVX49q+Kn20UTdytyNmqFdKQxMF
   SpGxbmZVelAiYWFT80zwyKGYjbAc2X9TdjiwjWWIr7cf1Xu1I5cM6PFCC
   Qa85XZ1fglZz/qD9tsiQctKcz1ELnVU2HhvYZtVSPpZ6uqC72kZ806TUd
   2NdbTTCCZ12azq2kA8PQxrcCVnw6zrJTCOnjsOG+1eVS0EAcIiSbCJRB7
   N7D0BcBx7F2fhNEsFUPb5lQDWYxaqPGkvJPC7Ndk6H2Zq03kwRFN7rQ8s
   w==;
X-CSE-ConnectionGUID: 3Ck+vhMxSoyHSuizu/G5NA==
X-CSE-MsgGUID: 2WBZYzx2Td+n3faKnv9i8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671680"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671680"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:06 -0800
X-CSE-ConnectionGUID: GjC0x+6kT6+wHrW61mOuCA==
X-CSE-MsgGUID: pernrHSNRFqPSjeB4JOf+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470580"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 00/15] wifi: iwlwifi: updates - 2025-03-08
Date: Sun,  9 Mar 2025 07:36:38 +0200
Message-Id: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
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

A few features, cleanups and bugfixes for the new sub-driver - iwlmld.

Thanks,
Miri
---

Avraham Stern (1):
  wifi: iwlwifi: mld: move the ftm initiator data to ftm-initiator.h

Benjamin Berg (1):
  wifi: iwlwifi: mld: assume wiphy is locked when getting BSS ifaces

Ilan Peer (1):
  wifi: iwlwifi: mld: Correctly configure the A-MSDU max lengths

Johannes Berg (4):
  wifi: iwlwifi: mld: initialize regulatory early
  wifi: iwlwifi: mld: fix OMI time protection logic
  wifi: iwlwifi: mld: enable OMI bandwidth reduction on 6 GHz
  wifi: iwlwifi: mld: remove AP keys only for AP STA

Miri Korenblit (8):
  wifi: iwlwifi: mld: fix build with CONFIG_PM_SLEEP undefined
  wifi: iwlwifi: mld: fix SMPS W/A
  wifi: iwlwifi: mld: track channel_load_not_by_us
  wifi: iwlwifi: mld: refactor iwl_mld_valid_emlsr_pair
  wifi: iwlwifi: mld: use the right iface iterator in low_latency
  wifi: iwlwifi: mld: always do MLO scan before link selection
  wifi: iwlwifi: mld: fix bad RSSI handling
  wifi: iwlwifi: mld: avoid selecting bad links

 .../intel/iwlwifi/mld/ftm-initiator.h         | 14 ++++
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |  8 +--
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h |  4 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  8 +--
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  2 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  8 +--
 .../wireless/intel/iwlwifi/mld/low_latency.c  |  6 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 39 ++++++-----
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  | 17 ++++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  9 ++-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 65 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  3 -
 drivers/net/wireless/intel/iwlwifi/mld/phy.c  | 49 ++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mld/phy.h  |  8 ++-
 .../net/wireless/intel/iwlwifi/mld/power.c    |  3 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |  5 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  | 26 +++++++-
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 20 +++---
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 43 ++++--------
 21 files changed, 222 insertions(+), 122 deletions(-)

-- 
2.34.1


