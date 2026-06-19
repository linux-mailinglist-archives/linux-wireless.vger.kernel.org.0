Return-Path: <linux-wireless+bounces-37927-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MHCmGOuBNWqZyAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37927-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 19:52:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E404A6A7518
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 19:52:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="LZTtt43/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37927-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37927-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC0693034EFF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B93B19B2;
	Fri, 19 Jun 2026 17:52:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311B349CEE
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 17:52:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891550; cv=none; b=SZ3tI7gYRGCrwp5AfrqyI2lMPIiTTin4IEVFHtE8bMkkgJyzfbI1TXqvPQaJn9UqMBB1/qGnY1TgT4EgYy91o1EBldW5h1lrsW4HqJK39HBsXAMgJeA20EHAQePnJ40TqYxx/Oj7sejOArwi3Pfw83sJkRIYJhWk57oYHvmjND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891550; c=relaxed/simple;
	bh=zW9DKON9mx7IrUyUOjcnoR5Dpd1gG+9B9/BVhakQksI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=un5X49itXZ330oVLM36tXBk4SdTiJcy7gOHMdGMFvd1iDAwIvxnViOWeuxexs10IyqaqsP1FBeP5Hiw1+IFzHaZ/b1TrdqdPElAa0CRWYKBVr7w1PaWEo349sQf2NWnIcUOIO3kMWuj4i1msvg2IJTdE8F8VkwuuIL/hzh6alK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZTtt43/; arc=none smtp.client-ip=74.125.82.170
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30b6dad2382so4353488eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781891548; x=1782496348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CkKUbPI8bcHsG3LZvBu1T6EdoJFBnx5t8VUOydPJDN8=;
        b=LZTtt43/8GK9EksmMt34X4Rtttb2oEsFfojD93y+5yjLe5dTKxXTVppdyxjvAD7MO3
         0TfoWogz23aV0/AidBQVmjW5TAinQXmW8Nrf+/5TlS9xk17/3+/v5SDM5uKmiHGfub++
         3NrA3D2KTNZkunyHYDiIKw+tj6zHJP2uoEQsJmZqOr5ZD3G3ECDjfneVbay9MQWOuybX
         BnkJGcCcxzSUhpraUfZhghc6rD+MjUc87a1Y5nEHK4ZBclIGDUF3Y92tS6c7KsTdGC9b
         j95bPaRNIXwtr3qxdGfFtVSLbTB3KNoJ+GjLKe2itc2XSyI6lyp5QVrP2wXsReMIIzSO
         elFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781891548; x=1782496348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkKUbPI8bcHsG3LZvBu1T6EdoJFBnx5t8VUOydPJDN8=;
        b=i7jxZh/rBHO/ilz8qvudYqlK6PdRsnaYMDnXV07qxFSEWCxy3wk8h3HTeswScnpnLX
         4Xaf018LF6pligfVCMFf/1wgx5lfLpuE/kHqaZCL4Rptu0BAbajGE44LAwMPr7nkNcIk
         wOX1Sq7NiaTsDTKMWuwd9K6Pn7EDrU4kZna6D6J/uFESIlu0E7SbEhPKbs3d4d9ygVSS
         5o2lEJCr4OdejY6fqD7GxYfnF/cmmvYsrSmvLQQ3BmXjhKTzpAFEH5a9j43gwH2u8EdW
         gcEsIQq1nhYYQuFaSxmL3YEpoucUtvjZRVtulR9aQvnGEQy/E9gsNPZ5heuDDxra3j1w
         5QgQ==
X-Gm-Message-State: AOJu0YxhEFjcYCfxwS/4RJ05l1EA62ONpo8XeNYgYRXd8J1TErfJVo+K
	qvZtnPBZhAN2wMYePhH1JPBDf0tTHisA4kFha7xPTqBq8vpsiH9pC3jZEUaiKw==
X-Gm-Gg: AfdE7cm7Zkwd1vRqOQI+EkHn1SPBMXAmjOd/mu3+hRU2+nJNjBAJTy6vc2erJjS6FAO
	qXPpcBqeBL3BA5NrM6H3oQDdUkJdooVza9nK/KuqxOUMhG4qUUm9FN3ikApT5Z4YZbOnyeapy/N
	riV95SjjLklbjLT/AT8fyge/CBpbgnwgnrnsi6yUsv1S8gz7s9Qww/uOfiVGSYzuWh6r22UkO1D
	6zOtO+hi6ThlhlHcKDSlGeLe6sziOILasg9HmHewuoheeiw/ku+ePXlFNvhdZScqDKaJmyxz+Z7
	OczWZK2Ghs9t+8iQS+FvaIJg0CAfR9dAoX9ucj9FFnsss/ksdC1rn+sXKP4DOTnXiNnl4/vrVVQ
	Zv7f8zluhsY2Akj5KvLMy+clYJXsmGO5RVlIal9mMwrzqhzDkFvUDSVZ4jw0DiFn3nM0W03ailO
	IeV2g60WDQs3Socr9p+b1FruGnEYjQfXjQtJD0QZzebfAnlYtjIASIBNORpmVnkMEBjFHQkct0k
	z/IFqYwv+JKaUyalkGXBJ2+
