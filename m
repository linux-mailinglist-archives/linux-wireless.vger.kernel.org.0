Return-Path: <linux-wireless+bounces-18495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8656DA286C5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B2188A2F1
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC2D22A80F;
	Wed,  5 Feb 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBVeJGDg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AF22A1CD
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748387; cv=none; b=C/Bf/tjsaOD9adiBEVqCuBirxvDwcOKbEcgyDOb2L+DhDs26UrotIoAqsbpgfGPJiAeoAoPmo4SligvWha447bqz635E/J1NQumzrDG50kltinJnSnN/rpPOKzr+FNtwP0Crfrkufd69PNZMF+8IzuI2MKZSRoagz7i+Ofln0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748387; c=relaxed/simple;
	bh=A4MxGisMpGGkiZximaHZvlPkFt1jNQOASSMrSwdFkeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgTQ60G0zrco0c/9mOvW/CwpA6kHZM7wCOk4dtXA2tQ2YHnXVUlf1iEUhdwR3ROED0ru37+0mnrzGmMIbqoH/XX9rVdVCDST4VbGl/clfOs4AKTBY06CZTNyVxl8yF9Cy4DVitG/1wF2b+W6kjCFUKXInQWtdjXysu9ODHyB4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBVeJGDg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748386; x=1770284386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4MxGisMpGGkiZximaHZvlPkFt1jNQOASSMrSwdFkeo=;
  b=SBVeJGDg2voPSALU+wtteOMaoxCpTfkEpTxj4ayPYCZoiSHcUOXxAob4
   ssQ/8kzmyzMyZ3its05RbFdDTQtiePcVSn1TI51LnAste9nEfJbaVWR8T
   xUIUuAhxOHzuFOHMFTinxoY6ThTSQJeMfSZCE6TWty6fR6KScrADoXlaX
   hkXS/0UE6e3oc26DsvqgIb374jDcPlGyTCry6aY3pFZ7b1dofFEu2Ny//
   Sfa6dFaONAcz65DOERTHOnKe+GojTV2wBcO1rEQqU+3l/0PvcYJh5WX8G
   lBZ8kjEazkSChKbDlMAyq6WB3q7QevlHgfdUhzWfc5un0A7dMiRmlASRI
   A==;
X-CSE-ConnectionGUID: 1c7d+RWWQV2pG3yj4sf7cQ==
X-CSE-MsgGUID: 0Z9BM2EMS4yE505yq1Fz0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225203"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225203"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:45 -0800
X-CSE-ConnectionGUID: G0YxBavZRAS0Pn3cfTTuUg==
X-CSE-MsgGUID: VQt2iLNvR9CpUYUd3nfoiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845256"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/17] wifi: cfg80211: Fix trace print for removed links
Date: Wed,  5 Feb 2025 11:39:11 +0200
Message-Id: <20250205110958.1dd2831cab5f.Ib9f5e82286f0352cd057b4bf76737223e9de8274@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Print the mask of removed links in hexadecimal.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4f0abd5d49df..9aa8081ca454 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4118,7 +4118,7 @@ TRACE_EVENT(cfg80211_links_removed,
 		NETDEV_ASSIGN;
 		__entry->link_mask = link_mask;
 	),
-	TP_printk(NETDEV_PR_FMT ", link_mask:%u", NETDEV_PR_ARG,
+	TP_printk(NETDEV_PR_FMT ", link_mask:0x%x", NETDEV_PR_ARG,
 		  __entry->link_mask)
 );
 
-- 
2.34.1


