Return-Path: <linux-wireless+bounces-3326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B27A84DC0D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 09:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857881C22828
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D386A8B0;
	Thu,  8 Feb 2024 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bayrepo.ru header.i=@bayrepo.ru header.b="fdIMWT2T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA46931C
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382324; cv=none; b=M9FJ+Pj5FLc2XH1xTjW6Bs/tbINpf17F/wPaAxjBEST3YKo5M577TtJ2T8NnGiuhWzJ5cSb5bYZ4D0rWa0KcWladZit7l+/8m7KZF6FEm4WdhRPwH3hLJUyykrTfmDWx0V9RIC870AtbC1E50JrSgLgoHeLd8isVtZ8FhJTlJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382324; c=relaxed/simple;
	bh=5hz4MSSmydqNYmWrxYCfPGy1EK1/KI70gO7b2v2//lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GChDWo4TqI3bqKzVsHg+1Z+/YPrCp3Erot7GRfe10ohFmvpXDUMtiqUKkntYadAkV8CnVYlntQwD7lnb5Ml2q1yMtjmuaziQN9z4dz1EhcHDbiYBYuYW+Na0l6XOV9jluHM+JWwP4VCEatt+Xo0WpkW1Oqtoaye41xi5HR2wL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayrepo.ru; spf=pass smtp.mailfrom=bayrepo.ru; dkim=pass (1024-bit key) header.d=bayrepo.ru header.i=@bayrepo.ru header.b=fdIMWT2T; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayrepo.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bayrepo.ru
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:a088:0:640:6c7c:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 910DC60B76;
	Thu,  8 Feb 2024 11:51:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id mpdAMe78USw0-1jMFk9pX;
	Thu, 08 Feb 2024 11:51:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bayrepo.ru; s=mail;
	t=1707382309; bh=AtE5ReX7bgr57wrB0vLUqyJNoZixAxr1MSludCs8wtA=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=fdIMWT2TzUq+sB1fKtiSh0jA76Aa5rtl+Tdxm0+kngZVvO/ZyQGEJH+QmXP+ov8eD
	 sy8am6K1yr69ZvnYhCdmJSZzHVgmbcoZZK0QkHrQXgv+4P5a1RkbL/dUZblFt4GEWm
	 FUKh88JXLZw535o6HwtJ5ddoeF7u0s5x/C7TyXDw=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@bayrepo.ru
From: Alexey Berezhok <a@bayrepo.ru>
To: Arend van Spriel <aspriel@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Berezhok <a@bayrepo.ru>
Subject: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value to boolean
Date: Thu,  8 Feb 2024 11:51:21 +0300
Message-Id: <20240208085121.2430-1-a@bayrepo.ru>
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
an explicit check instead. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Berezhok <a@bayrepo.ru>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 736b2ada6..63f6e9436 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5272,7 +5272,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 					      settings->hidden_ssid);
 		if (err) {
 			bphy_err(drvr, "%s closednet error (%d)\n",
-				 settings->hidden_ssid ?
+				 (settings->hidden_ssid != NL80211_HIDDEN_SSID_NOT_IN_USE) ?
 				 "enabled" : "disabled",
 				 err);
 			goto exit;
-- 
2.39.3


