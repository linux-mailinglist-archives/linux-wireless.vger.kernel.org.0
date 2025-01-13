Return-Path: <linux-wireless+bounces-17409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B134A0B383
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 10:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3D97A2FBB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAB21C07FE;
	Mon, 13 Jan 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="uom0rTP/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31131157469
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761601; cv=none; b=TUguNeski8XDIoSopchv3VhzBdglBLiTd4Pky3F8eIHr1m5Oybh98vnP1CwPXEUkTC3U86Wt7G1yhHqG7Yn1BrcHrtSHFMx2+inr4EIlxTnMvmDRKQazC4VBg+m4NFPu5QoIQDWezmJSi7oXx2eySMuVs8PxDF/vpAqp8FQs3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761601; c=relaxed/simple;
	bh=wwsU5LrOC3KHmaKGxtsUPmbIbM2R46HTWr01COJcS+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDlfnn68uQT4ZXwelkdZOl0sOVEuN3V9zVcfdpbDbquZC6T9iTqXnh488oSpTVfHNYUWHYSYSVOvxPj+Deo0L7DffXcXtEZyBEU5qSiQFxyLK1KSp7qbTEU89EklJng5vKm+BhdeXloyLuH3gXqVxfDJOQ2yN40Ey1EwwGRnBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=uom0rTP/; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id A3D6F667F6
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 12:40:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:2f03:0:640:5d54:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 6FF5E4733C;
	Mon, 13 Jan 2025 12:40:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GeK47iVOpGk0-wVqcztWz;
	Mon, 13 Jan 2025 12:40:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1736761217; bh=8I/3odp9BPLe4cYgyOHv45A+eP4Cp+AgmRmR5KOKFmE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=uom0rTP/O4r2d5B0tBN7ZjicF7C5rGWIBCpuEybOqm+Qg6Eu3tdN2Ej5p9qxieqOp
	 rWr9mIVfU/TAoIY72cCqKF1T3RAJ8eAuphtTwxaqCSQH/X9Llk7iv9xZwNdpbAuKmA
	 1zGnAXRE6n3pxAx87ycWw2YvlVgcgV3rJ8soMy1U=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Tova Mussai <tova.mussai@intel.com>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: cfg80211: adjust allocation of colocated AP data
Date: Mon, 13 Jan 2025 12:39:22 +0300
Message-ID: <20250113093922.149240-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'cfg80211_parse_colocated_ap_iter()' and 'cfg80211_scan_6ghz()', an
instances of 'struct cfg80211_colocated_ap' are allocated as if they
would have 'ssid' as trailing VLA member. Since this is not so, extra
IEEE80211_MAX_SSID_LEN bytes are not needed. Briefly tested with KUnit.

Fixes: c8cb5b854b40 ("nl80211/cfg80211: support 6 GHz scanning")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/scan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1c6fd45aa809..dd4fb53ea8c6 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -704,7 +704,7 @@ cfg80211_parse_colocated_ap_iter(void *_data, u8 type,
 					   bss_params)))
 		return RNR_ITER_CONTINUE;
 
-	entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN, GFP_ATOMIC);
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
 		return RNR_ITER_ERROR;
 
@@ -858,8 +858,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 			if (ret)
 				continue;
 
-			entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN,
-					GFP_ATOMIC);
+			entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 
 			if (!entry)
 				continue;
-- 
2.47.1


