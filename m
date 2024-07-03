Return-Path: <linux-wireless+bounces-9882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EC0924FDF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 05:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA31F22431
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 03:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A7138E;
	Wed,  3 Jul 2024 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5sqT3VX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1522318
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978209; cv=none; b=LmfO4UrHqx+6Bp1YSgCpzIDS6y27AF2jiSR3q5s1NY4ZpkzbuAFybR9XZBQOCFxnSWIgBpGen3jBFmoZl8132WMFFF/G5auJD4I3D5cWievASsPnquj3YWBfdQRsCACRgsDBKi7Sf6mrrgUYGY41gmC7dvDqVMmAuap+VZyVAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978209; c=relaxed/simple;
	bh=BezaXiQpa3NdJg/JXQXhGoVWm5LPRBMNB73iP579iMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g0hJVxbhNcC4I/JJ8YHkh5nVETVomTkRdUxM76y0Nyf0tJTMj0qUCGiqhmCBiF7FZ9aYj32B5WZGA6E8FCzBEblwSopH4phZy4fZlfvLp1qCy/oJbt/bhbi01rICk/It7PTHxCxF+L2oIUDY3Wy1biGpFToSjP/kKr6eM55XIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5sqT3VX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719978207; x=1751514207;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BezaXiQpa3NdJg/JXQXhGoVWm5LPRBMNB73iP579iMU=;
  b=H5sqT3VX+7MnQFQP+oo6sjlbrj5HVKR55v/b6viYZaDwVpAhmMfB2qH6
   mtMsUYFieCuCtlwU4B0fO2D03FamtNw8+YQKjotPf+b8YRXX9FFTAMF8T
   ZOg7xdg35YDhtYmPlBh+f3GQYLjuhT0j59tVzAEW689aSatWCPTel64n5
   WPceKm38O0Uca47DAeoavQkxq86pfCoJA4ATYBhKe7KKThWlI4kpyrDvL
   GRm13h6gFCQi/uLOVdsFVcN6Xd2CiV5g3tcTopueHBdkjDEHY4bEgYdNB
   DugSYyRwt084hYey+5/F+6s5EoYzc5jctcnQUic0fHoSKn2B6sr44qJZ5
   Q==;
X-CSE-ConnectionGUID: aNSRAKN7QYesEvKzFmggRw==
X-CSE-MsgGUID: G/ZFOA8ZQRC+WfH/4LEiaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17304035"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17304035"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:27 -0700
X-CSE-ConnectionGUID: K24/yB30QwWDR48rwUuXsw==
X-CSE-MsgGUID: 8mUg9KFUSyyZ/cDxgpoNog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51291055"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/5] wifi: iwlwifi: fixes - 03-07-2024
Date: Wed,  3 Jul 2024 06:43:12 +0300
Message-Id: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
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

A few bugfixes from our tree.

Thanks,
Miri

Daniel Gabay (1):
  wifi: iwlwifi: properly set WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK

Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: don't wake up rx_sync_waitq upon RFKILL
  wifi: iwlwifi: mvm: don't send an ROC command with max_delay = 0

Johannes Berg (1):
  wifi: iwlwifi: mvm: avoid link lookup in statistics

Miri Korenblit (1):
  wifi: iwlwifi: mvm: avoid NULL dereference

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c   | 14 +++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c    |  8 +++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c     | 15 +++++++--------
 .../net/wireless/intel/iwlwifi/mvm/time-event.c | 17 ++++++++++++++---
 4 files changed, 31 insertions(+), 23 deletions(-)

-- 
2.34.1


