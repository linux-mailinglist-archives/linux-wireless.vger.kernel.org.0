Return-Path: <linux-wireless+bounces-878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280D4816022
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Dec 2023 16:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D307028340E
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Dec 2023 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C8544C7B;
	Sun, 17 Dec 2023 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGW1Ocqk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38944C8E
	for <linux-wireless@vger.kernel.org>; Sun, 17 Dec 2023 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702826977; x=1734362977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RpsSGqJGs6/tq2WClwgzZRJ6f1RGI3hBSeaMwb86m+M=;
  b=ZGW1Ocqklu7A690uTcsrxmY0/Ji0VpxdkTT0NN1s/rTV515q45+SFQ/G
   BwdCLLxgr3sl79N38xUMVRw6oqSiBltCc7dxvuK9JJpW86lGcUNijt9Ah
   7wTx7OExgJg5sINxHlGKCU2upIQZVn9o+SA00/UhrupmlmJ52YbSSdzPm
   YKQ8b3lgH2A5EkflUPU2TRmqIdhyzo1J+KDQDYkYuz8OFWTDeJVNDpy4k
   HRmzAEcUybgJOMYl/4MyteE0qqA+Rk5wuy/cOjiML1k9Nl0eGZVPPum+y
   iDRP5YnaT0zbb//IdL5pZ3AE3E2ygsLuB52Lbf+QNUnv4JYyBILmkr0ZD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="385842344"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="385842344"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 07:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893522773"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="893522773"
Received: from weis0041.iil.intel.com ([10.12.217.187])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2023 07:29:34 -0800
From: Ilan Peer <ilan.peer@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>,
	Berg@web.codeaurora.org, Johannes <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH v2] wifi: cfg80211: Update the default DSCP-to-UP mapping
Date: Mon, 18 Dec 2023 11:30:05 +0200
Message-Id: <20231218093005.3064013-1-ilan.peer@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211085121.8a1c7d1f0034.I50aed38be78ae9aea052938e2cb6b5800010ecd4@changeid>
References: <20231211085121.8a1c7d1f0034.I50aed38be78ae9aea052938e2cb6b5800010ecd4@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default DSCP-to-UP mapping method defined in RFC8325
applied to packets marked per recommendations in RFC4594 and
destined to 802.11 WLAN clients will yield a number of inconsistent
QoS mappings.

To handle this, modify the mapping of specific DSCP values for
which the default mapping will create inconsistencies, based on
the recommendations in section 4 in RFC8325.

Note: RFC8235 is used as it referenced by both IEEE802.11Revme_D4.0
and WFA QoS Management Specification.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/util.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 626b858b4b35..d1ce3bee2797 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -980,7 +980,63 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 		}
 	}
 
+	/* The default mapping as defined Section 2.3 in RFC8325: The three
+	 * Most Significant Bits (MSBs) of the DSCP are used as the
+	 * corresponding L2 markings.
+	 */
 	ret = dscp >> 5;
+
+	/* Handle specific DSCP values for which the default mapping (as
+	 * described above) doesn't adhere to the intended usage of the DSCP
+	 * value. See section 4 in RFC8325. Specifically, for the following
+	 * Diffserv Service Classes no update is needed:
+	 * - Standard: DF
+	 * - Low Priority Data: CS1
+	 * - Multimedia Streaming: AF31, AF32, AF33
+	 * - Multimedia Conferencing: AF41, AF42, AF43
+	 * - Network Control Traffic: CS7
+	 * - Real-Time Interactive: CS4
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
+		/* Broadcasting video: CS3 */
+		ret = 4;
+		break;
+	case 40:
+		/* Signaling: CS5 */
+		ret = 5;
+		break;
+	case 44:
+		/* Voice Admit: VA */
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


