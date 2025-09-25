Return-Path: <linux-wireless+bounces-27650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D5BA011A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5543A8A90
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB82E0916;
	Thu, 25 Sep 2025 14:48:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364302DCF77
	for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811707; cv=none; b=l9duV11tz9+ha9GHouW4wzBRCCQijOfJrRgp2E4j8e3DVA4wc48dSpVYRq/XncRYeO1T1l18jKFyduB8TY5NVcPoPlqIR8lcSwwb7Q+C6KXxBkAko5p+/7Uug0Xj5OmvmrubryD62RO2PFC8HngMl3SVEmCkhx9kRA2athbOWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811707; c=relaxed/simple;
	bh=lWoZyBEzn9CXT05WWsMTzRx7t2dS8WBNztLjPkIsSvg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BhE1FMQL0ZnIuk87VWM7u40cNZbEVS+65x2rj02CH+TPH/g4Vv5mub0Ibpf1W2TPO/h/d/oX0ZdRDzPwRUn2/rEeR1dCqm8jAtAcvkrYmx7bmQnTIHCeV0z9GjZAO9/JoZhShnrWv5tgTTiGS8vhf8llY6MJ7HPUuSXmNrTF4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from evilbit ([88.171.60.104]) by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MaIvT-1unAHY24d3-00QFSL; Thu, 25
 Sep 2025 16:48:21 +0200
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mac80211: use jiffies_delta_to_msecs() for sta_info inactive times
Date: Thu, 25 Sep 2025 16:43:58 +0200
Message-ID: <20250925144629.26947-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cYDhZ9oWfGyK9P8VI5lPDtSlgSk8+51a+0RN0qiiLIWXj7Zke7R
 lZUivh3rzpvJP22Q53dg5sFw2afa+aT/C2HeQkcDcOYfH4F6CjdK+MPp5pi74qbvgsk1fGg
 XrPrTt9plkx1amdKklNDWyEG6SqjKIqBlf2kNHxN44360xozfTtnt/LcN2eY5eujwfeQRUQ
 6jngCXMtIBpwB4ZRbx/0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZnY02jXdvpc=;S6UY/tVNUEfH/4kD+fEid2IjmjC
 mzxsN7C2shnstaDpFwXRKZzB3/wlZ8/1sSzfRPCItdceozfC1tVbJVgoAPMO1CpxSJHYZLwFC
 wEbUqsxaY9FI+O/72LMajX5YVZsqReuf1MGJZWo7jMgRkI2NuyjFcOmGLlhhIohw8lCTzy+1D
 fXTaLX2ADNas+LAu96S5OQMxYW6D9KiugtLnzXt8Go69KbQrGk56deFkyWoUPtzJsIGvuh9Rn
 FtOtJhhtnEgg1AMEAmgnQQHo1+hWZey4Uv4SKbXUpzH/6esL+WYGS6mCyE4dibP1wdY/zNMYV
 rE35BFFsMWpyA3sIky2tyxkaCDYTss190BXJByMgO3DpJQbtsTCsM9BXYWib/YXHNO+OU/Qfy
 EmCGZTBlZNv3jcTj91/cwU7oUI8+btShSYFISIDRQCrMgboxt+IToqWsfD2Ipbgna4fpUi6Zu
 odClvi7lb3aHEHB+H8Fe8WKJ8VkTjF2A11BG384IjEQWVAgJ1i38ygnXlOPSHhDTFmURaaKDk
 ZClYr9Qx6kOsJheWxeaoJsoCHu7x5aYw7RlpZzUmFsZmid00fqRNwJ64X+IqkLg9rGmhKGSaf
 AvQ93VbZrqeTRjlEHaWMfqG51w5cJLGR8r87uok9e/5lNKDGYtHSQBnlcwZzPfcoGkJnSenlq
 Yc+cTnOUF5dH5knW8t9xp8EbJo6/t/zKe2+FV8+gSL5Mh4qakldRRs6y2C/paw6B2MYyBmOyb
 Z8KwnC8JXrUdNZKHl2GzJhmxhlaSzZFqv17zFrupRjYLavsACwdb7FuzFJEdPuXcPrKjMScw+
 x2JgpYb6Z+c+cztY8sfkADqd/o6dg+E9YWYpmsxiwH/s0dUkFM/D9Y9O1Wyg+EF5UrKxtykFK
 3w40JtxW1c72ZRMz5LA34H6w19Tow08i1RQCgFkSEgHzGs64P5tfvBJUobu2u29NLp0391GMW
 ctYj2MDukHa1PMotqgWdLIkyc2wdwp6FlrV0Vohb2ljcw1COoHkqgTG3qBMdLOJ7mflEevcmW
 mF278iglrxPWMr9zrWKKnHno5mQ2WpfMHV4LQ/FkTS2WdYOSQk11OFD5637ofseNgCBM7FWMA
 PGkT/9dA0yY/goFGcFzSywmIjTf83uQXgFuaHh3gLYcayYCuRuCGUmqs3vPl/Vz8FEdx/Oncw
 etFAu1FVwR3a2/6ALo8IVqUjAKvxwIgIseXK0efU0bCpQO2B59lw00B3R4/XWN2hJAGDaFWbR
 AEUhkhtfcHqMMgBf18z6SlzQC3ZdO0mT3xNO5uo3jrhSBGdof6qnIEmi6V/v+33jm7jfjA77a
 8FH2aAoL2Gf+OI4btgUBfuPozoHB2Y19FYlustLbZSGopcpCZph+6TV5x1JzMS0iO/k3klHKR
 232iMDmQyBbtCYXhhWZTJyhYwjBwo3pY8Ag/DedGItUM5uMFRBhlwoBE8c5TEKGQZX1Y6gtYW
 paML+9SoW31QVl5kHjRAkb/iTcxgCjNsuFFTKXjie4CIHc9u2UlwwV4TIdYMu/Duqi0VwTT7d
 3HUk4mLuv5fHg5HjgZf/KnS4klCVLKCk2v7pwZG5qK1t3C/yliwHv4iisR4wuTzvz5MAir4iW
 sjWIvotdDxiigOGTaVcsf6nF9iyt9eigKRALguFGZbmFBPQhM5WtO4n+VjZ4NhgLMPKbPIrV4
 h277ewx6zy5GwWrlCozZTuYBJIOcpik4tPOK9LqD5i2GzTWlF6RBVMtGeWDLcQsCM=

Inactive times of around 0xffffffff milliseconds have been observed on
an ath9k device on ARM.  This is likely due to an race in the
jiffies_to_msecs(jiffies - last_active()) calculation causing an
overflow when the observed jiffies is below ieee80211_sta_last_active().

Use jiffies_delta_to_msecs() instead to avoid this problem.

Fixes: 7bbdd2d98797 ("mac80211: implement station stats retrieval")

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
This code has been touched recently so backporting will be less easy.

 net/mac80211/sta_info.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8c550aab9bdc..c3db278f2911 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2760,7 +2760,8 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 	}
 
 	link_sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, link_id));
+		jiffies_delta_to_msecs(jiffies - ieee80211_sta_last_active(sta,
+									   link_id));
 
 	if (!(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 				    BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2993,7 +2994,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
 	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
+		jiffies_delta_to_msecs(jiffies - ieee80211_sta_last_active(sta,
+									   -1));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {

base-commit: cbf658dd09419f1ef9de11b9604e950bdd5c170b
-- 
2.51.0


