Return-Path: <linux-wireless+bounces-29501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD1CA3C35
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 14:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C19D30A4148
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4BC33F377;
	Thu,  4 Dec 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="osRZCTiB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6242E542B
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853923; cv=none; b=uITEXLWqXm0OyudMXLm0aOmIv7ObLkUls+PbQvveKcgAAaIJdEG9mgVHX3UnwFKcn5CwuI7v1WAzER2rwSaJDS5lK0LnbFq0B0lIBWZmcVHgQKXCziaUS7RK6MAaF2tDwSphqhj1B4tGB4zR6mWzD4D4rfkaj8rL+J/5Ibst3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853923; c=relaxed/simple;
	bh=t4sDRps2mRk/8AWhTzhu7Zd4vqIlvDcI8URd32MegYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKNw+Z/8J9tiriHZkcmA+2Yn4hsu//SCMd3X406YH1U8SDVR6ucdq064rvdQFWGBEOndBXahwWTVF/aLoWXt7uuHxRghjRQgPQZNyLUeJByRudivTqvzfLtLiHQg6BmFM9TlsXbTOJi4dsBQ3msyfJ0sro+g776+DTO/MeoxQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=osRZCTiB; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 8D9FC850EC
	for <linux-wireless@vger.kernel.org>; Thu, 04 Dec 2025 16:05:52 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:25b4:0:640:a124:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 708EBC007D;
	Thu, 04 Dec 2025 16:05:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id e5lkQF1LPeA0-Skc1MIkO;
	Thu, 04 Dec 2025 16:05:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1764853541; bh=a/JgdUIeVKPqISXaeh0J5OEGTJt2aT3lLE49JBQ6LFk=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=osRZCTiBZkE9J5Py95cjZLyghusdbUDi0seDwcRAKDeprXsrPtucZvjZibLDz8dsq
	 1A2l5XD04D6WVcmoTS+IvvFefhtOSiualXjMRV3ZgrhKULwD3n5TopmOk0R9LE06H1
	 E45erNu0SZcmSP+qz9JahYvY2ofX/E/WDs9IL4mE=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Berg <benjamin.berg@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+bc1aabf52d0a31e91f96@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: fix list iteration in ieee80211_add_virtual_monitor()
Date: Thu,  4 Dec 2025 16:05:33 +0300
Message-ID: <20251204130533.340069-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'mon_list' of 'struct ieee80211_local' is RCU-protected and
an instances of 'struct ieee80211_sub_if_data' are linked there
via 'u.mntr.list' member, adjust the corresponding list iteration
in 'ieee80211_add_virtual_monitor()' accordingly.

Reported-by: syzbot+bc1aabf52d0a31e91f96@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc1aabf52d0a31e91f96
Fixes: a5aa46f1ac4f ("wifi: mac80211: track MU-MIMO configuration on disabled interfaces")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac80211/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4f04d95c19d4..7b0aa24c1f97 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1251,7 +1251,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
 	if (!creator_sdata) {
 		struct ieee80211_sub_if_data *other;
 
-		list_for_each_entry(other, &local->mon_list, list) {
+		list_for_each_entry_rcu(other, &local->mon_list, u.mntr.list) {
 			if (!other->vif.bss_conf.mu_mimo_owner)
 				continue;
 
-- 
2.52.0


