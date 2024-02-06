Return-Path: <linux-wireless+bounces-3222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BF984B8E9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142EEB2F9B0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96209133422;
	Tue,  6 Feb 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gap/Ia+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EB133420
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231266; cv=none; b=d/vLz7GeCMNRDQWMTU/u9QMeFOi1pZn8y64ov+Lq2R7yz69DFxa1aQX4WBq9WImBk4ZCcEtaNPWmw+exv3hQFYHgem/9a8ziW4eqquXnVaUBVnsP1/A8Qo7sGibXnHNH5HukFZW2axcDRRr9dz8eFif3rH5RMgQHTXK13poESbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231266; c=relaxed/simple;
	bh=6BrtTIYLDqoYtvrEKhlZ/7B82WT3RiJLX0W7lhqR14A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L0iWerc5+2EiAJpKghTmo5s8LoF6ENp3a8etSPh1u/pAGuRm0mcflST7RFyCuxcA+YNNI9EceM1z3NKePJ+qD9wkdY629vjOSEKjMP0rjugTQ2/cCSDKOB+q0o/KNfuHu/SdYW6mMKxkDnue4rgPLeyilDqdpntJLGA8YBc0fJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gap/Ia+g; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707231264; x=1738767264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6BrtTIYLDqoYtvrEKhlZ/7B82WT3RiJLX0W7lhqR14A=;
  b=Gap/Ia+gqKA6UmXzy2Yg0RiOh9ZxjDc1auPKzhj9ZhUqKvIEMRtf2JXA
   XE6bx2FpXK1IcooaSwcBoYkaC8qmYDbHGIJvEFg70zbWH31mX/Raa25sH
   RKFR5NrAz1NKOpXwu/jEwvkHrf1IbpAVc2syWcRBHKQl/xq1H2QDrgrkt
   tJDehU31bD6fXsxl2chadSKGj4dH4UfqCpevj1nkcovijk2TNFZWo/G1H
   g6QkCf3OzQ8WGLVzW8ua2cLVgKxxSMVEyEBME5SrPJoiuNOWqnmoUbSSY
   /d6sJH44kcY7S+4Gm+dBHuTfEJHHwvQ8fl4nl6X5ppHeJH869VS6Li6pj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="917775"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="917775"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824197882"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824197882"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] cfg80211/mac80211 patches from our internal tree 2024-02-06
Date: Tue,  6 Feb 2024 16:54:03 +0200
Message-Id: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
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

A bunch of patches from our internal tree with mac80211 and
cfg80211 changes. It's the usual developement, adding a few small
features.

Thanks,
Miri

Andrei Otcheretianski (1):
  wifi: mac80211_hwsim: Add 160MHz bw range to regdom_custom_04

Daniel Amosi (1):
  wifi: mac80211: remove unnecessary chanreq compat check

Johannes Berg (3):
  wifi: cfg80211: rename UHB to 6 GHz
  wifi: cfg80211: optionally support monitor on disabled channels
  wifi: mac80211: drop injection on disabled-chan monitor

Miri Korenblit (1):
  wifi: mac80211:  make associated BSS pointer visible to the driver

Shaul Triebitz (2):
  wifi: nl80211: add WOWLAN_TRIG_UNPROTECTED_DEAUTH_DISASSOC
  wifi: cfg80211: report unprotected deauth/disassoc in wowlan

 drivers/net/wireless/virtual/mac80211_hwsim.c |  6 ++-
 include/net/cfg80211.h                        | 19 ++++++---
 include/net/mac80211.h                        |  3 ++
 include/uapi/linux/nl80211.h                  | 38 +++++++++++++-----
 net/mac80211/chan.c                           |  3 --
 net/mac80211/mlme.c                           | 18 ++++-----
 net/mac80211/tx.c                             | 10 ++++-
 net/wireless/chan.c                           | 26 ++++++++----
 net/wireless/core.h                           |  5 ++-
 net/wireless/nl80211.c                        | 40 +++++++++++++------
 net/wireless/reg.c                            | 10 ++---
 net/wireless/scan.c                           |  8 ++--
 12 files changed, 124 insertions(+), 62 deletions(-)

-- 
2.34.1


