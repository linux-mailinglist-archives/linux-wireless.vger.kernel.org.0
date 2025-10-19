Return-Path: <linux-wireless+bounces-28071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC90BEE119
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 633AC4E100A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D642356BA;
	Sun, 19 Oct 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7+KMIch"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D3A930
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863798; cv=none; b=MevJlq9dr4Q0pR5f6AsVpjQI1SpnUiNNTHkxIdA+fGeFLJ6qBCF+atNVTm2rZYL6kpz16HPR41mmRV//6yBUHYXVDTsCbZ0i5VyzA0d2M3+FhBi/9sHeMuK3Agk6NxRCaJQRsXBrtrkI7EtGUsRYWopTyFxhcrDuVmOfQJFIvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863798; c=relaxed/simple;
	bh=VmGa/5LHkcZoWCEkkVKCgjHz6mAqtHQr09J5KR4N28I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZVs6gPrZPa3JTPoqv2tvDPljhjR7vaiUB9Yq+NOnjdAbszKUt0o6a0JRbQCR81RytTXOV43LrZaRGZu3lT1c/NHfRJwLsMoRFD3XrMHrTC4HH2+yLfaBfGPlSkCrK1DU87L1hz+DZEvadz3lCG0tsfRDaWxSWuOmumg0KSmLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7+KMIch; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863797; x=1792399797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VmGa/5LHkcZoWCEkkVKCgjHz6mAqtHQr09J5KR4N28I=;
  b=M7+KMIchPzscJa3PNZJ3Ty9YwpoghE5xQpa+62Fd3Z3V5DKBH7zGMtix
   m9Rtz0p4KH/Xfe5gtAFs3Kt+ReG7ZhdWryBa7C7iSWMy0q9Di0dcDRL+b
   KyqTrbLydZUuA2gbeBopPDtKrwMZ3zsOyKn0S/w+2MGHlxnJyHUsfbt/J
   1FcsQ5U4iAK/Bk8ZKIcFj9gn75wYHHUscOHBN4aBJrB8hPwajqpFOK2DW
   avWPbu48edijFPHJnpjK7yzK0iIO5A0AwNb7V3AGTjIadJahiS3Jpwacm
   dR3IUp9ZtrlVXhYNeRfxWWfZjymMQOZUHrwvuRS+mEaz8WPNKzXPoqZfS
   g==;
X-CSE-ConnectionGUID: QpcXSQi3TCW6NO6ZBC9qNQ==
X-CSE-MsgGUID: YYVwWw8PQZWyrQP/664onw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65634502"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="65634502"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:49:57 -0700
X-CSE-ConnectionGUID: Bm48HTMPSla/JXAYUZuajg==
X-CSE-MsgGUID: yR92Z7ZBTpeSJ0SabHNHJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="183055152"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:49:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next v2 0/4] wifi: cfg80211/mac80211: add an hrtimer based delayed work item
Date: Sun, 19 Oct 2025 11:49:47 +0300
Message-Id: <20251019084951.2572582-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Apparently, the existing wiphy delayed work, based on a regular timer,
is not accurate enough.
This series adds an hrtimer-based delayed wiphy work and uses it for
several wiphy tasks.

Thanks,
Miri
---

Benjamin Berg (4):
  wifi: cfg80211: add an hrtimer based delayed work item
  wifi: mac80211: use wiphy_hrtimer_work for ttlm_work
  wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work
  wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work

 include/net/cfg80211.h     | 78 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/chan.c        |  2 +-
 net/mac80211/ieee80211_i.h |  8 ++--
 net/mac80211/link.c        |  4 +-
 net/mac80211/mlme.c        | 52 ++++++++++++-------------
 net/wireless/core.c        | 56 +++++++++++++++++++++++++++
 net/wireless/trace.h       | 21 ++++++++++
 7 files changed, 188 insertions(+), 33 deletions(-)

---
v2: add the destination tree, wireless-next, to the subject
-- 
2.34.1


