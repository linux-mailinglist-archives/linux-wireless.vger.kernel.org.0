Return-Path: <linux-wireless+bounces-2946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D358459E2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888531F2354E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534455D479;
	Thu,  1 Feb 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/hBDp8V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EF5D498
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797079; cv=none; b=CPwoopJsDKWlzsWDB8Cnyi2ABK6rSoRdY3qS+0N9+zJPAv1VL4h3yPZLPsSUS0XpGvW0/6Yl6wpEHO3gcLraVqdjbqhxqa6S6YscQPwW56xas1kk2KC5/EJQ3hYeiZYJDBTBcJWyHbRXay73EoPkwimO1VLwmAEoKvgwLeb4tvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797079; c=relaxed/simple;
	bh=EtkNYI9SC16E1sPwDvXACjCzg/LRxbfXOucfVZfw5jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1ytYHmdW7rPt97rCrRUc6YqTohRhLT9XphSDE5Bwh8Bje3D21h3KZtUYLS8cQ1tkSw1xZd2jGHMn5Y9NJEj1WsiQ1eGoTbAfUDIRuqTYFffgafvOZ4ZtlfqvKD3QayU3lBqjRPfw03R/BaWd+XmFRXPefkxIueeK4PfZ9tAZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/hBDp8V; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797076; x=1738333076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EtkNYI9SC16E1sPwDvXACjCzg/LRxbfXOucfVZfw5jk=;
  b=L/hBDp8VDu3Hb88qj91KraKi4/oTWD+Wjtm2XQS3O5iHSh0ed4RMBwhn
   cuBm+0WwVewTVBy0gCSvXfmns+Bth11ap0gvh28sO/Fe/PBmCPW4eMHOC
   QKS9+/bJ4stvTtPQOPHerxI8D5nItC5PmJUmDQpJn1CYHa7/TWRx6CEup
   sFw8RPBHgq9XszYxdtlB3ydiM6fJsbEJQUS3goq1r9mZXa7WKqeSvESKb
   wjon54pW51Gu8wJZwYygRa93Ob/Kc6Um+VmvImE2LwUEj5x5vI0ua6MYy
   +LChW0Kqmu8w4GIUUtI+GSgdPuQBORo98cWuemmPZbXJTUp+N1umNXjg+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062026"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062026"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:17:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="93293"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:17:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/17] wifi: iwlwifi: updates - 2024-02-01
Date: Thu,  1 Feb 2024 16:17:24 +0200
Message-Id: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.9. It contains a
few features, bugfixes and cleanups.

Thanks,
Miri

Ayala Beker (1):
  wifi: iwlwifi: mvm: use fast balance scan in case of an active P2P GO

Benjamin Berg (1):
  wifi: iwlwifi: do not announce EPCS support

Emmanuel Grumbach (2):
  wifi: intel: mvm: don't send NDPs for new tx devices
  wifi: iwlwifi: mvm: don't send BT_COEX_CI command on new devices

Miri Korenblit (11):
  wifi: iwlwifi: prepare for reading SPLC from UEFI
  wifi: iwlwifi: read SPLC from UEFI
  wifi: iwlwifi: read WRDD table from UEFI
  wifi: iwlwifi: read ECKV table from UEFI
  wifi: iwlwifi: rfi: use a single DSM function for all RFI
    configurations
  wifi: iwlwifi: take send-DSM-to-FW flows out of ACPI ifdef
  wifi: iwlwifi: simplify getting DSM from ACPI
  wifi: iwlwifi: prepare for reading DSM from UEFI
  wifi: iwlwifi: read DSM functions from UEFI
  wifi: iwlwifi: exit eSR only after the FW does
  wifi: iwlwifi: bump FW API to 88 for AX/BZ/SC devices

Shaul Triebitz (2):
  wifi: iwlmvm: support link command version 2
  wifi: iwlwifi: mvm: make functions public

 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 175 ++++++------------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  94 ++--------
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  18 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  60 ++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  52 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 109 +++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  78 ++++++++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |   5 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  86 ++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  80 --------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   8 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  80 ++++++++
 23 files changed, 543 insertions(+), 355 deletions(-)

-- 
2.34.1


