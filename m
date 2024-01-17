Return-Path: <linux-wireless+bounces-2092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2BF83064C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 13:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6542C287D60
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207991EB21;
	Wed, 17 Jan 2024 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ssnnSHEU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996D1EA90
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496243; cv=none; b=cooD4xDEQMPNM63XgQT19Vn2FNGMrdenVR3usaCU1yyeLLBx7dWdeWtx7cVZziuG3DLWS+dTpqzMg+a62J1UlCd329H5BY6s6ufFcvjR1ZnzmblrhxmuGH9eg0DC4ECy21hS1hXRqbZHxvcznLHkjH4Jrlywbc42f7ChM6GxBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496243; c=relaxed/simple;
	bh=kRsOVEk/na4GTYpowvSE8NFt65BSN1CLBqTrBXE/TQc=;
	h=Received:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=Wmcs01FxMLswqM+E46H9H8b6d1Nf+68SWKKn2XvJUeovnyqphNKOqaSn2PISlz3eVQZ2heaEQJcADULPFggmZVgKb+LjaR5X8Pkc5a3Se3KX9MRiL/Ce1RjoPVIEpqyBoF/zLpYRv6leQ7XoEAh4yzDXmYG5f0VhhNOKr6TNxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ssnnSHEU; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id A4ED9668DB
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 15:49:40 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2912:0:640:56:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTP id D976D608FA;
	Wed, 17 Jan 2024 15:49:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Unoc1NPo7a60-NB9hxfmR;
	Wed, 17 Jan 2024 15:49:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1705495772; bh=3TJS8oZ10ASA/NByjrFNlqRAghSKsUN2MktGWgQMxMM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ssnnSHEUvrwvoH7Xswq9KoIlsPy9rX1RCpRQWULu+XoDdNXPZhak8wUZ6IWlhG6dH
	 ADXlmXZ1KCj9fhUuuIekUcyXJEBB9eyHERlIdTLdb57ZRnyVQUZZuHKO/31nDn28L6
	 edt659JxD1DS0R3DselRGf/unNkvK4O1u7wylXFo=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Felix Fietkau <nbd@nbd.name>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: don't ask rate control with zero rate mask if scanning
Date: Wed, 17 Jan 2024 15:48:45 +0300
Message-ID: <20240117124848.120438-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're scanning and got the control frame with zero rate mask, drop
the frame before '__rate_control_send_low()' getting stuck attempting
to select supported rate.

Reported-by: syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac80211/tx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 314998fdb1a5..53a473a2f8dd 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -701,7 +701,12 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	txrc.bss_conf = &tx->sdata->vif.bss_conf;
 	txrc.skb = tx->skb;
 	txrc.reported_rate.idx = -1;
-	txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
+
+	if (tx->sdata->rc_rateidx_mask[info->band])
+		txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
+	else if (test_bit(SCAN_SW_SCANNING, &tx->local->scanning))
+		/* we're scanning but have no usable rates */
+		return TX_DROP;
 
 	if (tx->sdata->rc_has_mcs_mask[info->band])
 		txrc.rate_idx_mcs_mask =
-- 
2.43.0


