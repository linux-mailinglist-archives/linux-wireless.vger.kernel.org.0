Return-Path: <linux-wireless+bounces-7581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0FB8C3EDA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4863428630A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027AB14A0A6;
	Mon, 13 May 2024 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJGTQjaX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8FD146A9F
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596043; cv=none; b=IK7oU+WCdfeZY8UlG2LN1EdhOM4+Yw9Wwr4k871VgHe5hryknwa5qpDfGAQ1NZpIGpnEd/H84Ae39ddWnkRbE0WiApYRwlCBeQN7bEkbXgZ0MLrEQlPnVwbZoNFZkb0eDHAwm1n+0bGWOqzorQSlOGOlGdbicVfFueHeQHgwD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596043; c=relaxed/simple;
	bh=q4WJxsOWT3aJ+hzdHuCuTRFHMQXbZfueobQN1tuM4Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8FcCMJCPViam3z3ww5wLVrRu/+xgYKw68dxfbVXX6FSAcDmJe8gavmrxp0Kh26YJkEBIS9DXNg6vJMzLdKIKoWtoVvRTJmm4VcISVwf4xe0yKX9cb7GV+PBFyHmbo2ABOX8ee6QgaqXx9BEQSvd8B1RU8TDBb3cbPGoA/R6PMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJGTQjaX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596042; x=1747132042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q4WJxsOWT3aJ+hzdHuCuTRFHMQXbZfueobQN1tuM4Xk=;
  b=MJGTQjaXS4nk2Df51CBqyN5Yur1iWP9CDPZD8eMM1am+Eggal1woRKGO
   O67jYtJb010zXmivi0oyzInQMuMlx0m2bcTmc1p35aG9l1mXhyhjvJtrg
   /GhE9RxsFVjQsNEjNFyYOfHbNSEyYiOhNPXS6M30B2EFO7AvsG7BYfsaR
   7wx02hO7sGlfRjUkwYY+XWoOCCJbrfCN0/NCdM4/gKdxAuGSRbW9RTkoI
   xrMIq6yGmcaxF9iObmLxYbQ6aR1INu3zoodTMm65dG+REvlSIcaY1axym
   wDLiHSmgSi5e+FJvXApyr6b6X76Ap9mV58/XibVKl2eFzoAtj18a3FP9A
   w==;
X-CSE-ConnectionGUID: 8Vr0bPs8T3CMfAecwtIZMw==
X-CSE-MsgGUID: FKdbikVjR5eqGOCxJfinmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22928646"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22928646"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:22 -0700
X-CSE-ConnectionGUID: fonezLBWQRS5nKAoY8Uv8A==
X-CSE-MsgGUID: NicYJtNaQaaXSvvgXkR4kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="53516394"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/7] wifi: iwlwifi: bugfixes for fixes tree 13-05-24
Date: Mon, 13 May 2024 13:27:07 +0300
Message-Id: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
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

Resending the fixes of the latest patchset as a fixes patchset,
these patches needs to go to the fixes tree.

Thanks,
Miri

Ayala Beker (1):
  wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option

Benjamin Berg (1):
  wifi: iwlwifi: mvm: remove stale STA link data during restart

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: don't read past the mfuart notifcation

Ilan Peer (1):
  wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill

Johannes Berg (1):
  wifi: iwlwifi: mvm: handle BA session teardown in RF-kill

Miri Korenblit (1):
  wifi: iwlwifi: mvm: check n_ssids before accessing the ssids

Yedidya Benshimol (1):
  wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd

 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 13 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 10 -----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 39 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 13 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 12 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 12 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +++
 7 files changed, 77 insertions(+), 27 deletions(-)

-- 
2.34.1


