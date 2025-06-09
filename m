Return-Path: <linux-wireless+bounces-23875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DC9AD25AC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D83316DE78
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E05B1F4608;
	Mon,  9 Jun 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQxLTlWC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE8155A25
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494147; cv=none; b=Qtq1JYjIZTNJGgbt/X7Xoct9zLVqtFOfVPW3U2N7qe1dQP5eLDzBM7GBqo+sTfowGdRkxjH7tddWLXdJbQfKNCw1dSjNddGjI0QoHzMTtQBYZdhqw+JkMoGvlRtdX7un2gaEgS4f+4VvAG1k/igEmtGE0T+JsGj1VoHMjiNus90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494147; c=relaxed/simple;
	bh=Em7Pqnwd5Ix50ogFHbXUjopawzMfPJLnGdbE25tKDRc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oKmhPlT1l0y2EWLMYbgd1cq9owJS6+wWqPVLzp8twPJ3TpJVs5hbs5tjPUcLCp9PUIEzYppno0yqzR5Q3sHDP2i66gINi8Spi7CBhHKg5R8ClAySXZBqDSg0gquI7xb6nMk/woqkVRVLDH2nNmPO4b9SBqq62E038qejlX8qjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQxLTlWC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494144; x=1781030144;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Em7Pqnwd5Ix50ogFHbXUjopawzMfPJLnGdbE25tKDRc=;
  b=YQxLTlWCRIWeLZS/8lU0Izi5+wlRkM3Lt0oyEB8gVl17eCCfOY2do+wU
   ODpvnPZBugAtowFbbxnF8eoY3QnIFvJSQWXQBEZtVAH1QgULGJ34zRSuO
   KzlO4y9oiEMWLGTaoflpNOVH6JCULSIFz7MosWx9HQ2IgSIYz/C3mjc4S
   bDBU/3rLuFd2KmPOd5pxrt4oU3cKVRQnHg/hIeFx71MMCGlg81USEcUt1
   C6t15xrkFe6+1nBrTADbNp/dK1TSBWXl1TmWT5Wi5WdGluelDnOrIFhiE
   r2njBmXVoVRYEy5y9cuHQRWa3THkLsISIInbOXOMhqKDpOK8G7WbAeXe0
   A==;
X-CSE-ConnectionGUID: ME9X9zCPR1+U4+Dc6Fejxw==
X-CSE-MsgGUID: hw6maYLMQAC6SRpxdi6LFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249741"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249741"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:44 -0700
X-CSE-ConnectionGUID: 9Qvi5sewTEeUYDoNl7GEOA==
X-CSE-MsgGUID: bpg/FwmAS5W1SWNVUyw4pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732440"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/15] wifi: cfg80211/mac80211: updates - 2025-06-09
Date: Mon,  9 Jun 2025 21:35:12 +0300
Message-Id: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
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

A few features, fixes and cleanups from our internal tree.

Thanks,
Miri
---

Benjamin Berg (3):
  wifi: cfg80211: only verify part of Extended MLD Capabilities
  wifi: cfg80211: add a flag for the first part of a scan
  wifi: mac80211: copy first_part into HW scan

Johannes Berg (7):
  wifi: mac80211: remove spurious blank line
  wifi: mac80211: fix deactivated link CSA
  wifi: cfg80211: hide scan internals
  wifi: nl80211: make nl80211_check_scan_flags() type safe
  wifi: mac80211: remove DISALLOW_PUNCTURING_5GHZ code
  wifi: mac80211: send extended MLD capa/ops if AP has it
  wifi: mac80211: don't complete management TX on SAE commit

Miri Korenblit (2):
  wifi: mac80211: avoid weird state in error path
  wifi: mac80211: verify state before connection

Pagadala Yesu Anjaneyulu (1):
  wifi: mac80211: Fix uninitialized variable with __free() in
    ieee80211_ml_epcs()

Somashekhar Puttagangaiah (2):
  wifi: mac80211: add mandatory bitrate support for 6 GHz
  wifi: cfg80211/mac80211: implement dot11ExtendedRegInfoSupport

 include/linux/ieee80211.h  |  43 ++++++--
 include/net/cfg80211.h     |  12 +--
 include/net/mac80211.h     |   7 +-
 net/mac80211/debugfs.c     |   3 +-
 net/mac80211/ieee80211_i.h |   2 +
 net/mac80211/link.c        |   9 +-
 net/mac80211/mlme.c        | 150 ++++++++++++++++++++++-----
 net/mac80211/scan.c        |   3 +-
 net/mac80211/sta_info.c    |   3 +-
 net/mac80211/util.c        |  17 ++++
 net/wireless/core.c        |   4 +-
 net/wireless/core.h        |  11 +-
 net/wireless/mlme.c        |  21 +++-
 net/wireless/nl80211.c     | 144 +++++++++++++-------------
 net/wireless/rdev-ops.h    |   6 +-
 net/wireless/scan.c        | 204 ++++++++++++++++++++-----------------
 net/wireless/sme.c         |  40 ++++----
 net/wireless/trace.h       |  23 +++--
 18 files changed, 453 insertions(+), 249 deletions(-)

-- 
2.34.1


