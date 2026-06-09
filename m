Return-Path: <linux-wireless+bounces-37603-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dGuQDeRZKGpjCgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37603-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 20:22:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13A66346A
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 20:22:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=astralinux.ru header.s=mail header.b=fJ+ZMNPf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37603-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37603-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=astralinux.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00BF30A91D8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E643348A2DE;
	Tue,  9 Jun 2026 18:11:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9ED47B437;
	Tue,  9 Jun 2026 18:11:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028700; cv=none; b=Zt0LPU8Aculy2KTFEJ0QsDwCFI+BRpQdmGej0pPbv8MH9pFlFL/VUnPKm7KvSdYJxJyuVwgVZwUny9Ydgo7tpeRtfY1D2XNWFX9/8JrVpJ9F7sk/9kg/7r77ndywittpp8FZse/T2PTfsULwB50Yw2j2yAsys9+a6XIU4PhvHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028700; c=relaxed/simple;
	bh=K/XNtJsvYMKaQT2ZuXL8vJBcKhMPjxZ5O9Wsd9CHl1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XQwquC/9yKj+E91aM9hb+dpbIUP9ApgBDju2tFuA/4iuQFtT0OfwVDep3j6d9klW35vnel9AZsvsmNlWVTmfZE83Gc0mLZhtEybBN/4WqV0s/5qJI3R97NdAnoy0ytt5Fc8Xborv7YIza5vxuH3vWccohsaP4aylKWd/DtWSROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=fJ+ZMNPf; arc=none smtp.client-ip=93.188.205.243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1781028692;
	bh=K/XNtJsvYMKaQT2ZuXL8vJBcKhMPjxZ5O9Wsd9CHl1c=;
	h=From:To:Cc:Subject:Date:From;
	b=fJ+ZMNPfYauGpUyv8mSYBA6AM0cC0l0LJpymMgMQBPHEah51uepOn1SX+HTZy/WxL
	 aAygJTRKS1ThlEh5yifIEafveDBpc/1qA8LZLyYucDJYQYFNMTlG7MFX4j5sSJK+C8
	 qeGfwU9IOb+Hwq78zZ/afUOx7yfuZKHvCaFpF7P3fW6geWZh/JPhhiwTRspiEzqSUv
	 kq/APsgz/vBZNlpAnNTn6YATdn/v2feHesh7PXNf2xrTDJyGdq8pEgj+9wzHv5uBXk
	 G9dMIXtyC5rjZB0kDC2FvfVBmrJOUDpEP9RRrzbaugKszWqA4LQwjN5JngxGI+Uo9M
	 HNk/hVOiH4siw==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id CC28D1F402;
	Tue,  9 Jun 2026 21:11:32 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 21:11:31 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.198.18.49])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gZcRk5vg1zZd5h;
	Tue, 09 Jun 2026 21:11:30 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.10] wifi: mac80211: check tdls flag in ieee80211_tdls_oper
Date: Tue,  9 Jun 2026 21:11:08 +0300
Message-Id: <20260609181108.29138-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/06/09 17:43:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 107 0.3.107 575e75fe8e3b9d45c142d144823c5de38605099e, {date_rfc_vio_soft_silent}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1;syzkaller.appspot.com:7.1.1,5.0.1;patch.msgid.link:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203763 [Jun 09 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/09 15:23:00 #28224840
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/06/09 17:43:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[astralinux.ru,quarantine];
	R_DKIM_ALLOW(-0.20)[astralinux.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[astralinux.ru,sipsolutions.net,davemloft.net,kernel.org,vger.kernel.org,linuxtesting.org,syzkaller.appspotmail.com,gmail.com,intel.com];
	TAGGED_FROM(0.00)[bounces-37603-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:apanov@astralinux.ru,m:johannes@sipsolutions.net,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com,m:kartikey406@gmail.com,m:johannes.berg@intel.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[apanov@astralinux.ru,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[apanov@astralinux.ru,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[astralinux.ru:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,56b6a844a4ea74487b7b];
	DBL_BLOCKED_OPENRESOLVER(0.00)[astralinux.ru:dkim,astralinux.ru:email,astralinux.ru:mid,astralinux.ru:from_mime,vger.kernel.org:from_smtp,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:email,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C13A66346A

From: Deepanshu Kartikey <kartikey406@gmail.com>

commit 7d73872d949c488a1d7c308031d6a9d89b5e0a8b upstream.

When NL80211_TDLS_ENABLE_LINK is called, the code only checks if the
station exists but not whether it is actually a TDLS station. This
allows the operation to proceed for non-TDLS stations, causing
unintended side effects like modifying channel context and HT
protection before failing.

Add a check for sta->sta.tdls early in the ENABLE_LINK case, before
any side effects occur, to ensure the operation is only allowed for
actual TDLS peers.

Reported-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=56b6a844a4ea74487b7b
Tested-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Link: https://patch.msgid.link/20260313092417.520807-1-kartikey406@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ Alexey: Adapted to the older sta_mtx locking and error-handling flow. ]
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
Backport fix for CVE-2026-43052
 net/mac80211/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index e01e4daeb8cd..66e32f1d0a98 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1380,7 +1380,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 
 		mutex_lock(&local->sta_mtx);
 		sta = sta_info_get(sdata, peer);
-		if (!sta) {
+		if (!sta || !sta->sta.tdls) {
 			mutex_unlock(&local->sta_mtx);
 			ret = -ENOLINK;
 			break;
-- 
2.47.3

