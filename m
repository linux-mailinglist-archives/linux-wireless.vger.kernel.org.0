Return-Path: <linux-wireless+bounces-13663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E23993DEF
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B681C23ECF
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C82C859;
	Tue,  8 Oct 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjyRfx71"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C883C0C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361543; cv=none; b=dOZKOeEU0nWRixHrSO4nAqOPNnOYoNOUhsKXKoL0ixiywy8vZBiCEBOpXrNKZhd8T1yUy2PdUFxDvKALw234+bF7fwWnOMEUF1YxHEljSFbahfzX+29dKlv3MbD2DwIcWY9JrR2j4cBQj0vYSZwnBIKd5WLOLiag9/l3XOiAnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361543; c=relaxed/simple;
	bh=RyNWiiJQpjw4LcdFgsXqh2ORxBHbd7irdDbwwpKerlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MqYd7qDMp74+KncNNq6J266OjhNJApwbXNXFVgYrUBw0T2KAwMVgtcuoDWLpn7yVvXes0pyKb0FrVmbg6tMgqsmfMop6H4wdjbS4hR0BgTpDMSAQIIJA6JExzZqvne1kjhU7N+l49atl/NW8gyXmFiAUJiOE8TQc/31YCMdj+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjyRfx71; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361541; x=1759897541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RyNWiiJQpjw4LcdFgsXqh2ORxBHbd7irdDbwwpKerlY=;
  b=VjyRfx71/7X1RkoZZRXJr09SatFlvZiJxAGaFaidsR2vhvQGJuFfI/yT
   casb9kgSqg3Z+48ifNlqAG59IX/8WxqAdTxvQgfhr83lmZ7IdTvysoEL8
   QMyEIhuNxjuGzQAa4P7XhRdqKcrdhgs5Kr6GlO+qalvnjmbEJXHPaBz7u
   ZWD7zoigt5pvb8OOoduQz/N0+OjoPlFb/uTJM1qDBxIhzNvohUI/KEFjQ
   xllEPgT4UTtxNvoyc3MeAcPeSQMoUoAJ2Z0HmPR5ORAf0ZbSY65IPTrOT
   HpUBR2jEpBzi5T93AFLVCgvFZJd1GdvkmvgJU+kyJRWFVGurDzN7vZxhm
   A==;
X-CSE-ConnectionGUID: CwuBi2M4RDGiFCpfqY08GQ==
X-CSE-MsgGUID: OawmeTrmQYKrSCbHdBjqIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024246"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024246"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:41 -0700
X-CSE-ConnectionGUID: zWwR4UnaQlyaRdUTjjlCig==
X-CSE-MsgGUID: mxX2CZbvS2uW4JBvoX1nrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486291"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/14] iwlwifi updates - 08-10-2024
Date: Tue,  8 Oct 2024 07:25:14 +0300
Message-Id: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
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
Some features and cleanups from our internal tree.

Thanks,
Miri

Benjamin Berg (2):
  wifi: iwlwifi: mvm: log information about HW restart completion
  wifi: iwlwifi: do not warn about a flush with an empty TX queue

Daniel Gabay (2):
  wifi: iwlwifi: mvm: Remove unused last_amsdu from reorder buffer
  wifi: iwlwifi: mvm: Remove redundant rcu_read_lock() in reorder buffer

Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: exit EMLSR earlier if bss_param_ch_cnt is updated
  wifi: iwlwifi: mvm: prepare the tx_power handling to be per-link

Ilan Peer (1):
  wifi: iwlwifi: mvm: Add support for prep_add_interface() callback

Johannes Berg (2):
  wifi: iwlwifi: fw: api: update link context API version
  wifi: iwlwifi: allow IWL_FW_CHECK() with just a string

Miri Korenblit (4):
  wifi: iwlwifi: bump FW API to 94 for BZ/SC devices
  wifi: iwlwifi: mvm: remove unneeded check
  wifi: iwlwifi: mvm: remove IWL_MVM_HW_CSUM_DISABLE
  wifi: iwlwifi: mvm: remove redundant check

Yedidya Benshimol (1):
  wifi: iwlwifi: fw: add an error table status getter

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 32 ++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  9 ++---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 22 +++++++++++-
 .../wireless/intel/iwlwifi/mvm/constants.h    |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 34 +++++-------------
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  4 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 13 +++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 36 +++++++++++++++----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 33 ++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 15 +++++---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 13 ++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  8 +----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  4 +++
 15 files changed, 158 insertions(+), 73 deletions(-)

-- 
2.34.1


