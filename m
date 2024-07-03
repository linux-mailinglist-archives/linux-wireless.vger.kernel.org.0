Return-Path: <linux-wireless+bounces-9901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E68192578A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 11:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61141F23CCC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71FC1422C9;
	Wed,  3 Jul 2024 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlsVq7nY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6B13DDA3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000756; cv=none; b=O5f/7VBNCcXKqTEUYrqr9q0MR1lLcXuitfersPay0BfT5BCdk1ui7FMA4SlelwsImW3U7PJUTx2/SAnWYPw5r/mrEZOKUbmFcBKBZAE7SyX6P3tHvf2hGfpp440v4b1Bww0jmiKdZ18fTb8JuWrOwntFskbUIgmYki+BwiEWVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000756; c=relaxed/simple;
	bh=ZUTZJu3JO141r0A8S+yH7ZR4l5r5IQZSQZfZBBTKBmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=joA4WeVH3FYpfBbqQZfFaC/6feMTakPkIkyE/hvJcEQBqcBDQA/O0Oj7DafXT+CjUkehiZVNVss+29cBjf1Sl4JPQCRS/z9xy3YrIdk/cOPNn+v5IqeBTCMTnYAdiVnR+anlZIB4PcXGa/Z/K9UCjF9scqlHySdE4jvuHCeI78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlsVq7nY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000754; x=1751536754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZUTZJu3JO141r0A8S+yH7ZR4l5r5IQZSQZfZBBTKBmw=;
  b=OlsVq7nYF5SpO/VWvuwUiI6rQfA0hIo3IPtq8qoMpaUT2i1rvs1pX8zV
   hRFRGHRFP5y3GufS3R/W3jHUWjHRz1j8FqeHQ9IxqfI0NHW0X8HtHeYyo
   LaJ/1l5UC5B2Bl93NvXAVU6krrwnMWGWFY/wS2fCZwOx+4s8xSXBsN4OY
   r6kP9aXc02g9dcmJ1zegoS31Ta+AJJdimWYeS2Kv49ig/d70vPuVMWHHy
   YkQD6/AKH8LKsKsRroJYAxWwyR49WVLujBatL8CFBazPI7QDykwhFem6c
   d6uoLBRvI53CnW9kU+i8b0+3+2gteH046s4pXPGYbU7ByztiHFriUtf41
   A==;
X-CSE-ConnectionGUID: TSORAjKFS7i3moiQS9fxiA==
X-CSE-MsgGUID: Rz9LO7ODSSO/G7ZQkX9jzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837500"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837500"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:14 -0700
X-CSE-ConnectionGUID: POFvyu0nRvil97/ntIgCnw==
X-CSE-MsgGUID: LrCrosQaRc2y+k7ObYx7NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987700"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/18] wifi: iwlwifi: updates - 03-07-2024
Date: Wed,  3 Jul 2024 12:58:48 +0300
Message-Id: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
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

This patchset contains features and cleanups.

Thanks,
Miri

Anjaneyulu (1):
  wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v12

Benjamin Berg (6):
  wifi: iwlwifi: return a new allocation for hdr page space
  wifi: iwlwifi: map entire SKB when sending AMSDUs
  wifi: iwlwifi: keep the TSO and workaround pages mapped
  wifi: iwlwifi: use already mapped data when TXing an AMSDU
  wifi: iwlwifi: keep BHs disabled when TXing from reclaim
  wifi: iwlwifi: release TXQ lock during reclaim

Johannes Berg (10):
  wifi: iwlwifi: mvm: clean up reorder buffer data
  wifi: iwlwifi: mvm: align reorder buffer entries to cacheline
  wifi: iwlwifi: mvm: simplify EMLSR blocking
  wifi: iwlwifi: mvm: add missing string for ROC EMLSR block
  wifi: iwlwifi: fw: api: fix memory region kernel-doc
  wifi: iwlwifi: fw: api: mac: fix kernel-doc
  wifi: iwlwifi: fw: api: add puncturing to PHY context docs
  wifi: iwlwifi: document PPAG table command union correctly
  wifi: iwlwifi: fw: api: fix missing RX descriptor kernel-doc
  wifi: iwlwifi: mvm: document remaining mvm data

Mukesh Sisodiya (1):
  wifi: iwlwifi: Remove debug message

 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  34 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |   7 +
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |   6 +-
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |   1 +
 .../net/wireless/intel/iwlwifi/fw/api/power.h |   9 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |   8 +
 .../wireless/intel/iwlwifi/fw/regulatory.c    |   4 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  13 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  37 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  11 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  36 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 139 +++++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 311 +++++++++++++-----
 16 files changed, 469 insertions(+), 176 deletions(-)

-- 
2.34.1


