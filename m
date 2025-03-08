Return-Path: <linux-wireless+bounces-20045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC1A57E78
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555683B1390
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A09E1E25F7;
	Sat,  8 Mar 2025 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amHyMvzH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785222BB13
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468780; cv=none; b=S1qPqxQ7WxMIR5KwQnwb05uhVnRdlpXGoFdyjimg1SdwWjZq78nb3GiAfYmuItdWb8ipNiNm5nnKrM9fSKz9rMz12v5VXGF+xGK+MGf7nRPZFjWtBX09eXcu+PP/AGyert3Jg7U0ytPLe+KbNb7L4x6lIAvtjES/fBAnzgypBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468780; c=relaxed/simple;
	bh=+yWo3jdofddSucqwY2/mt1kcf6G/3clxJBGEe3Pq5kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dj/06Of21nk8+oqWGeoIU/ys56vt6CVncqSVpX1a+zNxXqP+CFVPECnyQwoezS+NPwYYktLjSBvWnF8rRkjrQW/5dC3uTRsPLGvl+WLf4FXhacV5FP68Vxa+xflMXdWKBLw+ndemyPby/NX2OTvQsP4/7wU9Mduk7E5svfvFHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amHyMvzH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468779; x=1773004779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+yWo3jdofddSucqwY2/mt1kcf6G/3clxJBGEe3Pq5kE=;
  b=amHyMvzHNVbH2uieq1Vlw+WWYVGDI9vks7N7Ad2VeZX6vZdiG0qNKYW5
   A68lKd3Uus5HsJuAZ6EelZT+b4QUx+JFhhbg/0vE9iLBoI2QoxfeqBfKI
   6So7W8BHh3jj2lDnj8QwsHfJY0+bY5SfYsvN51sVxBNC+e1oe6jJe2/HV
   WQUqtORpMaqh6uYNQkVCkQEYz44x2E2LIhXoyThL0kpyGgRSA6pTgPizp
   RpmX6zHQDFDxGyI+IqvC5BxaR2Galx/8rN29nQ8NM42lmY2MvVoUk/b0L
   wlv2CGXo9OUBCzSiWrmebaQv1qrvnnulSrE06yu8YVIYcQUI/9VOUk/7Q
   w==;
X-CSE-ConnectionGUID: eSNXOskOT2afQqcjo0Hm4g==
X-CSE-MsgGUID: L3nuUt+mT26qov8bufDGSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052361"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052361"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:38 -0800
X-CSE-ConnectionGUID: 4X8c23UKRCiFr6UgZ1LB9A==
X-CSE-MsgGUID: iVCK9cHYTNKUCVGcT25PLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859890"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3 wireless-next 00/14] wifi: iwlwifi: updates - 2025-03-06
Date: Sat,  8 Mar 2025 23:19:11 +0200
Message-Id: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
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

Resending this series with the requested change
(squashed 2 patches into 1).

Thanks,
Miri
---

Avraham Stern (1):
  wifi: iwlwifi: mvm: fix setting the TK when associated

Daniel Gabay (1):
  wifi: iwlwifi: w/a FW SMPS mode selection

Emmanuel Grumbach (3):
  wifi: iwlwifi: add support for BE213
  wifi: iwlwifi: fix the ECKV UEFI variable name
  wifi: iwlwifi: fix print for ECKV

Johannes Berg (2):
  wifi: iwlwifi: mark Br device not integrated
  wifi: iwlwifi: fix debug actions order

Miri Korenblit (3):
  wifi: iwlwifi: bump FW API to 98 for BZ/SC/DR devices
  wifi: iwlwifi: bump minimum API version in BZ/SC to 93
  wifi: iwlwifi: don't warn when if there is a FW error

Pagadala Yesu Anjaneyulu (3):
  wifi: iwlwifi: mvm: cleanup of TAS structure and enums
  wifi: iwlwifi: Add new TAS disable reason for invalid table source
  wifi: iwlwifi: mvm: Fix bit size calculation in
    iwl_dbgfs_tas_get_status_read

nerrera (1):
  wifi: iwlwifi: add restricted TWT capability

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  8 ++--
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 42 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 10 +++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 10 ++---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 17 ++++++--
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  5 ++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 38 +++++++----------
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  4 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 15 +++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 21 ++++++++--
 17 files changed, 121 insertions(+), 76 deletions(-)

-- 
2.34.1


