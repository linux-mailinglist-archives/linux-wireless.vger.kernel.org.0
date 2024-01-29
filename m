Return-Path: <linux-wireless+bounces-2709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B4E841329
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08428B23FF2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF0335B5;
	Mon, 29 Jan 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZlfkaI/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD64C619
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556008; cv=none; b=p7yYlDSPHRAmkr7XoR6pseyqL5oXEk51z99zkv89Nmtkqh2swHWhWSmetDKGvy8F6XnpLTdnWaG0k05vYke4V0rkFoCJOj5LKUc11nnWAIyHcUNOnLjOkTrA+B7q15+uYyOyGOgw9QOBMt+q++QB3d1FR2fWXdKjuMb5rAtOVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556008; c=relaxed/simple;
	bh=2GeXEVCOVNK5VvSmla+35MEJjD2KwCQ8NVUCL1gekF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ruJDfoFo2mLXXQZv81qvo9dfK4E51XMkeZ1fYbzpsOSyY4LC4uU/z/z2LL7GHNAcS94yg38TwD5/ITA4sFPJVETeQULFA6lPJ7ZSk6Z7c5UpKSrLsbQcwtzNpNfIwIItqqtE1dBt9NdIA3KJ1tnP3d8Pfiq+j54p9KMspk7vrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZlfkaI/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556006; x=1738092006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2GeXEVCOVNK5VvSmla+35MEJjD2KwCQ8NVUCL1gekF8=;
  b=lZlfkaI/yA2j2WpMir0Yw7/J2oxDgFJxshoHVaJZJmv0tQY2x6pw1+3i
   u4K/KFayncn5SKqzzPg8GtgShK9EPH9gOefYVdtLcUw6MZhv8+aHbKDWL
   AArn4dOv6T7l3Q7pcjPIzrLlTy1YXyMDgC07JcEZrbs9qR5EbzmF8zMeL
   gKZUtqoXFatkKJa2/hF+uEWNiI802/vn6ZqxhW2B4rqJe04TboCFqgSY5
   NzplCmfZ5xZqYm3gqzIp0EVYTT0EZbPGrdHvtZyHXHHtxaqjoJOowirXt
   KrRpx/vWuYksG3BWaVp63/iPsmzcQ7xTWPEBhjmE7RRHAZdYdmLSbjkoE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2890206"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2890206"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="821945637"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="821945637"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:14:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2024-01-29
Date: Mon, 29 Jan 2024 21:13:48 +0200
Message-Id: <20240129191403.4183255-1-miriam.rachel.korenblit@intel.com>
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
  wifi: iwlwifi: mvm: add support for TID to link mapping neg request

Colin Ian King (1):
  wifi: iwlwifi: Fix spelling mistake "SESION" -> "SESSION"

Daniel Gabay (1):
  wifi: iwlwifi: mvm: log dropped packets due to MIC error

Emmanuel Grumbach (1):
  wifi: iwlwifi: mvm: fix the TLC command after ADD_STA

Ilan Peer (2):
  wifi: iwlwifi: mvm: Fix FTM initiator flags
  wifi: iwlwifi: mvm: Add support for removing responder TKs

Johannes Berg (7):
  wifi: iwlwifi: mvm: d3: fix IPN byte order
  wifi: iwlwifi: mvm: don't set trigger frame padding in AP mode
  wifi: iwlwifi: always have 'uats_enabled'
  wifi: iwlwifi: remove Gl A-step remnants
  wifi: iwlwifi: mvm: use FW rate for non-data only on new devices
  wifi: iwlwifi: mvm: support SPP A-MSDUs
  wifi: iwlwifi: mvm: refactor duplicate chanctx condition

Miri Korenblit (1):
  wifi: iwlwifi: fix EWRD table validity check

Mukesh Sisodiya (1):
  wifi: iwlwifi: pcie: Add new PCI device id for new hardware

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  4 ---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  4 ++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 ++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  8 ++++-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  9 ++---
 .../intel/iwlwifi/mvm/ftm-responder.c         |  7 +++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 34 ++++++++++++-------
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 18 ++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 19 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 17 ++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  5 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 18 ++++------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 33 +++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  1 +
 19 files changed, 146 insertions(+), 44 deletions(-)

-- 
2.34.1


