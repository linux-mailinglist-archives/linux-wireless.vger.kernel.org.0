Return-Path: <linux-wireless+bounces-28802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43017C480E8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3EC4A7889
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590A279DCA;
	Mon, 10 Nov 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuXjnsil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D567279798
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790939; cv=none; b=CH0MbEV/I49S9vrzu4bLh/LuFWZx0LdAFNsVjW7k1IGdMNIwxr4ZybP3wy9mffDLIZlOyNzGlEXZnaSrIt2tFHLcnhW6qwdg1uUiwRpFNT3kjE/L++d1y+5MffqVsIfyAvkCkQyP1FmMTFwA8LHF6YbQCyRSzmdFxExdF64Bp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790939; c=relaxed/simple;
	bh=3sLicHUtp3P2lWJbljl0wSiU57coMcsvJSbl9KCOvMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EC3DKXw/ipuo1auwsbF/bfIQ+ag52VqJyx6lN9k9e5YiUkK9qBvfRbEn94nZefT2S6mU6guT8Kh7qk2yLgaw978fYVx/UDKRTpICfRVJaY+S0gwb/kryWo4GOerOjwna4kzLAfhyDg3R9h5HTNAYH1hEw+H+aMSylPRERrVcfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuXjnsil; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762790938; x=1794326938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3sLicHUtp3P2lWJbljl0wSiU57coMcsvJSbl9KCOvMU=;
  b=RuXjnsilFoQpMcMIu2S3bXbPt6eABocFAekTWTYElmBJkRL5eR5IKSBp
   k2sFSXPykdSBb1ZsSrM8z8Td0XcN5rFvXl91FxVLOKYf9L4WUn7WU9PK3
   FhftJ6CIlqAGeh1Apf9WXMDIlm1JKd/3g3Ax9M9LEq7b/4nBsDM5+0Xn3
   S6mrA9L2sxuP/nsslSZxkufUL9llbq2Z4/+f9vxpJ9vJFbqbOgTu26uT0
   x31kvNdCo/GJ3AHqfdFqh/MMlL78Jh6iNQ3H99Ht2xHtw01czxoroh0Kr
   keCcxQRDrbGtsI348iPL5Cklil62sA48csebQ/3ZDd3vMHo34YPdZy2t6
   g==;
X-CSE-ConnectionGUID: Pjv2Vd//R3+v8ou9ahU/qA==
X-CSE-MsgGUID: 4JhF4fTCSgiToZ5864m/Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64725161"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64725161"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:08:58 -0800
X-CSE-ConnectionGUID: vsDmzIT5TpyXhvDzCyuxCw==
X-CSE-MsgGUID: PhvfljCiRi+t2sSSMq++6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188877132"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:08:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next v2 0/6] wifi: iwlwifi: mld: Add support for NAN
Date: Mon, 10 Nov 2025 18:08:44 +0200
Message-Id: <20251110160850.366979-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This series adds support for NAN in iwlwifi driver.

Thanks,
Miri

Ilan Peer (6):
  wifi: iwlwifi: mld: Add support for NAN
  wifi: iwlwifi: mld: Handle rate selection for NAN interface
  wifi: iwlwifi: mld: Declare support for NAN capabilities
  wifi: iwlwifi: mld: Extend the NAN configuration
  wifi: iwlwifi: mld: Support changing NAN configuration
  wifi: iwlwifi: mld: Advertise support for multicast RX registration

 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 129 ++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   2 +
 .../net/wireless/intel/iwlwifi/mld/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  21 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  88 +++++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 287 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  28 ++
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   9 +
 .../net/wireless/intel/iwlwifi/mld/notif.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  11 +
 13 files changed, 569 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.h

-- 
2.34.1


