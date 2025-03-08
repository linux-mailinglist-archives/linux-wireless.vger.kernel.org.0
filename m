Return-Path: <linux-wireless+bounces-20029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB15A57E55
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636BF188DA4F
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52E1A8F63;
	Sat,  8 Mar 2025 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9UPr/VP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4F19597F
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741467971; cv=none; b=E1n13WB4Ys1Se7ZHaW3Baks4NA17yeVE2cxaIvcVlN90mih5arlgKitim2cl9OTpep9VeyUbRGVuQ25ljBxTthVy+SFxv2hyhjBLPZ6hiGolMdqUewcL8v4CvMnGc35TZ4CG4JnRsQHlnHHVS/GviRXJ/Cf69J7rVVcFiMaQpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741467971; c=relaxed/simple;
	bh=rcSMlftvPcI9+bX27fBdKRbQYlsms8+ClhNWLA0yPxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UHA9lRw6YEbdlHEVmZFSt6jOAX+1O0vsatN3JCRBbqhIOKGl1/yHDhCtW78tRZhh4A6Bs3ZpcYnsg4p9+Hoi3mVlQzL4kzR9zkN0v32b72JztJkeW3gtjg+u1d0pACfoeGHhLR1eSPW35k3Zp9UrMI1nedlL+PfwARzWvjrVRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9UPr/VP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741467970; x=1773003970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rcSMlftvPcI9+bX27fBdKRbQYlsms8+ClhNWLA0yPxM=;
  b=l9UPr/VPPRtNtc1pDiO/eMVc54PlkjvFVsW78z2z6Qy7EEAuPd12MkWe
   kOUfZcUOETTYHzLc+nmsNdeFB+08QTbdL21ZrgmdAgQIF3qgnJD1gaGK9
   5kE6Oat2AXEdNkd9zT2e0+calSF8B+0hNVMNiFIu9ik7LYFWPRRO4c7tc
   l+jDO2oEDwT3MMVqeIyR/iXOD/YHz+H44Fom49BPMjlNSl9c6Xyo4/bjB
   Y9lwkqrR5+OgRciZ249CyVZCh4faDh9IqGBCCq7DZX7PqEUaVGmYR3l/2
   8z/O5MVpVsi9xmW0fA3JnPhnbHSL97XTmyo02giymJN6strV/AY54rZXf
   w==;
X-CSE-ConnectionGUID: mqTJyKJwT3e8vODyKWtVrQ==
X-CSE-MsgGUID: Gosk4dH5SCS5LpZzJAjn4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42412997"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42412997"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:03:53 -0800
X-CSE-ConnectionGUID: xOJHkizKR0u+m4ZW76QfJQ==
X-CSE-MsgGUID: /ihrZyYFQ7GEoOPjqbOA5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644347"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:03:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RESEND wireless-next 00/15] wifi: mac80211/cfg80211: updates - 2025-03-06
Date: Sat,  8 Mar 2025 23:03:26 +0200
Message-Id: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
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
resending the series after a couple of fixes.

Thanks,
Miri
---

Anjaneyulu (1):
  wifi: cfg80211: allow IR in 20 MHz configurations

Avraham Stern (1):
  wifi: mac80211: allow 320 MHz FTM measurements

Ilan Peer (3):
  wifi: mac80211_hwsim: Fix MLD address translation
  wifi: cfg80211: Update the link address when a link is added
  wifi: mac80211: Notify cfg80211 about added link addresses

Johannes Berg (10):
  wifi: cfg80211: move link reconfig parameters into a struct
  wifi: cfg80211: allow setting extended MLD capa/ops
  wifi: mac80211: mlme: support extended MLD capa/ops in assoc
  wifi: mac80211: fix U-APSD check in ML reconfiguration
  wifi: cfg80211: improve supported_selector documentation
  wifi: mac80211: fix userspace_selectors corruption
  wifi: mac80211: fix warning on disconnect during failed ML reconf
  wifi: mac80211: fix ML reconf reset in disconnect
  wifi: mac80211: don't include MLE in ML reconf per-STA profile
  wifi: mac80211: set WMM in ML reconfiguration

 drivers/net/wireless/virtual/mac80211_hwsim.c |  14 ++-
 include/net/cfg80211.h                        |  29 ++++-
 include/uapi/linux/nl80211.h                  |  68 ++++++-----
 net/mac80211/cfg.c                            |   7 +-
 net/mac80211/ieee80211_i.h                    |   9 +-
 net/mac80211/mlme.c                           | 110 +++++++++++-------
 net/wireless/chan.c                           |   8 +-
 net/wireless/core.c                           |   3 +-
 net/wireless/core.h                           |   6 +-
 net/wireless/mlme.c                           |  17 +--
 net/wireless/nl80211.c                        |  40 ++++---
 net/wireless/rdev-ops.h                       |  10 +-
 net/wireless/reg.c                            |   4 +-
 net/wireless/trace.h                          |  17 +--
 14 files changed, 218 insertions(+), 124 deletions(-)

-- 
2.34.1