X-Received: by 2002:a05:7301:4b18:b0:304:d835:274 with SMTP id 5a478bee46e88-30c0d105d43mr1722116eec.24.1781891547841;
        Fri, 19 Jun 2026 10:52:27 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7726:ebb3:f6b4:614e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm449951eec.5.2026.06.19.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:52:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 ath-next] wifi: ath9k: mark static arrays as const
Date: Fri, 19 Jun 2026 10:52:10 -0700
Message-ID: <20260619175210.5348-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37927-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E404A6A7518

PN9Data is a read-only lookup table and is never modified.  Adding const
lets the compiler place it in .rodata and prevents accidental writes.

Use the same treatment for bits_per_symbol. It's not modified either.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: mention bits_per_symbol.
 drivers/net/wireless/ath/ath9k/tx99.c | 16 ++++++++--------
 drivers/net/wireless/ath/ath9k/xmit.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/tx99.c b/drivers/net/wireless/ath/ath9k/tx99.c
index f2144fd39093..b52d84f6cbc9 100644
--- a/drivers/net/wireless/ath/ath9k/tx99.c
+++ b/drivers/net/wireless/ath/ath9k/tx99.c
@@ -39,14 +39,14 @@ static void ath9k_tx99_stop(struct ath_softc *sc)

 static struct sk_buff *ath9k_build_tx99_skb(struct ath_softc *sc)
 {
-	static u8 PN9Data[] = {0xff, 0x87, 0xb8, 0x59, 0xb7, 0xa1, 0xcc, 0x24,
-			       0x57, 0x5e, 0x4b, 0x9c, 0x0e, 0xe9, 0xea, 0x50,
-			       0x2a, 0xbe, 0xb4, 0x1b, 0xb6, 0xb0, 0x5d, 0xf1,
-			       0xe6, 0x9a, 0xe3, 0x45, 0xfd, 0x2c, 0x53, 0x18,
-			       0x0c, 0xca, 0xc9, 0xfb, 0x49, 0x37, 0xe5, 0xa8,
-			       0x51, 0x3b, 0x2f, 0x61, 0xaa, 0x72, 0x18, 0x84,
-			       0x02, 0x23, 0x23, 0xab, 0x63, 0x89, 0x51, 0xb3,
-			       0xe7, 0x8b, 0x72, 0x90, 0x4c, 0xe8, 0xfb, 0xc0};
+	static const u8 PN9Data[] = {0xff, 0x87, 0xb8, 0x59, 0xb7, 0xa1, 0xcc, 0x24,
+			             0x57, 0x5e, 0x4b, 0x9c, 0x0e, 0xe9, 0xea, 0x50,
+			             0x2a, 0xbe, 0xb4, 0x1b, 0xb6, 0xb0, 0x5d, 0xf1,
+			             0xe6, 0x9a, 0xe3, 0x45, 0xfd, 0x2c, 0x53, 0x18,
+			             0x0c, 0xca, 0xc9, 0xfb, 0x49, 0x37, 0xe5, 0xa8,
+			             0x51, 0x3b, 0x2f, 0x61, 0xaa, 0x72, 0x18, 0x84,
+			             0x02, 0x23, 0x23, 0xab, 0x63, 0x89, 0x51, 0xb3,
+			             0xe7, 0x8b, 0x72, 0x90, 0x4c, 0xe8, 0xfb, 0xc0};
 	u32 len = 1200;
 	struct ieee80211_tx_rate *rate;
 	struct ieee80211_hw *hw = sc->hw;
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 89d8b3178784..57e451548958 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -41,7 +41,7 @@
 #define ATH9K_PWRTBL_11NG_HT_SHIFT      12


-static u16 bits_per_symbol[][2] = {
+static const u16 bits_per_symbol[][2] = {
 	/* 20MHz 40MHz */
 	{    26,   54 },     /*  0: BPSK */
 	{    52,  108 },     /*  1: QPSK 1/2 */
--
2.54.0


