Return-Path: <linux-wireless+bounces-19865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04510A547BB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F5A7A2358
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD971A08A6;
	Thu,  6 Mar 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RONEucXI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92320011D
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256763; cv=none; b=BN4iHRI8/rsox9/1eSuW2ASL92EBM/9eGh5KBUcfQVs8W3HC7wBxScoI+lovbF9xO1/ESZzDh1ujKqTMs2uZQGZVmVYrnq7z3N1IDCVBQBYo+M/wGWYorMuZPLMNoODE4FmQ3g3OW0zU+PqxhTfWVsS5oOQknGzdiI3bFDN6u/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256763; c=relaxed/simple;
	bh=KAmBTAtCwr1Cevo8tG1a7EUCkwNJmciBl8THRaMUeKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s56bBR1+mm2bEdsx0BKAQc7XU0mXKmj42dbizYfYv591PnY7PU0PX0kr9BzaoBMW+IhZFgYxZ/SP5b5QIPBfTPH8CgJzo9CY4H5RMvz+AtzLzATH7Yc/wamp3OLe5QdtAkMqfWP37AIoYESpSeU424pDfgIaCVbWzyiC/QowPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RONEucXI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256762; x=1772792762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KAmBTAtCwr1Cevo8tG1a7EUCkwNJmciBl8THRaMUeKQ=;
  b=RONEucXIfhoasREZIL3kDE+ghSn5mh1FKfgdmwY+ShvyGA7k9ty8Q5XF
   TWQsXDjLZdXXNC4XQi0XOPdMM7Nkj/3y537nH2OZZeJS74URpO+iuuxtd
   nLsla8weUj3ACyGH8bB5O23jEU7Kf7o7iQm1UYn1RYlVzT3b5L6Uaz/Wi
   FuG23bjkcnNt3kHdb4qspfEiuA21pQ5BZWR/MlsT6vt8V2XF/OpAJHxOC
   g6Lig4nhW4w2VbOQ8+E65RcEt0HkvbiipnEhrh721WT+3x1qFOkVvDVyl
   zZ11aFMkH9/zL5/OiTSaNUx6zJPwQK7C4iMWD0Q9DDValF9lX4cJX1R1c
   A==;
X-CSE-ConnectionGUID: KDbNkKfqTJOIbnYKmiubSA==
X-CSE-MsgGUID: nhXG4BUtSc+lxDkKwKGMQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41433436"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41433436"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:26:01 -0800
X-CSE-ConnectionGUID: 0Fu4pJw1SzShTxjHghjTAA==
X-CSE-MsgGUID: wJll74HUR6S0gvwsBod54A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="142209557"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:26:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless 1/3] wifi: iwlwifi: pcie: Fix TSO preparation
Date: Thu,  6 Mar 2025 12:25:46 +0200
Message-Id: <20250306122425.8c0e23a3d583.I3cb4d6768c9d28ce3da6cd0a6c65466176cfc1ee@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306102548.4056118-1-miriam.rachel.korenblit@intel.com>
References: <20250306102548.4056118-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The allocation of the scatter gather data structure should be done
based on the number of memory chunks that need to be mapped, and it
is not dependent on the overall payload length. Fix it.

In addition, as the skb_to_sgvec() function returns an 'int' do not
assign it to an 'unsigned int' as otherwise the error check would be
useless.

Fixes: 7f5e3038f029 ("wifi: iwlwifi: map entire SKB when sending AMSDUs")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 7b6071a59b69..7c1dd5cc084a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1869,12 +1869,12 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 				   unsigned int offset)
 {
 	struct sg_table *sgt;
-	unsigned int n_segments;
+	unsigned int n_segments = skb_shinfo(skb)->nr_frags + 1;
+	int orig_nents;
 
 	if (WARN_ON_ONCE(skb_has_frag_list(skb)))
 		return NULL;
 
-	n_segments = DIV_ROUND_UP(skb->len - offset, skb_shinfo(skb)->gso_size);
 	*hdr = iwl_pcie_get_page_hdr(trans,
 				     hdr_room + __alignof__(struct sg_table) +
 				     sizeof(struct sg_table) +
@@ -1889,11 +1889,12 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 	sg_init_table(sgt->sgl, n_segments);
 
 	/* Only map the data, not the header (it is copied to the TSO page) */
-	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, offset,
-				       skb->len - offset);
-	if (WARN_ON_ONCE(sgt->orig_nents <= 0))
+	orig_nents = skb_to_sgvec(skb, sgt->sgl, offset, skb->len - offset);
+	if (WARN_ON_ONCE(orig_nents <= 0))
 		return NULL;
 
+	sgt->orig_nents = orig_nents;
+
 	/* And map the entire SKB */
 	if (dma_map_sgtable(trans->dev, sgt, DMA_TO_DEVICE, 0) < 0)
 		return NULL;
-- 
2.34.1


