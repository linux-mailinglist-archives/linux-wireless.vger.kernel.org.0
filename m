Return-Path: <linux-wireless+bounces-3346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C1C84E5B9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A1D1F24CD0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0987D411;
	Thu,  8 Feb 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4jJacUW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD81E485
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411539; cv=none; b=I4op6B/ab4BI0A4hyAILMevzV3VNjhGzOeSj9hOBpehTY5gWGWxNFUEWgcWpJkIPBzrYi65wDmOxIb1WFWivgu7g/DUPxZ+YsSTNI4rsFH09RE6pxix/+R6Tu3R5Gt1SAsfbitc46Z36p9Wo9jjtmIZd5LGs4jxph31L7sowFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411539; c=relaxed/simple;
	bh=1EmcfS7DLrKkJ27Csr8JMZ62HZCX5KZVjYrR2V8HC5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pz4gL/K+hTZgPNTehiMEiMSLpYWqpKuDErfZWCZMAmO9EKJC0vKpt5L/WvC2bPaNPXVBDn4OKlnGecDvrkPDHi2zXN2myQ2yjJSCvgKhTg6P3KhplxVUUuXHYKh35XcZ9GWXUhyvPQBcXCDRMG90Sb6SsjzydKeN8Sf1WwwQGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4jJacUW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411538; x=1738947538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1EmcfS7DLrKkJ27Csr8JMZ62HZCX5KZVjYrR2V8HC5c=;
  b=H4jJacUWFo+PzH0f1fSJLAF/dv1clexf5E2BaIV7jAzGQ8OYSqDPddUz
   mSRvvCgMH8JxGxnb3oyS4d0gwuQXw8CJv9scndZ1sPrN9ZTl9pfwGajay
   dVTu6Wij1ptgoe0gVAH1yeaNHXpPbJ2vqvkuQFRLuig+8Rb4dqJm9E+8J
   hACM9M4mdU6IS0dSJ5aCbmlBWNff940+fQ5eJatfrbW/HjSpySmTXqg7t
   kKw7WVB9NdKHeW3BKjuSBFNJYGxJeDueOlL0H0OwaXwwVriY0uYr0P5ba
   Djp/6dPnsf4M06XpxcfvooW5SsndcRbVMW3iNL7warFtL9octj5Grnskj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1403950"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1403950"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318804"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:58:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/13] wifi: iwlwifi: updates - 2024-02-08
Date: Thu,  8 Feb 2024 18:58:34 +0200
Message-Id: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
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

Ilan Peer (2):
  wifi: iwlwifi: mvm: Extend support for P2P service discovery
  wifi: iwlwifi: mvm: Fix the listener MAC filter flags

Johannes Berg (9):
  wifi: iwlwifi: mvm: work around A-MSDU size problem
  wifi: iwlwifi: api: fix constant version to match FW
  wifi: iwlwifi: don't use TRUE/FALSE with bool
  wifi: iwlwifi: mvm: fix thermal kernel-doc
  wifi: iwlwifi: error-dump: fix kernel-doc issues
  wifi: iwlwifi: api: dbg-tlv: fix up kernel-doc
  wifi: iwlwifi: fw: file: clean up kernel-doc
  wifi: iwlwifi: iwl-trans.h: clean up kernel-doc
  wifi: iwlwifi: mvm: check own capabilities for EMLSR

Miri Korenblit (1):
  wifi: iwlwifi: bump FW API to 89 for AX/BZ/SC devices

Mukesh Sisodiya (1):
  wifi: iwlwifi: nvm: parse the VLP/AFC bit from regulatory

 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  8 ++-
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   | 10 +--
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 23 ++++---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  | 16 ++++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 10 +--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 33 ++++++++--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 64 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 11 ++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  7 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 10 ++-
 19 files changed, 155 insertions(+), 62 deletions(-)

-- 
2.34.1


