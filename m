Return-Path: <linux-wireless+bounces-26527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F56B3016E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E04716521A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346ED2E5432;
	Thu, 21 Aug 2025 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5ki12v6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC8482FF
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798474; cv=none; b=rY0LjriufKDpw4Dvle1iXoIXtc3SoKbF5smld9SNR94rm4mGL1u7UgNyqIz4VpugxVEkF03X88XQ0Cbtbqc4URITy8mGlcCTzo3E8P7uWOQQJoKEUsLkQZ9njnfSucbx6VQHfxVFkLNHebkWE2JMeZrf4jBTH8sSbqQhm+x4I84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798474; c=relaxed/simple;
	bh=LJnbizwVUKycYPviduVZ4qUDIWH1IiNMKJxvHN8lpAQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TOqYDqY7H9X7GkCBFQmDBt4UU5fsT/Djz6y0FiMllNQIjBgzhCRoSGrfgAhkZrp3/aIWYZ+RPkKBQRepvTobOpV+iFhK8resNT53rD65CD7yBFuqaGFCfJF7fFLl5YcGvSPmqqp4+xp7V63n+kp64Oalh4ISY0tZDNez743Y6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5ki12v6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798472; x=1787334472;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LJnbizwVUKycYPviduVZ4qUDIWH1IiNMKJxvHN8lpAQ=;
  b=L5ki12v6aeJAcscKOuBhJoIQBBWZfXXD9vMfpVA+BMm6yHv2a3mo8rVo
   s/4cFUPuhn0omR7CjmpSMsCv64TAyiv39/LXXnGfoL29EHwOw3oULHR9C
   r6yG21sjvGeBtHpDI/4IThztcm209wL8L7DKkcqgyCauIiApRZc3fwOUk
   W/aoQKAIRDf+oxqH6VJAAJdqH86lcecS0A8IMPKFaqMyPIwMKz88kjlMk
   5ixxVZbcYlCZBgK1pQop5RzRv6A8s6TLmjlWcb/Aj+PBHff+0iG5Y6N+v
   ebw8x4i/HMpDZhpmczXJ1bEd637pdSN/WLc1r2Q8XUBR6nZ1SuUs0wnpS
   Q==;
X-CSE-ConnectionGUID: gjRxMs2MSDqNceNMXnBEhA==
X-CSE-MsgGUID: YskrXOnWT7qQH+lZt/bcaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806055"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806055"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:47:52 -0700
X-CSE-ConnectionGUID: f0qhQN7KTxmL7PcKzRHvSA==
X-CSE-MsgGUID: 0mAgTPBXTHqzGjeHCotZuw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:47:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-08-21
Date: Thu, 21 Aug 2025 20:47:11 +0300
Message-Id: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
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
Resending since it failed to apply.

Thanks,
Miri
---


Miri Korenblit (14):
  wifi: iwlwifi: mld: cleanup cipher lookup in resume
  wifi: iwlwifi: mvm: cleanup cipher lookup in resume
  wifi: iwlwifi: mld: support MLO rekey on resume
  wifi: iwlwifi: mld: track BIGTK per link
  wifi: iwlwifi: mvm/mld: correctly retrieve the keyidx from the beacon
  wifi: iwlwifi: mld/mvm: set beacon protection capability in wowlan
    config
  wifi: iwlwifi: mvm: remove a function declaration
  wifi: iwlwifi: bump MIN API in HR/GF/BZ/SC/DR
  Reapply "wifi: iwlwifi: remove support of several iwl_ppag_table_cmd
    versions"
  wifi: iwlwifi: make ppag versioning clear
  wifi: iwlwifi: mld: don't consider old versions of PPAG
  wifi: iwlwifi: mld: refactor iwl_mld_add_all_rekeys
  wifi: iwlwifi: mld: rename iwl_mld_set_key_rx_seq
  wifi: iwlwifi: mld: don't validate keys state on resume

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: mvm: remove MLO code

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |   1 +
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  34 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  39 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 271 +++---
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   3 -
 drivers/net/wireless/intel/iwlwifi/mld/key.c  |  38 +
 drivers/net/wireless/intel/iwlwifi/mld/key.h  |   7 +
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   2 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  10 +-
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  28 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 131 ---
 .../wireless/intel/iwlwifi/mvm/constants.h    |  20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 175 +---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  94 --
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 809 ------------------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  34 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 124 +--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 138 +--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 133 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  53 --
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 133 ---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 101 ---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  89 --
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  24 -
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   2 +-
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 433 ----------
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   3 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   8 +-
 36 files changed, 314 insertions(+), 2684 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c

-- 
2.34.1


