Return-Path: <linux-wireless+bounces-15942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032D89E60E8
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 23:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A412918856DD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 22:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E61CC89D;
	Thu,  5 Dec 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="JOUjuaPz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB01E522
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439317; cv=none; b=AcE9U1eBWSfI+h4cVKAhMf6PZIebkLTgcco4ptiS+WMv1l7RmS/Sy9LmqruzITmlGAgyJTVibceMiItDzc6zeXnPTMavkD5lFWO8ZHlrI3/QxSCiN3RAIDvC/+aGarMt1hHVkbzmZQZzJshia+9LOUGvQ0Y5WVBaosnPrSte6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439317; c=relaxed/simple;
	bh=CotHnS6zLBkfpWcW0p1tP1nZCyHzP30Nr9NELO+Opy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxyyqUYxCzzkBsU9riekfeaF7K0U3aoDQ48wFMho4O/B6c3QFlgmO5gW13wuuFVIukB8NAwQ1GQfJK1HyUQyVTEPDSAUZ33wYyNSdbzMwXzrnNrZRzeG1TEGoN56x14DNSqlX3AjmMK3PHvjNm6ubbS6w9M7U959VWw77JjjjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=JOUjuaPz; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6DC8F940078;
	Thu,  5 Dec 2024 22:55:12 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id A2A2113C2B0;
	Thu,  5 Dec 2024 14:55:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A2A2113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733439311;
	bh=CotHnS6zLBkfpWcW0p1tP1nZCyHzP30Nr9NELO+Opy0=;
	h=From:To:Cc:Subject:Date:From;
	b=JOUjuaPzz/xikmoAtEHUpTh7divs4Py6yxUdJbjdLxkjZ/YCbrblr2syeFBxcjIvk
	 PRXfXcRieqQquirUyNy4WYgqiRr9/ciWo+IN3Wy7gO8Egl4AXBAPsgNDAYurOTdnEz
	 bfsDNXeh7GaHubK9EZnn7KB3qxDoqYafgBrKAGRI=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	Ben Greear <greearb@candelatech.com>
Subject: [PATCH] net: wireless:  Remove adhoc and beacon_int_min_gcd check.
Date: Thu,  5 Dec 2024 14:55:02 -0800
Message-ID: <20241205225502.878928-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1733439313-hvfO5ISFIykP
X-MDID-O:
 us5;at1;1733439313;hvfO5ISFIykP;<greearb@candelatech.com>;340f598122f25443170ac9d27e6a82df
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

This check keeps mtk7996 from loading.  If someone thinks
they can get ADHOC to work, let them try it.  If the
kernel really needs to restrict some combination, then
it should be done at time user attempts to actually
use that combination, not at driver load.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/wireless/core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 74ca18833df1..9c8827266700 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -658,21 +658,6 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
-			/*
-			 * This isn't well-defined right now. If you have an
-			 * IBSS interface, then its beacon interval may change
-			 * by joining other networks, and nothing prevents it
-			 * from doing that.
-			 * So technically we probably shouldn't even allow AP
-			 * and IBSS in the same interface, but it seems that
-			 * some drivers support that, possibly only with fixed
-			 * beacon intervals for IBSS.
-			 */
-			if (WARN_ON(types & BIT(NL80211_IFTYPE_ADHOC) &&
-				    c->beacon_int_min_gcd)) {
-				return -EINVAL;
-			}
-
 			cnt += c->limits[j].max;
 			/*
 			 * Don't advertise an unsupported type
-- 
2.42.0


