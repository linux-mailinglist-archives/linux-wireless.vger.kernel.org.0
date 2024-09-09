Return-Path: <linux-wireless+bounces-12644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C219711D8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E47B2284D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 08:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC21AF4EB;
	Mon,  9 Sep 2024 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RMoTpGVQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0B1B1502;
	Mon,  9 Sep 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870323; cv=none; b=cmkBlUxGJG8SpKur8OY7JYFjfNB1nAhgsGeZeu0BANgcj8uFQx5iKsa9ZSoQWE1xNaKPhSt2gSSO/W/qn5jPUb4g6y4wbtPLOaVMGZtzEtYhR9AlpvgQFNVfoHsyKhikX5yYnC8n30+ibR7w4t7HuHvq0gg1bYEpGMsY3x0vRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870323; c=relaxed/simple;
	bh=bm1LV9qtp3nNMqBUb5X5BLerwxqFNzr+qcd8+fYzMAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgcspaneDig2s8ASULI8zLKCjptMeJPi6IYBW8hXIApfzdLySgKXsMbVL2FCKDaERdGR5Nw51D7W5dE4K8l7PaX6Qh6w2VFVv7tgiVukc7Gn08LrpqpZd9Hdy3LNwhYFAomRrmdmPxD4sTdPLcWZLQ0CDEs3OI0tw4HChWJUF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RMoTpGVQ; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:9a26:0:640:21cf:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 5FB8960952;
	Mon,  9 Sep 2024 11:25:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id APciWrbOeSw0-j93roYy6;
	Mon, 09 Sep 2024 11:25:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725870310; bh=x/7HsQnXUHIdB1XBeM+5CtEP7DgTHgT0oB6Ls1mjLgQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=RMoTpGVQCqRDUhenZySkkLkW1FRL47CjTKBuxHOi3+Xz8DRaGJ+NEchxMfgg0HPpq
	 4YjE9pqfWYRtXOsgjshQ4xNAZTeGP56kPlG+BYKu0JN1K/mZQgw8NawpgDpVbBf3YN
	 oQYiRbS6t3zcTPlUJYXeQTKAxBr4fE0iMJabtz40=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: wireless: fix two more possible UBSAN-detected off-by-one errors
Date: Mon,  9 Sep 2024 11:23:48 +0300
Message-ID: <20240909082348.1080511-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although not reproduced in practice, these two cases may be
considered by UBSAN as off-by-one errors. So fix them in the
same way as in commit a26a5107bc52 ("wifi: cfg80211: fix UBSAN
noise in cfg80211_wext_siwscan()").

Fixes: 807f8a8c3004 ("cfg80211/nl80211: add support for scheduled scans")
Fixes: 5ba63533bbf6 ("cfg80211: fix alignment problem in scan request")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/nl80211.c | 3 ++-
 net/wireless/sme.c     | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8bad3c6db39d..9ab777e0bd4d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9778,7 +9778,8 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 		return ERR_PTR(-ENOMEM);
 
 	if (n_ssids)
-		request->ssids = (void *)&request->channels[n_channels];
+		request->ssids = (void *)request +
+			struct_size(request, channels, n_channels);
 	request->n_ssids = n_ssids;
 	if (ie_len) {
 		if (n_ssids)
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index d9d7bf8bb5c1..431da30817a6 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -115,7 +115,8 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 		n_channels = i;
 	}
 	request->n_channels = n_channels;
-	request->ssids = (void *)&request->channels[n_channels];
+	request->ssids = (void *)request +
+		struct_size(request, channels, n_channels);
 	request->n_ssids = 1;
 
 	memcpy(request->ssids[0].ssid, wdev->conn->params.ssid,
-- 
2.46.0


