Return-Path: <linux-wireless+bounces-3163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CEF84A6D0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DDD1F2917B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E5C57868;
	Mon,  5 Feb 2024 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTBNnnk2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F25788D
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160894; cv=none; b=H0RUTG3caFUqnSZ7vC1A/Xik/WObHKYIA2nX///YM0h8czqDBE4R27lueyZLsLbH2MDBLrmefwcS77ydUWSe7S7p2bHjKrlrkG9gk9G7tXEy5Wq++dTwZfism9LhTRbGUHmekm/YXyayMKnl3hzj8C67SV+Grycq/wscRK6tRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160894; c=relaxed/simple;
	bh=ICeSvk90bT2vQlVA/gceHEGB99e1+ooyF6JyoFfiJh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C9DnwdCViYCcMyhLRes2+ycp0g5hXJnaIfxUE8VAD3BkF6TITHq1JGBn1fybAS4Uq7tSN+R+Z6Qlbxfkt+anvipRoAPD6vpe2UpoybL48opWFvtJjO6aJMoPVmFsPFzG5xhIsZyuVLA8cTaoPpkt3L2eIPy+UtDTuKyzRbG/Lpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTBNnnk2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160892; x=1738696892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ICeSvk90bT2vQlVA/gceHEGB99e1+ooyF6JyoFfiJh8=;
  b=UTBNnnk2U4P72KvyFOEN5MhFDQSrZdj2rcYCgaBokINBG9vYaXe3Eu9l
   ZQWRDZgIcnGyyz+X/m4AVqwrpCqjuCnOYzT1VmH9Uz6MHUfWumMN2TTzb
   P+/yvfb+As2ApEWeVSM8wFOiS4J+AJIw/PfvPq8RrAdI1MrLJKGKJ3qDe
   EnDtScJ5Y9rnvZaUIMySOuHUmFh7IGKoFRoBsKD3iJ1WwXUDNtbtPakQ6
   /DYEHjKxqRDYk95LKXKl5q/qWnS0hrcE7HfoZWEXCe1ptyjOYKuv/UvAH
   +6CuERdGX60TDiO0eRE4EYjHVc1EJip8kPwkqhXA0JaKGvhv0S1kmsx90
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381526"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381526"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403025"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2024-02-05
Date: Mon,  5 Feb 2024 21:21:00 +0200
Message-Id: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
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

Daniel Amosi (1):
  wifi: iwlwifi: mvm: Keep connection in case of missed beacons during
    RX

Johannes Berg (6):
  wifi: iwlwifi: mvm: expand queue sync warning messages
  wifi: iwlwifi: mvm: don't abort queue sync in CT-kill
  wifi: iwlwifi: mvm: combine condition/warning
  wifi: iwlwifi: mvm: limit pseudo-D3 to 60 seconds
  wifi: iwlwifi: mvm: fix erroneous queue index mask
  wifi: iwlwifi: mvm: don't do duplicate detection for nullfunc packets

Miri Korenblit (4):
  wifi: iwlwifi: take SGOM and UATS code out of ACPI ifdef
  wifi: iwlwifi: properly check if link is active
  wifi: iwlwifi: mvm: remove IWL_MVM_STATUS_NEED_FLUSH_P2P
  wifi: iwlwifi: cancel session protection only if there is one

Shaul Triebitz (4):
  wifi: iwlwifi: mvm: define RX queues sync timeout as a macro
  wifi: iwlwifi: mvm: fix the key PN index
  wifi: iwlwifi: mvm: always update keys in D3 exit
  wifi: iwlwifi: mvm: avoid garbage iPN

 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 31 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 14 +--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 14 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 14 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 16 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 20 ++--
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 98 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 12 ++-
 11 files changed, 118 insertions(+), 116 deletions(-)

-- 
2.34.1


