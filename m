Return-Path: <linux-wireless+bounces-16978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1FB9FFA55
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEED16084F
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252C1AB51F;
	Thu,  2 Jan 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3FaDOSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924317996
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827625; cv=none; b=EK0rOO1W5+l4LZGFIuoGi2Zn34rr4ZSJts1QflPagpsJMrf+TQZbQlvJDjaEk43aNkBcDOv8CcD0dsDURtFB/w3HOd+84YFf6+GsnDgrkrlhEk17iem9VhUFBDiez5QGeqDd9WGSCVuDe1LWmTbakgL+HOxmRGqAY8KVJHeW4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827625; c=relaxed/simple;
	bh=B4CEWOC/DG9QJcTMoj9T4v1BVyX6ivWRmNXZwz4GKjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q3h344VBgUsvsS419XeD5ZjXTgymNbcqbbpA/4erbPyboszAIfwAYkiZaJiMOTa8ipkrb9Jf52CTsf308Tj+RUYf9Wa8NPK5SHrCV7+aIPe3S7JdODJw2MTQE11slKP55xAd1d6Pyhe2xWXnuxEhnlIyleXxpTLOYjXnjSfRm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3FaDOSF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827624; x=1767363624;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B4CEWOC/DG9QJcTMoj9T4v1BVyX6ivWRmNXZwz4GKjc=;
  b=Z3FaDOSFddXF0CMC1894P9iSEsUp2rOa59wqBzjPMPFPbbH+Rh69FnBT
   sXFo6xKa1BSaBZXN48JtNeLU1jGVtDDKn6fFPH7m1ajJdAvIrYesytqK6
   SKn1j+xtWmbvbyG2tPKxIYXhLGwgaeOUbkntqZHpAYQeiQ4AGFFckEN51
   76XhswdSRGDSe+ElB3mrOke5a95xMvt4OT0jh4j9B/SY5IWtZcx0iI+bA
   UC/PYjRnf9MUP4BiTiMwqmkf8ej4JSA+Q0NbjZ+ro1LeB/Xx0Yvs0Ifsz
   D+18+eEx+iV2K22vABb5GdhqVpV2M6Uoy3uLzQNreBRcXJ0Djqn1yHu+l
   A==;
X-CSE-ConnectionGUID: McglT/acTdapVvVBDQlpZw==
X-CSE-MsgGUID: Dx/JYU94QS+N1YmBoONBOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735088"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735088"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:23 -0800
X-CSE-ConnectionGUID: 61/Y60LXQ9iSdll5ww8bdg==
X-CSE-MsgGUID: oj8M3XcsR7qIZ3PvspKtCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357344"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/17] wifi: mac80211: updates - 02-01-24
Date: Thu,  2 Jan 2025 16:19:52 +0200
Message-Id: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
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

A few bugfixes, cleanups and features (EPCS, ML Reconf)

Thanks,
Miri
---

Benjamin Berg (2):
  wifi: mac80211: pass correct link ID on assoc
  wifi: mac80211: set key link ID to the deflink one

Ilan Peer (9):
  wifi: ieee80211: Add some missing MLO related definitions
  wifi: nl80211: Split the links handling of an association request
  wifi: cfg80211: Add support for dynamic addition/removal of links
  wifi: mac80211: Refactor adding association elements
  wifi: mac80211: Pull link space calculation to a function
  wifi: mac80211: Support dynamic link addition and removal
  wifi: cfg80211: Add support for controlling EPCS
  wifi: mac80211: Fix common size calculation for ML element
  wifi: mac80211: Support parsing EPCS ML element

Johannes Berg (5):
  wifi: nl80211: simplify nested if checks
  wifi: iwlwifi: simplify nested if checks
  wifi: mac80211: don't flush non-uploaded STAs
  wifi: mac80211: ibss: stop transmit when merging IBSS
  wifi: mac80211: ibss: mark IBSS left before leaving

Miri Korenblit (1):
  wifi: mac80211: avoid double free in auth/assoc timeout

 .../net/wireless/intel/iwlwifi/mvm/binding.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   5 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   6 +-
 include/linux/ieee80211.h                     |  52 +-
 include/net/cfg80211.h                        |  55 ++
 include/net/mac80211.h                        |   2 +-
 include/uapi/linux/nl80211.h                  |  19 +
 net/mac80211/cfg.c                            |  24 +-
 net/mac80211/driver-ops.h                     |   3 +
 net/mac80211/ibss.c                           |   3 +-
 net/mac80211/ieee80211_i.h                    |  17 +
 net/mac80211/iface.c                          |   4 +
 net/mac80211/key.c                            |   2 +-
 net/mac80211/mlme.c                           | 922 ++++++++++++++++--
 net/mac80211/parse.c                          |  29 +
 net/mac80211/rx.c                             |  12 +
 net/wireless/core.h                           |   4 +
 net/wireless/mlme.c                           |  77 ++
 net/wireless/nl80211.c                        | 302 ++++--
 net/wireless/nl80211.h                        |   3 +
 net/wireless/rdev-ops.h                       |  34 +
 net/wireless/trace.h                          |  78 ++
 22 files changed, 1486 insertions(+), 174 deletions(-)

-- 
2.34.1


