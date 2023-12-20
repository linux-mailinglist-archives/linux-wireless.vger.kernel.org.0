Return-Path: <linux-wireless+bounces-1009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C202818E68
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C982837EA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5781037D3E;
	Tue, 19 Dec 2023 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbjGr/7+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B237D39
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703007691; x=1734543691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ggLh64SME2uyC4SNAH9vTEw95j4Gr+YKvm8FWZrpE1c=;
  b=kbjGr/7+dWJIOPEPdO/kogQAUc1G0Ol92lEXzJhk/bUHCq0XELNgta2/
   UZo/Hd9uQ/3QvESJFCDNdKS9MvSqXO6EJF0Ab5LBeILT5vdrI9JR6szNp
   KsexnOCHiJOutX5jSyE0oHnV8QZ1EhlMbRV2e8r+EMWzeglu76gSCp1JK
   iAlFsSsKNst494Jv3vbE/wh5kCn2vrd64ylvmgENJ4wCiPqS4r28R8pSY
   Sc/vj7g7ov9Svbuu/5b8EiGB4if+sM+TLL2/ti8DGF2/QdCwYXlSxDXSU
   IpliGcOAwGWm1e8M9G9r3bY1zqdP22ryZyKlkcL7hHXcKRzB9++n/dbgB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2790483"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2790483"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894370222"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="894370222"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 08/13] wifi: cfg80211: free beacon_ies when overridden from hidden BSS
Date: Wed, 20 Dec 2023 13:41:41 +0200
Message-Id: <20231220133549.b898e22dadff.Id8c4c10aedd176ef2e18a4cad747b299f150f9df@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This is a more of a cosmetic fix. The branch will only be taken if
proberesp_ies is set, which implies that beacon_ies is not set unless we
are connected to an AP that just did a channel switch. And, in that case
we should have found the BSS in the internal storage to begin with.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Fix wrong email addresses
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a601f1c7f835..68ba446067ac 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1871,8 +1871,12 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 				list_add(&new->hidden_list,
 					 &hidden->hidden_list);
 				hidden->refcount++;
+
+				ies = (void *)rcu_dereference(new->pub.beacon_ies);
 				rcu_assign_pointer(new->pub.beacon_ies,
 						   hidden->pub.beacon_ies);
+				if (ies)
+					kfree_rcu(ies, rcu_head);
 			}
 		} else {
 			/*
-- 
2.34.1


