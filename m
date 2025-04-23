Return-Path: <linux-wireless+bounces-21860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ECDA97E49
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12DB3B8EC1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C17264A96;
	Wed, 23 Apr 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfH+x1N+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CDEEAFA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387451; cv=none; b=WTHlW8bg4i2T+Arre3QVZCqC0Tkub0wjcsgx4WizxxxRZYdG/G1XBcW+pIMpGoSLAPfDa5m4fABi2rp/+gMi7iKBr7QjWI6t41UlaB7X5T2LbOgPqvBb7hc3ymkioGKngCTX3DEQHj+X8PoYmbcKTP9VQelFSLi5bLditetJ0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387451; c=relaxed/simple;
	bh=bhx5ZinGdjwk96vWtBLxp8/tjYTfdAwMVx56yvJNrec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BTUaVavYuSiqVwkPP/LLdRI/S6wk4RLEGLcOaamcowj+/OJXH60E0/FHF9p+gdCGgqPqEfrxpm+1RtoLU+6P4DfZjQ1velvUwB6YDyxIG+1DPvlDvEZcWtUzLXwJnw6jBJsJe9kp6ONoN/GcVnDcOhV/CTIWP0lmr3hM8TplpuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfH+x1N+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387450; x=1776923450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bhx5ZinGdjwk96vWtBLxp8/tjYTfdAwMVx56yvJNrec=;
  b=RfH+x1N+KRVUPUR1xpK7rlUECpps0Z/HLASQ3iFql9tRB0xB52BXWhfs
   de3wXFa2FRu4WIcfPqKlT2Z/jCEDZLQydjZpSval4vAb5Fj9AxvFcIuTh
   hOYuJyx+NKkcz1wlGMIHt41wPebkHdU1iIjGHb1UorDyX6ik8EsZQexEq
   +PRXg9/j9evI+HTDdwPyffIvog1aFvWsYSdEjoJ7qw0k7YIjkSmtaVGDm
   oOI5AYtTsPxRQKS7qq/4DCC8FPCKHIXW11Li57f/Bw/IAkbsj4uKkYOtI
   nF0/0t8Euv9HIs/lbcMvNeXdLVjMsNlh2bWvnZyrG4qC5OVbxx2sGmfYK
   Q==;
X-CSE-ConnectionGUID: oIb0qTXLSj+Yqv7bgskrnw==
X-CSE-MsgGUID: eGi59ZtRR5W4AmyEzMfr2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844611"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844611"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:49 -0700
X-CSE-ConnectionGUID: W+q7GodrRZmSniI+ULNdgg==
X-CSE-MsgGUID: empIG98XS4yVNvjmF4xoHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164288"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 00/17] wifi: iwlwifi: updates - 2025-04-23
Date: Wed, 23 Apr 2025 08:50:19 +0300
Message-Id: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
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

A few cleanups, features and fixes.

Thanks,
Miri
---

Anjaneyulu (1):
  wifi: iwlwifi: parse active and 20 MHz AP NVM channel flag

Emmanuel Grumbach (3):
  wifi: iwlwifi: mld: remove stored_beacon support
  wifi: iwlwifi: update the PHY_CONTEXT_CMD API
  wifi: iwlwifi: pcie: add support for the reset handshake in MSI

Johannes Berg (5):
  wifi: iwlwifi: mvm: remove IWL_EMPTYING_HW_QUEUE_DELBA state
  wifi: iwlwifi: fw: do reset handshake during assert if needed
  wifi: iwlwifi: mld: remove P2P powersave tracking
  wifi: iwlwifi: mld: tests: simplify le32 bitfield handling
  wifi: iwlwifi: mld: clarify variable type

Miri Korenblit (8):
  wifi: iwlwifi: re-add IWL_AMSDU_8K case
  wifi: iwlwifi: mld: avoid memory leak if mcc_init fails
  wifi: iwlwifi: mld: stop hw if mcc_init fails
  wifi: iwlwifi: mld: don't do iwl_trans_stop_device twice
  wifi: iwlwifi: mld: refactor purging async notifications
  wifi: iwlwifi: mld: properly handle async notification in op mode
    start
  wifi: iwlwifi: mld: inform trans on init failure
  wifi: iwlwifi: set step_urm in transport and not in the opmodes

 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  8 +--
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  9 ++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 15 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  7 +++
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  | 20 ++++----
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 36 ++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |  2 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   | 48 ++++++-----------
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  5 --
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  9 ----
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  | 25 +++++++--
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  5 --
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  2 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    | 51 ++-----------------
 .../net/wireless/intel/iwlwifi/mld/notif.h    |  2 +-
 .../wireless/intel/iwlwifi/mld/tests/agg.c    | 14 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  5 --
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 14 +----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 14 ++++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 23 +++++++--
 22 files changed, 151 insertions(+), 169 deletions(-)

-- 
2.34.1


