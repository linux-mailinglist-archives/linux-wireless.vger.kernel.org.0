Return-Path: <linux-wireless+bounces-2867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F10C8438E0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0459728AE6A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC05813B;
	Wed, 31 Jan 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahq8YXvq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6055FB91
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689498; cv=none; b=NnpFCUzHm4oPLYFdkq/jIdDuw94WJaFdj+fMraMrN49rlyLAEkyEqZDHy68bFSVQVbK+4/WN683SDPgPBAMBzS2LYEa238ZchCo55p9h5yIxiaizhAquRAjDYH4desGzXUN+s+0gp/zeEezNC9KwQZSr55p5qm29ukPzKEfqLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689498; c=relaxed/simple;
	bh=lLLmVbEXMzVnCXjK4jyDpxyz/NuUZruLOafVAFEhl8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lE0sYFDMaJkznOZPB/nd8RfeA2T+1S7T3be3Zfl3lgUyJlo9DbSceT1fxO54RrNnQCaZhROBkvAUsyGj9ZSskYeWA7hpBtZMVMl9sC4s5QU1OOg7WzbB/r3+Ca79lgwe12MWWXnLM60YgRWtfxSCiOK8fSn7NqfpxcHmeSS6jho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahq8YXvq; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689496; x=1738225496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lLLmVbEXMzVnCXjK4jyDpxyz/NuUZruLOafVAFEhl8o=;
  b=ahq8YXvqInSMkU7h6HE32kG7QIaMlskJK2o5bQmdGnkxIO6tr2k5O192
   KFa28LS5zK8c9BdjgAZMmaZCCqW/5ycHGZMhgDhCWWaxZG1CHk0h5yxo7
   g14TBoQpK2YgtowGxeXcwX50jntUooaIhwYypcwUPvtQ9Fdhjt+6RIUfe
   1ovs2x7pyKK5sElgGqRKpPP9u0mhEbt/KHdvyqEvUajuKKQa2JLhKyz5D
   EpCY5Q3eHOTcEENM+TrM4M0hOdMJX8qegIsnfNPggC0fCYKxieU8BBmAx
   NzV8S4/YNjxR/EeX+UByY2ZLboks7SHxM/Dtz8ulgJBM61qL47PoeEoAc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249867"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249867"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968765"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:24:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/14] wifi: iwlwifi: updates - 2024-01-31
Date: Wed, 31 Jan 2024 10:24:33 +0200
Message-Id: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.9. It contains a
few features, bugfixes and cleanups.

Thanks,
Miri

Johannes Berg (2):
  wifi: iwlwifi: mvm: d3: implement suspend with MLO
  wifi: iwlwifi: mvm: check AP supports EMLSR

Miri Korenblit (12):
  wifi: iwlwifi: read BIOS PNVM only for non-Intel SKU
  wifi: iwlwifi: prepare for reading SAR tables from UEFI
  wifi: iwlwifi: cleanup sending PER_CHAIN_LIMIT_OFFSET_CMD
  wifi: iwlwifi: read SAR tables from UEFI
  wifi: iwlwifi: small cleanups in PPAG table flows
  wifi: iwlwifi: prepare for reading PPAG table from UEFI
  wifi: iwlwifi: validate PPAG table when sent to FW
  wifi: iwlwifi: read PPAG table from UEFI
  wifi: iwlwifi: don't check TAS block list size twice
  wifi: iwlwifi: prepare for reading TAS table from UEFI
  wifi: iwlwifi: separate TAS 'read-from-BIOS' and 'send-to-FW' flows
  wifi: iwlwifi: read WTAS table from UEFI

 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 392 ++--------------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 109 +----
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  28 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  30 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 429 ++++++++++++++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    | 140 ++++++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  12 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 185 ++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 122 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  79 +++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 251 ++++------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 16 files changed, 1095 insertions(+), 695 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h

-- 
2.34.1


