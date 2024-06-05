Return-Path: <linux-wireless+bounces-8527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32A78FC987
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 12:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5725F1F23D3F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A271922E3;
	Wed,  5 Jun 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VteIP5Q8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8B191493
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585052; cv=none; b=VxUckiUIEHyj4vlX3lS185RCoukyJzfpE4rIbH1DxU7GnkbG7gJ52BibiUqg/SlOmD8ziJLn6Z17wHpuSMgu0FLxU92GPk6RpncCmKuQxz3N2B1SUeDe66/R0JhPB6mv9SvYROe0tPSx9xTl6JXhaOK0sVw+3kq/cUV6zI/Nbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585052; c=relaxed/simple;
	bh=PefIPK+aLjyUFgDCSwFio13agGm4WPw3aiy8bDDuI1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=plH0kKoBQZMXSgXr5riNNnOXxaOHzU76fzcfOHc7AAOIgR2ayJn8OLKC1aLeS4mKozHYBT65eKhN/TxS5hJgw/mUNjFb69lVC1GMd3Exbu60n9tr+U1jQKpBrdGnAOwIqziLQ9Rv10UeBhC0njZ7X7iGNGVTiez5hXgvoMEFFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VteIP5Q8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585050; x=1749121050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PefIPK+aLjyUFgDCSwFio13agGm4WPw3aiy8bDDuI1k=;
  b=VteIP5Q81ixGoNcebwo1k9Cw7nLjFt03Lk6YH8WxVYzO58O3BAGTRFCF
   vHHsws/d4WGdeSXIujYF/se48mkbmkOZVGMUIZ0XP1l3J7+eMFha6vC7d
   TcFDOdXQfvuaF0VTgknt8RxafXbmrNeHrlumNBdl2ne1+147NSOFJdYVd
   NIVAN5QIKE9Rkqwikii3hxr9qjAtF7vu/W0IsgIkIFPOo+HhDIv1XCK0U
   7ZrWCcylLM7SHgMUp1NktrZxZOsXIpjNGNOj6TpXifrB7fXHMPQ7UC13o
   sqyJ0zFhCQjQnSWXl+AE33dSHptQVHfo0CcBTenphcucCZFT0RijC94Il
   w==;
X-CSE-ConnectionGUID: G823GktySGiazKMaUEJSCA==
X-CSE-MsgGUID: LXPdUboSRwqULIt6rJerTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11919943"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="11919943"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:29 -0700
X-CSE-ConnectionGUID: qzJFnh/YQT6XEJFiJS2QvQ==
X-CSE-MsgGUID: vspshHGsRpSxnjjTxbt1jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37562999"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/7] cfg80211/mac80211 patches from our internal tree 2024-06-05
Date: Wed,  5 Jun 2024 13:57:15 +0300
Message-Id: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
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

A bunch of patches from our internal tree with mac80211 and
cfg80211 changes. It's the usual developement, adding a few small
features.

Thanks,
Miri

Avraham Stern (2):
  wifi: nl80211: remove the FTMs per burst limit for NDP ranging
  wifi: mac80211_hwsim: add 320 MHz to hwsim channel widths

Emmanuel Grumbach (1):
  wifi: cfg80211: honor WIPHY_FLAG_SPLIT_SCAN_6GHZ in cfg80211_conn_scan

Ilan Peer (2):
  wifi: cfg80211: Add support for interface usage notification
  wifi: mac80211: Add support for interface usage notification

Johannes Berg (2):
  wifi: mac80211: fix erroneous errors for STA changes
  wifi: mac80211: clean up 'ret' in sta_link_apply_parameters()

 drivers/net/wireless/virtual/mac80211_hwsim.c |  1 +
 include/net/cfg80211.h                        | 12 ++++
 include/net/mac80211.h                        |  4 ++
 include/uapi/linux/nl80211.h                  | 16 +++++
 net/mac80211/cfg.c                            | 72 +++++++++++++------
 net/mac80211/driver-ops.h                     | 14 ++++
 net/mac80211/trace.h                          | 23 ++++++
 net/wireless/nl80211.c                        | 39 +++++++++-
 net/wireless/pmsr.c                           | 10 ++-
 net/wireless/rdev-ops.h                       | 13 ++++
 net/wireless/sme.c                            |  4 +-
 net/wireless/trace.h                          | 18 +++++
 12 files changed, 200 insertions(+), 26 deletions(-)

-- 
2.34.1


