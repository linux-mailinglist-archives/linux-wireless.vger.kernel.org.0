Return-Path: <linux-wireless+bounces-7178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B418BBF6C
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB21F216F6
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22417184D;
	Sun,  5 May 2024 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOPqTayx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128FC567F
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890010; cv=none; b=T1zX0yspYSU0xkiOBsINKnbxjj5N9OvjOUfXU/6fCPloNmGKE5TB6hvcfZ/s33xZMMmWLPB25M4h0ztTq24uVkwvPClsM0HyvvbgU4bQN5fulaS5JFZR9qnuwkpPLruKdqD9vvx2yU3ucF++ahYYEQsZ17ClqAAJClF/fp9+aS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890010; c=relaxed/simple;
	bh=j4o1aculQtrNPOyyT7E0a/fQ88wg4sNuLlcM4oMc//Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lmP2dQv3IvHBvQxSF6OBCLYvqqdQklA1XcFjPMKvq5R40h7Ji9T+0TwLsMhYZbPMKMmFpDPOgbdstnRkrD9d0JA2SWXrFoCL2K2qjsulta9D6Ic7zoLNqUkkCJaraS5Qc5PFRxf1I0v+q4/O8RYYlBNz3naXu7GIqdh3IuYXEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOPqTayx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890008; x=1746426008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j4o1aculQtrNPOyyT7E0a/fQ88wg4sNuLlcM4oMc//Y=;
  b=XOPqTayxpM/t1GhU8q4JSMmChvW4Dzu2//MyZ1qQR+qltWdey7qr74yH
   26hEXt5FhvJsK3gL8ZY3RZsYbSRyAjFxgc70RKYdwPFOOAYQNhTrAi6Ib
   trrEdYDxWkudW5bTVokAMC/bVT8qbunRCbnvkuXTShrK4xpWbXIq7NKjR
   066IEhrFq7WdMDAxQKpbpKZLYgP5n43YUI4H3FLs4ovFmuPS/dTedFZym
   W+SNVI9K3RoufHxvhrYDeXoAKCM2T//5D93Tq5GZ9B+OcnWnrjwkVjPLH
   bGvn8HjG/5CA6mly+5U/1iNraha8rHFTsJN/+9btdyha3oyQJi4XlIwM4
   g==;
X-CSE-ConnectionGUID: N63+/sGxQZ2Z+NgxLojMug==
X-CSE-MsgGUID: mEptSycSQWi6goy7/Wm9zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461799"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461799"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:07 -0700
X-CSE-ConnectionGUID: 81z//wUMS1i49oQLjZMO5w==
X-CSE-MsgGUID: 9ZkxyrCfRJyoxceCoIAdqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903568"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2024-05-05
Date: Sun,  5 May 2024 09:19:44 +0300
Message-Id: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.10. It contains
a few features, bugfixes and cleanups.

Thanks,
Miri

Daniel Gabay (1):
  wifi: iwlwifi: Print ESR states name

Johannes Berg (2):
  wifi: iwlwifi: mvm: exit EMLSR when CSA happens
  wifi: iwlwifi: mvm: don't reset link selection during restart

Miri Korenblit (10):
  wifi: iwlwifi: cleanup EMLSR when BT is active handling
  wifi: iwlwifi: mvm: trigger link selection after exiting EMLSR
  wifi: iwlwifi: mvm: add a debugfs for (un)blocking EMLSR
  wifi: iwlwifi: mvm: Always allow entering EMLSR from debugfs
  wifi: iwlwifi: mvm: don't always unblock EMLSR
  wifi: iwlwifi: mvm: Activate EMLSR based on traffic volume
  wifi: iwlwifi: mvm: consider FWs recommendation for EMLSR
  wifi: iwlwifi: mvm: trigger link selection upon TTLM start/end
  wifi: iwlwifi: mvm: avoid always prefering single-link
  wifi: iwlwifi: mvm: fix typo in debug print

Yedidya Benshimol (2):
  wifi: iwlwifi: mvm: Disable/enable EMLSR due to link's bandwidth/band
  wifi: iwlwifi: mvm: Block EMLSR when a p2p/softAP vif is active

 .../wireless/intel/iwlwifi/fw/api/datapath.h  |   7 +
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  42 +--
 .../wireless/intel/iwlwifi/mvm/constants.h    |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  17 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  53 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 289 +++++++++++++++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 129 +++++---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 136 ++++++++-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  51 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  25 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  50 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  49 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  86 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  24 ++
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 113 ++++---
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   7 +-
 20 files changed, 919 insertions(+), 228 deletions(-)

-- 
2.34.1


