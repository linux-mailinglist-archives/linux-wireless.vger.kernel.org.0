Return-Path: <linux-wireless+bounces-24669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6198DAEDF73
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 15:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A916319D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F52147C9B;
	Mon, 30 Jun 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sc1nwKrU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C528AAE6
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291109; cv=none; b=ShmDiKuG8kdcCEAfV8PstPN22Ik9xPuO9mzmnzR91dcfxWGLSzWDv7qwW8md0IxlGVbqLCLfljxsGfx74p/zsfwEHJ24imvlrcYrXOvSaNGRcbZdB0/z7CQSmlTH7pW6UyFBJeVI4xCEqeMHSbJYBcwTwKJxh5F/1qSbVTalE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291109; c=relaxed/simple;
	bh=aNqJ3YyZkSlMOQoMr4mytXMfHcc2YcbcnDPrC0pDUQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhcW9R7lXT1nOwfxUZ18HdcxmGmYDd50VyOq0imqWNgs6E2BMi9lkItQfC1/OI4kT9wK9eLum4soRCxBGMwXfDhw8Mhf0i21xKEJYQpMHD/qKUCbhjG/JHMN4uOBt8IZ0BE/V40ue2fyNRGd7MKEFo8Y7LApuP5Hozwro8nkhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sc1nwKrU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=BM+5FT3DmDaSlscw6LXX4NYj97l2C5qBR756LQ/tmIs=; t=1751291107; x=1752500707; 
	b=sc1nwKrUDsEJE0QtJ7+o/b7lQ0y/wHE9wzFbyRPDbNbLt0QbDjSFwLIW2qsqr2kfDyHJfUxvJm1
	AG+Fz9yx8FtsVKcI25VRbY6w7MgyhiHrp1Dk+YitZyYOIWPhrLk/oNdFPGSUKbJRkeaLaDZNGyV4Q
	7YSuv2nHYBv06yZD3YOqLRgar926sS14FkBLjR9PTIKrhqegbG5k+wZB9uD0OkzArBenybcjRaqRk
	wlipA9Hl8CmdfjTjwioEI6SBJjISjDqFdn5JkzrQLhgK/7NlAtYGYeB2gNkwCW0QFplv5D7c7s+nG
	opyoIfN1R6tkaWVariHwr9ygTv8sbENu3yrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uWEoh-00000001O80-1xtJ;
	Mon, 30 Jun 2025 15:45:03 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Michael-CY Lee <michael-cy.lee@mediatek.com>
Subject: [PATCH wireless] wifi: mac80211: fix non-transmitted BSSID profile search
Date: Mon, 30 Jun 2025 15:45:01 +0200
Message-ID: <20250630154501.f26cd45a0ecd.I28e0525d06e8a99e555707301bca29265cf20dc8@changeid>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When the non-transmitted BSSID profile is found, immediately return
from the search to not return the wrong profile_len when the profile
is found in a multiple BSSID element that isn't the last one in the
frame.

Fixes: 5023b14cf4df ("mac80211: support profile split between elements")
Reported-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 96584b39215e..c5e0f7f46004 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -758,7 +758,6 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 {
 	const struct element *elem, *sub;
 	size_t profile_len = 0;
-	bool found = false;
 
 	if (!bss || !bss->transmitted_bss)
 		return profile_len;
@@ -809,15 +808,14 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 					       index[2],
 					       new_bssid);
 			if (ether_addr_equal(new_bssid, bss->bssid)) {
-				found = true;
 				elems->bssid_index_len = index[1];
 				elems->bssid_index = (void *)&index[2];
-				break;
+				return profile_len;
 			}
 		}
 	}
 
-	return found ? profile_len : 0;
+	return 0;
 }
 
 static void
-- 
2.50.0


