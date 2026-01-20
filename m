Return-Path: <linux-wireless+bounces-31026-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EYQBmzub2m+UQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31026-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:06:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F94BF56
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B2CB4EE577
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09B3A89BA;
	Tue, 20 Jan 2026 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTGrqMCy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2138F23C
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939853; cv=none; b=gZVOSQI3GJcpMyL+6R4K9/CyAPt8f8ULjDOCbZX9QUC4WNYPm5qwaAm7xIb+udlXZOCmARoQRPiaY75mz6NhenqDZmyKZkq/e4RUrgn2nfIhgYXd59jwgS1tm/OKHvUrFX4HSHejn74wZnIgIz1PjFsHxLjsM6/XHSux3M28PW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939853; c=relaxed/simple;
	bh=mXrVqUsFr+KWKIhla8VgweQxi5AiinnrHhpbrpqMzfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFXUgNuiSic1BvGPZ18Ds0prINRLnjVWkqp1XHtp4pEI2MStrYwZAdB5KbFSUHMs1/i1/jMmz2jHKsCDwXTWucUBv6mk/JL6g5uU2rbJoRxFyIjqpjqywlmb5tii06KKCqiF9Ii28OEqywn+zQwpeqKvCi+Bu2mL5E9rhy7JWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTGrqMCy; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12336f33098so4746358c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939849; x=1769544649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4eJ97Uk/V3oa3o11cK676DDz0RecUq4tSnmFW3bFfU=;
        b=LTGrqMCyeucEKAV5iwR5LWKm4As/pSnZ2FoBwrGqiAYyqyHW4fnSCPh0dl76fuQN3P
         ApCR+aT8UX6gfAZV3MGFF/yt8pNKIjKXPbhBKzrHC5ZtCSWtpO3Oi2tCiNeT8YQgLOJK
         /easkkss1CUP0UdK1v/3SKl08DkGpWi/cry4P3ks9DGMDgNrlI9VJGCasO9cFMTW6E76
         /FWTq8PGSWLMHaMLToQI9vI1ZILWRZTEGtMxyYQL+wul3vYxBGKknSepSmq8HXvfq7/V
         b4qU0quNx/+iMM9f9T0hO0N6LaiQYdb9LSijb6tsYFZUF4CAUskRQ2/YRV/syuubBqmH
         kWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939849; x=1769544649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4eJ97Uk/V3oa3o11cK676DDz0RecUq4tSnmFW3bFfU=;
        b=uwLmOvPoRDNNkRMMlAM7tCumnAzqRtz4dDkCW9Tc/x02AaC/7w+yV70hwNJt7Tfljk
         hFMVzeRSykkwxzfiMI0Wo4X377iyMvnoJbURs6CqhT7TAZBNO4+qobp7L+ck8OPT+clF
         U35h4whqCQwY0rBc9NU/2y12seBs1jGI2rFP9CykvPP89K5HFNa/yK3nulpk1NN3LsMJ
         H+pIX9BLTu8mvupm5kpENqUUfE1tqXeuj8SK2MFm1wnmzdXQi1R/O4EZMhYr1dYIY+T1
         iYqUVJritoqOA9gA0g0bo4D+QKKwrAugQsiZALlsGyXuTzpnKNYBoi2/fJ389ufclOIm
         SOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7vm/9OIkQlmac4W07IOC/ACgBrkRFFoh0bVrhGQbYnErLVltuj1xM4N2BQpZJae3yx15DTfpKpcvwzUuLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4q8BAWN9dGfGkMUyH9H9nM8BA0gkgVt4GT99VrZo3pt2yQiN9
	pbrInz3vYah1l9Wu5WBpIJmAOPzdZ3DWMbSQOKjAvlFPazSHlB5LylGP
X-Gm-Gg: AY/fxX7qb3AwIGaWsCjMd01zHWOQ+vy3Vsn2Y3XNDmGieL/26FxLNbYNqLw0N6hi7/I
	sRyCIO0Ycu/SfWG3g4ikHDf0CXbRBNiAQYodUHhPQyr2q/FUcgwlK6gbdeEfgvBPtwqcEVVeH4V
	fqSL9+sQsv1neussGMDhsryDjHacZshCX2azLzVf2GTXheCFy3CVgds6SzDNjfF+Xka+Xfvw9db
	i/fwtg6/gX4wxTud/HYsqdhzFLW+ZmpgymxlzaF1WRiu7lVgyzIUnQFtCv1wdFpfEqGBE5N20yA
	UubdQYO+iFvH2asUYUMk0Y0o8tdHdzUwpBK0pqcpnmhpwRDwZTuAoeDpr6YWnUuXXwUwrMVqDYY
	YrnmU+soiGyMUdtryyfUSh8vWoJqjECLCXAClduuUrnD4CKoBHX0QuaHMVf6SMZ62Dl3M0zjSwE
	1y0HbUtvG9JeyZ40UPKhdEztFU48V1m/EF2sKd3vk7PcqELh/1SMfzKsMmHsCQcg==
X-Received: by 2002:a05:7022:1289:b0:11a:51a8:eca with SMTP id a92af1059eb24-1244b32e446mr9126176c88.18.1768939849233;
        Tue, 20 Jan 2026 12:10:49 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:10:46 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com,
	Quan Zhou <quan.zhou@mediatek.com>
Subject: [PATCH 01/13] wifi: mt76: mt7925: fix potential deadlock in mt7925_roc_abort_sync
Date: Tue, 20 Jan 2026 12:10:31 -0800
Message-ID: <20260120201043.38225-2-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120201043.38225-1-zac@zacbowling.com>
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	DMARC_NA(0.00)[zacbowling.com];
	TAGGED_FROM(0.00)[bounces-31026-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,zacbowling.com:mid]
X-Rspamd-Queue-Id: E00F94BF56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

roc_abort_sync() can deadlock with roc_work(). roc_work() holds
dev->mt76.mutex, while cancel_work_sync() waits for roc_work()
to finish. If the caller already owns the same mutex, both
sides block and no progress is possible.

This deadlock can occur during station removal when
mt76_sta_state() -> mt76_sta_remove() ->
mt7925_mac_sta_remove_link() -> mt7925_mac_link_sta_remove() ->
mt7925_roc_abort_sync() invokes cancel_work_sync() while
roc_work() is still running and holding dev->mt76.mutex.

This avoids the mutex deadlock and preserves exactly-once
work ownership.

Fixes: 45064d19fd3a ("wifi: mt76: mt7925: fix a potential association failure upon resuming")
Co-developed-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 2d358a96640c..05990455ee7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -457,12 +457,16 @@ void mt7925_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return;
+
 	timer_delete_sync(&phy->roc_timer);
-	cancel_work_sync(&phy->roc_work);
-	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		ieee80211_iterate_interfaces(mt76_hw(dev),
-					     IEEE80211_IFACE_ITER_RESUME_ALL,
-					     mt7925_roc_iter, (void *)phy);
+
+	cancel_work(&phy->roc_work);
+
+	ieee80211_iterate_interfaces(mt76_hw(dev),
+				     IEEE80211_IFACE_ITER_RESUME_ALL,
+				     mt7925_roc_iter, (void *)phy);
 }
 EXPORT_SYMBOL_GPL(mt7925_roc_abort_sync);
 
-- 
2.52.0


