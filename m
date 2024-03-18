Return-Path: <linux-wireless+bounces-4843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8564F87EE09
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188D528161E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A054BC8;
	Mon, 18 Mar 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsI7Pm24"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91B54BC5
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780824; cv=none; b=IdlgT1Z5HtW7JPbLq8G8PhnOL3a2nUCcqXiW8DZ9IFCKNlqQIB3kzRVCDbRqw/jsMfTMl7vTh9CVgOyMdHLJjJRTOHtSEyODvA8rb4iVU8rFdABr+ekbGxOid36+aGXqwNn+fPpIKZvYHOTlDi1jaaurEAu+8S5pX6wrYBytX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780824; c=relaxed/simple;
	bh=cGPOxQlIZB1vsXcjSRgbko052LgZ0oaZZWYOQpXWitI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lx4EHMIyPhdCeON9+kOvsG8CUVf2gQ3Hg4oZgcWRsJPZfuljaMYrBOwZ5ZW9PYHtFUYSMTZShHXHb1BzFgfewegpxL/eXOAmtWyarqyUvNi3Tab+mTu2gEz7Umm8UD3r73r7SL6Hl4Q+A9dicMsicvWUSrk0uF+XrCXAuNphuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsI7Pm24; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780823; x=1742316823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cGPOxQlIZB1vsXcjSRgbko052LgZ0oaZZWYOQpXWitI=;
  b=CsI7Pm24m4nUAZSi5Y13ZArMSJa4aTDz/NSbKgWo8VqL8nYtBfbtPvLq
   cz7FhIkcwKxFozFguXRuU5z7H5mFSbwdd+CDYsYXCHZF8Sfn97FyNjfV6
   33c2RXEpukcmxH4V97FMp1sCIeDDweR7A7tnpAY2/ArAtpMCsQes7qO+J
   tj1T6I8T21tGNLL3UpW4yda2mva6ctXQ14mLy9Ees/QrsSvu2XUwSo0GH
   vcqRf7MMbCaQTQ5aIAf/W/q9z+rKHJRYjB+olVlnuovXvl1/phDTL5HuM
   t5zCoQ5BHpobOE+VxaOUjXAOJzjIe/kh2gKnBhswPsrNUhyA/mLWBMvTP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819363"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819363"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909666"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] cfg80211/mac80211 patches from our internal tree 2024-03-18
Date: Mon, 18 Mar 2024 18:53:16 +0200
Message-Id: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
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

Anjaneyulu (2):
  wifi: mac80211: handle indoor AFC/LPI AP on assoc success
  wifi: cfg80211: handle indoor AFC/LPI AP in probe response and beacon

Ayala Beker (3):
  wifi: mac80211: fix BSS_CHANGED_MLD_TTLM description
  wifi: mac80211: correctly set active links upon TTLM
  wifi: mac80211: add support for tearing down negotiated TTLM

Benjamin Berg (3):
  wifi: mac80211: improve association error reporting slightly
  wifi: cfg80211: check BSSID Index against MaxBSSID
  wifi: cfg80211: ignore non-TX BSSs in per-STA profile

Johannes Berg (7):
  wifi: ieee80211: check for NULL in ieee80211_mle_size_ok()
  wifi: ieee80211: fix ieee80211_mle_basic_sta_prof_size_ok()
  wifi: mac80211_hwsim: move skip_beacons to be per link
  wifi: mac80211: clarify the dormant/suspended links docs
  wifi: mac80211: add flag to disallow puncturing in 5 GHz
  wifi: mac80211: parse puncturing bitmap in 6 GHz
  wifi: mac80211: fix prep_connection error path

 drivers/net/wireless/virtual/mac80211_hwsim.c | 19 ++--
 include/linux/ieee80211.h                     | 12 ++-
 include/net/mac80211.h                        | 22 ++++-
 net/mac80211/debugfs.c                        |  1 +
 net/mac80211/ieee80211_i.h                    |  2 +
 net/mac80211/mlme.c                           | 97 ++++++++++++++++---
 net/mac80211/status.c                         | 22 ++++-
 net/mac80211/util.c                           |  2 +
 net/wireless/scan.c                           | 54 +++++++++--
 9 files changed, 192 insertions(+), 39 deletions(-)

-- 
2.34.1


