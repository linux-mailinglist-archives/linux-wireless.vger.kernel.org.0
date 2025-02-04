Return-Path: <linux-wireless+bounces-18439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E3AA278C7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746711885DA0
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAFF21638A;
	Tue,  4 Feb 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwiDyl+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6BB2144CA
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690995; cv=none; b=IshC1T3Oq0lINfYPuubxIWk70I4neSNQZnEwKT0coNutrvupqZd4NFEuXbvF2ZTJYOCBkOiZ21v596QXpGDSxMbBuVvshfGRuPMAn9U+LEJyjTHW47wa1vww08S1vseugvakvLH61ZbWBOkjNoQetViS0M9g7Rzo6goy7j9L7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690995; c=relaxed/simple;
	bh=A4MxGisMpGGkiZximaHZvlPkFt1jNQOASSMrSwdFkeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DI8GBBzYTyQlTGl2EfhmNnIc1oATFrQJWeLHdtUOOwSLzOkZq9Z8u2sJbmww15ytAX3Q9XRTKj57c3vtryXf+k1EMRs1vQaaLLLXkoo3Qc5FScWngTnNqcv1rkxb8N6HWnLxg6d83m21Ir9FrLjz5WtuMrtde6CQa5uKKEkHmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwiDyl+T; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738690993; x=1770226993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4MxGisMpGGkiZximaHZvlPkFt1jNQOASSMrSwdFkeo=;
  b=iwiDyl+Tvt9J/74BlYfcdQzRSZXWa7DI+seUkQXS3mh6vWdtEC8NrO1v
   6hsLz39I5A5OPlcxB9uYR9ZYL4F9sQFzbTxsdf0tzQzgYRULi4B646i2B
   rODNXWmyGG6G+7otWUsQxwZ0YQhQcH/SB5x0fG5/+UZGCBHuiTbMnv5Nw
   RTbouZ+WCjoklKQ1zNwlkUJZC15EfM5/LegjXjRG86UOx5BE0iEz9zjaJ
   y+MqduLy/i5cUCL+ios3uM2Hm/veBmOj7ALqZXUne+Z3UijBGIcdIvKw4
   uR6SJTMjukFV0FbSA1ozZFlx9J55Co2QfbJBdNTMY8meNIuw56yhRx8FP
   w==;
X-CSE-ConnectionGUID: AYweGFQkQwyc9g1vvGjh/w==
X-CSE-MsgGUID: uuIx4cvmTRKLTaphG90m9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585327"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585327"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:35 -0800
X-CSE-ConnectionGUID: rXRDKUg3Q/Kyjn6kh2kzZg==
X-CSE-MsgGUID: 34CAZAFtT4WxKTBz8njbLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696665"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:33 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/20] wifi: cfg80211: Fix trace print for removed links
Date: Tue,  4 Feb 2025 19:41:58 +0200
Message-Id: <20250204193721.1dd2831cab5f.Ib9f5e82286f0352cd057b4bf76737223e9de8274@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
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


