Return-Path: <linux-wireless+bounces-30932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3ED3932C
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 08:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54EC4301174C
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 07:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A101DE894;
	Sun, 18 Jan 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaqLC1Lf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DC50096A
	for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768722688; cv=none; b=Bij1A+dr8PWKANjlVTVd44OjahrcXccnYd7Ed44qdvsrokOCgZ27sBYhrC/lBZWcG75utaP+0T22m1El2EctdniI1mitV1HLHJZIaF4wwcLmemlXqKjfeooDC4ZkY0qN7f2ss4E4/hBuEYXRIs6ZMShMsLxUks7kKjuvDYHQjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768722688; c=relaxed/simple;
	bh=C6bFslO5cwLXD7MiJ9fz3u0gvXGhywiBbU4uT/fks5I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=IfFqNfjaknouSSddy1QLLJnO0gVT5OlK0S/6R4fdjLLaTuRAOsD55b5IohgHfjUuwLUxNvuQLR8kIY5W25Pm1SuL5aPYdKsFLBD1+kNjQqB60JpVjI7JN7zkItd9llMayvlnpVG8fe+ALbiL6tFyTPhe9MzybVnaHu2RxbpxtWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaqLC1Lf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768722686; x=1800258686;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C6bFslO5cwLXD7MiJ9fz3u0gvXGhywiBbU4uT/fks5I=;
  b=YaqLC1LfUwISBcjzM9fKK5TkWc2EuOHhsk2Y/OnCCF+tGee7tA5H+GKM
   ZZ7eQIq37e29bGOP9a2Psq4wrqriTngll4oC2NDAL+FXTY9USMc0XBgtx
   Yvfsahr92ip6IDaEFH9NfiLfNXjaZqDgwgI3FycfT8bdTDpv+yCRrrJi+
   k2k/2k+wzq7I6uQ0VbIQ6O90U04ozrpp3F3jKSHoUAsSgiOaiVVkcsQr+
   NXk2YotxYMzM3iaqJCiOZPZFjjdDgr1Z1PAl3q9K20DPcTA6vSVIsLuV9
   C32sWCUty7HOQyY2Qdj+lEDAVTE9nteaa/NB/wz1X+w4chGeUr4InTIxn
   w==;
X-CSE-ConnectionGUID: wgTmi4pETOilTOCo4hX+Vg==
X-CSE-MsgGUID: H/U+DOCKRnqpc2tXg3bZeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="87546806"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="87546806"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:51:25 -0800
X-CSE-ConnectionGUID: Fa2PYqV/TOCMBLwPFE/m/Q==
X-CSE-MsgGUID: HpYLk9OxRIqZTtGV3EExUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="236278486"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:51:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi 0/3] wifi: cfg80211/mac80211: apply advertised TTLM from association response
Date: Sun, 18 Jan 2026 09:51:12 +0200
Message-Id: <20260118075115.808517-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This series implements applying advertized TTLM from the association
response. This required a preparation patch to parse a TTLM entry
without a switch time,
and is followed by a cleanup patch that removes the no longer needed link
disabled flag.

Benjamin Berg (3):
  wifi: mac80211: parse all TTLM entries
  wifi: mac80211: apply advertised TTLM from association response
  wifi: cfg80211: ignore link disabled flag from userspace

 include/net/cfg80211.h       |   3 -
 include/uapi/linux/nl80211.h |   5 +-
 net/mac80211/ieee80211_i.h   |   2 -
 net/mac80211/mlme.c          | 213 +++++++++++++++++++----------------
 net/wireless/nl80211.c       |  10 --
 5 files changed, 122 insertions(+), 111 deletions(-)

-- 
2.34.1


