Return-Path: <linux-wireless+bounces-20060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2CA57F2A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B0F3ABAA1
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973518DB35;
	Sat,  8 Mar 2025 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkTPCwSS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51114D2BB
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471300; cv=none; b=Eh6YS8pq1ZiVhQF8GSSejJF2wIleym3oBB9+WA7YU+gzHR2mYeD3lKkFsMMonW++2YKT4//VTNlQ+2G+KwHYwUYw5pruyD4MFW/GEYU5V98h5naj4/A6mBwr/Sh/mINdkGqathgHIo0dl0VFLLF7Nx47XQ1JwJP0WyhJ7rhCeQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471300; c=relaxed/simple;
	bh=5p+q+ara0rYcOpDShJpL2XM3eNuhzdnkeBgd1EnYN7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OMOlcFcQ47d1wP8F7XwCXAzdNHqAkqhx28cmSE3riEUsX7Uy/lxB2CrL6+Hzpczr9/dOxYENriAmDMPOAkIfVdhd4ARyhIbq08GN6Ly5X4IQt9ykr0kjJXULnVh9kaX+QrRmIJO0q2dNXWCi3VvrhwrDvXeQce1XFAjnJTwCfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkTPCwSS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471299; x=1773007299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5p+q+ara0rYcOpDShJpL2XM3eNuhzdnkeBgd1EnYN7M=;
  b=NkTPCwSS8uU9xyvYLIea18m5JXtCOo7NqQEllTytFJd7xksmKEyMvlgt
   qgFfDFLg0wGlgRbl6f2s8a9kdTh8LxjSp4XHzh1HjKrb1E+XPH8TE66tv
   fB5SuxlAkvIz4RgCQGu2UQEq3I8G/T7cYnWhXEM9oN9SXgiJg+tpCB1vP
   d4VT2n2EOVhnLn1A7b44+iInftEegdTjyEw2RCKjDX+CqM266VG1ybaPM
   FNF+ap255IQMJExa5aPFa5eXvMnRqE+vbFrAnWg0V/gF4fxdSPK4yHsei
   VgszhLxcOTMf69RfomiC6LHpnwEjm8Erq14rCqeBnbupGGLVWXYcHIdGu
   A==;
X-CSE-ConnectionGUID: HKqUIM35TpOMQ86YzCp/gw==
X-CSE-MsgGUID: uB0+s7SDT1+lQL5ntU5UcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540612"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540612"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:38 -0800
X-CSE-ConnectionGUID: 9OMcHn3RR6mAnk57A4IbjA==
X-CSE-MsgGUID: G7ECNKK3Rgya/OkVKbLYUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352042"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/15] wifi: iwlwifi: updates - 2025-03-08
Date: Sun,  9 Mar 2025 00:01:10 +0200
Message-Id: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
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


