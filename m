Return-Path: <linux-wireless+bounces-595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13280BACA
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908F6280C99
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7048C134;
	Sun, 10 Dec 2023 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7U7Meow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15466A6
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213493; x=1733749493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ENQ9Mn8M2QVd+OlbdSsTwWfUxrcqzNimDmtirbkCXA=;
  b=T7U7MeoweB8E3LY2BTjq5JMgiSG1n359ys5c7GvEG3Zm/vliHqBqhMgG
   z/+M72BKjvHMEss+SV0P5rnVBjV1CfHsEPMbQL964oLpozNyBahzljPhi
   nkLDu9l4TK4DKf7V/Tj9JB1gaRAN5yWBiE26Hy7oppKFh5ybqHMGFSOfD
   8WX4hURpCVp8nJgXlXm0VmkfQKL02qXsfdTKHRZcJSmpxbgfakyvE/GdL
   jhD4m2AV+vYKpnTsOwaSF43Fkm0xGdkNW53f9XuRNYsqzFDJXGLkIm0KD
   4MQKyGztM6ULQxJqNqO0Mch+Ib1MzP6PNKlSaFc5juHeEtZP4KyfX43CY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480745621"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480745621"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748925394"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748925394"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:04:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/14] cfg80211/mac80211 patches from our internal tree 2023-12-10
Date: Mon, 11 Dec 2023 09:05:18 +0200
Message-Id: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

Hi,

A bunch of patches from our internal tree with mac80211 and
cfg80211 changes. It's the usual developement, adding a few small
features, bugfixes, and cleanups.

Thanks,
Miri

Andrei Otcheretianski (2):
  wifi: mac80211: Replace ENOTSUPP with EOPNOTSUPP
  wifi: cfg80211: Replace ENOTSUPP with EOPNOTSUPP

Benjamin Berg (2):
  wifi: cfg80211: generate an ML element for per-STA profiles
  wifi: cfg80211: consume both probe response and beacon IEs

Ilan Peer (2):
  wifi: cfg80211: Add support for setting TID to link mapping
  wifi: cfg80211: Update the default DSCP-to-UP mapping

Johannes Berg (8):
  wifi: mac80211: don't re-add debugfs during reconfig
  wifi: cfg80211: add BSS usage reporting
  wifi: mac80211: update some locking documentation
  wifi: mac80211: add a flag to disallow puncturing
  wifi: mac80211: don't set ESS capab bit in assoc request
  wifi: mac80211: check defragmentation succeeded
  wifi: mac80211: mesh_plink: fix matches_local logic
  wifi: mac80211: mesh: check element parsing succeeded

 include/net/cfg80211.h       |  78 ++++++++++++++++++++++---
 include/net/mac80211.h       |  23 ++++----
 include/uapi/linux/nl80211.h |  59 +++++++++++++++++++
 net/mac80211/cfg.c           |   4 +-
 net/mac80211/chan.c          |   4 +-
 net/mac80211/debugfs.c       |   1 +
 net/mac80211/driver-ops.c    |   6 +-
 net/mac80211/driver-ops.h    |   2 +-
 net/mac80211/mesh_hwmp.c     |   2 +-
 net/mac80211/mesh_pathtbl.c  |   8 +--
 net/mac80211/mesh_plink.c    |  16 +++---
 net/mac80211/mlme.c          |  29 ++++++++--
 net/mac80211/scan.c          |   4 +-
 net/mac80211/tdls.c          |  18 +++---
 net/wireless/core.h          |   3 +
 net/wireless/nl80211.c       |  95 ++++++++++++++++++++++++++----
 net/wireless/rdev-ops.h      |  26 +++++++--
 net/wireless/scan.c          | 108 +++++++++++++++++++++++++++++------
 net/wireless/trace.h         |  20 +++++++
 net/wireless/util.c          |  46 +++++++++++++++
 20 files changed, 467 insertions(+), 85 deletions(-)

-- 
2.34.1


