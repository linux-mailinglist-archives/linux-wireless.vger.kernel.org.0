Return-Path: <linux-wireless+bounces-10620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE87793FC48
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46DE1F20F69
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224535028C;
	Mon, 29 Jul 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANzDq/JN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401BA15CD7F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273631; cv=none; b=lHf8B6NIbBpkMbc3Udmy5fvk9oYsMufNFj3g4jzKXnAVO3OgSB/cYzYYV8+h5NT72N14bW3mZBQhj0NvPtvBjPWF/Ksh/0AHTv/yc9VjZJ+z6KIFMZhiIlT3SEbKvEqf7C699gfg6MAvZSeR5r/lbW6Y9cCnYRoMzymGkaf6eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273631; c=relaxed/simple;
	bh=IL3OO5NckTCSKV3VVWivu8FZu9jzjs+ccIJwI+z3RJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O+z1ZZ/MuGFBcvU7gNxPqSRvclrCyn85gVzYs2Kqn+P/lFWnqM/dl79xC8oM9YnM1JLXHfvceNXx4cFqg7FZrZUoBtKK7MFnVM6STYr0h33QIJjSlr7wPueBXEO3+Vd6vtsItaX9X2dfV+95LFd5Gu/uqLo6ycbTc0dDIEXxlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANzDq/JN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273630; x=1753809630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IL3OO5NckTCSKV3VVWivu8FZu9jzjs+ccIJwI+z3RJc=;
  b=ANzDq/JNfn21n+WnU1BiTqqt6JJcMSd6PXlmymIZyzramoRCBpLKdbTf
   GJ4WwKq4hRdawW5anl6mTfEstPEvjdKZQ9hfGAZFMCluwpp/Cz67bptkg
   oVbKyJXgTeEJy7RHDIdGLtUYD+LUvDNQifBcXa6bUjAFPiij9GSSinayN
   ZlqfCb/93hi5ArlXGmE85oM54rZggj3my9SrBWkNfqryjkq6RCMgxgo0e
   nxb/JMNkgsqqVFPlfaXwAxEy+Xa5Bt9CwYxxLRIrQHdHxn5eu42BgPx4Y
   MyKN6Ehc+SQlrGxpyB6SCitN0BoXnnp3M11g0ug+0NOIEodReYS4eiZmc
   A==;
X-CSE-ConnectionGUID: 3Tu5fVcaT5KzbNn5Eket8A==
X-CSE-MsgGUID: ld4yHN/UTxKJReGjXdv8mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445553"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445553"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:29 -0700
X-CSE-ConnectionGUID: FJW26sA+TcKmSERwWkkB6A==
X-CSE-MsgGUID: M8jPfIdFR9yw+4xwcnqcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288229"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/17] wifi: iwlwifi: updates - 29-07-24
Date: Mon, 29 Jul 2024 20:20:01 +0300
Message-Id: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
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

This patch set contains a few features, bugfixes and cleanups.

Miri

Avraham Stern (3):
  wifi: iwlwifi: mei: add support for SAP version 4
  wifi: iwlwifi: mvm: set the cipher for secured NDP ranging
  wifi: iwlwifi: mvm: increase the time between ranging measurements

Emmanuel Grumbach (7):
  wifi: iwlwifi: mvm: prepare the introduction of V9 of REDUCED_TX_POWER
  wifi: iwlwifi: mvm: add support for new REDUCE_TXPOWER_CMD versions
  wifi: iwlwifi: mvm: set ul_mu_data_disable when needed
  wifi: iwlwifi: mvm:
    s/iwl_bt_coex_profile_notif/iwl_bt_coex_prof_old_notif
  wifi: iwlwifi: mvm: start to support the new BT profile notification
  wifi: iwlwiif: mvm: handle the new BT notif
  wifi: iwlwifi: mvm: add firmware debug points for EMLSR entry / exit

Ilan Peer (1):
  wifi: iwlwifi: mvm: Fix a race in scan abort flow

Johannes Berg (3):
  wifi: iwlwifi: mvm: use correct key iteration
  wifi: iwlwifi: pcie: print function scratch before writing
  wifi: iwlwifi: config: label 'gl' devices as discrete

Miri Korenblit (2):
  wifi: iwlwifi: remove MVM prefix from FW macros
  wifi: iwlwifi: mvm: add and improve EMLSR debug info

Somashekhar(Som) (1):
  wifi: iwlwifi: Enable channel puncturing for US/CAN from bios

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 11 +++
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  | 29 ++++++-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  7 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  4 +
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 12 +--
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 79 ++++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 13 +++
 .../net/wireless/intel/iwlwifi/fw/api/stats.h |  4 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 16 ++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  2 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 29 +++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 28 +++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  | 10 +++
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 58 +++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 83 ++++++++++++++++---
 .../wireless/intel/iwlwifi/mvm/constants.h    |  2 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 29 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 11 +++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 48 +++++++----
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 12 +--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 14 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 16 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 42 ++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  4 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  2 +
 31 files changed, 491 insertions(+), 99 deletions(-)

-- 
2.34.1


