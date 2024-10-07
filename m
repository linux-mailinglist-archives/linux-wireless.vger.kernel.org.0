Return-Path: <linux-wireless+bounces-13585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79DB992AEA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0AC7283F67
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B31418BB90;
	Mon,  7 Oct 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKjQffKC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9893D18B483
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302474; cv=none; b=tWL1ISCpbgpO1PAII9CkBlRRjyCVD9n79Y9yAXDeP16gc5ybxn+6gKItRc07yJ2dhLzUUJu39epO90pu44JFyuLucIoBdMl9n2d+qmBiAAqarHOjBTBUdK7S6a+71mxQ/xKTxnYzb7XKXlnHoNVNtm8b260JmQJaDzHz6awOj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302474; c=relaxed/simple;
	bh=viUnxLyl0O2MJt/FEclUo93I6+pFiBiFu0N3NlOF0NE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EF52r2GTO4Jt6CDZ1cq/qDpn96/rvHMQE3Gy4Dy+gKBFw7zN7ZTONnro/Pr/uE/J56ND2SfF3kgi1rnm2lCajGI57lOHjGkyVZCT4WnppCfh4X3CfoYqe1L9UONULI7EYicMSsc5gG3OLcjKeKlIS3QYbRhl+TeoyE1Kx5paDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKjQffKC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302472; x=1759838472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=viUnxLyl0O2MJt/FEclUo93I6+pFiBiFu0N3NlOF0NE=;
  b=LKjQffKCwsVVEPp96qPyjvy9K9Oy9vjcADSzq+vru1ZZ+Vc1nrtg6JQL
   JghC3H6nWwdUEmJBvoD7QJLlCl9WnjrJUAQ6XGyXTAt2zNI38PsvwMaMw
   yjHOEBsTqy/LEaHD93+NQtjjcgh66DJjmtJ5zUemirWbh565rP7jbzNXA
   65YaCWBiEc23pw38v4poIHpYYYLmNbUo2Yoh4aPS8o+ctm2sNJcnXlA8P
   gw5NpzcX24UJG3PdVwHtuvVBlx8i4OfdNPO7p7K4vrFyDp1HYVpXuSSdC
   +6MxwKCxhjOBNuLZk6n/phe+fXgouxElYHTa7gk0L42Fn8mZY3/B0uy86
   w==;
X-CSE-ConnectionGUID: PFRC8q5oTKC4wkR4qhfPRA==
X-CSE-MsgGUID: 3Y6v9glkTKm2rK6jqOKIzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099362"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099362"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:12 -0700
X-CSE-ConnectionGUID: 7uPEokn4QZ21i8d0RftMcw==
X-CSE-MsgGUID: 7sEMtx8YRm+QdHeastHsBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019216"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/14] mac80211/cfg80211 updates 07-10-2024
Date: Mon,  7 Oct 2024 15:00:44 +0300
Message-Id: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
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
some features and cleanups from our internal tree.

Thanks,
Miri

Emmanuel Grumbach (5):
  wifi: mac80211: make bss_param_ch_cnt available for the low level driver
  wifi: mac80211: remove unneeded parameters
  wifi: mac80211: ieee80211_recalc_txpower receives a link
  wifi: mac80211: __ieee80211_recalc_txpower receives a link
  wifi: mac80211: update the right link for tx power

Ilan Peer (1):
  wifi: mac80211: Add support to indicate that a new interface is to be added

Johannes Berg (5):
  wifi: cfg80211: disallow SMPS in AP mode
  wifi: mac80211: allow rate_control_rate_init() for links
  wifi: mac80211: call rate_control_rate_update() for link STA
  wifi: mac80211: chan: calculate min_def also for client mode
  wifi: mac80211: expose ieee80211_chan_width_to_rx_bw() to drivers

Miri Korenblit (3):
  wifi: mac80211: rename IEEE80211_CHANCTX_CHANGE_MIN_WIDTH
  wifi: mac80211: parse A-MSDU len from EHT capabilities
  wifi: mac80211: add an option to fake ieee80211_connection_loss

 drivers/net/wireless/ath/ath10k/mac.c         |   5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c         |   5 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   9 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   5 +-
 .../net/wireless/quantenna/qtnfmac/commands.c |   2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |   6 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   6 +-
 drivers/net/wireless/ti/wlcore/main.c         |   5 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   8 +-
 include/net/cfg80211.h                        |   2 -
 include/net/mac80211.h                        |  66 +++++++--
 net/mac80211/cfg.c                            | 129 ++++++++++++------
 net/mac80211/chan.c                           |  34 +++--
 net/mac80211/driver-ops.c                     |  15 +-
 net/mac80211/driver-ops.h                     |  18 ++-
 net/mac80211/eht.c                            |  21 ++-
 net/mac80211/ibss.c                           |   7 +-
 net/mac80211/ieee80211_i.h                    |   8 +-
 net/mac80211/iface.c                          |  29 ++--
 net/mac80211/link.c                           |   3 +
 net/mac80211/mesh_plink.c                     |   5 +-
 net/mac80211/mlme.c                           | 118 ++++++++++++++--
 net/mac80211/ocb.c                            |   4 +-
 net/mac80211/rate.c                           |  32 ++++-
 net/mac80211/rate.h                           |   8 +-
 net/mac80211/rx.c                             |   4 +-
 net/mac80211/tdls.c                           |   3 +-
 net/mac80211/trace.h                          |  34 ++++-
 net/mac80211/vht.c                            |  25 +---
 net/wireless/nl80211.c                        |  30 +---
 35 files changed, 451 insertions(+), 215 deletions(-)

-- 
2.34.1


