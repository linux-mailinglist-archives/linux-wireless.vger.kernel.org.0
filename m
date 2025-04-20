Return-Path: <linux-wireless+bounces-21753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADBFA946DA
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AAF175234
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 07:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163511547D2;
	Sun, 20 Apr 2025 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZul1NBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05F2AE86
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132418; cv=none; b=fJqIlSP0Nzxux1Xx/4GUILFedEC3mzZhpGbUaY8xwtzyrW4XBEw4mH+NhNUeQH7Ol1pFGCzlpuYl9X52hwjWMgzwe/764JyExKuTr+ClLNQkfaWEc6oiTcSD8uKCoLzGllXwCgwyyg9IBZl0UGiFYmslg9iLyVCLYBN+9eRSx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132418; c=relaxed/simple;
	bh=a5OZ2SgZLBuiuH7HHJnzElrzUY1YkYDd9BlWVXK8JP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qfEEob9VHxWHHdnFPT7Ntzv1Gz7AOn8FapeA+9En+KVs531RkEK5q2ZWqgEelpBKkWL7Owgv7+N1fKoAo7NNkhMxluDyge9UlZfkE0v2SU751/TW8Q8zfcLyCH64nNGRGjuvlcBmcssdeZ80souH21DHGM4336/Nz7gGIAqQSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZul1NBm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745132416; x=1776668416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a5OZ2SgZLBuiuH7HHJnzElrzUY1YkYDd9BlWVXK8JP0=;
  b=GZul1NBm7DpGeb2lxzbUJIaStxRcyyFuXaHCOXfWgEkSjRRVIU7FshWa
   iOqCHHlEcxWT1LgZSgED1m5UYj+G4YdZAe5JqA6UFzP+xLbHr50UUhGAW
   OirBjdDfAdMw9xSaSExnLhFGzc/GlfbW1P60jvYZQ1oq6Z/ayciPFoDYc
   u0cV19uBNZEkglmt9bDs4u3qE1vPH0yXyeOOYhjh7SnSDwaulo0ptjLSL
   aE9NO7iEEhQ1a0/JknwwW4tOToRwSDOG8YrxKA0bLfhC4YTLYxHGCwglr
   U9+alfSk4869O9Ie1TEOrmtl3BqgZ/1IDQ3Itu5jbDOiq+a1oTsCJcdFX
   g==;
X-CSE-ConnectionGUID: ovrUOcB6Q0S9co8VNNYQ3w==
X-CSE-MsgGUID: JFpvGVRjS1mJeaUh2ofpAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46827879"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46827879"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:15 -0700
X-CSE-ConnectionGUID: hU9+kggpSZm7D5RqRrYHEw==
X-CSE-MsgGUID: 20x31pFdTq2J/qvhPZaZ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="154615700"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 0/7] wifi: iwlwifi: fixes - 2025-04-20
Date: Sun, 20 Apr 2025 09:59:54 +0300
Message-Id: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
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

A few fixes from our internal tree.

Thanks,
Miri

Benjamin Berg (1):
  wifi: iwlwifi: mld: only create debugfs symlink if it does not exist

Emmanuel Grumbach (2):
  wifi: iwlwifi: don't warn if the NIC is gone in resume
  wifi: iwlwifi: fix the check for the SCRATCH register upon resume

Johannes Berg (2):
  wifi: iwlwifi: back off on continuous errors
  wifi: iwlwifi: mld: fix BAID validity check

Miri Korenblit (2):
  wifi: iwlwifi: mld: properly handle async notification in op mode
    start
  wifi: iwlwifi: mld: inform trans on init failure

 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 28 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  7 +++--
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |  6 ++--
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |  5 ++--
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   | 13 +++++++--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  | 10 +++++--
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  5 ----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 24 +++++++++++++---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  9 +++---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 16 ++++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  2 +-
 13 files changed, 90 insertions(+), 37 deletions(-)

-- 
2.34.1


