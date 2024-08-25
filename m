Return-Path: <linux-wireless+bounces-11905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA48095E441
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11DE1C209BF
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B9ABA53;
	Sun, 25 Aug 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxM7sqP9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EFE2119
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602646; cv=none; b=B//TpG8y2lyC5O/nAtDS8Eyby5+HYGn8SeSac93F/CZcvV2Ip6vw3Sw0h2vnrTeLhjEXzj8PxUfWBKmEyw8ks2HIGwiVuwrd0yCAVbA9MKhxmniyDdXSipfH7roEWRHY4lDNnRcv+fkpVDACOEXFfxUeSJASuWV0IrPFlAXT85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602646; c=relaxed/simple;
	bh=LZ6156RlC5BP+5QTXPPFw0iy4KBMBszWlEhrbezbjPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utSJvTATtADFGXKRR12XPh+Gj/KS5AomBA8RHknu13tZE5ZBsHLvBDd3uN/79Fm37vkVusXPj0S0OllU8MWaOmuDcjUi0ZRWfyXEaVJ8U7P5YZ+N/Ga3cIOg+b5WvN7l1Z1RDpGogAtWQjgvk8tSPnP2b34cnun11c6qnLga11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxM7sqP9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602644; x=1756138644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LZ6156RlC5BP+5QTXPPFw0iy4KBMBszWlEhrbezbjPA=;
  b=SxM7sqP98k490oIGOYukwwyRUTMVq++B24ZeOZuGo2PZgsgPovpHjnCQ
   Yw4PVcTNVEb+LsYiRNMdRzHb48yPQ9E5qpLXh2bTV4n8DzkW62XLsJ/0A
   mSMGSI3q7UpXJK7wbmUIsIQan3d8iH8FLBTjn5BXV2ATekUDkqUuKeeWU
   WPsFs6gqI1m1+L7yZaZB2TEpksC7/iy0+aELmqdoluUMjDBvjyuT39rLE
   I/UJrb5D2GKNkpCqPx7DHLxabgXv5ZgKsdLXuXBI4HPiLzZOLz7xoCy9f
   TK3g5PEFMhSs9VKsHxJLgMZfc8DUoHOZVylSN5/iCeFHxfjbogxGpkmyf
   w==;
X-CSE-ConnectionGUID: OdzG0qF5T3++kAXcP86iyA==
X-CSE-MsgGUID: IUD7067WQUyFlDj1er98VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544114"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:23 -0700
X-CSE-ConnectionGUID: NfygajauQha6yPuFhxoIHw==
X-CSE-MsgGUID: kIPKQpqQSFOv3UxXKAmI0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999715"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/13] wifi: iwlwifi: fixes - 25-08-2024
Date: Sun, 25 Aug 2024 19:17:00 +0300
Message-Id: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
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

Anjaneyulu (1):
  wifi: iwlwifi: fw: fix wgds rev 3 exact size

Avraham Stern (1):
  wifi: iwlwifi: mvm: allow 6 GHz channels in MLO scan

Benjamin Berg (1):
  wifi: iwlwifi: lower message level for FW buffer destination

Daniel Gabay (2):
  wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation
  wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()

Emmanuel Grumbach (7):
  wifi: iwlwifi: clear trans->state earlier upon error
  wifi: iwlwifi: mvm: fix hibernation
  wifi: iwlwifi: mvm: replace CONFIG_PM by CONFIG_PM_SLEEP
  wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead
  wifi: iwlwifi: mvm: take the mutex before running link selection
  wifi: iwlwifi: mvm: pause TCM when the firmware is stopped
  wifi: iwlwifi: mvm: allow ESR when we the ROC expires

Miri Korenblit (1):
  wifi: iwlwifi: mvm: avoid NULL pointer dereference

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 13 +++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  | 12 ++++++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 10 +++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 24 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 42 ++++++++++++-------
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 14 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 12 +++---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 41 ++++++++++++++++--
 14 files changed, 149 insertions(+), 47 deletions(-)

-- 
2.34.1


