Return-Path: <linux-wireless+bounces-15507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B52969D2A07
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 16:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D21B24A93
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115351CF2B6;
	Tue, 19 Nov 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpzTHx4o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97D1CCB35
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030558; cv=none; b=NN0o0Gd53KwJ2lXf8/le/ARVhPlisFtCu+AsY7jA2DS5cRp5zZMNt+qDBSih2dQPkAxPI1F1izYR84AWfb3VUMTpdqW/+TYUDxB43s3PFuz+VKMQ7A5eKZVrtVoJW1he6nzaeA/+bzaIW2CVqhvyzwEpp5WRhEUsqA2KZfSbp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030558; c=relaxed/simple;
	bh=CSGXEB/ASH2zGk+dzWUt47mdUMVSzD/wcU/+I/r5dPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pxwW/7CHO3ZNYsSBeK6McpEGBPKautxg4BjWzZa9/LG0xe+nBYcp/9CvoA7ig9xJzJVCqmF50JUXaTArOdt10JMWIe2dPFh2KBs7Uj/eq5sSkOuURWd/c/Wr3PjMAbRcyuJa7dDw73NKy9cZqZUcDdhXEJimnh0uRSP3bHJ3z5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpzTHx4o; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732030556; x=1763566556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CSGXEB/ASH2zGk+dzWUt47mdUMVSzD/wcU/+I/r5dPs=;
  b=GpzTHx4om+rcrmvN1vl/9+qb6UPHwF7wFZVw7vzquDKNysUE3SlAw/Np
   C6GhxMO/k/msMQ8AxEWuvmnDs/VdMN+jA4okT9eMAYwetdF5fp2eG1QHD
   iQGhvL5q0UYrxahkNo09YroLjMFL6bA2D1gQPUsU+ZXsOq4RtN4y2U5Pq
   pTF3N2YUdieNGJowP11uZgvIlhqU1LJJ/DCzYyvbV3qgq97skFZ2hElY0
   HsApOUHJjwzpeIE0sEC+7rlJKdrl5KcCKn5RqVS3DZaCnt7vP9fbeUZ1p
   tHnETuhv+DmBLnolA9rXmWniPTQ/VuVrqzK+DY1K4VbR2P55CDHg42HKI
   g==;
X-CSE-ConnectionGUID: ErMk9MERQwiv78NY+n/mHg==
X-CSE-MsgGUID: SnHuB+3KQlubJi1K4EEUXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32284126"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32284126"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:35:55 -0800
X-CSE-ConnectionGUID: 1BEF0ZtbQPCh7MVAWx8JuQ==
X-CSE-MsgGUID: 9kmgICcLRX++I/wtq7Ub/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89180878"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:35:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] wifi: mac80211: a few bugfixes
Date: Tue, 19 Nov 2024 17:35:38 +0200
Message-Id: <20241119153540.594699-1-miriam.rachel.korenblit@intel.com>
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
This patch series addresses two issues in queue management: during CSA
and during resume failure.

Emmanuel Grumbach (2):
  wifi: mac80211: wake the queues in case of failure in resume
  wifi: mac80211: fix a queue stall in certain cases of CSA

 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 include/net/mac80211.h                        |  4 +-
 net/mac80211/cfg.c                            |  3 +-
 net/mac80211/ieee80211_i.h                    | 49 +++++++++++++++----
 net/mac80211/iface.c                          | 12 ++---
 net/mac80211/mlme.c                           |  2 -
 net/mac80211/util.c                           | 26 +++-------
 7 files changed, 53 insertions(+), 45 deletions(-)

-- 
2.34.1


