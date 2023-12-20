Return-Path: <linux-wireless+bounces-1022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78C8190B7
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8B71C24E43
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505AB39870;
	Tue, 19 Dec 2023 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMNy31MJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168F39863
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703014149; x=1734550149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rJ9nvCvCt7K3nnU32QnO41c+vE1B9XBM9esHMzGIqJA=;
  b=ZMNy31MJJmPgV6+yR4ZzsURSwGsrrf6Dylrnp1k7uVyhb0UDe9Q6dF5T
   oeNI1yrc4/1ZMxf9GUrQgGKGP21Jbc+odsKHeND4EzrEYTZWj+Mb+SBdx
   uyOQL3nI6N9y77cnHidG7JRfkz92TL98vXDyvlO4nBb5G+kz1vhmBIdtm
   yk5CWQHHVp3d1t+widqiazjjEjiEHrRvjW2LnfaUnmZ+7UfxujNnSzmoq
   CazNLgGDkYB+LxxAOu8k8qnrRnoXTAjJepLjnVhtKyrqomM5YQqcUddNj
   pkHdg6pNA/4ZCFHqHvhNM40OxMnDQkoUdA9oHc+8OjAducGBiLh/yjhYh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460054330"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="460054330"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="899478215"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="899478215"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:07 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/14] wifi: iwlwifi: Don't mark DFS channels as NO-IR
Date: Wed, 20 Dec 2023 15:29:20 +0200
Message-Id: <20231220152651.94cd9b96a532.Ifb0e8d8a6a6384493758f26b811d58432536101a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
References: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

The NVM_CHANNEL_ACTIVE bit means that active scanning/beaconing is
allowed, however it's not an exact opposite of IEEE80211_CHAN_NO_IR.
For example, NVM_CHANNEL_ACTIVE bit is not set on DFS channels, while
cfg80211 doesn't really expect NO-IR on DFS channels.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 1bccbbe9a5ea..402896988686 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1612,8 +1612,13 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 	if ((nvm_flags & NVM_CHANNEL_GO_CONCURRENT)) {
 		if (flags & NL80211_RRF_NO_IR)
 			flags |= NL80211_RRF_GO_CONCURRENT;
-		if (flags & NL80211_RRF_DFS)
+		if (flags & NL80211_RRF_DFS) {
 			flags |= NL80211_RRF_DFS_CONCURRENT;
+			/* Our device doesn't set active bit for DFS channels
+			 * however, once marked as DFS no-ir is not needed.
+			 */
+			flags &= ~NL80211_RRF_NO_IR;
+		}
 	}
 	/*
 	 * reg_capa is per regulatory domain so apply it for every channel
-- 
2.34.1


