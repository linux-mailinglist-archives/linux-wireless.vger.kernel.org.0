Return-Path: <linux-wireless+bounces-8335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AD98D58FD
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 05:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5BF1C217F0
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 03:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52538DEC;
	Fri, 31 May 2024 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="pL0Oefgz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E733993
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717125956; cv=none; b=F8bxP9XDTIkJTMFCJUyHdSyDg3BZI43G+P83+ZyZ3SignfF6+HKYlukvJVsvDUaZwon0dJKZJO99BfkccJj1DppGSkGMQvRbvIbjw5t9Le2TW6ITTJhY351x19JQ9+MEFIN5W//nDN1/8CGKT+OAsUvbn9OqUcQPOh7EeRyT2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717125956; c=relaxed/simple;
	bh=bQgNdifRlXG+6YvlhtUeAOK6Mywvi8QoaccOz2Xdopg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umNaMOfrqRevqajtIqbbxd8rIss+7wcwhFVQA29PpZLX6cjYzFSGuDtBJxaq63rwhoZgOvBRKOzKWpWM8DvFTzcEi2Kh9utMLvpGHMh/aVhgS4D422aNmpVT5F12EiNtTDdRNLnwaIE4DcQhkD23j1uESb9O2GIWyTpjoXWkG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=pL0Oefgz; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id CF57366377
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 06:22:08 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:980:0:640:9d32:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTPS id A47C160AA2;
	Fri, 31 May 2024 06:22:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vLJ0NiFOm8c0-8ZypTVeE;
	Fri, 31 May 2024 06:21:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1717125719; bh=gZAVuRodAHbWTiC8IuA+RQLzAXhqPeUU7RFRhElhywc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=pL0Oefgzyu002ZMTTqbLWX/ugntvWx09Oi0ADp1OXajbn/W6EjPmaS9DwCnY6VofO
	 r4kERjeIKMY8IihIIlsYuLT44SWULewoussIRzduvYaqkY1BX2DoINwIodFrcgvIJp
	 /WEAgsXMWcQ465qsFkOz2riupB1I4/0GZx5gYmuE=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+253cd2d2491df77c93ac@syzkaller.appspotmail.com
Subject: [PATCH] wifi: wireless: add extra SIOCSIWSCAN data check
Date: Fri, 31 May 2024 06:20:10 +0300
Message-ID: <20240531032010.451295-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'cfg80211_wext_siwscan()', add extra check whether number of
channels passed via 'ioctl(sock, SIOCSIWSCAN, ...)' doesn't exceed
IW_MAX_FREQUENCIES and reject invalid request with -EINVAL otherwise.

Reported-by: syzbot+253cd2d2491df77c93ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=253cd2d2491df77c93ac
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/scan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 127853877a0a..6d4d3447aecc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3400,10 +3400,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	wiphy = &rdev->wiphy;
 
 	/* Determine number of channels, needed to allocate creq */
-	if (wreq && wreq->num_channels)
+	if (wreq && wreq->num_channels) {
+		/* Passed from userspace so should be checked */
+		if (unlikely(wreq->num_channels > IW_MAX_FREQUENCIES))
+			return -EINVAL;
 		n_channels = wreq->num_channels;
-	else
+	} else {
 		n_channels = ieee80211_get_num_supported_channels(wiphy);
+	}
 
 	creq = kzalloc(sizeof(*creq) + sizeof(struct cfg80211_ssid) +
 		       n_channels * sizeof(void *),
-- 
2.45.1


