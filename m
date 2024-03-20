Return-Path: <linux-wireless+bounces-4942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D76880BC4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767FA1C22721
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 07:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6521100;
	Wed, 20 Mar 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFM6CCBN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CA1EB52
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918856; cv=none; b=HVnTNMd96y/FY/ufYMS/mRHL+xI9tE5eKXgoHtCcs0e2ZAfA2u/M9VIgfzK2345cEi//GUARyUdQ47w+I3JuaMfk2lihnv5uJ10AsgivjvlaUzXym608WL1JfrdA24AnTodxeYp3e9SlKShimLYUHOFJDjEunlJNxCMsrPSrW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918856; c=relaxed/simple;
	bh=p0grTOr9ZISW4I7rcZOjh8ifd0rpGbtsCyJGH4v6psY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Honi+KB7jgJjCA8bYvx6dZFEBESkSDSpGdrBeRayUX1cMRqZvttqmvRARdHTgWOtyI0DMPZJ8iBuWjhhFnKfugSaOboTfVOFKbZtdXx9Tz+pVsId2z43IfbHMuMuuiM1XvpNZaTEFcHd2ldV3ILcyy2T+L51UdXBdc6QW+QBT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFM6CCBN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710918854; x=1742454854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p0grTOr9ZISW4I7rcZOjh8ifd0rpGbtsCyJGH4v6psY=;
  b=LFM6CCBNr0tbEnKlU4Qjma9EYPL08uIP+NXmbfrQ590FviogBN/bcEi3
   rGcRUgktORovMjGZJPFMBXAG7A3EkTLwDCoNUibR5kj/FiiFp9c6ipRf9
   PfoS/EzZzlKNLny1OjpH2GP0JOOL5u4qyVjpuIVA3CuUbqvir/M7ujHhT
   bQkIgKPQ6oF5RSryeMS0lyo0V4eiCCJFpUkLosmkuSWzoBRTbOP3OeuvD
   1m35sHZu2jDxofazu4MWgEGHkKSWgRk6s8G+oxtoTGrmQViZLC28539E1
   pzsbbGPqwRvMMrxbN8Bj6MlaWkEUJqWkwDd6Y/gOLssGFuENXUzIFFRXu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5763825"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5763825"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14477393"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:14:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] cfg80211/mac80211 patches from our internal tree 2024-03-20
Date: Wed, 20 Mar 2024 09:13:57 +0200
Message-Id: <20240320071405.815427-1-miriam.rachel.korenblit@intel.com>
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
cfg80211 changes. It's the usual developement:
features, cleanups and bugfixes.

Thanks,
Miri

Ayala Beker (1):
  wifi: mac80211: don't select link ID if not provided in scan request

Benjamin Berg (1):
  wifi: mac80211: do not call ieee80211_key_switch_links during reconfig

Ilan Peer (1):
  wifi: mac80211_hwsim: Declare HE/EHT capabilities support for P2P
    interfaces

Johannes Berg (5):
  wifi: mac80211: don't enter idle during link switch
  wifi: mac80211: clarify IEEE80211_STATUS_SUBDATA_MASK
  wifi: mac80211: don't ask driver about no-op link changes
  wifi: mac80211: improve drop for action frame return
  wifi: mac80211: reactivate multi-link later in restart

 drivers/net/wireless/virtual/mac80211_hwsim.c | 20 ++++++-----
 net/mac80211/chan.c                           | 34 +++++++++++--------
 net/mac80211/drop.h                           |  3 +-
 net/mac80211/ht.c                             |  2 +-
 net/mac80211/ieee80211_i.h                    |  6 +++-
 net/mac80211/link.c                           | 13 ++++---
 net/mac80211/rx.c                             |  4 +--
 net/mac80211/scan.c                           | 16 +++------
 net/mac80211/util.c                           | 12 +++++--
 9 files changed, 63 insertions(+), 47 deletions(-)

-- 
2.34.1


