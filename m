Return-Path: <linux-wireless+bounces-964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F930818386
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E35D286103
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1513FF7;
	Tue, 19 Dec 2023 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bW5tFN/N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77C13AC2
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975034; x=1734511034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vyVwl8VOlQKIZZ+qB1nGLh36OeNdSWGae98fDFkWIsU=;
  b=bW5tFN/N3uOHDGwmw23QqV361nh4MwnnmF4Qlqt5dU09fDptHeVFrS5w
   CtoKTO0nLlJQhidxqzGz2EFM/bW9zMQA4N3Q2vRjlUs7bqgq5YNa9E6jS
   p56FOEAadhYOh5+G6pHpY8uLg9qQI2ANsBEVDRVaUr/1+KAbLI4hxGsGB
   LpCd1ZroSuQslSC/XgGNMgTkZ4TYWgSQwrLIznIi2jjIE0aBfPUqpZDh0
   B/61OTEnkq7VMQE++yti9qqTbS4qXQ5p7EMNoK0M6Iuh7zG0pKm3f7PY+
   gkM5RSLM41KYeoNCYtb97RFLWK12WKKQ4LBVz4yCRfXvIl6wnBqZD6Rov
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969094"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969094"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846265903"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846265903"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] cfg80211/mac80211 patches from our internal tree 2023-12-19
Date: Wed, 20 Dec 2023 04:37:48 +0200
Message-Id: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
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
features, bugfixes, and cleanups.

Thanks,
Miri

Andrei Otcheretianski (4):
  wifi: cfg80211: reg: Support P2P operation on DFS channels
  wifi: cfg80211: Schedule regulatory check on BSS STA channel change
  wifi: mac80211: Schedule regulatory channels check on bandwith change
  wifi: mac80211_hwsim: Add custom reg for DFS concurrent

Ayala Beker (1):
  wifi: mac80211: fix advertised TTLM scheduling

Benjamin Berg (5):
  wifi: cfg80211: free beacon_ies when overridden from hidden BSS
  wifi: cfg80211: ensure cfg80211_bss_update frees IEs on error
  wifi: cfg80211: avoid double free if updating BSS fails
  wifi: mac80211: do not re-add debugfs entries during resume
  wifi: mac80211: add/remove driver debugfs entries as appropriate

Johannes Berg (2):
  wifi: mac80211: rework RX timestamp flags
  wifi: mac80211: allow 64-bit radiotap timestamps

Miri Korenblit (2):
  wifi: mac80211: add a driver callback to check active_links
  wifi: mac80211_hwsim: support HE 40MHz in 2.4Ghz band

Mukesh Sisodiya (1):
  wifi: cfg80211: handle UHB AP and STA power type

 drivers/net/wireless/virtual/mac80211_hwsim.c | 25 +++++
 include/linux/ieee80211.h                     |  1 +
 include/net/cfg80211.h                        | 19 ++++
 include/net/mac80211.h                        | 23 ++++-
 include/uapi/linux/nl80211.h                  | 29 ++++++
 net/mac80211/debugfs_netdev.c                 |  9 +-
 net/mac80211/driver-ops.c                     | 14 ++-
 net/mac80211/driver-ops.h                     | 20 ++++
 net/mac80211/ieee80211_i.h                    |  5 +-
 net/mac80211/link.c                           |  3 +
 net/mac80211/mlme.c                           | 50 ++++++++--
 net/mac80211/rx.c                             | 13 ++-
 net/mac80211/trace.h                          | 25 +++++
 net/mac80211/util.c                           | 16 ++--
 net/wireless/chan.c                           | 94 +++++++++++++++++--
 net/wireless/nl80211.c                        | 24 +++++
 net/wireless/reg.c                            |  8 +-
 net/wireless/reg.h                            |  5 +
 net/wireless/scan.c                           | 79 ++++++++++++----
 net/wireless/sme.c                            |  2 +
 20 files changed, 405 insertions(+), 59 deletions(-)

-- 
2.34.1


