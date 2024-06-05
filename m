Return-Path: <linux-wireless+bounces-8535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9568FC9A6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25571F2202D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126BE18C34B;
	Wed,  5 Jun 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBU6+gGM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710E146017
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585517; cv=none; b=bi7iyV1Db8sU3qLp51gwp32zA7olkJaHNpFYZepKcSDEDa0mrhQQlmW814ilzyKttaLukmwWEUxo7JLYlcsj52ChfkRLbEWocehM1jiUH/oTvmnKC9fJUDRL7T/gpfQ/tIAX9ZEmPs1cVeqJPA6DVVr39FTkJaHDoXaju52l8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585517; c=relaxed/simple;
	bh=a5jjgFbwm/ahf4cyFKQYHOFxShNcFwMYxA2DFu66oM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rub49ZQsm1hMdx+OphyjTkN5TrlxlmLLHAo1AApAH8xlftMSBLAEze3gWV+ITar1J1qRPjQIhNI2Mna8QSXaf2ycxFJIMzMj6kGZKEMr35UAaZ/oxnXqdD4TArcsHDNWMqvn0zpd5wu2BKZJKTmKYsWPuVyTe+KJ9n6h9JTwu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBU6+gGM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585515; x=1749121515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a5jjgFbwm/ahf4cyFKQYHOFxShNcFwMYxA2DFu66oM4=;
  b=WBU6+gGMZONwVyoEO/cUWsl2fVnbJh1TnsE9XcIUovzlmJbsHhI9khNS
   MmEnCL/lbRJExR+ru4wflJ/eBfPwvwEi0Rc87gvuE8IB1UGQMItzg0u0P
   UuIFf1dVk1i15JbD7Lvv1HMyO/7u5FqO0K2KC9U5atKBuh4DjS5CQ0W05
   R0NycenbTFmcUhqI9ztjuu6LUpZ/6uO3jPu4WKSrJ70EjMwiKbOVzUPCA
   rXoAZaqco0KYsQPQDKyhT8/0Ie18hUsjHj+/XncqRrN9NJ/LtcpoxVIRk
   JwQ1Dvn2mSk+zb59EZJpzreqar3zCEDZJ7G2PIBT6AzYemm3DZ1vmLq7W
   g==;
X-CSE-ConnectionGUID: /1JJgGy1RaadDeK4UCh8zA==
X-CSE-MsgGUID: S2xVX74BQKScQjDMPNixOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402168"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402168"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:15 -0700
X-CSE-ConnectionGUID: IUEBeHaVQ4+uOIaxoOKBqA==
X-CSE-MsgGUID: asO0KYiWTNG9+eNLxhofug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997305"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/11]  wifi: iwlwifi: updates - 2024-06-05
Date: Wed,  5 Jun 2024 14:04:56 +0300
Message-Id: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.11. It contains
a few features, bugfixes and cleanups.

Thanks,
Miri

Johannes Berg (4):
  wifi: iwlwifi: mvm: fix DTIM skip powersave config
  wifi: iwlwifi: move TXQ bytecount limit to queue code
  wifi: iwlwifi: api: fix includes in debug.h
  wifi: iwlwifi: pcie: integrate TX queue code

Miri Korenblit (4):
  wifi: iwlwifi: mvm: remove unneeded debugfs entries
  wifi: iwlwifi: bump minimum API version in BZ/SC to 90
  wifi: iwlwifi: mvm: fix re-enabling EMLSR
  wifi: iwlwifi: bump min API version for Qu/So devices

Shaul Triebitz (2):
  wifi: iwlwifi: mvm: unlock mvm mutex
  wifi: iwlwifi: mvm: fix ROC version check

Yedidya Benshimol (1):
  wifi: iwlwifi: remove struct iwl_trans_ops

 drivers/net/wireless/intel/iwlwifi/Makefile   |    1 -
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |    4 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |    2 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  |   69 +-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |    6 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |    6 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |    2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  452 +++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  637 +-----
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  221 --
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |    6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |   64 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   27 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |    2 +
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |    2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |    4 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  254 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |    9 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   11 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  273 ++-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 1130 +++++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  999 ++++++++-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 1900 -----------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  191 --
 29 files changed, 2966 insertions(+), 3323 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.h

-- 
2.34.1


