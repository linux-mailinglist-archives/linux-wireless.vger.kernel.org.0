Return-Path: <linux-wireless+bounces-26363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A28B24B4B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 15:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D216178B83
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA42EAB8A;
	Wed, 13 Aug 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YXEmoMAC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202A2EA491
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093180; cv=none; b=X+ThETBxSHFvklL3eag/HfFa+wEx6B5Q9CjRuuyMba4SFe4t8t/m77zej5lvc7XdTtookqCBTMIAP4sKqb5Bca+1JsSKZSamukMw39X2OdzupfbEAJPf6W20HPhVQWHcJLSO4UyMx1JMcgRtJ3GIUDRQWyXop6onnY4oJmpApNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093180; c=relaxed/simple;
	bh=okGcF5Jic6BdI3ahXj66my1733y/uXDcLf/Jh3IeJuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9vA1x4MaeoFN4qhhNWOLFLmxQs+gziqECFGrDRsOz+kUMYApZabgb7pcwas0gQ4vnsn56ilwxepTK3aoxMCJM8B6uZySLw8Yn754WxYw0O5sjS6in8wAmfcl/x3xJWRWJFVKfQPcWNMge/VtMOtkTaEobmPaeC/vd934f8peLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YXEmoMAC; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4880:0:640:22e4:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 50AA3C0081;
	Wed, 13 Aug 2025 16:52:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pqLWRk0MxmI0-g1hduy1f;
	Wed, 13 Aug 2025 16:52:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1755093172; bh=Tguy+85sR/wbBHQZcS7jQozj/S+oBlBU+wXUq/cTLCo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=YXEmoMACLuV0BT+0BT3cN0ndJDUjSxMNKaJNvRCs8IkgqmVcoGmRLIPMYcHaTzRoO
	 AHYDd9h86wE9L6LV8fN7BpkVReZU3tNY02vnyRpaOqoH1kJXbpYxk9/MV9Lxqibp5n
	 sEmKlAjVxLteIe5JUQM6XrIfpElD0CatLqFrzvV4=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com
Subject: [PATCH] cfg80211: fix use-after-free in cmp_bss()
Date: Wed, 13 Aug 2025 16:52:36 +0300
Message-ID: <20250813135236.799384-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following bss_free() qurik introduced in commit 776b3580178f
("cfg80211: track hidden SSID networks properly"), adjust
cfg80211_update_known_bss() to free the last beacon frame
elements only if they're not shared via the corresponding
'hidden_beacon_bss' pointer.

Reported-by: syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=30754ca335e6fb7e3092
Fixes: 3ab8227d3e7d ("cfg80211: refactor cfg80211_bss_update")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a8339ed52404..6c7b7c3828a4 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1916,7 +1916,8 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			 */
 
 			f = rcu_access_pointer(new->pub.beacon_ies);
-			kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
+			if (!new->pub.hidden_beacon_bss)
+				kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
 			return false;
 		}
 
-- 
2.50.1


