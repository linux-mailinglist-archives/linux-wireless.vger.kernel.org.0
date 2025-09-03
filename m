Return-Path: <linux-wireless+bounces-26967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151DB418BF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 10:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1A53B922A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700C2EBDDC;
	Wed,  3 Sep 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcGfVYPn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4333B50276
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888775; cv=none; b=XMxGdDU8THG/doODhGVktCAr/2f+xPOEN1ZI0390SaNgZHjf7NYOtSloCkjutywI4k0aRQEpUG6SD8TcdrdWf7Hb3CGZqv/3eqHzGGV3f8Y3zbB2acpZudSdsx6z2IO42FvaNmcLQjtWEjzIUEpkAGKrJDYnFg0/pmOrwMqUfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888775; c=relaxed/simple;
	bh=QqOctkE9Li0WuUhAiEEnhFG3YXOxyU5cIPrPbf5bHnQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dtIg6ZNVfG/541LALDtodci0F7E6D5oSiSE/As8xng1V4UBclsVYYgwrA2Fm+EEWASDfnHyHR7wXKEO7oCnfXy1jv0qf1A6VYlm8UN/iHXdPReEeu+UWtVH7UGZx3q2Vt1kHJRsXA8vQz5tV37xWuW/LnyLR10dIgUvZ4M/YrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcGfVYPn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756888773; x=1788424773;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QqOctkE9Li0WuUhAiEEnhFG3YXOxyU5cIPrPbf5bHnQ=;
  b=HcGfVYPnsg+rU5C0vCki4HLJ2+RlDyxUeA3BY2EwpUbzC1r5Hw5kpkbL
   n1suh09ZiWBu53lB9o2cOhvIOaEhRiO1sw3PkK5utWp0D1yvYolaF6/6p
   uXhpkOH2hjaplXKnwo5/Bde1noPmvfuKH+Tcz61OASPERNMmz1A5v5siF
   HoicJfpu0hqV1TvQklj4dYEYTjfpMzYm9jAgHrKkvlcutcmTUzq1Z8kgj
   3cwgKpBXeAXN75sZdpk4fo5xLyHMD3SVOzWyeUWKcpnmNmd+QbJLVjN/c
   mC16s7fBnlvI6E+zcovPNyFs3B+Hrijo5Wpbb03jqABlSopiB18OroVB3
   w==;
X-CSE-ConnectionGUID: nDfSNZIKRTGGC1BHvRl3/g==
X-CSE-MsgGUID: euHJI4y8QEChqqHBozstIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63028819"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63028819"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:39:32 -0700
X-CSE-ConnectionGUID: ki5L1aJITiGTE+v5UcwF8A==
X-CSE-MsgGUID: V1PxkFtdTBqBLC3iv7i10A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="175896588"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:39:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/2] wifi: mac80211: reduce scope of 2 variable
Date: Wed,  3 Sep 2025 11:39:02 +0300
Message-Id: <20250903083904.1972284-1-miriam.rachel.korenblit@intel.com>
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

The patches in this series simply reduce the scope of 2 variables.

Thanks,
Miri
---

Miri Korenblit (2):
  wifi: mac80211: reduce the scope of link_id
  wifi: mac80211: reduce the scope of rts_threshold

 net/mac80211/sta_info.c | 3 ++-
 net/mac80211/util.c     | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.34.1


