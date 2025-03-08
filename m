Return-Path: <linux-wireless+bounces-20041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629EA57E61
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A6188D90B
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382171A3177;
	Sat,  8 Mar 2025 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEs21YWR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4501A08B1
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468033; cv=none; b=bWitSWj6LowIORODmMuTATM4TuHHlOiNjbTwyU5DGcMGKF/sg3+1pRxil0k4qwUuHkJhRrBN/bKHC5vGGsXTE6Se3f92j/8uCYXNdC0tPh673UT5HHrtQmEZzdyFNtwF/LEuLmQ6VTsXfV8KQ+UVGWimbUxMuvc0fckGbmuIpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468033; c=relaxed/simple;
	bh=gsIIy478v8/6nY9cvDyZuNEbjerd5nropVjWreVv+qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvCF861IgbWxFQc6pdajz+W4OG6C0iNbBReKYxBCoePug38485GzH+uOKas5S4KuBqp3lMSh9P9X4QR9HeZEDQAXDhmDnzU94/JGzd3kH/HXO+3RIx7gRGKyR4bM/RuGuwoP6sMjqdnS3LlbvNF7gINbrNn/qx7/vHZFP0U8B54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEs21YWR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468032; x=1773004032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gsIIy478v8/6nY9cvDyZuNEbjerd5nropVjWreVv+qI=;
  b=aEs21YWRBawkUb7giKJTi7YAG9QBvWFB3WDDkZ/DUYwtWkc5fAyDDkSt
   IcWoBG+m+4hcQSMenqePU1DFkQx1mf/nqvwopArhKg13eotCdwEIHSv0D
   ohMAsP8NLrasJr4fOCPivhn6srGpv72oy20cFXv/R/qCbScou8idkYkzx
   o51fRI51WKb7Lobb2gutHfJBsHe1PC1Rm8YJjSs+6jM6lPVdfxBz+fymX
   aev/KYkyVMNCeZc+won+V/phCFfoPGaWVSoDNots7Z1hVMhzFk6Gu5yiq
   wfyeWE5SWxG4jrCCGozBPcD34oFrdUfPhRZwlvUZJoTeXAn1MswnEAFME
   A==;
X-CSE-ConnectionGUID: Ydnx+3MoTraNK/lPazs5gw==
X-CSE-MsgGUID: Q3fRz1MeTpS4Jkc3mfV0aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413108"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413108"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:12 -0800
X-CSE-ConnectionGUID: vK2Q9ioITga2ni6ZowUxlQ==
X-CSE-MsgGUID: 3pOFwKtLTg28lpyhnTRNTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644423"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 12/15] wifi: mac80211: Notify cfg80211 about added link addresses
Date: Sat,  8 Mar 2025 23:03:38 +0200
Message-Id: <20250308225541.0c6bf8b1bef3.I2aa16801f07321a580dd7dce4a074a3486f627f1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When ML reconfiguration is done and new links are added, update
cfg80211 with the addresses of the newly added links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f3bf66d4ce6a..60a585caa96d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10135,8 +10135,11 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	done_data.len = orig_len;
 	done_data.added_links = link_mask;
 
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		done_data.links[link_id].bss = add_links_data->link[link_id].bss;
+		done_data.links[link_id].addr =
+			add_links_data->link[link_id].addr;
+	}
 
 	cfg80211_mlo_reconf_add_done(sdata->dev, &done_data);
 	kfree(sdata->u.mgd.reconf.add_links_data);
-- 
2.34.1


