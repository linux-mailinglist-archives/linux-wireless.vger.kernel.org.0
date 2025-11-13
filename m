Return-Path: <linux-wireless+bounces-28900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396AC56A1C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DD084E5670
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881BD330B23;
	Thu, 13 Nov 2025 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7rfGfUP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E3D2C327A
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026388; cv=none; b=DQBN4emKKgyljdg8thSiaHAk5DG1vAn+BoTIoubRu0Nl1tVfNrj1Wnkh1a4tyLkqfdt2MLQPCs7qaIKM026avXY6BfTfMAHNEv+5n5sRQzIGl7ESoxJEA+gYHJY0UjAFRJNSCvxL8PJL0/C4O46AyyvnKKN0AHzj9YHkuvyXPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026388; c=relaxed/simple;
	bh=Iwxrrt8+s2oCm5FkvTxyOC4ThIAsJKC8ixXVOJBxksI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qtSer7iln4vp8bJzvbTaHSQOZnjVApM3zyhAIYPij0jjDHe6KzvuQB6GpU+1jGAyVKww0jqr8CmzkrPJZp8rGETcX0VWFXopcTuT5HCmvroxZzGjyt7EJ6IXL/FPFRzj9HnMZJ6KfSNL8wu0LeM6HKs1l8B3/GLTeAMY+fnVWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7rfGfUP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763026387; x=1794562387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Iwxrrt8+s2oCm5FkvTxyOC4ThIAsJKC8ixXVOJBxksI=;
  b=G7rfGfUPI1zK/UOQVFHRCkcjlikCzfCGGax1AEFH8sH93g5NkBB9CXeO
   jx2Wnvv41f7ppceYjr23YymiGhQut/scedO/pBTR+BhBgJfggATZIIq1/
   iLwNGHRLlPwm/ATejdT9jFqzoKfust5JId5QTXqcuPJFeSbvB5/1B+Gtg
   mKWVr7uevvqewpEF3UZ9gtLkO+WyiFnz0/BaDdhxR7tAIxwm5AP3jnzsX
   xewyWeGW9uYH8IYoQlbvlu8TQmVQVWMROnDL/yibTzAtUoGep18WuzFfK
   awDdGvexFyiZ/6bbaFGtyuGiiT/DjsuHeXMjLIKrjHDXsJ5uYf52Ji+0J
   A==;
X-CSE-ConnectionGUID: 8YE3p0BDRqGmCrFwbQf+vg==
X-CSE-MsgGUID: MMmGYuKJQsmcO7BSM9v7kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65028270"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65028270"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 01:33:07 -0800
X-CSE-ConnectionGUID: wOH/6HPkRK+HGwT6Jp9Fkg==
X-CSE-MsgGUID: Lcn1XbcJSLqgEgUdKVBO7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="188737136"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 01:33:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/3] wifi: nl80211/cfg80211: NAN local schedule API
Date: Thu, 13 Nov 2025 11:32:56 +0200
Message-Id: <20251113093259.3576302-1-miriam.rachel.korenblit@intel.com>
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

This series adds a new NL80211 API, that provides a way to configure the
device with a NAN local schedule.
Disallows usage of DFS channels for NAN (might be changed in the
future).

Thanks,
Miri
---

Miri Korenblit (3):
  wifi: nl80211: refactor nl80211_parse_chandef
  wifi: nl80211: don't allow DFS channels for NAN
  wifi: cfg80211: Add an API to configure local NAN schedule

 include/net/cfg80211.h       |  41 +++++++-
 include/uapi/linux/nl80211.h |  35 ++++++-
 net/wireless/chan.c          |   2 +-
 net/wireless/nl80211.c       | 191 +++++++++++++++++++++++++++++------
 net/wireless/nl80211.h       |   5 +-
 net/wireless/pmsr.c          |   5 +-
 net/wireless/rdev-ops.h      |  16 +++
 net/wireless/trace.h         |  21 ++++
 8 files changed, 280 insertions(+), 36 deletions(-)

-- 
2.34.1


