Return-Path: <linux-wireless+bounces-16895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6CF9FE285
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D35B1881FE1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCD8190468;
	Mon, 30 Dec 2024 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzSRUHI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC2187870
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534587; cv=none; b=lKdmJ4hSHzffakSHYyxDzSs2QPiaah4ln2TY0SU2SJ4xffIosI87/jue57yN0Fq312v8MHlH6I8kHupExhzoivX+X5NnJQ6Hc/r1AjFWydf3IXmZkczAHVI6TdkVzSrIcDmR7QJkFA7a5MZ40xS8jzBMNIo4J81/sKoNqAu9byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534587; c=relaxed/simple;
	bh=JbtW1lIiHkCbtPzM0doK1y3v4DlITHkWMM/dYXxq3as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=moFZbu50M5RCG5rZuD+4xfQIBoPuORzZXeAhbBa40HIhc8tiiDEHZAjFHWUwkdt1ZmoNB9IDCg1NQB7d8dl0YOUzu8BVAUA6oDRrBjie0bjv7GwRWMh8Jwesrg04qVkTDMCAz7GAvbHtSKq9F49gaIB3Opia3tY0IpnOMWkhIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzSRUHI+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534587; x=1767070587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JbtW1lIiHkCbtPzM0doK1y3v4DlITHkWMM/dYXxq3as=;
  b=CzSRUHI+Ux2hb2JMClFrt5ebRthh4W5/Bb7fahheOnKQLI4ipr4EMXIY
   AZKPVJzUW9mx5k/Jd2d9JN/dXp0oF26kSESbQp9F5lrG796ND1EHKiy/N
   zu3oQ80k80WA82bYJfa+zglQCFCFujgNZpVel8uUrB0XMQoA9J4pNEv/I
   TkJK5PqA/Q0IxGc7QkI2Zcgvy0i7yMDiZbGUnzbQTQb+HBhumsyu/4BKB
   u5BTVudqZsvpYj69faFB5/BDQ+G3HqDDvWfvGkSdMmmLvUwclxDG7FP9R
   v6aYVeniM+49xqnkZZmb8O4Jy2kG4t8bpQVumzg7vjjIdMLjSHXZsmJ+J
   A==;
X-CSE-ConnectionGUID: f0xuh8AuSoS5fpdkS4BuUg==
X-CSE-MsgGUID: +rxxLZp6RoiHcrZKpaTBpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405029"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405029"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:26 -0800
X-CSE-ConnectionGUID: b9ZYNtAESduqNgCGuNvmow==
X-CSE-MsgGUID: 4GkehJspR5m1AEIHSy9IOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758918"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/15] wifi: cfg80211: Fix trace print for removed links
Date: Mon, 30 Dec 2024 06:55:51 +0200
Message-Id: <20241230065327.2a90e927988f.Ib9f5e82286f0352cd057b4bf76737223e9de8274@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
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
index a57210c8087c..41a9f52e1f97 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4100,7 +4100,7 @@ TRACE_EVENT(cfg80211_links_removed,
 		NETDEV_ASSIGN;
 		__entry->link_mask = link_mask;
 	),
-	TP_printk(NETDEV_PR_FMT ", link_mask:%u", NETDEV_PR_ARG,
+	TP_printk(NETDEV_PR_FMT ", link_mask:0x%x", NETDEV_PR_ARG,
 		  __entry->link_mask)
 );
 
-- 
2.34.1


