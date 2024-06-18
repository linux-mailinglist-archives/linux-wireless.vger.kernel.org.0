Return-Path: <linux-wireless+bounces-9201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B779990D9B1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641331F22F75
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D4641C89;
	Tue, 18 Jun 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmetShwM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278013BC35
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729065; cv=none; b=DMkmmsKz5aqvnWunDUq+IYJ7ZuXLwD0K1GtssHEt7CQuA5tBv02FkREisblxp7Edn9DCsUCXWcDA91P9SyuXMVHytrp+xwN6nr5ND3H/OyXQ3IEJ2ZGFgbLiPOAypmAFNP6pXGuEd76tNArPzK0AH1NjZjtLcfjfDIkI5GCKYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729065; c=relaxed/simple;
	bh=iOCbGfWcOqJ/vrW7SILYSJHK1ERwDSg4VMMBADm76Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J7Yo+qgqIXrtpski1+YUDlvyWrMu2ez1cbhyUOxPxW/UVGfrhGQOee1/ejrjyZbS8SkeZpq/x8LcFD4jZES6bloLmRRrmIwCT5PEerZJuV4X4TbHTRt3udXuj1ckNqeeizcKwkoyiZTUW8uEDvk5D/rCBEhynldGeBVsTUlSruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmetShwM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729063; x=1750265063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iOCbGfWcOqJ/vrW7SILYSJHK1ERwDSg4VMMBADm76Lc=;
  b=KmetShwMSoDQ+mAFvRxbDDOBURCOe1QF6gDTiCJU18q6zEnUkdGMki/x
   623GcPYfN7RUy8kQMkkVPLGpjM5ptSYIcpcwlT7VhD7RctRme8O3FdcGK
   JdJDUU/HG9oZOkfqXzfjVNp96DTAiRr73vueVo+4crE7OGJKSLWoPclPw
   f8wBhgQaYossaEpiTINrYG+eKslR2G14+LvGzr1TbcS94J8nhATWI3h0u
   /wW07GAzcbcDn3FPid057RkZKdvenkqfM9pqgZMIedmnD6lDlyCqG60+8
   +cXC20BrsTwyZK9VbN/b2sJ1+wMZVZfo6pj5MOk5FGYrxqZ7wIoJa+jch
   w==;
X-CSE-ConnectionGUID: 4P1VSzgsQwWXHTW8mk0QeQ==
X-CSE-MsgGUID: zrRzzHD2TQaeN/w7rbWmJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257156"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257156"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:23 -0700
X-CSE-ConnectionGUID: 3X97mQH1TcWTLWPGxLeZLQ==
X-CSE-MsgGUID: OjWXAp+XSTGwQYQgfSbfeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306493"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/11] wifi: iwlwifi: updates - 18-06-24
Date: Tue, 18 Jun 2024 19:44:02 +0300
Message-Id: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.11. It contains
a few features and cleanups.

Thanks,
Miri

Emmanuel Grumbach (3):
  wifi: iwlwifi: support fast resume
  wifi: iwlwifi: don't assume op_mode_nic_config exists
  wifi: iwlwifi: trans: remove unused status bits

Ilan Peer (1):
  wifi: iwlwifi: mvm: Fix associated initiator key setting

Johannes Berg (4):
  wifi: iwlwifi: mvm: dissolve iwl_mvm_mac_remove_interface_common()
  wifi: iwlwifi: mvm: rename 'pldr_sync'
  wifi: iwlwifi: mei: clarify iwl_mei_pldr_req() docs
  wifi: iwlwifi: mvm: enable VLP AP on VLP channels

Miri Korenblit (3):
  wifi: iwlwifi: mvm: remove IWL_MVM_PARSE_NVM
  wifi: iwlwifi: trans: remove unused function parameter
  wifi: iwlwifi: bump FW API to 92 for BZ/SC devices

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  8 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  5 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  5 --
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  7 +-
 .../wireless/intel/iwlwifi/mvm/constants.h    |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 85 +++++++++++++++++--
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 22 ++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 61 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 21 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  2 +-
 17 files changed, 167 insertions(+), 69 deletions(-)

-- 
2.34.1


