Return-Path: <linux-wireless+bounces-4532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B3877AE6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF28A1F20CC4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A75CA47;
	Mon, 11 Mar 2024 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STm/+EV0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EF747F
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138507; cv=none; b=HhXdA9KPNXyV3W9Q+L5SHsiVgYL+jNP1ABKfke8HeroeX/dogUqzlLHZTT7vwfFOUO2tMV9szSUT2jd5czD0U/MsQm3itxhbzn66HL4LRPtjRM1nES/sDy2rEfVfNPoPWhaNMMRzJDHKCvLuNqkKmNWgIVtDVJIjmRkPC5IO/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138507; c=relaxed/simple;
	bh=KJmfb0EYjO2/sh0UxAuxJ/GMDTq84mANEkQo4asvG3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPEoiNOdoCIh+VdDtS4oRxm4Z577cjtm1CPf/e3UXHGSp1+v5ygIphblAVu/xCNqmJsVid4WNqSARwYH1QEErDDkehEAm4Cwhnm0R33xdd4BQzxQhxd4mByC/9tqU5xDt5P5SK6gjwRoilCGaQQ1T4s52575Sd29NHpnMJMZG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STm/+EV0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138505; x=1741674505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KJmfb0EYjO2/sh0UxAuxJ/GMDTq84mANEkQo4asvG3Q=;
  b=STm/+EV0iPoFthfwC+CEoxWN9w6Ms+HdSWgxozPLKZ+Di7n5y3WDsLms
   e7t6YainEbEsjHMd+pi2qgWnbSdwGtzZyekwaz9X3kmxt10uDw2cvmT57
   Qlwtm+W5j6OHrUcNhR/EQyMRjpqfAKv+ZO/uDd0dH6rJ9Xl15P3bhJVDM
   u3VMKHQVkwxm51pOg8bXbL0j0laWH9/VSAv7pvvUyVFjqFAAChCu9RboM
   tMDlUJVdx8hpL9J+05ecV4gqUGWDQJKD2HWOJaIAgZ6rQkzK6M/ZGU6zR
   tSVMDk3qCPn+XZX7hb94wGbBfGZnfaD+t4/fg/keQVGS+lNMjMHahg7E5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226724"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657573"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2024-03-11
Date: Mon, 11 Mar 2024 08:28:00 +0200
Message-Id: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi feature and cleanups patches intended for
v6.10, along with bugfixes.

Thanks,


Avraham Stern (1):
  wifi: iwlwifi: mvm: add debugfs for forcing unprotected ranging
    request

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: pick the version of SESSION_PROTECTION_NOTIF

Ilan Peer (4):
  wifi: iwlwifi: mvm: Move beacon filtering to be per link
  wifi: iwlwifi: mvm: Configure the link mapping for completeness
  wifi: iwlwifi: mvm: Refactor scan start
  wifi: iwlwifi: mvm: Introduce internal MLO passive scan

Johannes Berg (3):
  wifi: iwlwifi: mvm: fix flushing during quiet CSA
  wifi: iwlwifi: mvm: advertise IEEE80211_HW_HANDLES_QUIET_CSA
  wifi: iwlwifi: pcie: remove duplicate PCI IDs entry

Shaul Triebitz (6):
  wifi: iwlwifi: mvm: consider having one active link
  wifi: iwlwifi: fix firmware API kernel doc
  wifi: iwlwifi: mvm: fix the sta id in offload
  wifi: iwlwifi: mvm: stop assuming sta id 0 in d3
  wifi: iwlwifi: mvm: skip keys of other links
  wifi: iwlwifi: mvm: support wowlan notif version 4

 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  57 ++++-
 .../wireless/intel/iwlwifi/fw/api/offload.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 228 +++++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |   5 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  59 +++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 107 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  42 +++-
 .../wireless/intel/iwlwifi/mvm/offloading.c   |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  48 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 108 +++++++--
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   1 -
 15 files changed, 601 insertions(+), 121 deletions(-)

-- 
2.34.1


