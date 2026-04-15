Return-Path: <linux-wireless+bounces-34848-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHD4IqEQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34848-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:26:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 546EA4089E2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EB5D3097BBC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB3E3C873B;
	Wed, 15 Apr 2026 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1Jy6fJU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E639B4BE
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291855; cv=none; b=bXOWpRdIPLvD4ussFRhykdcQbrvVzk9t8dEa9/28ivbkq4i3lazoJHP4t0ms0uuUkL6uWSoNfdEg0rMmMKWJ3k/SWhUazuGhht0QhUJXW2VwucHcKwmgwAji1P7XiBbkUzDxdHPc5zKR6CZTVx3KYpPHKmmMsm6FxdIVYl/KKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291855; c=relaxed/simple;
	bh=3NtyoA1+rIxC6eOqlCUu6L5JyAy/EPsSeH2SVhd3LFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2jxLogI/kFQ/pJWtQZyQRajxgZbeKd+oRo0jVVXN7sXm9FGY1TPy8yXRUN1i/5bGINQVRgjYXQuRoDSCNu6zFH0ecINKOIFDjL19rf0zT7JDT0TG9xtVkRPgDwY/Nx4suneBX9XFmjk1kKjFptniCBQFlGkceqaHJ8L+r5fL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1Jy6fJU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso71913455e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291853; x=1776896653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Tt0YKW321XbT71CwRPCUmwYnUbE6Bqe7J0z7izkIPc=;
        b=T1Jy6fJU/s01b6lbjaOZdBXvIieaA/wkKYCZvZttCo4f25v3ANCFpfqGj0ZauLckhV
         hAsYPdnDhtPeaqtMYMPoDBzeUVcLK220XzREauPuqBVx+8bqcLohXwbb4NafVP88cAm+
         p3YloC4sjMU+y/Fppj7E9cyZCL4IIjuRFFOXrqyANiWigyHbVWp/5ULwmiTVSgtwEYLo
         A07k3qrWJg/ThYzjewqcSm6tUwbW5NEIRWKtGAGd4x2uqz6IUQtWvNaxrcrFArZxsNGC
         CqLIvX83oaxpY3/4V7MWm9ANyuz6RSRoK/hDdyGfY7pqF1RHeslJXGkup6H5ZmZGwBHb
         oK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291853; x=1776896653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Tt0YKW321XbT71CwRPCUmwYnUbE6Bqe7J0z7izkIPc=;
        b=oEEpHXEYKbiOOwxsYpYWeXH4cBue9KvwTZdgfPzNh/Q99Rav4/0zSWAdD09oWTQ6ry
         KwDFyuNvE7gwC8E24IQzkp1jFS5Eqeyd7epsV6+3yAOsCP71ORlaHrDV4jbEI7r9BXWx
         KkMrHzTg4/7gknZG0aHqBUZO90ilLMP6ixtqbFS/0wABei3QZ0Wp/a0rluawGOm9AaMy
         lg2SUyzkbykwKNhM4CG5H5RkdbjJOny71cg9pL6IKqpT0VsXRWYN36b8YIEao9ist+v1
         4u8vtYfD0Hj97+D/5nZnM6CEV1JAunkE+So220h+aw3JOnGfGo+EFv40q0WmkiJwRU7b
         tI/w==
X-Gm-Message-State: AOJu0YyhGGw6I960i4LCyOlT5sSDWSHzST4WsEaQ2sfaMZVmIBlH23y7
	R1TOKzceEdByoRS8uN9JjXqxeZ0VM4Pk3YEHGCS/EkfPBb3mAQ/UpwQ=
X-Gm-Gg: AeBDieuPEm781+01CbkJSDqNUSfPZ5Ge8Fg8qr/EEB4LDlS3dUOD8TrD/MLk5qs207a
	3sWZiFk2FePMfi748Ra25+dtnTysyCTfsrXTqzXOzdWU6ZHquZyHe5yAqDOVAhJ+0pXMK7DeXPq
	HoO5iKoSs3LbfXyZNbqTEWzvE8+ivbSdlQYmjFyIXOEef/PvAfX9rcFaimg/N0vM2Faygxkxx1m
	oDEb6vItorfl/PNlkndmK6wlhom4ADVUYCAh89sTQyEyVN6LRqC8WG6Tg9sJEAr+6JlI/Z4fycC
	1KisZH/AVxNU+IteUilmvU0eEZAU6l+KIHBks9r0kD/Gp6Wsucs2BOOVvtrnEpZjh3MlrM7J3ij
	jfZId2hC+YPZyRoJ6+rY0gs2xYhF1rLPQWoBI2q8usRjTdiNoZREXPcoNiN1gCxdc7lWP9jQq+a
	xyWpo=
X-Received: by 2002:a05:600c:8595:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-488d6ab8082mr239160085e9.31.1776291852777;
        Wed, 15 Apr 2026 15:24:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818da1sm1932785e9.6.2026.04.15.15.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: wl18xx: fix OOB read from firmware SSID/password lengths in smart config event
Date: Wed, 15 Apr 2026 22:24:09 +0000
Message-ID: <20260415222409.1542989-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222409.1542989-1-tristmd@gmail.com>
References: <20260415222409.1542989-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34848-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 546EA4089E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled sc_ssid_len and sc_pwd_len values are used as
nla_put sizes from fixed-size mailbox buffers (32 and 64 bytes) without
bounds checking. Values exceeding the buffer sizes cause out-of-bounds
reads delivered to userspace via nl80211 vendor events.

Clamp the lengths to the mailbox buffer sizes before use.

Fixes: e93e15fb47e5 ("wlcore/wl18xx: handle smart config events")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ti/wl18xx/event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ti/wl18xx/event.c b/drivers/net/wireless/ti/wl18xx/event.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ti/wl18xx/event.c
+++ b/drivers/net/wireless/ti/wl18xx/event.c
@@ -82,6 +82,9 @@ static int wlcore_smart_config_decode_event(struct wl1271 *wl,
 {
 	struct sk_buff *skb;

+	ssid_len = min_t(u8, ssid_len, 32);
+	pwd_len = min_t(u8, pwd_len, 64);
+
 	wl1271_debug(DEBUG_EVENT, "SMART_CONFIG_DECODE_EVENT_ID");
 	wl1271_dump_ascii(DEBUG_EVENT, "SSID:", ssid, ssid_len);


