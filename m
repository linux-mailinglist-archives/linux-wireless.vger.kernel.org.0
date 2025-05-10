Return-Path: <linux-wireless+bounces-22813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F261AB2503
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6764A5CCB
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BBB248F7E;
	Sat, 10 May 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N99KZBDe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BC14901B
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902924; cv=none; b=EhcjdCMPKMzk/h/Vnv/aSk0kRmGBSgZEU4VxPgWrnTJowpFeTu3oLQmcZSilmCsx6tThgm3+vziIeqetlUeURxzUuwVdcDAJA+6C07H32Io/sOmHTIfIHFL4niQXm+syX7td19EAuKbHLswAKNcoQXt+8GbHi0I87kTZwJlqIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902924; c=relaxed/simple;
	bh=0Di6bCrezOnat9+e9iK9ojcRerM1DiWTqfFTg7+URFI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kxK7NpZo5gpq07wQXYv0o04nRllB+tG7VUjtmainK1ru5G91w0J+jAkPIOv0LfRrAfgzX8y11Nsa14bM6jleDEbiDXun2ATuQ6ArqWF9gKil08DDNtnJShEgMC8/vevsCe9J3T9LlTuDTcdrGppJPkoNQEXYo4RDmGV/FhbOZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N99KZBDe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902923; x=1778438923;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Di6bCrezOnat9+e9iK9ojcRerM1DiWTqfFTg7+URFI=;
  b=N99KZBDeMADwObKTG52cjCs7tbBiFEMjKDmPIyfMlPw7soPwKSOnvXbu
   WdzAk/4Rb2owKmkZsMO0mWTTMuzNjttqTXQBQp5GvTGiiGja/z+olNqSh
   7LKS45yTiwzasoSNdXTLi8xe9qAg691s41H+2XK6bGBDpDj/vy1EyrmwI
   zvY4wLDFX9ePNZ2KuDsd/VerS8N+bH0XGq6kvwvAK/XtxOVeevMcmmqek
   jDOiioA3vktuZaru/zB/2O6y9rfD9Q67WnDC1Z3JYTmviqY3xZ2vJS7D3
   P1UDLkG4OKbWUcqI0BsjCPP6HG25uWRo794e+ybcdH+rw1+5VGD/la3N+
   Q==;
X-CSE-ConnectionGUID: IYBBJxhSQ0GhaChic7ivUg==
X-CSE-MsgGUID: xDBuH5bcTwuBrv1YaaeOHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880871"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880871"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:42 -0700
X-CSE-ConnectionGUID: N16eaEPeQV+tK+vVn4Gxiw==
X-CSE-MsgGUID: aWx/8hz5SaiJv3aB+KXY+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033406"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-10
Date: Sat, 10 May 2025 21:48:12 +0300
Message-Id: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
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

Features, bugfixes and cleanups from our internal tree.

Thanks,
Miri

Johannes Berg (14):
  wifi: iwlwifi: dbg: fix dump trigger split check
  wifi: iwlwifi: cfg: remove some unused names
  wifi: iwlwifi: cfg: fix some device names
  wifi: iwlwifi: cfg: fix Ma device configs
  wifi: iwlwifi: cfg: fix and unify Killer/JF configs
  wifi: iwlwifi: cfg: unify and add some Killer devices
  wifi: iwlwifi: cfg: clean up HR device matching
  wifi: iwlwifi: tests: make subdev match test more precise
  wifi: iwlwifi: cfg: clean up JF device matching
  wifi: iwlwifi: cfg: clean up GF device matching
  wifi: iwlwifi: cfg: fix and clean up FM/WH device matching
  wifi: iwlwifi: cfg: fix PE RF names
  wifi: iwlwifi: cfg: add a couple of older devices
  wifi: iwlwifi: cfg: remove MAC type/step matching

Somashekhar Puttagangaiah (1):
  wifi: iwlwifi: mld: add debug log instead of warning

 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   5 -
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  13 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  15 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  25 -
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  19 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  10 -
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |  18 +
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    |  17 +
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |   5 +
 .../net/wireless/intel/iwlwifi/cfg/rf-jf.c    |  16 +
 .../net/wireless/intel/iwlwifi/cfg/rf-pe.c    |  16 +
 .../net/wireless/intel/iwlwifi/cfg/rf-wh.c    |  15 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   3 -
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  37 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 685 +++---------------
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  13 +-
 19 files changed, 259 insertions(+), 662 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c

-- 
2.34.1


