Return-Path: <linux-wireless+bounces-31037-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPZ7BU/lb2lhUQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31037-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:27:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A764B490
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C40272E7AB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D063D3300;
	Tue, 20 Jan 2026 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LToLwIrg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691603ACF08
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939886; cv=none; b=eIggEq5HiUMvyr6m4eVB99AKt+vIpHbK75ef9bQyOP5qvtVqatRTCjcUbAm8F50Swv2GUBL/4is9HzPjPhswqdoH6FroRHMN5PRoYvhaKU1p6TlZqox/R5Y0HOCggL7J4zhfwWp3T3AOKAFNUMOmRt6HDVFE4x9p9heD8FBUPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939886; c=relaxed/simple;
	bh=6af2zsceAUfdt9/tN2Gh7ZwQQh4wM8zkAusXvjcpOHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLvn7pkLw1JH+f8YTt2oLA3lnSCTM9c6IL3xjoKB9d+ehv+IowituWx2HsCbQ5FiUbfQGCzy0yf90m1URu9+iDRnGclmHe4JImCud7Kc5jt8XrJZfWVwm0XK6eDDKPTa8qZnh9i0cVPXDHs30R8JJRl8pFQLG9z4yaySWpSBzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LToLwIrg; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12339e2e2c1so170061c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939878; x=1769544678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyEJCUGxWh8NOcDt1pHqHJNYXEMGHKOoRcUV6C7L5qs=;
        b=LToLwIrgQDvLjLDN55Htq0QEieVFtaxvsBQ4bKBLp1dqLKH0O7m0wBlJgIBDlmE06D
         8KSt9MRcHfHltN0Szw3/TJosaZAjmSHk9vayu/G9pxaRPiB0HsXCEozvDZtwK8NzG/iR
         4j/xeYdYsjR3Rz6MbaMEs1NuNSN6Ke9i/Rml3X3u5cIBSohO0Bf3G0AMYfROMzVjQCNl
         rLNAeCQ0QEvY/e1tnZpirAaretV/qqc8CUeepflX3V+ebNPOXJuGk6RK1bUCx7jVjRJk
         gbbqLbnU+teqi4vjX62jwvveQByw4GFkDlFeZwDYiWwTsBxokuJh2Cj0QtqJvx3RYPts
         L85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939878; x=1769544678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyEJCUGxWh8NOcDt1pHqHJNYXEMGHKOoRcUV6C7L5qs=;
        b=VJM4VOY2EYazHg1OUpDzgr6meyFnpG6oV5e5CuPGIFk9WQW1Z/bYjj2gVhoadzUxfO
         /nJiAFUtt4nIruPyHVh0GKl+3oT/rfp22T2l929OMhe4ayBrPahBq5Kv4DleWq2RxqsY
         QIarVRdedLOIzOZoR9OploJwyDyVG6D8E04IOArXXZLRYZ9HxTuZL/mI7BQgFabXg6D2
         Ohv3gm0DEQ+yKx8Z78skjUhmpUGKBgI9nEx3pCVMWURzZ3IGxAuBAk+iCr0kceN1cQ2N
         7uwh/8gSZpsNJdCVS5niHv5T4qWe2U1haPkjE7UTs1KjicRacVQ/bCGBM5iPTMF87knd
         llbA==
X-Forwarded-Encrypted: i=1; AJvYcCVpg8aOGKQ+5p6dTipQplnFZG3xARxtmqQfRODsS5pYmLjD7M3Xcb7OjYL+COD0Tv5Su3GcvR2/HgFMS+gJGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEf9tzdFaZVQhRO9w1H7WpTcY8yCVWi+QZTy0RDYQR/ypa6pw
	RBGgYjT6PhwBoP5X2Sq5LlsRzgjKLJg/XaMym0vkebZbTaJ1DPXP4QrZ
X-Gm-Gg: AY/fxX5IVGK9PSuZF0QK7rLESscyaCz53svLNYwgg2rhax+f92hBOcvqrO4WfMkKyQF
	8Od4OwzeAudkyHVfCik+E/JNbmnV9NpoPUrieiBQFU6L+Va0ll94lImVKpSFwXLrNrF88S83bXB
	/9QCTura8doL+onD5LXg9KzfX0tYVRM9ZaUjM7D0/C98aeQxJHvtIBPTbXGSj/QfUO4WYu474lW
	06WEUQLrefsf66bOJipPNTX4QzKvNuElDPOShvfEHR2UICvrG13Nh741PJhGA7veiHHyRbag7h1
	fBC50iQT8dbnAo0ykQodPjvbTeBoiQZ7fT9j+ZMuCqzVIR1fCOsFXLNMEnSbz70XC8yX2R9Kiqz
	GRaWfjoDxlEWS8CfxFdBWwr05nuCmjMh1L9Z9wDtvFxWPYrQP1/YKQB0Rk8DdTf599dgfA6+weO
	buxyWVwlJOpROeiyMlbLTgDGmim24DoFyn15swVEBsLgIZJnN3RgocqPoiwxF9zQ==
X-Received: by 2002:a05:7022:140c:b0:123:3c24:b15 with SMTP id a92af1059eb24-1233d0ed5bfmr9477991c88.19.1768939878038;
        Tue, 20 Jan 2026 12:11:18 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:11:16 -0800 (PST)
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
	zbowling@gmail.com
Subject: [PATCH 13/13] wifi: mt76: mt7925: fix double wcid initialization race condition
Date: Tue, 20 Jan 2026 12:10:43 -0800
Message-ID: <20260120201043.38225-14-zac@zacbowling.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31037-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:email,zacbowling.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 98A764B490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove duplicate mt76_wcid_init() call in mt7925_mac_link_sta_add that
occurs after the wcid is already published via rcu_assign_pointer().

The wcid is correctly initialized at line 1023 after allocation.
However, a second mt76_wcid_init() call at line 1036 reinitializes
the wcid after it has been published to RCU readers, which can cause:

 - List head corruption (tx_list, poll_list) if concurrent code is
   already using the wcid
 - Memory leaks from reinitializing the pktid IDR
 - Race conditions where readers see partially initialized state

This appears to be a refactoring error where the duplicate call was
left behind.

Fixes: TBD ("wifi: mt76: mt7925: add MLO support")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 4b7c13485497..acce21ad3a29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1033,7 +1033,6 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	wcid = &mlink->wcid;
 	ewma_signal_init(&wcid->rssi);
 	rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
-	mt76_wcid_init(wcid, 0);
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
 	memset(mlink->airtime_ac, 0,
 	       sizeof(msta->deflink.airtime_ac));
-- 
2.52.0


