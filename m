Return-Path: <linux-wireless+bounces-20037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0787A57E5D
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACC23B0150
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785419597F;
	Sat,  8 Mar 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hgot/jdG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F5374FF
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468019; cv=none; b=QNgJ/ygDOexbTF8j43BVdsppAM5hJ7CFBhlaeJeNfqpWtA7krBrUyU+AZTBUodeeeu3acSrFHxkdHxsPcfmFkvyoA0ASIHyu5d4y63GCTGkD4mx8rz9L/9RkhvVdDkBFcxHYzn01qvvZeq+vnaVyMd9SyMTLnJUoVdSLhNXzbt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468019; c=relaxed/simple;
	bh=z9YiSsuR8tZfAE1pEAoxKoDCaDTLLV85kifjv5K9shM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKnFXzaZD5hzRy9nqRW07EUvgLEdNwLr5VzaZLqmQJOTHGGxMgpIZg7a/0ptSdxGB5YfVUsiEOXXq4Hc17be04wJnS8rzvH4+dZTVk1Te5J3cvvnB0sW1T3DZsCu3PlQXo1o8DMflFPI0XYpEMYdY9YIiuB8HMB27MSBuI0L7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hgot/jdG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468018; x=1773004018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z9YiSsuR8tZfAE1pEAoxKoDCaDTLLV85kifjv5K9shM=;
  b=Hgot/jdGAShcu1x9AWeta5VUpt5gf1/jMQlrcrG7uAD331944W9gPCzB
   FAMBSEr4BQMS6p5DYlPD+H+7u+79+ImWWQEmMrvlX0o6rAwU2ljPtRRTH
   anN0fcHpp1v0q0CdrlAeBKmoYv3LgADBsQNZT5nxKvr0RUqXkj1BeNtyP
   UIkJKWcTzf8pC+WA9FJcFJgEQCd6Ypot2coREGzT0MxZLHH5nxribHF1Q
   Vft4D7AMXdJyBvOGf/nnoHnlhTbmZtrNcy/dQLv5IEoYypbTN3Qd7OBLZ
   yBQMJ7HbJIt0X9sKLVPbVwQK5ZWngOl6jjUHFEyiZ/Z7+1mbG2qC+VbzV
   w==;
X-CSE-ConnectionGUID: 7d7bLkoYSQ6e/c0rw7chCg==
X-CSE-MsgGUID: lERw494SRwqSbwZv5xF5hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413087"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413087"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:06 -0800
X-CSE-ConnectionGUID: jalRpvthR1iiCg2YKFp/hw==
X-CSE-MsgGUID: WgzSLpHcRN+skm2W45s2xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644391"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 08/15] wifi: mac80211_hwsim: Fix MLD address translation
Date: Sat,  8 Mar 2025 23:03:34 +0200
Message-Id: <20250308225541.1aa461270bb6.Ic21592e1b1634653f02b80628cb2152f6e9de367@changeid>
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

Do address translations only between shared links. It is
possible that while an non-AP MLD station and an AP MLD
station have shared links, the frame is intended to be sent
on a link which is not shared (for example when sending a
probe response).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index d0d9dab7f11f..b426f3bfab28 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  */
 
 /*
@@ -1983,11 +1983,13 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 			return;
 		}
 
-		if (sta && sta->mlo) {
-			if (WARN_ON(!link_sta)) {
-				ieee80211_free_txskb(hw, skb);
-				return;
-			}
+		/* Do address translations only between shared links. It is
+		 * possible that while an non-AP MLD station and an AP MLD
+		 * station have shared links, the frame is intended to be sent
+		 * on a link which is not shared (for example when sending a
+		 * probe response).
+		 */
+		if (sta && sta->mlo && link_sta) {
 			/* address translation to link addresses on TX */
 			ether_addr_copy(hdr->addr1, link_sta->addr);
 			ether_addr_copy(hdr->addr2, bss_conf->addr);
-- 
2.34.1


