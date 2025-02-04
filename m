Return-Path: <linux-wireless+bounces-18440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DECBA278C8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B3C7A2CB7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6D2165E6;
	Tue,  4 Feb 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRQlKbe6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA7215F7F
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690995; cv=none; b=s0v3lcWcMtiOarbRh8n0/U0vn1ug3A+oOEirEvGIUYa54LT6ByS3C3N8nVQ6u3uKiG8woERuH6S44r2i0BDnsUUx+h/KTJGhjpyh0x7XsW8cSqAQmUSjcth0Plvrh6TuvOgdtZNZ9uhB5BWL8yoKHBQjMv9+UCBok/ld/T/a3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690995; c=relaxed/simple;
	bh=tOqoPwI8WsvNP7aLV3nWb8DJmFBV3GyoDNPonqBqTk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFhnOLhoUy932U5GlkaeRi4AgCVhY1SO90Fg44RPCBwMgpZtxfHkHDG1EoYr/AF39/+jDbQxupyNKdElnCNtgDieHTxpJkX8s9lXMKmEQwjDl1CyPW9dnoZ2vOLyLGVxmch0MtrcrKRRrqs1SfkctYz8468CaBcAECyN0VHG/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRQlKbe6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738690994; x=1770226994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tOqoPwI8WsvNP7aLV3nWb8DJmFBV3GyoDNPonqBqTk4=;
  b=hRQlKbe6PLK4K3mUyecetNwMJ/+chJSXHJQZoacs76R2gsjWa4/GOkT3
   L+mOpPA9aBbhwWOWS8caXu5pmHZc4BbBrS6UhljwT9/kVaPQWL54wud5e
   7wkvorB4ba9gAmrIlCTwgXtPHLQbPYHvoyk5fe0WKktFhaxrnbBtg/X2t
   OrGM52VaUnqqbF2Y9EDgItRbUGWvT1FgQnPPDe+aAwsM1mUD3PFPRj3Is
   4kUKNSxfamS5EzeoIT0MTrGBeQpAtPfDh6kOrIZ8+P9B3m6i3iuK9MWDE
   FWkX460eEKba3IrNhi1Oj7A4LNtRzfho9syrgGgax/TXmbFYnwxQba4rQ
   Q==;
X-CSE-ConnectionGUID: q4b4B7bRTJ+o1JNWj9fNdQ==
X-CSE-MsgGUID: AjGuzKeYTMCGaIkMhwGxkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585321"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585321"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:33 -0800
X-CSE-ConnectionGUID: IHdtfj+EQeif9AoUY40nxA==
X-CSE-MsgGUID: i94/58vFQ0+G23HwFN+fwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696659"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/20] wifi: mac80211/cfg80211: updates - 2025-02-04
Date: Tue,  4 Feb 2025 19:41:57 +0200
Message-Id: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
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

This series contains a few features
(EPCS, strict mode) cleanups and bugfixes.

Thanks,
Miri
---

Benjamin Berg (2):
  wifi: mac80211: add HT and VHT basic set verification
  wifi: mac80211: tests: add tests for ieee80211_determine_chan_mode

Emmanuel Grumbach (2):
  wifi: mac80211: set ieee80211_prep_tx_info::link_id upon Auth Rx
  wifi: mac80211: rework the Tx of the deauth in
    ieee80211_set_disassoc()

Ilan Peer (5):
  wifi: cfg80211: Fix trace print for removed links
  wifi: mac80211: Refactor ieee80211_sta_wmm_params()
  wifi: mac80211: Add support for EPCS configuration
  wifi: ieee80211: Add missing EHT MAC capabilities
  wifi: mac80211: Add processing of TTLM teardown frame

Johannes Berg (9):
  wifi: mac80211: fix MLE non-inheritance parsing
  wifi: mac80211: fix vendor-specific inheritance
  wifi: mac80211: add strict mode disabling workarounds
  wifi: mac80211_hwsim: enable strict mode
  wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
  wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
  wifi: mac80211: always send max agg subframe num in strict mode
  wifi: mac80211: aggregation: remove deflink accesses for MLO
  wifi: mac80211: enable removing assoc link

Miri Korenblit (2):
  wifi: mac80211: don't queue sdata::work for a non-running sdata
  wifi: mac80211: ensure sdata->work is canceled before initialized.

 drivers/net/wireless/virtual/mac80211_hwsim.c |   1 +
 include/linux/ieee80211.h                     |  12 +
 include/net/mac80211.h                        |  13 +-
 net/mac80211/agg-rx.c                         |  22 +-
 net/mac80211/agg-tx.c                         |   9 +-
 net/mac80211/cfg.c                            |   9 +
 net/mac80211/debugfs.c                        |  44 +-
 net/mac80211/driver-ops.h                     |   3 +-
 net/mac80211/ieee80211_i.h                    |  19 +
 net/mac80211/iface.c                          |  16 +-
 net/mac80211/mlme.c                           | 583 ++++++++++++++++--
 net/mac80211/parse.c                          | 135 ++--
 net/mac80211/rx.c                             |  25 +
 net/mac80211/tests/Makefile                   |   2 +-
 net/mac80211/tests/chan-mode.c                | 254 ++++++++
 net/mac80211/tests/util.c                     |   6 +-
 net/mac80211/tx.c                             |   3 +-
 net/mac80211/util.c                           |   8 +-
 net/wireless/trace.h                          |   2 +-
 19 files changed, 1029 insertions(+), 137 deletions(-)
 create mode 100644 net/mac80211/tests/chan-mode.c

-- 
2.34.1


