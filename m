Return-Path: <linux-wireless+bounces-3916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D285F830
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 13:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23F41C24920
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D31651031;
	Thu, 22 Feb 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bayrepo.ru header.i=@bayrepo.ru header.b="ZLSO2lLT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5F42068
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604994; cv=none; b=tgqs6wOGKDbcyOA+fe8HJIQ7Qbx/cIFMPL/XDj3EO1+9Mf9nqQIbDeyQYxjsm1n8j3YIJYI68oBM3s22uOY3nIefw86LvuwfSXBfqlPZexA5qs9WToKeU/jCrZ7bf71+fSVYz4KiVuEEfFKomNz9n1UDyTuGjva78kekfq4oB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604994; c=relaxed/simple;
	bh=ecD3hpd6kIrRNIK2hyc/u/bdxFbMa6GsOzoblNXaCZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g7D/M9Ekh/vXHFXmnndf9EhpLz4sw4FuTcFpSJwm7QNGSfA8cDp6y01umBuzVDtrJG2BUJUbfZcqLk7LXadkvYMInr5VDbzK7sgvy5J3z/BKk7OPSCo3O9gLOJekBHxT8+zS30FZuyPLeHElh/pOAdNx322C198Iig5INI0QGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayrepo.ru; spf=pass smtp.mailfrom=bayrepo.ru; dkim=pass (1024-bit key) header.d=bayrepo.ru header.i=@bayrepo.ru header.b=ZLSO2lLT; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayrepo.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bayrepo.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward206c.mail.yandex.net (Yandex) with ESMTPS id 331446415D
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 15:29:41 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:edad:0:640:6050:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 6030160AFF;
	Thu, 22 Feb 2024 15:29:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UTS6qhJoJGk0-Njgd4O9w;
	Thu, 22 Feb 2024 15:29:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bayrepo.ru; s=mail;
	t=1708604971; bh=MU9AUYKwoXNW27veVet++KS/du7b61EZa8539EmNuow=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=ZLSO2lLTIWL/ZxME9o0m2QJ6aXuqKjKCxdpsAWyL59phr1lZDmG+SAHgSsSiJPXK+
	 4C3WyMVgjBra89fP3YnoveJ+lUE7jUPHJFd3Uf8Wi/VWX43zQicZ6Xjdu8OCWOjlKx
	 U2+zno5op3GDAxCknRQAMARTe/sWmsNXmRhIFbNo=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@bayrepo.ru
From: Alexey Berezhok <a@bayrepo.ru>
To: Arend van Spriel <aspriel@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Berezhok <a@bayrepo.ru>
Subject: [PATCH v2] wifi: brcmfmac: do not pass hidden SSID attribute as value directly
Date: Thu, 22 Feb 2024 15:29:23 +0300
Message-Id: <20240222122923.46691-1-a@bayrepo.ru>
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
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 63f6e9436..c89307c29 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5099,6 +5099,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 	bool mbss;
 	int is_11d;
 	bool supports_11d;
+	bool closednet;
 
 	brcmf_dbg(TRACE, "ctrlchn=%d, center=%d, bw=%d, beacon_interval=%d, dtim_period=%d,\n",
 		  settings->chandef.chan->hw_value,
@@ -5268,12 +5269,12 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 			goto exit;
 		}
 
-		err = brcmf_fil_iovar_int_set(ifp, "closednet",
-					      settings->hidden_ssid);
+		closednet =
+			(settings->hidden_ssid != NL80211_HIDDEN_SSID_NOT_IN_USE);
+		err = brcmf_fil_iovar_int_set(ifp, "closednet",	closednet);
 		if (err) {
 			bphy_err(drvr, "%s closednet error (%d)\n",
-				 (settings->hidden_ssid != NL80211_HIDDEN_SSID_NOT_IN_USE) ?
-				 "enabled" : "disabled",
+				 (closednet ? "enabled" : "disabled"),
 				 err);
 			goto exit;
 		}
-- 
2.39.3


