Return-Path: <linux-wireless+bounces-28048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED1BEE06A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4122C3B6B8A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8361D618C;
	Sun, 19 Oct 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+V+lgPm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D71C54AF
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861589; cv=none; b=YhJvD93QljqqjLBpmEFpt1L4gUtAof5wdhC3brQN3dtDZ9ZQD/QSz2ojFkynCPYl1EJinqmOmL3fWdvftxE1pzxLVuCBSnPx5Nsz4MH5tCP39fMSBargyE3cgzU6Lb6PkcdXpfSuYQ/l6Ulg3oZb3ZwaAJ37wtuEM5e1XKMZ/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861589; c=relaxed/simple;
	bh=6AMEYEbkifEVD2Vl8tSxITLXPO13O2OBSUhQPPRhJEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k5AX+2bT6++Bgi8kVcoBhgXIRXK1p5enKJwHTqeUfT7YCli2OiT9eWd5Cwo4qXZh8El3GMitBDurtgzZsOta95J009hZdDAYOqTlpliWcc3WWYVDHuOzyCXrBlM9T7anBVsAJ+gg9PkR+R+zqHeXOJcPg0pddzo7sA8e1of01Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+V+lgPm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760861588; x=1792397588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6AMEYEbkifEVD2Vl8tSxITLXPO13O2OBSUhQPPRhJEE=;
  b=J+V+lgPmYKDOKEtSsWPWXFi6ptj4ZxRia6QEI1X1vZ/9KYNpBFNqvSHW
   UCDAenNDQ0HQoY5gHrxy/j08cZnVquQW/7xclQzPmfxZqTt/MsaSiwTDC
   VdFYZNwespZHlLkZNKpEYnv+BlxzqXeGHJrFyH0x6ZGihJanERAzgRIuv
   pKqCNEYW9a+KcKTCdvAnlmw2nWJy5HU+6z8srz5sb/fYIPa6JUzlyw8VG
   wh1EkrEXmLKa56xeTvb/uef4aTPhJBYBoqdzCWiFGedYOEBhwR+CDUM43
   yKoXG/55NAbQsJ41AX098g+9sBaezRzOuyCpI18xv09ACqEL1I/XUBdSb
   Q==;
X-CSE-ConnectionGUID: EOHkrsrZTJK+3wzC42bAbQ==
X-CSE-MsgGUID: Gg9xlMJPQD2j4y4fB+xi4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62912538"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="62912538"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:13:06 -0700
X-CSE-ConnectionGUID: GHUQtWJiRUi2ah1497078Q==
X-CSE-MsgGUID: YbZOhKZ+QmK2fxPf6rS2xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="183501596"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:13:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/4] wifi: cfg80211/mac80211: add an hrtimer wiphy work
Date: Sun, 19 Oct 2025 11:12:55 +0300
Message-Id: <20251019081259.2455317-1-miriam.rachel.korenblit@intel.com>
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

-- 
2.34.1


