Return-Path: <linux-wireless+bounces-12649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8889712F8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415151C2217F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B041B29AA;
	Mon,  9 Sep 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YaGaPqhE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E122582;
	Mon,  9 Sep 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872925; cv=none; b=jB4rU8NlnG871GITTmtB6pnd1PtM+SfDxET0L6fuaLRekCHW7kIKYHJPA68idt/0/YzZ5pR76oDwP89UI1QBgz9+H12XoLxVMPCKvCCjCMftfhttOYeEKYjOpfSSSt0CZ92gSn1u4ubFU2HrUYOsJeqbuCHp5sSP+8AhuRg6L3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872925; c=relaxed/simple;
	bh=33hAWHkSpBt7ODHZtQgbCNFOdiQ+Yfj/4Z7436WAEiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YviiEJ2vnB204fN0EIwwy09xlo7U+lpKLvGidXe5pHlg0QQ9qGpNPD5vBt3HH7rON7/tK5Kfzb+BMs012zZeN0eOoNyjVXjf+tr/5Xo6rOx8DuJoB/OSTYjDphdSfuF5lQzKkW174KhuNwHX5mfzKeVTQjwPhFWoyKKT45uwLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YaGaPqhE; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3294:0:640:b20b:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 00A766092E;
	Mon,  9 Sep 2024 12:08:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id b8dULblOhSw0-RQ1Kd2M8;
	Mon, 09 Sep 2024 12:08:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725872918; bh=C5pECD2oCP4o024Adfiz7aio3NrLsxgmJpTXnnuNr5E=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=YaGaPqhEpKSi+tu8O8RMkSjVjqDv5D2GBVeTL+eSF93Qcd2NvHHwm5o/RQj8D1hwB
	 aX40eg+GCg6fjSPrQbyz6jKg/LqbWmTI0ijO2CFV5/74IYAYUMMUqVAlD8xUpgkAco
	 CZywU6/iEdKgN16YYexeqHO6+dvnC8PelBfgE19I=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors
Date: Mon,  9 Sep 2024 12:08:06 +0300
Message-ID: <20240909090806.1091956-1-dmantipov@yandex.ru>
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
v2: fix title prefix as noticed by Kalle
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


