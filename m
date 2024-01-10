Return-Path: <linux-wireless+bounces-1648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62982936B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 06:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505A4B211CB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 05:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62736090;
	Wed, 10 Jan 2024 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="uk8G2q14"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B2936099
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5b96:0:640:feca:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTP id 4B79E60B1F;
	Wed, 10 Jan 2024 08:44:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8ia9uIFsGW20-zFHexS0f;
	Wed, 10 Jan 2024 08:44:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1704865448; bh=fhRQ2mTKBYVbCrCAge5uON2Bvhk6ZFVEJM2grYGKnyQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=uk8G2q14NpSEql/bSmd52oFS4jFl+Z7b+scmGvbHBNtcrsXvE+Bs0c9qu0OsBgI2i
	 x9lNK2dcDIvmdgsPi0AN+ahPXY3bEjgBxzBT0DnHE8bLTr9dramPODsWp27eie9gIb
	 1dZ956vEOp7z34BLFmuSG4KnccN9sm/5tG1fCCas=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: wireless: avoid strlen() in cfg80211_michael_mic_failure()
Date: Wed, 10 Jan 2024 08:42:06 +0300
Message-ID: <20240110054246.371651-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'cfg80211_michael_mic_failure()', avoid extra call to 'strlen()'
by using the value returned by 'sprintf()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/mlme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index f635a8b6ca2e..43ba7891e2a3 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -241,12 +241,12 @@ void cfg80211_michael_mic_failure(struct net_device *dev, const u8 *addr,
 	char *buf = kmalloc(128, gfp);
 
 	if (buf) {
-		sprintf(buf, "MLME-MICHAELMICFAILURE.indication("
-			"keyid=%d %scast addr=%pM)", key_id,
-			key_type == NL80211_KEYTYPE_GROUP ? "broad" : "uni",
-			addr);
 		memset(&wrqu, 0, sizeof(wrqu));
-		wrqu.data.length = strlen(buf);
+		wrqu.data.length =
+			sprintf(buf, "MLME-MICHAELMICFAILURE."
+				"indication(keyid=%d %scast addr=%pM)",
+				key_id, key_type == NL80211_KEYTYPE_GROUP
+				? "broad" : "uni", addr);
 		wireless_send_event(dev, IWEVCUSTOM, &wrqu, buf);
 		kfree(buf);
 	}
-- 
2.43.0


