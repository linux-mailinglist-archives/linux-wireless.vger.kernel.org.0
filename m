Return-Path: <linux-wireless+bounces-39119-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HBcpI6nmVmqvCgEAu9opvQ
	(envelope-from <linux-wireless+bounces-39119-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 03:47:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F365B759F3B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 03:47:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BkADfyjV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39119-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39119-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0648D3014C7D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 01:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA986341;
	Wed, 15 Jul 2026 01:47:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D3EAC7
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 01:47:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080039; cv=none; b=MvqSHuUZTpO4Gvln6+CCrwgaqKT5k+CGDwdDFZnoD1VPU04P6U19xcxXyqi2f0REZqaQl5H8O21r0IjZnBmmFrFCjbV8v6Z5+wR+LTXSGgwFR4aH5BDfNdwjSe8pphk9L9Oc5VZ5FhynY/Ge1Wp1BruKXoUkQT+U2leTbyejKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080039; c=relaxed/simple;
	bh=VzpdxuHb8maKJVpJ29m1XvNr/HeU5CaERW0oz/1NJgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXtUq+TXhCHz0w/EuxxMYtwenEJl7gcoLT2CQB+ScXKLssybBd/GZoELtQMf5ayaqJNJHLwNXRxuw3IfrLRdyp0jdqdKqRLTonpNrE5x+XuXZOfC1ct6y3gD+aGgqJJ3xkKUoZ5KhrPJTf6drjIjM3CYY1/PfKhtjw8C6sxkj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkADfyjV; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso16240345ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784080037; x=1784684837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1G5U81Dkih/D0CAkNBfSOxVYZXTH2mys99woWjtS4JI=;
        b=BkADfyjVLjqY4YphKcLBlCBa6Vf7gbTT4Sk9qjFfxuPcysyOym0+7DiKcKrxpOX7va
         HiOImalvfWLfkCHyQLNLzn52XX3UPFpoAoEF1EnknDE3/12jHNNuLSNGrkP070c1JtIB
         k0SyMWNUyo4eCp934OOjRYX4gDd/5LnVF53Jz0fvplscaE4dWq1I/QbzGw+TUJOh6Q2d
         iVw/ZwDmGzI3oLbTGYBgZdM2IPTp+YXTI44G7uScZbYpiAieU8q2gh6QQVTx+Rwggj+e
         uoGfLs25K063xvjnVIGeoNV0iGrWXR7S8HR6Q1fK37j6lxWalNCt7fhGhPPrtsD5yvjP
         nYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784080037; x=1784684837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1G5U81Dkih/D0CAkNBfSOxVYZXTH2mys99woWjtS4JI=;
        b=qXRnR3i3saYlUCU3j0O8GDRggBMA8v5kvdggj8g8fhWtZJzP9+xudW0EwhH3DQcsnB
         fSOFsL9Y3qX1aIhEA3Pw3M0LLDkhbOVzKEQTWinGMENgxiAraNjTmpwXOrgGBKY8jK3n
         w5HA9yrb+98S+t0yUldgwDfRbC5bqyfMkdQAno+A0MrwH/8+6QoDwsM9DybLpAAboPbz
         /DTcmc6rFACI3S2KJte7zfWWFv+lfwYvlbMHHMkbN3u+/fUw5FCEMP0XK1AEekzlPJbG
         Z/zXbI+357N3hc1Z+5XtdAyf8/Glf6WIK36le6xfGxfbFvXHgzj8i15KUnDDziKpS4Iz
         SDqA==
X-Gm-Message-State: AOJu0Yw9fV568QOobfkOR5eSQEcuL9r1MfRAFDNhKP2y+e9tj5XDWD+o
	DpmbR2gsVIEozlSDxE6t24H2v2qf+WSYbyaFESVivL1cBk80AAdPcfJQOyVK8Q==
X-Gm-Gg: AfdE7cljUqNfnjmXLUcqR2CF7xLrUAAKB8/RGtgC0iHv7FczKSxM78RDYR5tKFXDmgZ
	2iQO0Mh2fqyZIlbN+NmgSmWNMMEZYt1Cb8/RNx/0xYhjOj78Cj7fWwTdNiuqrtuA81htY/a9os/
	VOJGOrF573ypW50Sfi+BKLAy39/oG7H9CTg0kIti+hnSXQrgTWnPASXE4h+Mle2Xdd+4HXxU0wW
	Bm4sABMVq4tGQEFKyppQ9GA1MtJIYfSMyrOlBo6rD5VErzX+aS8XQSCqVmnf9NkTDxriDdTp25n
	xg9OjMp9vISaZ0iWdpm4eOyPOAcTDFoeThdlain8A80YpMzek9EDmGeWM7EGdBo/q9xnSUEx5zb
	0Ny2dm+mbXs3csWwLkMFGuylu82Wx8MvsZGsh2Z36aT9LvVsXc/s4aayIAUBqWM5YyFhPbHjLvW
	DBDGq1z0lhs+DIzIFJRjX4/Snb6tvO+i5V7vAnwlPtsRrt/3YhbPGeFZ19iBKgzNYI+M1r22ezQ
	ok/jjS08QUSjuipgC5ZllRCSxlMR+da4JyUMOmvaGzTRxQilgdJHaMCoLTqXhI4xQ==
X-Received: by 2002:a05:6a21:6803:b0:3b5:52b4:87a7 with SMTP id adf61e73a8af0-3c110776462mr17879764637.6.1784080037488;
        Tue, 14 Jul 2026 18:47:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm70110084eec.22.2026.07.14.18.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:47:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless] mac80211: stop tpt LED trigger timer before freeing trigger
Date: Tue, 14 Jul 2026 18:47:15 -0700
Message-ID: <20260715014715.1416183-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39119-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:linville@tuxdriver.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F365B759F3B

The throughput (tpt) LED trigger timer is only stopped in
ieee80211_stop_tpt_led_trig(), which is reached via ieee80211_stop_device()
when the interface is brought down. On a hot unplug, the device is torn down
through ieee80211_unregister_hw() without ever going through
ieee80211_do_stop(), so the timer is never stopped.

ieee80211_led_exit() then frees local->tpt_led_trigger (which embeds the
timer) without cancelling it. The still-armed timer keeps firing and
dereferences the freed tpt_trig, walking local->tpt_led's LED list in
led_trigger_blink() -> led_blink_set_nosleep() on the freed wifi LED class
device, causing a use-after-free page fault in interrupt context.

Call ieee80211_stop_tpt_led_trig() in ieee80211_led_exit(), before
unregistering the trigger and freeing the struct, so the timer is always
stopped and can never run after the trigger/LEDs are torn down.

Fixes: e1e540685437 ("mac80211: add throughput based LED blink trigger")
Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 net/mac80211/led.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/led.c b/net/mac80211/led.c
index b5600d223452..5a7747dfbfb1 100644
--- a/net/mac80211/led.c
+++ b/net/mac80211/led.c
@@ -9,6 +9,8 @@
 #include <linux/export.h>
 #include "led.h"
 
+static void ieee80211_stop_tpt_led_trig(struct ieee80211_local *local);
+
 void ieee80211_led_assoc(struct ieee80211_local *local, bool associated)
 {
 	if (!atomic_read(&local->assoc_led_active))
@@ -206,6 +208,7 @@ void ieee80211_led_exit(struct ieee80211_local *local)
 		led_trigger_unregister(&local->rx_led);
 
 	if (local->tpt_led_trigger) {
+		ieee80211_stop_tpt_led_trig(local);
 		led_trigger_unregister(&local->tpt_led);
 		kfree(local->tpt_led_trigger);
 	}
-- 
2.55.0


