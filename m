Return-Path: <linux-wireless+bounces-25187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6B9B0094D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E63A37A36F9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29BA2EFDB6;
	Thu, 10 Jul 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7O2JCw4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2D25B1D2
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166511; cv=none; b=R8vUVKndxMDOaKefjAlXfWoqYEMDnEtQvQsmbmIQ3wy3SxdJmdUYKJCFpti2ypBFIGHAv8cRIV4D97T+fO6H1+FmWwLjiL0MroXccOz7MWU7FB4zbFQ1Vg5W+8znDEgBDxNXXm9v3PJ8N9ZnSk2wIgy75w1NW9ZN4AfazRjrSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166511; c=relaxed/simple;
	bh=ZrR56wnglWw7spPg+Vk2jcxnTW0MeVaieFSR1p5a1Kc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GNnpkih7f4KAjl3e80TR61e5hhOqzee+Gll6atF6+uylUV9DzLyTmGBYk6KdXkZTiVI8OQh/ilQPLy0RVSvat0ubYqLav55FYADUgFdJTEeTONOaNMJkz2vA9eMhhd7lyeVEnE3MeDDGDKlDTVxXqhoBMYducH6jZedgavTxqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7O2JCw4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166510; x=1783702510;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZrR56wnglWw7spPg+Vk2jcxnTW0MeVaieFSR1p5a1Kc=;
  b=k7O2JCw4r4bnDw0BdCJ3Y9kRhiOpej34F1NsSu2cfTroWuyu3dAXE/JD
   ZDuX2nWwhuqFap2X1AJyDYGPYFHTKLybQPFHQt7fiHzdmNIVhtLopWAnZ
   5kvwqAfjUJ918qiPPJ5eZB4qmnnU74ZBvWoG7UuIG0rdwrEjBqhU808bf
   J3OoDevL2lOINFZA3dq14EC4veW7hl1SRk8ofLYBBYwDl76Fw9lh+xMlv
   wFCwJGPwpCEvub5SwXAxIy65t0EBtfDPEBY+IX3t80zjhwITaecRlp89g
   K3zvZ2aDQYmKmzlqD+osfq99ugHDbHbkXZ5NCOWE7EZIx0PsJpvQN0ERS
   w==;
X-CSE-ConnectionGUID: ELlybsd6SGKCfNXrPms68w==
X-CSE-MsgGUID: LLZQuZhxS9K5FaU0OvbIKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54609983"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54609983"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:09 -0700
X-CSE-ConnectionGUID: 8IlOoaKOR9G/oFITybS5bw==
X-CSE-MsgGUID: brHqEAneQIWZSF2OQ5uTGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156276974"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/15] wifi: iwlwifi: updates - 2025-07-10
Date: Thu, 10 Jul 2025 19:54:33 +0300
Message-Id: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
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

Features, fixes and cleanups from our internal tree.

Miri

Avraham Stern (3):
  wifi: iwlwifi: mld: fix scan request validation
  wifi: iwlwifi: mld: update the P2P device mac before starting the GO
  wifi: iwlwifi: mld: update expected range response notification
    version

Johannes Berg (4):
  wifi: iwlwifi: mvm: remove regulatory puncturing setup
  wifi: iwlwifi: mld: restrict puncturing disable to FM
  wifi: iwlwifi: fix HE/EHT capabilities
  wifi: iwlwifi: pcie: don't WARN on bad firmware input

Miri Korenblit (4):
  wifi: iwlwifi: mvm: set gtk id also in older FWs
  wifi: iwlwifi: mvm: always set the key idx in gtk_seq
  wifi: iwlwifi: mvm: don't remove all keys in mcast rekey
  wifi: iwlwifi: mld: don't remove all keys in mcast rekey

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: add support for accepting raw DSM tables by firmware

Rotem Kerem (3):
  wifi: iwlwifi: add suppress_cmd_error_once() API
  wifi: iwlwifi: add iwl_trans_device_enabled() API
  wifi: iwlwifi: add iwl_trans_is_dead() API

 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   6 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |   6 +
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  35 ++++--
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   4 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  78 +++---------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  15 +++
 drivers/net/wireless/intel/iwlwifi/mld/ap.c   |  24 ++--
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 112 ++++++------------
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/key.c  |  12 ++
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c  |  14 ++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   2 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   2 +-
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  30 +++--
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  85 ++++++-------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |  11 +-
 27 files changed, 230 insertions(+), 239 deletions(-)

-- 
2.34.1


