Return-Path: <linux-wireless+bounces-16785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAB69FC0F5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 18:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5A7164257
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006020E327;
	Tue, 24 Dec 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edde2h+q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726EF14D433
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061269; cv=none; b=AxgFoOYM0plPvnHxreohhBjsIz+LvnPCz+rCHqe/ok5qEhzGxNgnf20sW2ISqdRFQfvxsIuAVOg/wWtufb3dZhariPFkvFA7eisYwVQyHB5ILeT3/bPw0n+7i/LWkX8alUup0SyPIgSjRIDnPcrDRlxGAS8z8qYzY0OsL43RUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061269; c=relaxed/simple;
	bh=+8yD7KuQo9ztU0BY50UQRast+XKdn1osiM6gAhEJ7rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oTb9am7xivV08pK2HZWh+HdoQ78Z1muzHPiR3t/qiROkAvDXC3F12E09xDLL6bDp0SZr7K2c72bp47PqkEWoheZwIU2qKCa8ZeH/sWwDwOY0hgTL0eVMXowbb4eFqqQiTfVHhb2I1s7j+8F4NnkjUUcVSJRwgT7h/N3Die/jgfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edde2h+q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735061267; x=1766597267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+8yD7KuQo9ztU0BY50UQRast+XKdn1osiM6gAhEJ7rk=;
  b=edde2h+qiA55pSCyvHw5wyqHH+JEdZCFLPF+GUHyNpfHEk2vI7Oq2gN/
   VwD859J6Oy2dHEysVZAO5sfoGOXdNdTTLUis44X1Eb+R1tSCAL5++aDz9
   xptw2tKPztubOd97S6AOzSsZIafG/GrPq1jzK7+FL7Vn/IO2JCek6iZz9
   MXWCJCv7bGpAVGGNgsONSQQjSMa3pN9dCDfo7QCwTLCC5cvB4tO6dV9tT
   es+Am2AN9TBMkMtC9XGibQBlGwkifzui7xTmurkM9T5+va/qmsyX5AryX
   TUqidqRJT/n0UWogYunLIEdDE0Ays8RSmv7Vtn79aGn4bl23q8n83jE4E
   Q==;
X-CSE-ConnectionGUID: GHZDIlJCQ8mk3QgTxejUkg==
X-CSE-MsgGUID: za8zGk7CTcyf3wHxHGVImg==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39311117"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="39311117"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:47 -0800
X-CSE-ConnectionGUID: nPUN7LT0R8mK4tGCE4VVYw==
X-CSE-MsgGUID: kISz+NctRsm3IYUgIsmIWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="99341008"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [RESEND] [PATCH 0/5] mac80211: change disassociation order
Date: Tue, 24 Dec 2024 19:27:26 +0200
Message-Id: <20241224172731.2640748-1-miriam.rachel.korenblit@intel.com>
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

This series contains patches that changes the disassocation order in
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


