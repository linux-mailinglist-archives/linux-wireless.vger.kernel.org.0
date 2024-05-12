Return-Path: <linux-wireless+bounces-7535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B2B8C3673
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5996E281038
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E25A20DF4;
	Sun, 12 May 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+DuxH1U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026520DC3
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516717; cv=none; b=F+4FzDSZqnJHrPQZgmKS56Mhqbi7aJi8BrMqEPCBO+Q5Wa/pdVCMl9dSyDMILYIRJZqUtzNZqvHgwcyD934PjdNyGZ8g0eLrwat9OCNuH7WflReVSFlWntOFalJQ9q3jLoQkY8DksUou9wc3kpCJoZ7Vy0HtVjjXWyPiBebj9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516717; c=relaxed/simple;
	bh=9bW0ETK1+TzofnurU/suwTwWFtIPOL/6J0aw76fctvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G/oWz6kQAZrz9d4tz5HkKw25cOFHsltTL76+o/8mAy+Qm11URnnpNb1zqAVCOT6cUAReyFdCjrw6pYziTlaH1k69Ju0joeeSuxAdpmc5ZOfw1g+H+HdNEaXYSXM+Luban57vcfEO20vaVRiWq+VmHO66CwqmQmVkHlEaDhvt6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+DuxH1U; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516715; x=1747052715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9bW0ETK1+TzofnurU/suwTwWFtIPOL/6J0aw76fctvI=;
  b=G+DuxH1UaXJ/n/XaiT1shSUa1zqhBsQeOrM5m9gMiqZhFQkHC2Jsx8eI
   iz359W0Px+kdNYhuiHi3PzxoaaTloPq5uxduJQ1Dv5PHL3irmKGsllUI7
   upbt0u/LLMmrbD0afSxShcFZLHPUZ/OEcDfi233k3ReJBKLOLp+oNSujf
   wLyWI1EQVjrchcxPs0cLzWHJ5ryXbIZP/egr6JLnfjEykf+t4N+iHUhtU
   5j0gt/HMcKsPHJ4kmtIPP3C20l4BYGy6fXRJmIoSx6Rg1KeaZ1js/7vUG
   F6W7qtFpAkH+L5N5mRSatT9OYISO60Zpzsh4+cwE7cZImafay/r53WShL
   w==;
X-CSE-ConnectionGUID: vYECNJNOTQS4o0lhLSPR9A==
X-CSE-MsgGUID: s2KpIH66QNWRisqO+ZE3qA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397178"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397178"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:14 -0700
X-CSE-ConnectionGUID: xt79izPcSwuHYSyEgJAgUA==
X-CSE-MsgGUID: jWvU+5QlQXOmvEmJhVWSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761285"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/14] wifi: iwlwifi: updates - 2024-05-12
Date: Sun, 12 May 2024 15:24:53 +0300
Message-Id: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches. It contains a few features,
bugfixes and cleanups.

Thanks,
Miri

Anjaneyulu (1):
  wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v11

Ayala Beker (1):
  wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option

Emmanuel Grumbach (3):
  wifi: iwlwifi: kill iwl-eeprom-read
  wifi: iwlwifi: move code from iwl-eeprom-parse to dvm
  wifi: iwlwifi: mvm: don't read past the mfuart notifcation

Ilan Peer (1):
  wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill

Johannes Berg (4):
  wifi: iwlwifi: mvm: handle BA session teardown in RF-kill
  wifi: iwlwifi: tracing: fix condition to allocate buf1
  wifi: iwlwifi: simplify TX tracing
  wifi: iwlwifi: mvm: add mvm-specific guard

Miri Korenblit (3):
  wifi: iwlwifi: mvm: don't skip link selection
  wifi: iwlwifi: mvm: don't initialize csa_work twice
  wifi: iwlwifi: mvm: check n_ssids before accessing the ssids

Shaul Triebitz (1):
  wifi: iwlwifi: mvm: always set the TWT IE offset

 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/Makefile   |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |  21 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/devices.c  |   2 +-
 .../{iwl-eeprom-parse.c => dvm/eeprom.c}      | 448 ++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |   1 +
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  52 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  15 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   3 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   2 +-
 .../intel/iwlwifi/iwl-devtrace-data.h         |   4 +-
 .../intel/iwlwifi/iwl-devtrace-iwlwifi.h      |   8 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c  | 394 ---------------
 .../wireless/intel/iwlwifi/iwl-eeprom-read.h  |  12 -
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.c    | 118 +++++
 .../{iwl-eeprom-parse.h => iwl-nvm-utils.h}   |  17 -
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   9 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  10 -
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   7 +
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 229 +++------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  90 ++--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  60 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   7 +-
 35 files changed, 755 insertions(+), 860 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/{iwl-eeprom-parse.c => dvm/eeprom.c} (69%)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
 rename drivers/net/wireless/intel/iwlwifi/{iwl-eeprom-parse.h => iwl-nvm-utils.h} (73%)

-- 
2.34.1


