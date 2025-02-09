Return-Path: <linux-wireless+bounces-18661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D617CA2DDC9
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2261A1885528
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384574040;
	Sun,  9 Feb 2025 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vs4ImPi+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE9243378
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104512; cv=none; b=HxgD9gKD3Nssx/WPFfCWkjpCCD2YVr4bY10XWKvSEIbVj7jFnDHJvnqmZ2lOwM++ThIv0NqZ05fAk2+bQ2yiSZrad1ISOvKgfB060S8wprsjs+1NzteDsXS2WxummQSjJ3/Wdy83un/Q3hyUwsoIIVDQylBm7j2wraFGilpee5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104512; c=relaxed/simple;
	bh=YpuaS5BO7Gui483cBtc19ev2L4oh+FrsvpdJEsfr3c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FxnycAjxRKIHzVYTGQzyEyV3UpWLHnAizilPLgcjiV0cqfafqwwhSeskanzZAuAw6GXiZzawlM8u0lKrn41fHIqCFzatpQ9zzyFwDO+qZdkq4VWTo9RyDYmD6eH0dl2hl/AMF5K/bNCIpVAhW+QGrqs8cPiC5E7DtN+YncwjIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vs4ImPi+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104510; x=1770640510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YpuaS5BO7Gui483cBtc19ev2L4oh+FrsvpdJEsfr3c8=;
  b=Vs4ImPi+nLjRNBPoxPC/DP6i0Ns3e6fgsHP1C9n+k8De1hVrKJAggNr2
   vFOX37IzrKsf+vcFtvE0KySzW65znLEApz+MH1vNTYDRoi5lBqB68lS0k
   NQSTUjiljAUkC+0wfwXZt/GbA5qKm9FiwT/eckZ2aECZJnRI/v+Spj1sj
   +DnPANmnBY5rtyS+gVMGH6YyCcms+64Lk/aBryoKmiKkeVyNl2u/sPXq5
   cdFLXZuUJG2tyXg9+vGX9iFqAO1Bd/WQAUDblozKDxs+dgbKt/OCJUvSG
   nBmbRWrL9Ictl5UHl65TZFXAmrNQCbMDKnPLfIsV6guVwDe/6vcjPYYI/
   w==;
X-CSE-ConnectionGUID: 6zKvISeoSUaaqjyFVzj6pw==
X-CSE-MsgGUID: nTLHQkvjRgS5JSpsS47HQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125968"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125968"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:10 -0800
X-CSE-ConnectionGUID: ApUYjFT0RuGbPNMjttBxkg==
X-CSE-MsgGUID: bar+jpBTRnW5/+yzH4ZmKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782389"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/9] [WIRELESS] wifi: iwlwifi: fixes - 2025-02-09
Date: Sun,  9 Feb 2025 14:34:44 +0200
Message-Id: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
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

This series contains fixes from out internal tree.

Thanks,
Miri
---

Emmanuel Grumbach (3):
  wifi: iwlwifi: mvm: don't dump the firmware state upon RFKILL while
    suspend
  wifi: iwlwifi: mvm: don't try to talk to a dead firmware
  wifi: iwlwifi: mvm: use the right version of the rate API

Ilan Peer (2):
  wifi: iwlwifi: Free pages allocated when failing to build A-MSDU
  wifi: iwlwifi: Fix A-MSDU TSO preparation

Johannes Berg (3):
  wifi: iwlwifi: fw: allocate chained SG tables for dump
  wifi: iwlwifi: mvm: clean up ROC on failure
  wifi: iwlwifi: limit printed string from FW file

Miri Korenblit (1):
  wifi: iwlwifi: fw: avoid using an uninitialized variable

 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 86 +++++++++++++------
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  3 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 77 +++++++++++------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  7 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  8 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +
 .../wireless/intel/iwlwifi/pcie/internal.h    |  5 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 20 +++--
 10 files changed, 145 insertions(+), 71 deletions(-)

-- 
2.34.1


