Return-Path: <linux-wireless+bounces-609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28280BAD8
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8817DB20A73
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E48C0A;
	Sun, 10 Dec 2023 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0tXvTtc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236AC106
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213605; x=1733749605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KreBiLuQGquSgy/UVsC9UojUd1ufeB/JDzNnIs0CQj0=;
  b=Q0tXvTtc49WuygpHhA+Ixjmefzd7lv03oz5mvl0agwZRoKQzFBAhb2nz
   +dprH+JoYWrsFBBe/H2WtUgkzLK8rryiytlFj0WuWPqEwe15WIli1+iIk
   7c4UAIl59fuiycb/ugYnenH3XyqeMBVyPvovaHEBKUHoBKQ809aNXkruX
   AO4wPejL3841LQn37pVkOaZcp9kp3K6GlFmSgNH3NDl59yU5i6w5BFeSf
   SdPnkfbWk8wLfjx7FPR6HB7bWGMiau35pio8pEDcs4QlE1uYp0hxNTgKd
   sun74NB2HOKUKRg8GgUByyIsRoqIYvAPuNVPofKyWdWsY1V1iXJFYktp/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480746186"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480746186"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748926503"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748926503"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/14] wifi: mac80211: mesh: check element parsing succeeded
Date: Mon, 11 Dec 2023 09:05:32 +0200
Message-Id: <20231211085121.93dea364f3d3.Ie87781c6c48979fb25a744b90af4a33dc2d83a28@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

ieee802_11_parse_elems() can return NULL, so we must
check for the return value.

Fixes: 5d24828d05f3 ("mac80211: always allocate struct ieee802_11_elems")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mesh_plink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index efffde7e5695..28bf794f67f8 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1247,6 +1247,8 @@ void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
 			return;
 	}
 	elems = ieee802_11_parse_elems(baseaddr, len - baselen, true, NULL);
-	mesh_process_plink_frame(sdata, mgmt, elems, rx_status);
-	kfree(elems);
+	if (elems) {
+		mesh_process_plink_frame(sdata, mgmt, elems, rx_status);
+		kfree(elems);
+	}
 }
-- 
2.34.1


