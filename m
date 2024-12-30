Return-Path: <linux-wireless+bounces-16883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DCC9FE279
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45803A0618
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA0713633F;
	Mon, 30 Dec 2024 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abSPrF4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D408152E02
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534571; cv=none; b=okG56J+9awjtwe3xExgelo60r9WDu0wWhox7TyibiFjMx8skusveptPuQOGnSNHc/Ott7j4bM+InkMuG+GMujpx/Wte0O3iQKk4QfWnbLBCy+tKAMG3OqoBQKn8dvBNT1MYDkfaZTpnZ4VyUBfH47IYTraNiM5U2XuEeSXXb2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534571; c=relaxed/simple;
	bh=FlPkXLr9UgSKNIeepRzSEHQRdRpV4J7rkIRqQWpS2Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LZ3V+WS5tamumgpKsxZgxUeJirkbwAZL4gEKeCUlGo3/V+oMmh5u/7Qg7FUBU0aawuyMx2k1ennXV2SybbIFN3yvZ4QVja6RyiA3wP4zHiOcS+CbVdnj0nn33wZFsAHLeLBq7L6ttcvKcYu/hKjFQeqlJ6ihxifayBLxRthLahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abSPrF4L; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534569; x=1767070569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FlPkXLr9UgSKNIeepRzSEHQRdRpV4J7rkIRqQWpS2Uc=;
  b=abSPrF4LZvKFCFpjEWqiv09kTK+Ta5TPiNcUaXDPU8Bqx/KYHRNOjv4w
   7veNnooWbANVE/tiyuAtUAcj6vO2VNxIvtb8mhyF9TRbnra0w3pQiPZNh
   1eYv4lZTDhIMdl3Ia6JCr0P43iCn9z/x4XjTR73+sjBxzdU6oj92KdlAO
   3gMDi8lMpthJaJP01pd5ZB2xJnHrAn+ntsQuRzwyp1RLVTJHun8nE+saf
   OM29XEbySR7fTOVKGzE5ngNxfJYfdmDABuVjp6dDn3Plp+uS2v9lVEpoz
   aHsVIicMJ4wR8CzXVl+1rHQmn2NAkpkl4SeUU2CLerezSiGtIj7bDJCtT
   Q==;
X-CSE-ConnectionGUID: P6cHc9CLSL2bue3la8xZ5Q==
X-CSE-MsgGUID: vmAJ4uPkSiCHG2OkRcxatQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46404998"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46404998"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:08 -0800
X-CSE-ConnectionGUID: HRC5uqQbRMO8IrtWkEfmzg==
X-CSE-MsgGUID: mdzO28zXRRuI2c6R0viEsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758856"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:07 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] [WIRELESS-NEXT] wifi: mac80211: updates - 30-12-24
Date: Mon, 30 Dec 2024 06:55:39 +0200
Message-Id: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
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

A few features, cleanups and bugfixes from our internal tree.

Miri
----

Benjamin Berg (3):
  wifi: mac80211: Remove unused basic_rates variable
  wifi: mac80211: fix typo in HE MCS check
  wifi: mac80211: log link information in ieee80211_determine_chan_mode

Emmanuel Grumbach (2):
  wifi: mac80211: remove an unneeded check in Rx
  wifi: mac80211: improve stop/wake queue tracing

Ilan Peer (4):
  wifi: cfg80211: Fix trace print for removed links
  wifi: ieee80211: Add some missing MLO related definitions
  wifi: nl80211: Split the links handling of an association request
  wifi: cfg80211: Add support for dynamic addition/removal of links

Johannes Berg (5):
  wifi: mac80211: add some support for RX OMI power saving
  wifi: mac80211: reject per-band vendor elements with MLO
  wifi: mac80211: mlme: improve messages from config_bw()
  wifi: cfg80211: scan: skip duplicate RNR entries
  wifi: cfg80211: check extended MLD capa/ops in assoc

Miri Korenblit (1):
  wifi: mac80211: clarify key idx documententaion

 include/linux/ieee80211.h    |  74 ++++++++++-
 include/net/cfg80211.h       |  45 +++++++
 include/net/mac80211.h       |  48 ++++++-
 include/uapi/linux/nl80211.h |  10 ++
 net/mac80211/chan.c          |   7 ++
 net/mac80211/debug.h         |  10 +-
 net/mac80211/he.c            | 119 +++++++++++++++++-
 net/mac80211/main.c          |   5 +
 net/mac80211/mesh_plink.c    |   5 +-
 net/mac80211/mlme.c          |  54 ++++----
 net/mac80211/rx.c            |   3 +-
 net/mac80211/sta_info.c      |  18 +++
 net/mac80211/sta_info.h      |   7 ++
 net/mac80211/trace.h         | 120 ++++++++++++++++--
 net/mac80211/util.c          |  10 +-
 net/mac80211/vht.c           |  33 ++++-
 net/wireless/core.h          |   4 +
 net/wireless/mlme.c          |  84 +++++++++++++
 net/wireless/nl80211.c       | 235 ++++++++++++++++++++++++-----------
 net/wireless/nl80211.h       |   3 +
 net/wireless/rdev-ops.h      |  19 +++
 net/wireless/scan.c          |  13 +-
 net/wireless/trace.h         |  46 ++++++-
 23 files changed, 845 insertions(+), 127 deletions(-)

-- 
2.34.1


