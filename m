Return-Path: <linux-wireless+bounces-8551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AE28FCA2B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4516AB241A4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5F19306A;
	Wed,  5 Jun 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZonhNugB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B5191499
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586246; cv=none; b=aQexaf8oqm9151zTIIy/f1P/SKqzmQZLlwLHWSJCeJYS5LHR6EOu6lKhU6x4kysMt3y+TPyBq1FY8WlBCfQ9l4TZVmr78HkmMueiCenVNf8raa1f7eTYO6qgKjPPtD9uU91Q6FxhTWz9lIcOrxdjd0gtsVSiGizkidj7KKz6V3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586246; c=relaxed/simple;
	bh=BGVSaiQuMys+6qvc3wPzQu4qtDwktxTcM8c3aLjbaes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H+uDSzX7LlsweIxF52ErLAZ6Wuj925YfPIie5LNsbWgmVPdwbXvIXL007+fn5qyQUtapAxh1fkjZ0YMqaPPJPEq0p5Txpj0wVUHRlpfWOeIeJ8yEmV2KzXLwJppfhGwSexfnGnz+GOlmE7UE3PwJDibckl4fSYs10UmPTuYWeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZonhNugB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717586245; x=1749122245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BGVSaiQuMys+6qvc3wPzQu4qtDwktxTcM8c3aLjbaes=;
  b=ZonhNugBb3JghFR0BJYpvwNnQ5jBLSx6NnfqbFjpmJb1qC+CImD3MWjD
   RXkqf8xDnt0RObxvz2bU40mULhCTBTajTDmEYrM50lej8DarRbq1PmCWI
   DYQMFft6hxDnqU1DNhWW9ObVeDE20gH57ib30hafzn003cSRQVEAJ64Ia
   KdQr6Y2Oq3xM7azZ9O+U+O2x1yXXpL5MH3K+KESgCVpw+R1MlRrLI0v8n
   p5/nXnvy/50eFhUvjea2FAERzRx/gSK5qLqwqAV3rQhx9w3gKax5iwfWv
   GyPlTcoNyuvlUPiW7/ei253w/urbTsqRwcZ2we69NNtFnBeLXTu1HOAcJ
   g==;
X-CSE-ConnectionGUID: fz7Ges2PTc+NQbT8e0shew==
X-CSE-MsgGUID: IlVH03p/SQ+EvM19LvTZEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36718034"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="36718034"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:47 -0700
X-CSE-ConnectionGUID: 2B4ng8vqTqiMU/LlsrKwSg==
X-CSE-MsgGUID: 9A7ymL9CTni9sKGAi5xwFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37433734"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/5] wifi: iwlwifi: updates - 2024-06-05
Date: Wed,  5 Jun 2024 14:07:35 +0300
Message-Id: <20240605110740.2046411-1-miriam.rachel.korenblit@intel.com>
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

Ayala Beker (1):
  wifi: iwlwifi: scan: correctly check if PSC listen period is needed

Golan Ben Ami (1):
  wifi: iwlwifi: remove AX101, AX201 and AX203 support from  LNL

Ilan Peer (1):
  wifi: iwlwifi: mvm: Add support for interface usage notification

Johannes Berg (1):
  wifi: iwlwifi: mvm: separate non-BSS/ROC EMLSR blocking

Shaul Triebitz (1):
  wifi: iwlwifi: mvm: use ROC for P2P device activities

 .../intel/iwlwifi/fw/api/time-event.h         |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  49 ++++-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  15 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  22 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 182 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  38 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  32 ++-
 10 files changed, 257 insertions(+), 90 deletions(-)

-- 
2.34.1


