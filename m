Return-Path: <linux-wireless+bounces-30641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0691D0F7C3
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB5930596BD
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B634D381;
	Sun, 11 Jan 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6Kv+J1W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AA34CFB3
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151044; cv=none; b=QWNHY9bVRs358V3JMWyrsoq3a+BaV9TVleX/JpOxMxVFtxxt203/YBtOswE8W1rqZKafY7su3F9hKggcWvajJvukqxqrBt6yjbx9MIVMUIwtpb7fdcqxuRcQAJpBCbUOvqiqAdm4UpJLBt2SW78OmmMHFIuvTT/kMtbFnPAUc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151044; c=relaxed/simple;
	bh=LThXZQu5eGePBeSXgBmiedkpjQ/NBge+UcGDliLIYzM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Lox6IqaVT8SrXQKxH+Ivrf9fGTpBPR2kuhDfNwHMJ3MLrDR6bmd+0fWvIKRPYkbx4ke+4dINLzWLO7BsociGmVtKQRgAAYHXeSjXbgmrkaDxuS+R9rQY/6HXGFtwCUTaTD5Kk5SibzGrm00yWJPo33dS7IZQI3HMUx3X4A/KmFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6Kv+J1W; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768151042; x=1799687042;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LThXZQu5eGePBeSXgBmiedkpjQ/NBge+UcGDliLIYzM=;
  b=h6Kv+J1WsKIDCgO7Xu75/ko6VuD/KTh8qHoJLJ6cnAystzFoYxkhR7zL
   5kdA/QOQrdHhaDeNpIF1tMspJWA6ugQn/yxyFUJ61UZvMmZDuNKxds8ap
   /z2ENuCFVBT/1Z9vS2Jj+ejI2Lc70eycwkH0l6vU68YBs4sr5cqrx17uG
   410qiRzDEZgAJVHiIfUIhK4RMiF25NrRfbhdxql1gAfKrswq9NskrAXLt
   tPs2suN43IkMhC7cSpiEu3MG+i3+t7M9TAz/Y1EUVwlPOCBExXuF0W6g1
   HkBIg4IoRrKaBH6puo7pZvvBgrvuRS+cY7x7sVmV2W1ApOqNVqvF67kRN
   A==;
X-CSE-ConnectionGUID: DnrNuRK8TJONXcPIM2Aw1g==
X-CSE-MsgGUID: oFbC1k5WTvayz14hFie3PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68650775"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68650775"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:04:01 -0800
X-CSE-ConnectionGUID: 58aq8+GeTSuXAo6w9kHOkw==
X-CSE-MsgGUID: 9+An2EH3S4O07/+V/api/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208433269"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:04:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/4] wifi: nl80211/cfg80211: non-EDCA ranging support enhancements
Date: Sun, 11 Jan 2026 19:03:47 +0200
Message-Id: <20260111170351.2093318-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This series adds several enhancements to non-EDCA ranging:         
Reporting of more capabilities, periodic ranging and RSTA operaion.

Avraham Stern (4):
  wifi: nl80211/cfg80211: add new FTM capabilities
  wifi: nl80211/cfg80211: clarify periodic FTM parameters for non-EDCA
    based ranging
  wifi: nl80211/cfg80211: add negotiated burst period to FTM result
  wifi: nl80211/cfg80211: support operating as RSTA in PMSR FTM request

 include/net/cfg80211.h       | 33 ++++++++++++++++++++---
 include/uapi/linux/nl80211.h | 51 ++++++++++++++++++++++++++++++++++--
 net/wireless/nl80211.c       | 27 +++++++++++++++++++
 net/wireless/pmsr.c          | 27 +++++++++++++++----
 4 files changed, 128 insertions(+), 10 deletions(-)

-- 
2.34.1


