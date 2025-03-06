Return-Path: <linux-wireless+bounces-19855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B5A5478E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0070E3A859E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA41D61A4;
	Thu,  6 Mar 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDoX4Vp8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AA1A08A6
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256326; cv=none; b=R7OXcYPblCLttZxXdI/l0LJMFK3dfs1iMM4D9k5hNAjnPsm7Mur9MgOrAE3P6G+zB4M4Y7XfV/yOpNe+pv58deqWrxKNB4GEt9JLBeV7O8acYR3uSbThv+4ds2mvvdbctpUNJprXRcl7Z92xmQYOGl4zMsLNIHdKjy1Ag6eeEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256326; c=relaxed/simple;
	bh=UqIbrdbDCwrFj/nL7NBfJTFqfa88p16esS/SwhbvcMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PePsmntDCGW09sGpBT+kSVAwKGtaCeaMMdC0Zv3/PGDtDwOM4HmEHLynjpsasL8+vB7M8J723QtQiSAmMRyNe6fqzE2tHGcNgvSuYgGFdJRCwWzlYzBZqI90eBznEuXsDDnNpS1cn9JaGutaACYFzeGLPH8nWV0jgyOGzFRIuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDoX4Vp8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256326; x=1772792326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UqIbrdbDCwrFj/nL7NBfJTFqfa88p16esS/SwhbvcMg=;
  b=iDoX4Vp8uoKjGzPY6wSa2AWGVNmnl9s+7nOP7nH1C8Y0eLyaCLxBTL6J
   DYxAXue6/MAa+UU2tjkaC/GHv9KCkoFjXhRaZNaAeXuTrGdeusKxTPsnP
   7zju1QdKcMmDXxtyvchd42QhyGXEjZuYn5oYUI8N47WQt9yTX7+UxD4dE
   Apg8qmLHVt0HY3vJsYP5DrQv6ZN6rqlt0O3dZUBrYdV73gwp06XjaNkeT
   iBqcV9SBfIc+kDaDpQYW6mR6bPxRkoLhFM1ew4zt3kLghpVutwrJF99Ub
   65oSC/KSp58AkwGYwtaLVHBmhOoY8PKc+4AdoxBHRb5OtGy6a7Qrg7cbH
   g==;
X-CSE-ConnectionGUID: DEf6pzaoQu+L2yjPzNTEzg==
X-CSE-MsgGUID: vk1qD2S/QIa43cDgzJCxyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46181353"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46181353"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:45 -0800
X-CSE-ConnectionGUID: Gpj1YoiBQgiWAkLMZYkoXw==
X-CSE-MsgGUID: /c4KrmiSQ7aw3DpsL2eyyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118705687"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 0/5] wifi: mac0211/cfg80211: bugfixes - 2025-03-06
Date: Thu,  6 Mar 2025 12:18:26 +0200
Message-Id: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
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

A few bugfixes from our internal tree.

Thanks,
Miri
---

Emmanuel Grumbach (1):
  wifi: mac80211: flush the station before moving it to UN-AUTHORIZED
    state

Johannes Berg (2):
  wifi: nl80211: fix assoc link handling
  wifi: mac80211: fix SA Query processing in MLO

Miri Korenblit (2):
  wifi: mac80211: don't queue sdata::work for a non-running sdata
  wifi: cfg80211: cancel wiphy_work before freeing wiphy

 net/mac80211/rx.c       | 10 +++++-----
 net/mac80211/sta_info.c | 20 +++++++++++++++++---
 net/mac80211/util.c     |  8 +++++---
 net/wireless/core.c     |  7 +++++++
 net/wireless/nl80211.c  | 12 ++++++++----
 5 files changed, 42 insertions(+), 15 deletions(-)

-- 
2.34.1


