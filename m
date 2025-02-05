Return-Path: <linux-wireless+bounces-18494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3BA286C4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFD5188A250
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7137A22A4CB;
	Wed,  5 Feb 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GueHp2d8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C322A7E1
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748386; cv=none; b=Kj8jzsuMq5e74Sa6QZtfH8gywks0Gp+oH0TyrBhaK3jyssq+HynkpOmHN/qjnKAR0P/XKsdKfdnqMpZ2hXLBDtX3ens+jFqYMfti6de4OrvtqHHIKXymWmxn3bLIKbW1Sj5DNNb/BPE6eohJ+vi1fBgORiYg7OKB6fS+6suoYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748386; c=relaxed/simple;
	bh=KHNO08ZfvA9xhs2xZbzFdLJAFFpQyr09q5r2yEtBBLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fahKDXe9uvaNc9PyESraKDYIsu4tXCzKjFl/fqbf4JwQc8JVbVII08Wr8eCUJt3wq97xOjd7jL/sjGmg6N12fskP3v6hv4sRYOnEpIzYnHFu70r54tBoNlm/xxnpy01Y6V0Z9O/0fReFUPI/5kzya446zAUMfU+aXcLJ7AIXHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GueHp2d8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748384; x=1770284384;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KHNO08ZfvA9xhs2xZbzFdLJAFFpQyr09q5r2yEtBBLs=;
  b=GueHp2d8LhEUFwWiOckMJEde7v5WA8HBFW+jxSM8I12T5zjlDvFurhTz
   MYZOQ9/2c6snSJmmkvoqZp8pVjC+3cCCcYCvZzvzPxwCzWyVGNzupfvTQ
   bLFYHn/FuGvhmAbevi0wAGfJG8paUl08Xup2aP7IwasnX/C3SVDJH79Hz
   EcdQ6clOiGrBBMV1QQHs+sLclkki4THMx6IDNlhkShB8KNNGdpI9dCPBV
   FeTaaBI1RdaXGCrHFIGlIVOu3h394sYwWruXbAEB0AhQR+2QOW5NRYxLD
   XIzCyL4Yq6CeNWHGrf+Ak4vSkhItGUU0Q6MC7j2URX64sMfnYoKemwk+/
   g==;
X-CSE-ConnectionGUID: S7bL2G7MTPC7+thwF28aJw==
X-CSE-MsgGUID: RPS7/UtSTAO0CQgnIUpJHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225200"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:43 -0800
X-CSE-ConnectionGUID: qj3GchHpT5mlYr6wacT6sQ==
X-CSE-MsgGUID: +Emp4D4ySeGBN7DIb5h+MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845247"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/17] [RESEND] wifi: mac80211/cfg80211: updates - 2025-02-04
Date: Wed,  5 Feb 2025 11:39:10 +0200
Message-Id: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
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

Johannes Berg (7):
  wifi: mac80211: add strict mode disabling workarounds
  wifi: mac80211_hwsim: enable strict mode
  wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
  wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
  wifi: mac80211: always send max agg subframe num in strict mode
  wifi: mac80211: aggregation: remove deflink accesses for MLO
  wifi: mac80211: enable removing assoc link

Miri Korenblit (1):
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
 net/mac80211/mlme.c                           | 582 ++++++++++++++++--
 net/mac80211/rx.c                             |  25 +
 net/mac80211/tests/Makefile                   |   2 +-
 net/mac80211/tests/chan-mode.c                | 254 ++++++++
 net/mac80211/tests/util.c                     |   6 +-
 net/mac80211/tx.c                             |   3 +-
 net/wireless/trace.h                          |   2 +-
 17 files changed, 933 insertions(+), 89 deletions(-)
 create mode 100644 net/mac80211/tests/chan-mode.c

-- 
2.34.1

---
v2: 
removed patches that should go to wireless,
rephrased the commit message of "wifi: mac80211: add HT and VHT
basic set verification"

