Return-Path: <linux-wireless+bounces-13227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A8987486
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3C62881BC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DE63A8F7;
	Thu, 26 Sep 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="UHN9UHy4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749062171;
	Thu, 26 Sep 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357909; cv=none; b=LLggsRNKiWP/1crGIBE2H5G4IfXp1K7+Yx+lNjZR8RVxwri5unRHus0+xURg4nYnEnPualohY1tc0zKxrfoG1DqpVkTIxVC//GUXNKFOdtvu6MUtIIehuQIcEj0Tjc8gTGQxkXnsZu2KoOfLfQcQX4XEs18jQKdLCyGIoVvk3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357909; c=relaxed/simple;
	bh=HM8hWjCaGTIhZ+L0lEK+WDF+Dg03Qo7kEWliuN+AiEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kssgP2hxkGMgSSH364qSJbjKrnQYLBHHfzFuPc/EVd0s+pI623TzzK80CqXFwzSbQjL/0t2CReUFRvqSA+I7rDEsFM1WAjLmMDw42fwPqmZG5Cn7ZTqLOLv9732PPYpkGM4vVVFATmIoTyG+HjCKjrXJpC6O6JnKCj2YjXxNKmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=UHN9UHy4; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1A8C840769D4;
	Thu, 26 Sep 2024 13:38:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1A8C840769D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727357905;
	bh=U3C6gL58GGhS+NoBws1dkbyUPAYlkDpUF6lUMqgKoC8=;
	h=From:To:Cc:Subject:Date:From;
	b=UHN9UHy4+CdcrAOYtcOpWdmVsyzKGVFU+Jnbd0fQK8Hdy1xJ9dlZFWJQxJfe+V46j
	 Wlu6q/ckIcKHCHwdzaBp8TbK6TrFEkywV8Nv361vXKDkWnw/kCwOTAvSnIgM0b1fIL
	 QEPyGb/JLXOMb3QG9UviBeZmmvhf+mDVTNZ2WnhM=
From: Vladislav Efanov <VEfanov@ispras.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Vladislav Efanov <VEfanov@ispras.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] cfg80211: Convert WARN_ON() to warning message
Date: Thu, 26 Sep 2024 16:34:38 +0300
Message-ID: <20240926133446.25445-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller got the following warning:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 9992 at net/wireless/ibss.c:36 __cfg80211_ibss

This warning is the result of the race condition between the following
events:

event1                          event2                      event3
__ieee80211_sta_join_ibss()        |                          |
creates new cgf80211_bss           |                          |
structure.                         |                          |
Calls cfg80211_ibss_joined()       |                          |
which will scheduled               |                          |
new event_work.                    |                          |
                         ieee80211_ibss_disconnect()          |
                         is called due to connection          |
                         dropped/ibss leaves to               |
                         remove cfg80211_bss structure.       |
                                                event_work starts.
                                          __cfg80211_ibss_joined()
                                          is called and WARNING is
                                          detected due to
                                          cfg80211_bss structure was
                                          removed by event2.

It is a normal situation when connection is dropped during handshaking.
So it looks reasonable to replace WARN_ON() with warning message to
prevent false alarm.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.
Fixes: 04a773ade068 ("cfg80211/nl80211: add IBSS API")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
---
 net/wireless/ibss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index e6fdb0b8187d..93c8bee12bdf 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -34,8 +34,10 @@ void __cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
 	bss = cfg80211_get_bss(wdev->wiphy, channel, bssid, NULL, 0,
 			       IEEE80211_BSS_TYPE_IBSS, IEEE80211_PRIVACY_ANY);
 
-	if (WARN_ON(!bss))
+	if (!bss) {
+		pr_warn("cfg80211: cfg80211_bss with bssid %s not found.\n", bssid);
 		return;
+	}
 
 	if (wdev->u.ibss.current_bss) {
 		cfg80211_unhold_bss(wdev->u.ibss.current_bss);
-- 
2.34.1


