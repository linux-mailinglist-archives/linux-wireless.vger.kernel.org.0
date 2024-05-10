Return-Path: <linux-wireless+bounces-7468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F7D8C2660
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA4C286338
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B027168AFC;
	Fri, 10 May 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqcmRQiL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC4171677
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350028; cv=none; b=raB/ExbVtYEXE0CL62IHvFSYKhSyYDxRMhjfy8/9KOQZzNJ14+55jxroUVmA6mJjhk39aD3ahWOZSLTzD2mlGE06pd0qfwd6b5BhlLP69uo/pLSsirfBlNj7Pqj6SmDZ3t7ndjw9kkDoP4EEKXtdAmtnVb3j2gAKywOAFpxFpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350028; c=relaxed/simple;
	bh=PToMZa0wjwpHe0TDHSH5JmgZX8xQJSzZtIeeVkazJ38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5pSiZpXVoVxicCPSQqzUhwtIZOOlFBaBrNXxu4PVxJP3jQ0T4H5WOKp3JcoOOPzwut89P0ZKBKfrODHkrizHXNE8HMqrw0+6GjXmwtpIOcwtjfWDuh3sDyA783wbmIApZbHkg7MKYWjhpQSK3HMIfFjunDl/CscJk4p/Jeke0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqcmRQiL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350027; x=1746886027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PToMZa0wjwpHe0TDHSH5JmgZX8xQJSzZtIeeVkazJ38=;
  b=IqcmRQiLLbeq39xSvTRiH5Jfv6CjltxfqpyasDLCBmG5D1YVfSzpnQCb
   yaeMQzOyi6FoA6ZDWWsHzqsR3T3sDtmUvrEVezmOK3Nj0hvoQZZaJPesr
   PMB7FRcFzIM2liOspgT7EkdVCYjBybG57K4TjFsMETHNuqIQrdPdqmqIr
   AhnRl2w5QSgpOU7K/jE+8vwYrPTUlm8xGzR/s7cyfOrGBofI6WZUDiVUC
   RwW0cyRsDf+FmO10rJEwD8RS3Q4MOHO52tVGByYT5hY0Ydjz2K2MF4Tes
   8j5hg14MulKDv57OwqAkw/978jlBO//lmbLcE+hTkFEqXFJgQ6+HxV5f1
   g==;
X-CSE-ConnectionGUID: RDkS9zXQQTiBJUHn2NdYog==
X-CSE-MsgGUID: iBuzlcfVSkqaHXgUzKFacQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125578"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125578"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:07 -0700
X-CSE-ConnectionGUID: xsEoVYVzRiG+VolO5smGUw==
X-CSE-MsgGUID: 4kwZzdO3TJmU7+0QjXwHUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101879"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mordechay Goodstein <mordechay.goodstein@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: mvm: set properly mac header
Date: Fri, 10 May 2024 17:06:35 +0300
Message-Id: <20240510170500.12f2de2909c3.I72a819b96f2fe55bde192a8fd31a4b96c301aa73@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In the driver we only use skb_put* for adding data to the skb, hence data
never moves and skb_reset_mac_haeder would set mac_header to the first
time data was added and not to mac80211 header, fix this my using the
actual len of bytes added for setting the mac header.

Fixes: 3f7a9d577d47 ("wifi: iwlwifi: mvm: simplify by using SKB MAC header pointer")
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 8bbef4454399..98a4f6fb3f03 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2451,8 +2451,11 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	 *
 	 * We mark it as mac header, for upper layers to know where
 	 * all radio tap header ends.
+	 *
+	 * Since data doesn't move data while putting data on skb and that is
+	 * the only way we use, data + len is the next place that hdr would be put
 	 */
-	skb_reset_mac_header(skb);
+	skb_set_mac_header(skb, skb->len);
 
 	/*
 	 * Override the nss from the rx_vec since the rate_n_flags has
-- 
2.34.1


