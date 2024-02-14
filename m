Return-Path: <linux-wireless+bounces-3590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD0854CAC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 16:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20290B24802
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944A5A0FB;
	Wed, 14 Feb 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bayrepo.ru header.i=@bayrepo.ru header.b="gdWAULGP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D25C905
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924450; cv=none; b=N1m+U5hHCJTN3KF21TX7ABEYvMI0TrETmpdGxFk7Tkk3GzlZOmu/yDIMQ+mudWmq8HYdQ0yCr7JqupYF7s3uZGItAIH2EkJ9wbHbQnVptz/XFqUc6ha5EjLeHb2O9sSap/ACjqwtffs0fCbtJFtTRQj8SRrAs45TmIzEwgdIIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924450; c=relaxed/simple;
	bh=jaNf69VJ1xvMbnXNDlHg5IpZScoVZJV3mA5NmsLo8Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tYJsPIS1uDWsLPtKny01YbJoDe1BrbjILzdkq0ZWz+NoDa84acCOGVyRTHGyzBH9/EUZ/NpJIdXQVaH3tDVRlG/t4WB8+spnIG4zwSdExHmgAdjYPfDn5sVbouW8qlKkRB+ibcKpAwaTTdpwTSF+GsVOTsKIRwxsE3IgmIv269c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayrepo.ru; spf=pass smtp.mailfrom=bayrepo.ru; dkim=pass (1024-bit key) header.d=bayrepo.ru header.i=@bayrepo.ru header.b=gdWAULGP; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayrepo.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bayrepo.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id 99A726312B
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 18:21:27 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:47bd:0:640:2492:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 3461D608F4;
	Wed, 14 Feb 2024 18:21:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ILqFUkBkBCg0-Ot3ycx0W;
	Wed, 14 Feb 2024 18:21:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bayrepo.ru; s=mail;
	t=1707924079; bh=LwzN9+oiYr7+0J/NCO6NxY48BDUzAtBfj4NOxkTVMOY=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=gdWAULGPlZb83W3oNbnGQyjviAe3KTP5PRKfKrWYns6+5Y+04j/2L7s8Cm2TkM6A8
	 xVLwmFe6CGp3eEo78v3g7nmf1Nv8bHlBKPSPC231jFltPDkLsqk5KvKmosHXFP43P1
	 xC0cIZRg7CCYwgWVZAVjSqueu8Lktz9fonfLQf5M=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@bayrepo.ru
From: Alexey Berezhok <a@bayrepo.ru>
To: Arend van Spriel <aspriel@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Berezhok <a@bayrepo.ru>
Subject: [PATCH] wifi: brcmfmac: do not pass hidden SSID attribute as value directly
Date: Wed, 14 Feb 2024 18:21:17 +0300
Message-Id: <20240214152117.14467-1-a@bayrepo.ru>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'brcmf_cfg80211_start_ap()', not assume that
NL80211_HIDDEN_SSID_NOT_IN_USE is zero but prefer
an explicit check instead.  Use local
variable 'closednet' to pass in function call and
use for error message. Compile tested only.

Addition for the following patch

    commit f20073f50dfd1 ("wifi: brcmfmac: do not cast hidden SSID
                           attribute value to boolean")

Signed-off-by: Alexey Berezhok <a@bayrepo.ru>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 63f6e9436..cd6e01f23 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5269,7 +5269,8 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 		}
 
 		err = brcmf_fil_iovar_int_set(ifp, "closednet",
-					      settings->hidden_ssid);
+				(settings->hidden_ssid == NL80211_HIDDEN_SSID_NOT_IN_USE) ?
+				0 : 1);
 		if (err) {
 			bphy_err(drvr, "%s closednet error (%d)\n",
 				 (settings->hidden_ssid != NL80211_HIDDEN_SSID_NOT_IN_USE) ?
-- 
2.39.3


