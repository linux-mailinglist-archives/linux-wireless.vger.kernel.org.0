Return-Path: <linux-wireless+bounces-601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C680BAD0
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B63280C8E
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7511710;
	Sun, 10 Dec 2023 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAaJNyTd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC210C
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213524; x=1733749524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tZ7+wE/izBaRQGj8oFwyPgjypteWkGNiW6d7aDysPgY=;
  b=TAaJNyTddqXbG1XQFU18tyrNt1Wsmf7o8XtJVYp9sYfiT2FZ+uslDM87
   g9o1oH5MceRDCEiJwt5WuI2AYVvxBCNxbcge5Ul1Ye+nXj5aV+v8rl1Ue
   LrG+Leifik9PSevrBLo4Hulqwbvqtxs4VjBOcp9UXpCcqf/t1hSemW1hn
   uwkSnMeSYVEH3+NDc84POMaCOatgLYPKQ17wB9z2jKA1XEQ5GfyWpQ6HP
   fW9ITOAc7BHuJG4rv03HnPejhnbWNK5q40N74h1hS9AP8BkjirUmeZYrb
   f8SWVHQhUsphom/dcuAXT8v/aRYDg9vlOIWv9fr8scJz1lw34nEqlmnY8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480745745"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480745745"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748925618"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748925618"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:21 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>,
	Berg@web.codeaurora.org, Johannes <johannes.berg@intel.com>
Subject: [PATCH 06/14] wifi: cfg80211: Update the default DSCP-to-UP mapping
Date: Mon, 11 Dec 2023 09:05:24 +0200
Message-Id: <20231211085121.8a1c7d1f0034.I50aed38be78ae9aea052938e2cb6b5800010ecd4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The default DSCP-to-UP mapping method defined in RFC8325
applied to packets marked per recommendations in RFC4594 and
destined to 802.11 WLAN clients will yield a number of inconsistent
QoS mappings.

To handle this, modify the mapping of specific DSCP values for
which the default mapping will create inconsistencies, based on
the recommendations in section 4 in RFC8325.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/util.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 626b858b4b35..dd93e1950921 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -980,7 +980,53 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 		}
 	}
 
+	/* The default mapping as defined in RFC8325 */
 	ret = dscp >> 5;
+
+	/* Handle specific DSCP values for which the default mapping doesn't
+	 * adhere to the intended usage of the DSCP value. See section 4 in
+	 * RFC8325.
+	 */
+	switch (dscp >> 2) {
+	case 10:
+	case 12:
+	case 14:
+		/* High throughput data: AF11, AF12, AF13 */
+		ret = 0;
+		break;
+	case 16:
+		/* Operations, Administration, and Maintenance and Provisioning:
+		 * CS2
+		 */
+		ret = 0;
+		break;
+	case 18:
+	case 20:
+	case 22:
+		/* Low latency data: AF21, AF22, AF23 */
+		ret = 3;
+		break;
+	case 24:
+		/* Broadcasting video: CS23 */
+		ret = 4;
+		break;
+	case 40:
+		/* Signaling: CS5 */
+		ret = 5;
+		break;
+	case 44:
+		/* Voice Admit */
+		ret = 6;
+		break;
+	case 46:
+		/* Telephony traffic: EF */
+		ret = 6;
+		break;
+	case 48:
+		/* Network Control Traffic: CS6 */
+		ret = 7;
+		break;
+	}
 out:
 	return array_index_nospec(ret, IEEE80211_NUM_TIDS);
 }
-- 
2.34.1


