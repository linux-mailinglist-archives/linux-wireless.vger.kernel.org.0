Return-Path: <linux-wireless+bounces-16950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE579FF2D1
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09EA3A2BE3
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC84610C;
	Wed,  1 Jan 2025 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M69dAE2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA24C92
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707954; cv=none; b=Efk7kWzCA/K4Q03COvqAqVekHwuq6idAyWaTejqBb3LGhD5xjhI5i/VXbtnymf10n71pRpLvw4vByQnvphwwctUFE41DId1tfsY1u0E+d8M1JCJbzaH3OjomklmUSqkIS7Gj1NiYNim5942A4Fq1Q+s2tHz7Uvk4AJnFMnnxMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707954; c=relaxed/simple;
	bh=xe1uCrEvGadQjEe4YXpb5rJBQgwtEErAsrmaheCuMgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R79QB05pjSwiRikXJZb4GurgPSDbanozOL0EZH0KNX1LaLkrWsZZccDhrU+fDakFJ5ETjyE5UOxPMcbu60YZfjPu5qORQJn9y5r1ZncL5eGDLt36+rBZ89Da/ZVsAHR/ZMrrEyG2W/Fb7/8ADo5yemuz1SW4LMIg0beBVv3bDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M69dAE2K; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707953; x=1767243953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xe1uCrEvGadQjEe4YXpb5rJBQgwtEErAsrmaheCuMgw=;
  b=M69dAE2KizFbXIA7bIP2SLz5HTxohZosJuZ84WtNdhq4rQgNDTSh1l5c
   ZJb+Rr/AJiwMW6PMm/DFfpwKWJk014Hm86AlNlBymNU16G8H8kFDwakDe
   CCbLDt6rhAGANn7cnGd7RTK27mXLdGe8R2/ZYzYqnGX+7kwXJ3LWVWDQz
   Ihz9BhZjYbWxj56Euop4wcqDIi7Uww85qBVUJpHy9p4msj2Um2zqMaPma
   I+Aif15NZIS/KJ5chsawbshg2GTr7UYb8INJYmiLEe4ca3yufrLOEdn9u
   fZWJlDOTvo6/MFy7lauKxidwgxK7VPadBpMawtCiKhLobBCmb+nnOogYo
   Q==;
X-CSE-ConnectionGUID: o6n4C1QdTau6YLAeU9eIbw==
X-CSE-MsgGUID: 44TaNaC4QNGMuhiPoHluyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194395"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194395"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:53 -0800
X-CSE-ConnectionGUID: f3Kqp3p9Q9quB6GC7RqIGA==
X-CSE-MsgGUID: NuhCt3JJTFKKRQquU5zZUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618855"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/19] [RESEND] wifi: mac80211: updates - 30-12-24
Date: Wed,  1 Jan 2025 07:05:20 +0200
Message-Id: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
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

Resending this series with a different order.

Thanks,
Miri
---

Benjamin Berg (11):
  wifi: mac80211: Remove unused basic_rates variable
  wifi: mac80211: fix typo in HE MCS check
  wifi: mac80211: log link information in ieee80211_determine_chan_mode
  wifi: mac80211: add HT and VHT basic set verification
  wifi: mac80211: skip all known membership selectors
  wifi: mac80211: parse BSS selectors and unknown rates
  wifi: nl80211: permit userspace to pass supported selectors
  wifi: mac80211: verify BSS membership selectors and basic rates
  wifi: mac80211: also verify requirements in EXT_SUPP_RATES
  wifi: mac80211: tests: add utility to create sdata skeleton
  wifi: mac80211: tests: add tests for ieee80211_determine_chan_mode

Emmanuel Grumbach (2):
  wifi: mac80211: remove an unneeded check in Rx
  wifi: mac80211: improve stop/wake queue tracing

Johannes Berg (5):
  wifi: mac80211: add some support for RX OMI power saving
  wifi: mac80211: reject per-band vendor elements with MLO
  wifi: mac80211: mlme: improve messages from config_bw()
  wifi: cfg80211: scan: skip duplicate RNR entries
  wifi: cfg80211: check extended MLD capa/ops in assoc

Miri Korenblit (1):
  wifi: mac80211: clarify key idx documententaion

 include/linux/ieee80211.h      |  48 ++++-
 include/net/cfg80211.h         |  12 ++
 include/net/mac80211.h         |  48 ++++-
 include/uapi/linux/nl80211.h   |   9 +
 net/mac80211/chan.c            |   7 +
 net/mac80211/debug.h           |  10 +-
 net/mac80211/he.c              | 119 ++++++++++-
 net/mac80211/ieee80211_i.h     |  11 +
 net/mac80211/main.c            |   5 +
 net/mac80211/mesh_plink.c      |   5 +-
 net/mac80211/mlme.c            | 379 +++++++++++++++++++++++++--------
 net/mac80211/rx.c              |   3 +-
 net/mac80211/sta_info.c        |  18 ++
 net/mac80211/sta_info.h        |   7 +
 net/mac80211/tests/Makefile    |   2 +-
 net/mac80211/tests/chan-mode.c | 245 +++++++++++++++++++++
 net/mac80211/tests/util.c      | 309 +++++++++++++++++++++++++++
 net/mac80211/tests/util.h      |  36 ++++
 net/mac80211/trace.h           | 120 ++++++++++-
 net/mac80211/util.c            |  10 +-
 net/mac80211/vht.c             |  33 ++-
 net/wireless/mlme.c            |   7 +
 net/wireless/nl80211.c         |  32 +++
 net/wireless/scan.c            |  13 +-
 24 files changed, 1375 insertions(+), 113 deletions(-)
 create mode 100644 net/mac80211/tests/chan-mode.c
 create mode 100644 net/mac80211/tests/util.c
 create mode 100644 net/mac80211/tests/util.h

-- 
2.34.1


