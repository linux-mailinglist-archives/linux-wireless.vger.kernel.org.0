Return-Path: <linux-wireless+bounces-3101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65F8490F5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93CE1F22740
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83D2C695;
	Sun,  4 Feb 2024 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqIJGBsU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6342C68E
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084391; cv=none; b=tvMTpOjA9R8DqWfCINEnbtvIPI8O+uM4FrMQWnJHFqfz+4M4bV0tf3FwryUoI9RL3YaJ+tGMP8nZ14itHV7VINWMu3e/SNRivhxCUL/qNwkPvtFX+9JFr03luRik946YvUdnjfuX8qAP4jYPr7i8pvytkTGFRY0/sgOHD/PRMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084391; c=relaxed/simple;
	bh=ywynNuzc+zkTLhxEIpdOYC08sdhsZQXngV4TURsgJRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GX/aGbMNQ/T3ryiouAR1DYrTe2mWRy+bSUjxW5rEYPEVagDNo6aKBgDMsvTGai2xvSoNiq87zLr7s+Skjb05mCBcTEWu7BKcsHlIpPXp70/iVztIELv6bgGFMx7ru9CRB+X5tU8kAO6Jc9uWrOHj0OXwDitI2gee+2Y6BdRM678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqIJGBsU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084389; x=1738620389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywynNuzc+zkTLhxEIpdOYC08sdhsZQXngV4TURsgJRA=;
  b=GqIJGBsU1sQWAM/b3HsuJb3EVVf3l5oybhhyMIzPvtS2EQ2D+kacOG8S
   e4/vyj3lDfuJAsENr5PkjlZPLtvqsdZSUCBiAsAxlR5DAi8T/bu87Kp/W
   oLxvfevj1CDb3ffT7hasA17EkeaVj9+la0wvS0g+Qahy+b/Kr3R5oWlm6
   Lq4onunT86iWupcdq+/psGzQQe2/PX4yte1x07lse08ndT8PHCIpdi3FX
   o7uplEQQeWyQEV/HEkSFYfn8QS4Oca2IWUqsgpTTK3/pD+w1Ovqb9dsnY
   hVRI6UdtlTgdkEw/mbwe8iFhwGJREd++5GJsXcQgPMR4XVKnLfeKtpLcS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869356"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869356"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815833"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2024-02-05
Date: Mon,  5 Feb 2024 00:06:02 +0200
Message-Id: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
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

Anjaneyulu (1):
  wifi: iwlwifi: Add support for PPAG cmd v5 and PPAG revision 3

Avraham Stern (1):
  iwlwifi: mvm: advertise support for protected ranging negotiation

Daniel Gabay (1):
  wifi: iwlwifi: mvm: use correct address 3 in A-MSDU

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: don't support reduced tx power on ack for new
    devices

Ilan Peer (1):
  wifi: iwlwifi: mvm: Declare support for secure LTF measurement

Johannes Berg (5):
  wifi: iwlwifi: pcie: don't allow hw-rfkill to stop device on gen2
  wifi: iwlwifi: mvm: const-ify chandef pointers
  wifi: iwlwifi: mvm: remove EHT code from mac80211.c
  wifi: iwlwifi: use system_unbound_wq for debug dump
  wifi: iwlwifi: mvm: remove one queue sync on BA session stop

Miri Korenblit (5):
  wifi: iwlwifi: add HONOR to PPAG approved list
  wifi: iwlwifi: adjust rx_phyinfo debugfs to MLO
  wifi: iwlwifi: read mac step from aux register
  wifi: iwlwifi: support EHT for WH
  wifi: iwlwifi: clear link_id in time_event

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  9 +--
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 40 +++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  7 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 25 +++++--
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  9 ++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  3 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  3 +
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 44 +++++++-----
 .../intel/iwlwifi/mvm/ftm-responder.c         |  6 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 27 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 10 +--
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 14 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 12 +---
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 69 ++++++++++++++++---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 14 ++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  9 +--
 25 files changed, 234 insertions(+), 96 deletions(-)

-- 
2.34.1


