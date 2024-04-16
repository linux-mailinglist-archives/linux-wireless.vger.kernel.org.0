Return-Path: <linux-wireless+bounces-6377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245118A691E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF654282657
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E8127E32;
	Tue, 16 Apr 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDJOnyr4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6712882E
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264862; cv=none; b=sp5t3prZ+H7FFav5aKfpN86HupEv9EYEQcmd2QGqLHTNhY/Pa/mpv0uiOIJuaxyZXLiDl9m2sj/ON8Rav2bGY1eFa/REMjyFtgebAwoKxskiiAToQENBArmlK8gInLX6tdh3JYy/Ib/Q04JX+jAPrzdXRgkjfS55153GI2hOIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264862; c=relaxed/simple;
	bh=8FwuZGFB38gA7BsX96e1z4s/T8fbATLL5T8YYQZvP+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+ux61zTMSvEANof3SW/BO0sewPE8h3cCOxl8Cg8HOd294P8D+X9fjxja4vVENEAZ4pE1714BE2rTFtf4PGUL9+JmI4CVlUIOhU+ePkTsbobolaQhmV24CXCfdvIKDoVZ09MYsX6RCCU6i5/5I/C5MSijuSaEv3tm8GHgZH2xX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDJOnyr4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264860; x=1744800860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8FwuZGFB38gA7BsX96e1z4s/T8fbATLL5T8YYQZvP+Y=;
  b=oDJOnyr44pOioQ6vXDs+kz0qyKm+Sda8qrPKWp7ippEdZ3xQzC0rsiE8
   oOLXUTULV+azDB3tQTIkrwfjL13WjL83Q4oMdQ2TL0Dwwr2wP44ZanPGe
   Me6jMvZwLObsbXvku48UNCXQZ15bGOJta949rJSccbITkKutJIfeZzPqR
   R5zjEGHl0Vx9JaIlnp+taxQcRVHM4WMKvuUrjEW0yBeKpJJu3lXGuMHG2
   Oy7noHOix8AwFuBypbnuipB+qHKuC7dCV2IiRIMM0UQvl+oR5VlzXhrDG
   Khwxvdse7Tk8Oni5DnhzLfuSboaVyUXP/dJ/rLyaIyYo2Lcg+XH7ZPhS5
   A==;
X-CSE-ConnectionGUID: j+Gb1ndcTh+xtw2O7rcV7g==
X-CSE-MsgGUID: NAWmBywNSf+3cBbT4MYdIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556022"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556022"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:19 -0700
X-CSE-ConnectionGUID: pPy4CUCIQf6sDTKHpET5ug==
X-CSE-MsgGUID: 0UlOAiHqSk2u7/iSrMSmzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872361"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/16] wifi: iwlwifi: updates - 2024-04-16
Date: Tue, 16 Apr 2024 13:53:55 +0300
Message-Id: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.10. It contains
a few features, bugfixes and cleanups.

Thanks,
Miri


Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: introduce esr_disable_reason

Johannes Berg (1):
  wifi: iwlwifi: mvm: init vif works only once

Miri Korenblit (12):
  wifi: iwlwifi: mvm: implement link grading
  wifi: iwlwifi: mvm: calculate EMLSR mode after connection
  wifi: iwlwifi: mvm: don't always disable EMLSR due to BT coex
  wifi: iwlwifi: mvm: check if EMLSR is allowed before selecting links
  wifi: iwlwifi: mvm: move EMLSR/links code
  wifi: iwlwifi: mvm: Implement new link selection algorithm
  wifi: iwlwifi: mvm: Add helper functions to update EMLSR status
  wifi: iwlwifi: mvm: exit EMLSR upon missed beacon
  wifi: iwlwifi: mvm: implement EMLSR prevention mechanism.
  wifi: iwlwifi: mvm: don't recompute EMLSR mode in can_activate_links
  wifi: iwlwifi: mvm: get periodic statistics in EMLSR
  wifi: iwlwifi: mvm: Don't allow EMLSR when the RSSI is low

Mukesh Sisodiya (1):
  wifi: iwlwifi: mvm: send ap_tx_power_constraints cmd to FW in AP mode

Yedidya Benshimol (1):
  wifi: iwlwifi: mvm: disable EMLSR when we suspend with wowlan

 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |   7 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  42 +-
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  75 +--
 .../wireless/intel/iwlwifi/mvm/constants.h    |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 567 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  21 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  78 ++-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 287 +++------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 123 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  22 +-
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   3 +
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 394 ++++++++++++
 .../wireless/intel/iwlwifi/mvm/tests/module.c |  10 +
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  22 +-
 include/linux/ieee80211.h                     |  18 +
 19 files changed, 1416 insertions(+), 328 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/module.c

-- 
2.34.1


