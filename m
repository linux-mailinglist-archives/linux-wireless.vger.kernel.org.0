Return-Path: <linux-wireless+bounces-3239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C0C84BA89
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229BF1C214D4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE18134CE0;
	Tue,  6 Feb 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PViucR4B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052C134CDF
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235363; cv=none; b=Hcd7SrWd7F+HcGMZqCU9H0glmY9jQBvYkhYN9JYKR9Zd5km3iZOGqNEs1Jj6FGIwvdZxmVaLqP53mNVKYotaM4FaMaj7qd2fuKaxbNDYJ4n0hhgC36nXH7x7Yne9NeBjOz7fzookhnEUN57TErFPmkTVPCA3q8BhXmdvAE1aoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235363; c=relaxed/simple;
	bh=0G+QrkN4u5yEDM1nW3ZI+XNNxwLZv9YAlkZn3oRWrQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJ7o4BIReKXIqhOS22xR694S2RQgq7N/kvJg6laGfKUmE+bYOkshjdishOUifAOGS5xHiGdXifqcKsG/SX3YSaiPe02za6ALsOV+CX+28LHCvdOMNxku7yvhaPHJth9ViCdm9SYRBxMH7Oaj22b17yhXUXvU8slptOS2SUYQGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PViucR4B; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235363; x=1738771363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0G+QrkN4u5yEDM1nW3ZI+XNNxwLZv9YAlkZn3oRWrQU=;
  b=PViucR4BA1d69Qnsw8SJ9bjygvNGjNDEiyE2exTPyFqvtw9bRWA977PN
   f1qEHgsSnCc8QVhfz29uTbL7I2AcgG1SW60+HtH3ZQGzCwJX2Yj1UDZ5J
   eWyyqZCXmi+Pj72GkNxXwQaOB/eewW1xmD7SuVDqeZMhb7sx8Zt70MWWJ
   SmYB6CIKYL1jJA1WpVSYNpgDGJgJFza0yDzn/C6FCJJ+l3wqTvUYvyJcs
   9eN+RTn6QBRlO4xhIHz8qmFvBsK+Zbs7qNsANrHPjF2uxgkCg/nMWLGbw
   Uv6ezk63NlqmvhmyID68ILOMcOH0FeIernvI/qbcEabk58JNQm15ek5y+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252421"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252421"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349847"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/11] wifi: iwlwifi: mvm: show skb_mac_gso_segment() failure reason
Date: Tue,  6 Feb 2024 18:02:11 +0200
Message-Id: <20240206175739.b1b907741e85.Ib8ee9c90bd8f1af69969981ff0c63e9cc3123e1f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If this warning triggers we don't really know why, print out
the return value so we can see it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index c5fafaaee521..3c887a8eebc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -951,9 +951,15 @@ iwl_mvm_tx_tso_segment(struct sk_buff *skb, unsigned int num_subframes,
 	next = skb_gso_segment(skb, netdev_flags);
 	skb_shinfo(skb)->gso_size = mss;
 	skb_shinfo(skb)->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
-	if (WARN_ON_ONCE(IS_ERR(next)))
-		return -EINVAL;
-	else if (next)
+
+	if (IS_ERR(next) && PTR_ERR(next) == -ENOMEM)
+		return -ENOMEM;
+
+	if (WARN_ONCE(IS_ERR(next),
+		      "skb_gso_segment error: %d\n", (int)PTR_ERR(next)))
+		return PTR_ERR(next);
+
+	if (next)
 		consume_skb(skb);
 
 	skb_list_walk_safe(next, tmp, next) {
-- 
2.34.1


