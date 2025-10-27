Return-Path: <linux-wireless+bounces-28311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E8C0DA05
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 13:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030A740807D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEDC2F5A39;
	Mon, 27 Oct 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3yT2s6V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B072E8E00
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568445; cv=none; b=J2GgQQeYEsRyEUwrKwx3v1FSykG8QP1V2BngwsFHyM8yIb+c9M1F1xTt37xSqCbWdGDTczSuKavpiUUsbBQlAA7kPHSSNM1xA7Xsblw7954BHtFV9kZJTv541clJr0T4AwMq4eHoJEqn4IouS4xt+I+28by1xCn6NXvUaXL5X2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568445; c=relaxed/simple;
	bh=gI0wpSeC4MsHkobfxtIrzf3aeBB9cEHELE0PPl9GHsI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NlWnS2EGe905kIORWb8KyUR+KumQLY9cOjdpBaPY8JUJ4CUsVYYapPEhvOB+CmIbT3zwtjXRi2QqbOIeni4JZ6lLkc3aUJoY6DRBXr7IVZB9daOLxRKQ4Mm6xlRoX18cdE0PxoakfCkpGxeLd5ll2Jcmviy5RWFFLuGcyMFt50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3yT2s6V; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761568444; x=1793104444;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gI0wpSeC4MsHkobfxtIrzf3aeBB9cEHELE0PPl9GHsI=;
  b=i3yT2s6VEtpfFNnlIubUnGr8xcgRwRvuIE2OcDEJ+g1Mx8psP0juCHXt
   y/xW9IjeLXaBf21Gdd5LEGrUyOjLJC+qqRrGhS6imj+oXOA6I8I5ZEpzu
   ja9Uv2ZAc1juEktWXqY+ZKUeNvSxDWIIPYqDuFJXInfPZJmyE3tzKZnq9
   RLxrnevYmbvbVK6uKW5QB59+xEKzK2X17LuIhmWINuDg7MLNnYh9JCBMm
   MH4qihL/ucS9+BbpmHIPw80XN88rkbds09RgYF/FiDySjK7DPTb2aeGif
   JQ1G2WkhMCLTm+nmrqlOt3f4UTVKp9wwOUpilpI74oCZ5ai8CRMuDBIT+
   A==;
X-CSE-ConnectionGUID: UB53glooSCm+giDgsUJCRg==
X-CSE-MsgGUID: PubFsRI3SJuLZlO//aqH3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66258568"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66258568"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:03 -0700
X-CSE-ConnectionGUID: FXRFpkz3RtmkbGIo1gSZbw==
X-CSE-MsgGUID: KKPgOwitQnyJt71eKhS8xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="190162803"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:34:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next v3 0/4] wifi: cfg80211/mac80211: add an hrtimer based delayed work item
Date: Mon, 27 Oct 2025 14:33:53 +0200
Message-Id: <20251027123357.2221947-1-miriam.rachel.korenblit@intel.com>
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
v2: add the destination tree, wireless-next, to the subject
v3: fix kernel documentation
-- 
2.34.1


