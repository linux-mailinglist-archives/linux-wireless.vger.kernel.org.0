Return-Path: <linux-wireless+bounces-2394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A36839726
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785352894FF
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C68005D;
	Tue, 23 Jan 2024 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceyl8orb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F3F81200
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032924; cv=none; b=JMXhc2PwqCRlbHO+f9i9hW1NvHoPVk1zCd2F+yX7J+G4jZq1cHIqSlSEWVlIQTJMWEIxoA7EDyDyrdrCB0k1JUji5J9J2+d/0lie2vAe8YzWbr2wb8unVOijwKu+YtEqA4E7CbzEFlRQ4LYf6NGfnfSwMHx7tWfvI2Gzuv9z6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032924; c=relaxed/simple;
	bh=B7UdzmMhGjXxkoeXPqTzkqBhREHl8rtGXqWt4Dr/OlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=csAHiQoKywubcx8+XDY3YIaKUM7rRQ7c2WFLsg+eoLpPLjg1Ncvv7sQ/086oMWwigVRnlw0vL2IAToyKA6fIeZmsslB0z8Z0C7MrU8j6PyHbSwMt0U9wuo9rBpeQze4n2Bty8ZIdidVw2vox3UzI0IKtVJ9MGiuX3Dc4S6YzQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceyl8orb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706032923; x=1737568923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B7UdzmMhGjXxkoeXPqTzkqBhREHl8rtGXqWt4Dr/OlA=;
  b=ceyl8orbpkHJQ/7Xt3b3O7gKdUG428Z/lz0pRQn7vrnwMuPzUU7Ryfzq
   OmfdES36pWkUMDRa4rCLrrdyAGSesv+VbbTKKqpLUobj30peHDoz+adcx
   IyoB31BOfAJlxwsC3zZ2Xfbap2NpfeMtCUgDjfVID4u/vDsAuIhM6pPJd
   pimA120DbdNh9gk9tduTdyzuXbKPp24fSuyiuW4e2xJvDseOTUTnYZJ7t
   RAv65pfuk2wlJOFf9BTN/G/x3Dt59uTU16vw8tAf6W+7rlIdmdrBDJjSp
   dmlKafr1/i6EB2EYdQuJRxqhT3pg8MFiXNnqt0d4hV9A7yPN3ndVOACVp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="498091"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="498091"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1663759"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:01:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2024-01-23
Date: Tue, 23 Jan 2024 20:01:28 +0200
Message-Id: <20240123180143.2434614-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi,

This patch set includes iwlwifi patches intended for v6.9. It contains a
few features, bugfixes and cleanups.

Thanks,
Miri

Benjamin Berg (2):
  wifi: iwlwifi: skip affinity setting on non-SMP
  wifi: iwlwifi: mvm: skip adding debugfs symlink for reconfig

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: introduce PHY_CONTEXT_CMD_API_VER_5

Gregory Greenman (1):
  wifi: iwlwifi: bump FW API to 87 for AX/BZ/SC devices

Johannes Berg (6):
  wifi: iwlwifi: add kunit test for devinfo ordering
  wifi: iwlwifi: fix double-free bug
  wifi: iwlwifi: make TB reallocation a debug message
  wifi: iwlwifi: mvm: limit EHT 320 MHz MCS for STEP URM
  wifi: iwlwifi: remove retry loops in start
  wifi: iwlwifi: nvm-parse: advertise common packet padding

Miri Korenblit (3):
  wifi: iwlwifi: change link id in time event to s8
  wifi: iwlwifi: implement can_activate_links callback
  wifi: iwlwifi: add support for a wiphy_work rx handler

Mukesh Sisodiya (2):
  wifi: iwlwifi: Add support for new 802.11be device
  wifi: iwlwifi: disable 160Mhz based on SSID

 drivers/net/wireless/intel/iwlwifi/Kconfig    | 10 +++
 drivers/net/wireless/intel/iwlwifi/Makefile   |  2 +
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  | 16 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 13 ++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 14 +++++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 29 +++------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  | 10 ++-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 39 ++++++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  3 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  5 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  5 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 17 ++----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 21 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 61 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  8 +--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 19 +++++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 +
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  7 ++-
 .../net/wireless/intel/iwlwifi/tests/Makefile |  7 +++
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 54 ++++++++++++++++
 .../net/wireless/intel/iwlwifi/tests/module.c | 10 +++
 26 files changed, 292 insertions(+), 74 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/module.c

-- 
2.34.1


