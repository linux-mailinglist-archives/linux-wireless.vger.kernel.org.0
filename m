Return-Path: <linux-wireless+bounces-11325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904794F905
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 23:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2932A1C21BA2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894F186E3C;
	Mon, 12 Aug 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="bX0M1/pn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503314EC59
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498695; cv=none; b=n/JTeDy9ZY00/or/inGSfYotPT8s4oA1ztvtaNyoX6OPAGzh6VuW5c9BCQwA8S1BIfEyvjs7xQwaQhr6hJ8TIgE+2yvXFnvKGZzU2G3aJb5qP+gPR7weKq88satIURbllorKEkNiW6gsR5+z821N2rA88xHKLSefyuA3n8Prxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498695; c=relaxed/simple;
	bh=sE61+FRvo/SBq+CA1e2vQ4FVnre9f+dEhEnCzKDXTbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QjAFtortpfvDU/cR3+I1j7OPUQzyHJyB1dnAEUcgBzJPkHagTEKov+XQ/bNtJ34qooFslG0AgPAdjjCEDc2+nXSTb5vtP0LuvSBAaS4PxxTXjrYqpU5+QH8MIHZP1XeNuvY5kY+4KUERBpmM4+LXpm/oqPPZLlAchTkUCuuML1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=bX0M1/pn; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A52B5C00074;
	Mon, 12 Aug 2024 21:38:10 +0000 (UTC)
Received: from carkeek.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 07B1C13C2B0;
	Mon, 12 Aug 2024 14:38:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 07B1C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1723498690;
	bh=sE61+FRvo/SBq+CA1e2vQ4FVnre9f+dEhEnCzKDXTbM=;
	h=From:To:Cc:Subject:Date:From;
	b=bX0M1/pnZdmmJNpwVWxzFcJlDFRqi61kozw4WzH73c5dyhQBwI1R2fuP1TPkzeqWN
	 cH4OMF5bXyxj2hMbaGQJz3aIbIK0CyTYv501sn6XW9TXf8GhFAyCpsIfM8uZaaFHAJ
	 ifURyT2juhs5KUe2MpdFwQjIqw/9ysOLqLiM0WWw=
From: Rory Little <rory@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH 1/1] wifi: mac80211: Fix 320 MHz max TPE field parsing.
Date: Mon, 12 Aug 2024 14:37:29 -0700
Message-Id: <20240812213728.1799255-1-rory@candelatech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1723498691-6oqk3ARtxY1h
X-MDID-O:
 us5;at1;1723498691;6oqk3ARtxY1h;<rory@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

Transmit Power Count will be one less than the number of HE fields, so
if we do find an extension field, its index will be this number, plus
one, rather than two.

This fixes an issue noted in the iwlmvm driver, where clients
associated at 320 MHz had degraded performance.

Fixes: 584b4bfff5ce ("wifi: mac80211: pass parsed TPE data to drivers")
Signed-off-by: Rory Little <rory@candelatech.com>
---

We noticed and recently reported a 20-30% drop in transmit throughput on BE200
radios, and have identified the issue as being that the TPE sent to the
firmware did not match the TPE reported by the AP. The fault appears to be an
off-by-one error in IE parsing logic. This patch fixes that error.

 net/mac80211/parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 28aae14db8a9..36a844e536e6 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -235,8 +235,8 @@ static void ieee80211_parse_tpe(struct ieee80211_parsed_tpe *tpe,
 		*cnt_out = count + 1;
 		/* separately take 320 MHz if present */
 		if (count == 3 && len > sizeof(*env) + count + 1) {
-			out[4] = env->variable[count + 2];
-			*cnt_out = 5;
+			out[4] = env->variable[count + 1];
+			*cnt_out = count + 2;
 		}
 		break;
 	case IEEE80211_TPE_LOCAL_EIRP_PSD:
-- 
2.34.1


