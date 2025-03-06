Return-Path: <linux-wireless+bounces-19875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCBAA5482A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EECC16AFA0
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B72040BE;
	Thu,  6 Mar 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhJPzEZH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6311FCCFA
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257819; cv=none; b=JWYfY9RgaWjo5vQN9ob3NLyOTRlQ56tNwevpY8G1YhJLDp5owjnQvK25vaGoryAaN9GX/91srIhBWuvtj5OpUhZ2MWdMKRtgPp1uZzGjCLe9lb0e/EDJvKFfgZCl3WK1tzrMNIeL4FQ6ADNKgcPGhR/PHTgfAAv/Po9zVZfmVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257819; c=relaxed/simple;
	bh=zFMCxF9FGKVXDgct+HlrPb5Gz9sXOilfo2LBrDi7Cpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CDiN4A64XsBr9X8TyPRCBrjGCr8QaJycRypcHgS5/y8nCMXM8ctIYgoR5swHCkzZDV5Tt+09FC/wSG/sZhG67FqneDmMhqm+E+W2ajvNKRsQX3Tkwn4nrBbXuRV++qen8u1N1QsIDvgwRhOrUvhRfCTli4oFRlTj65xp5KPUKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhJPzEZH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257819; x=1772793819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zFMCxF9FGKVXDgct+HlrPb5Gz9sXOilfo2LBrDi7Cpw=;
  b=bhJPzEZHskvnqBWggjYDKfkb0NruNkRoMq9zl+X52fc3PpmtnbcaN04Q
   cZDJX1YJG6qPuZYNaZ0FidM+HL7FmbNiHl1PN20YO7txnSZxyOxDmTFvm
   PAHo3/Ub2OZnju0vbnfkRHSfdGB3E446iWlPcckBjd0M6uh3H7dnjOI4E
   ivdiIlXtYFRyeOkKOF0qS3RzXHZL3nmS2EY9eoZffVgm91HWgaRb7/oDa
   L81QIuwIxgJkaNrW5rO80JIiutWEGz3ZKdo64NbHAv039KFzomVSyjj22
   iSi6yh6wW9IaLJ1jwK07Tqg8QDIgP9Lm00wiuZ9gU6nAU8ULKhDLUauKU
   w==;
X-CSE-ConnectionGUID: 7F/EE8mNQRGJs/b4sFTQGw==
X-CSE-MsgGUID: gaDpTe8+Tp+nL8c0oO8JKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844463"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844463"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:38 -0800
X-CSE-ConnectionGUID: pnLGACYsSIGpVQqR3a/PiA==
X-CSE-MsgGUID: srSlZkTCQEKNZ4hwPIQcdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797694"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/15] wifi: mac80211/cfg80211: updates - 2025-03-06
Date: Thu,  6 Mar 2025 12:43:11 +0200
Message-Id: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
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

A few features, cleanups and bugfixes from our internal tree.

Thanks,
Miri
---

Anjaneyulu (1):
  wifi: cfg80211: allow AP operations in 20 MHz configuration

Avraham Stern (1):
  wifi: mac80211: allow 320 MHz FTM measurements

Ilan Peer (3):
  wifi: mac80211_hwsim: Fix MLD address translation
  wifi: cfg80211: Update the link address when a link is added
  wifi: mac80211: Notify cfg80211 about added link addresses

Johannes Berg (10):
  wifi: cfg80211: move link reconfig parameters into a struct
  wifi: cfg80211: allow setting extended MLD capa/ops
  wifi: mac80211: mlme: support extended MLD capa/ops in assoc
  wifi: mac80211: fix U-APSD check in ML reconfiguration
  wifi: cfg80211: improve supported_selector documentation
  wifi: mac80211: fix userspace_selectors corruption
  wifi: mac80211: fix warning on disconnect during failed ML reconf
  wifi: mac80211: fix ML reconf reset in disconnect
  wifi: mac80211: don't include MLE in ML reconf per-STA profile
  wifi: mac80211: set WMM in ML reconfiguration

 drivers/net/wireless/virtual/mac80211_hwsim.c |  14 ++-
 include/net/cfg80211.h                        |  30 ++++-
 include/uapi/linux/nl80211.h                  |  68 ++++++-----
 net/mac80211/cfg.c                            |   7 +-
 net/mac80211/ieee80211_i.h                    |   9 +-
 net/mac80211/mlme.c                           | 110 +++++++++++-------
 net/wireless/chan.c                           |   8 +-
 net/wireless/core.c                           |   3 +-
 net/wireless/core.h                           |   6 +-
 net/wireless/mlme.c                           |  17 +--
 net/wireless/nl80211.c                        |  40 ++++---
 net/wireless/rdev-ops.h                       |  10 +-
 net/wireless/reg.c                            |   4 +-
 net/wireless/trace.h                          |  17 +--
 14 files changed, 219 insertions(+), 124 deletions(-)

-- 
2.34.1


