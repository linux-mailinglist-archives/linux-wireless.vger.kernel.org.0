Return-Path: <linux-wireless+bounces-1395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923CC822217
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406F228421D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750315E96;
	Tue,  2 Jan 2024 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9Z7FqZ6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A115E90
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224154; x=1735760154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nXQCPuW8XuXCPP/G4F8dk+uJiBFLmby+XyJLaZpkamU=;
  b=G9Z7FqZ6UrWI6CZRBZKVxXOQK0ypdceif0nGlc3t7iyEZaCDDtrla0rP
   BGiDm+jEUz5OFd3ycVasABaYHjtuFE/1zb/kxO1M5Enkgv8UJg+gTgzvO
   K91f/QJXHG2xc9LsOR15ru5Wd8+IcnWL9G4Hm1u4Z6Pr6Iw6x54K/ZKjZ
   7MP1dnEdpZCwdK/F6FCE1chJEVIlrsJPr38FdsvtU7958zp7FEw5qQVMS
   j8OohO+yy+bygKIabBm+oHjXiWLpgTfKK3PBkEFqzw3bsO6MITZS0Mg/G
   9ZcDCNEas+HnHhVcHZUgfKbECcLTOLAmMWfGXbFhDdwdOgByubT7NfYGY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314257"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314257"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624393"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624393"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:35:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] cfg80211/mac80211 patches from our internal tree 2024-01-02
Date: Tue,  2 Jan 2024 21:35:29 +0200
Message-Id: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
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

Ayala Beker (5):
  wifi: ieee80211: add definitions for negotiated TID to Link map
  wifi: mac80211: process and save negotiated TID to Link mapping
    request
  wifi: mac80211_hwsim: handle TID to link mapping neg request
  wifi: mac80211_hwsim: handle BSS_CHANGED_MLD_TTLM
  wifi: mac80211: add support for negotiated TTLM request

Benjamin Berg (3):
  wifi: cfg80211: correct comment about MLD ID
  wifi: cfg80211: parse all ML elements in an ML probe response
  wifi: cfg80211: add RNR with reporting AP information

Ilan Peer (1):
  wifi: mac80211_hwsim: Declare support for negotiated TTLM

Johannes Berg (6):
  wifi: cfg80211: add support for SPP A-MSDUs
  wifi: mac80211: add support for SPP A-MSDUs
  wifi: mac80211_hwsim: advertise AP-side EMLSR/EMLMR capa
  wifi: mac80211: remove redundant ML element check
  wifi: mac80211: take EML/MLD capa from assoc response
  wifi: cfg80211: validate MLO connections better

 drivers/net/wireless/virtual/mac80211_hwsim.c |  50 +-
 include/linux/ieee80211.h                     |  89 ++++
 include/net/cfg80211.h                        |   2 +
 include/net/mac80211.h                        |  58 +-
 include/uapi/linux/nl80211.h                  |  14 +
 net/mac80211/cfg.c                            |  15 +
 net/mac80211/driver-ops.h                     |  19 +
 net/mac80211/ieee80211_i.h                    |  11 +
 net/mac80211/iface.c                          |  16 +
 net/mac80211/key.c                            |   4 +
 net/mac80211/main.c                           |   8 +-
 net/mac80211/mlme.c                           | 500 ++++++++++++++++--
 net/mac80211/rx.c                             |  22 +
 net/mac80211/trace.h                          |  52 ++
 net/mac80211/wpa.c                            |  33 +-
 net/wireless/core.h                           |   3 +-
 net/wireless/mlme.c                           | 131 ++++-
 net/wireless/nl80211.c                        |  27 +-
 net/wireless/scan.c                           | 181 ++++++-
 net/wireless/sme.c                            |   3 +-
 20 files changed, 1140 insertions(+), 98 deletions(-)

-- 
2.34.1


