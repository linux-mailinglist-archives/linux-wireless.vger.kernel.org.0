Return-Path: <linux-wireless+bounces-28767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B134C46BE1
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F6304E4726
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C81FE451;
	Mon, 10 Nov 2025 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZj2+lvo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8831A704B
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779754; cv=none; b=Oca20lQreHjMUtBTJDxBzti0ozWUJLfg6LXo24nu9lvfJcyqJYXkM6yRcAFvpMYbXnW0pqSUqGq4jCf3uw/h/hbUwWsJfnVqub8Vqz3txjg+EH4OjacV/rxVv0LJM8pLGwYaZL3yT/E3vAju28VOfxvZStHXDH3zxR/VsxeT0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779754; c=relaxed/simple;
	bh=5+lhp6HN0KabUYcqEPMM43hzR3tldbpkLnMk6zJwX/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JOYIr1ilDCN1EKrt6FTHzbNmLFa+Bnqj7iVzUc4DGnvF6I/hlh3VAP9JDxruxK/Z8tb54WXaAmmNXTOE5mTd9rUldf4BmhYwZpCJiOSLkL2Hf3UPUKX60Am0iSr8Dj9IJxtkRgz/D1DL4g7s47L4WSie8eOLG3GsEuXwFxdF8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZj2+lvo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779753; x=1794315753;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5+lhp6HN0KabUYcqEPMM43hzR3tldbpkLnMk6zJwX/Y=;
  b=nZj2+lvoTPFfmCsWjZm/haTKayLmI/zr5BjP3LIZQwDVihQfyeIcV3cw
   igW2XH7ViGTQy9qsGjX5JgmZ1mWjnw/Pq1hT3HA/K53KYh1DJisOk6elt
   Qaq30muuTxzYMCAhrlr9UcTmhTS/xI9KA5h+camSAJUk8nryS04Y9ZX1P
   GDJFbYnzOZ9OwyQd0a3SKVmVyh2TQR1/QwxsvDMOXogKoKCsHIhANpn0T
   PS+Ev5+C+DFw7KsDALHWrDhyiF1gCOzloUlb+5e2CcMOqN7xBT6E7xg62
   NbXzRLa7X5fQa9zOpUkwQUDQnGDygbevPFpsvdwJ1MWJkHeBAINIYwVw2
   w==;
X-CSE-ConnectionGUID: 86Psg7boRLuvEnF/fFGn5g==
X-CSE-MsgGUID: GpvO2l8DR+KtBfyNHW1mlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454866"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454866"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:33 -0800
X-CSE-ConnectionGUID: qkS+Fa4fT1+xygIhmpnvPA==
X-CSE-MsgGUID: VcuaX+X0R8WCMZEhq3GwyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928483"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:31 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-11-10
Date: Mon, 10 Nov 2025 15:02:11 +0200
Message-Id: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
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
A few features, cleanups and fixes from our internal tree.

Thanks,
Miri

Benjamin Berg (1):
  wifi: iwlwifi: mld: decode VHT information for sniffer

Daniel Gabay (2):
  wifi: iwlwifi: mld: Remove wrong channel flags in scan cmd
  wifi: iwlwifi: mvm: Remove few redundant 6 GHz scan chan params

Emmanuel Grumbach (1):
  wifi: iwlwifi: mld: trigger a dump upon notification if needed

Johannes Berg (6):
  wifi: iwlwifi: fix 22000 series SMEM parsing
  wifi: iwlwifi: adjust LINK context NPCA API
  wifi: iwlwifi: add UHR TLC mode
  wifi: iwlwifi: fw: api: add UHR data definitions
  wifi: iwlwifi: mld: fix HE SIG-B MCS/DCM/compression
  wifi: iwlwifi: fw: api: add HE type for UHR ELR

Miri Korenblit (3):
  wifi: iwlwifi: mvm: check the validity of noa_len
  wifi: iwlwifi: mld: support TLC command version 6
  wifi: iwlwifi: cfg: move the MODULE_FIRMWARE to the per-rf file

Pagadala Yesu Anjaneyulu (2):
  wifi: iwlwifi: fw: fix documentation reference for ap_type field
  wifi: iwlwifi: mld: refactor AP power type setting

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  12 --
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |  12 ++
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  29 +++-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  41 ++++-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  95 +++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  |   8 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   4 +
 .../net/wireless/intel/iwlwifi/mld/power.c    |  37 ++++-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 142 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |  85 +++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  14 ++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  10 +-
 14 files changed, 439 insertions(+), 64 deletions(-)

-- 
2.34.1


