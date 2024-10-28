Return-Path: <linux-wireless+bounces-14609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF29B364F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 17:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E6A1C2209C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C4188CCA;
	Mon, 28 Oct 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCx/twJo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B89189F20
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132358; cv=none; b=hJWVV0OHL3jSvMSUCh1ao3WFN/w+ycy3Bage7aYuDgp/KlAWiG/z+c+KJ4/DrO5+v6cZsrU5kEAuVeVX4/yF68aOPelnt8K0fBost3g3OhV6D2UACEoXXidGoZ293GKCZYirXW1NIUnPwOjJ8mVaLAZcTZi0lcaKfCKjoMCpIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132358; c=relaxed/simple;
	bh=ISveoEiAIA2hboxMjDT6Yk4cUl0LZmCppXxokMBa4h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMwsAqGgZpMY3WR9bH2OzN/blAV+jWTmVvV28fn/LOFewCjlHBX9dwAJX7NmQkpIqaXE0vSUlUCUjLnmoEtz9Lnbd9kwp7/3hPfDrH0//tDgEKLepQ9S8ACqGv5ss+HaxyOtYMSG6CoG9mBh6FHGvNkj4Mb/MKYtGPkD0anZjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCx/twJo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730132356; x=1761668356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ISveoEiAIA2hboxMjDT6Yk4cUl0LZmCppXxokMBa4h8=;
  b=LCx/twJoxLU2M4tDtR5FsLMGNljeRPikaTL3UfDG7PWxniDuzS2RjAix
   T0G36S2+e9J61EFneZb89eCR9deipmBVy4MHriiPVxoMbmf663ibwoIbr
   c7PQF5cijx2u2ol+sNo4Id/r/Cnet0oRhL3V9o9uZhSjI10wKJhPAqQSd
   N000xbJj1AewD0R7TxVfUXlSYpN9kA2Uu7+UpES20DZw8yCN3EplWQnsg
   ASi1fZA3McN0gxXaDGRnp7G9ajRY7Cam6ftEjDgf6NJdMR6DrI6gMoSZG
   cPajtbQaRgVuYgvfijLCZk6zfciEzl8lWOBlmjytcW3EQ03UTRL+Zz+sQ
   w==;
X-CSE-ConnectionGUID: LBp3bNibQwWAryN6G6VGEw==
X-CSE-MsgGUID: lrpl6EUdTEWGM8NscqFwKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41099891"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="41099891"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:15 -0700
X-CSE-ConnectionGUID: Wq6KJKzQTIaNpDP1t2FzdA==
X-CSE-MsgGUID: zXVmTTuYRxePCswIpyd80Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81561522"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/5] mac80211: change disassociation order
Date: Mon, 28 Oct 2024 18:18:57 +0200
Message-Id: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
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

This series contains patches that changed the disassocation order in
mlme code:
Instead of removing the AP STA completely, and then mark the vif as
unassociated
(which means that in between, the vif is marked as associated but there
is no AP STA. That makes little sense and may be a problem for some
drivers, as iwlwifi),
first move the state of the AP STA to NONE, then mark the vif as
unassociated, and only then remove the AP STA.

The new order will be used only for drivers that set a special driver
flag, so otherwise no impact on other drivers.

This series also contains the dependednt iwlwifi patches.

Thanks,
Miri
---

Miri Korenblit (5):
  wifi: iwlwifi: mvm: remove pre-mld code from mld path
  wifi: iwlwifi: mvm: send the right link id
  wifi: mac80211: add an option to filter a sta from being flushed
  wifi: mac80211: change disassoc sequence a bit
  wifi: iwlwifi: mvm: cleanup iwl_mvm_sta_del

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 31 +---------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 35 +----------
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 27 +++------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 59 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  7 +--
 include/net/mac80211.h                        |  4 ++
 net/mac80211/cfg.c                            |  2 +-
 net/mac80211/mlme.c                           | 24 +++++++-
 net/mac80211/sta_info.c                       |  5 +-
 net/mac80211/sta_info.h                       |  5 +-
 10 files changed, 75 insertions(+), 124 deletions(-)

-- 
2.34.1


