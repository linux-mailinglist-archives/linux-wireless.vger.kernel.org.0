Return-Path: <linux-wireless+bounces-33205-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEIyL1X3s2nYdgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33205-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 12:39:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 263E228253F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 12:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA9931D3EF4
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222AC3264DB;
	Fri, 13 Mar 2026 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="p4GdMm6O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340228BA95
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401708; cv=none; b=PLJN9CsytshOkr+cQvOxLeBlWKniVvE1AH47IxTO2s2Qd5ghuhB0u6RRdJZx+5alauFcNgRIX3p9f/rjytf93XymjZslcYNJpQUe8luRYApxFe2CJakQnNApPb7LLMKGSkWOXFglvldz7GzgL5dHlsznglIvUXx63GUplnKf/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401708; c=relaxed/simple;
	bh=zV7neuLkSOIlzYViwAfwLRYPEUuyu/AOjQWX/yJqh5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQxNKX9yCKX5P1Au6mRt1tT10aZ16+TEckOMkTh3ZguYuQOrURJL1bNuL4eYM23+wiYmc60jIYWusOtydxFr00vJJb2bzV4Q3c6qcllhdzHW0UQXvUrodJWv7dD+87EP+zmULi1B09nZAixeDVjiRyr+6OJzt9eiVRj/qopE01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=p4GdMm6O; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 0CEE717F9A1
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 12:25:15 +0100 (CET)
Received: (qmail 12959 invoked by uid 988); 13 Mar 2026 11:25:14 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Fri, 13 Mar 2026 12:25:14 +0100
From: David Bauer <mail@david-bauer.net>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH mt76] wifi: mt76: mt7915: set mt76 specific PS flag
Date: Fri, 13 Mar 2026 12:25:00 +0100
Message-ID: <20260313112502.2026974-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999991) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.099991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=zV7neuLkSOIlzYViwAfwLRYPEUuyu/AOjQWX/yJqh5c=;
	b=p4GdMm6OX8p1shu1IHk2C2EUFa/IUErWxQ39poHEQ6qhB1JV89F/6YstW2qr41yXeR7tO76Z1n
	QbrVXYQLeP+ViXsEQAe5xdidL81a4BSDQC7u2HQNGxG1SOpObTXwHbb9vRh9oy7sR7YL8trnTZTt
	Yf/WvESlH6FdUDAno6aeYfzLqq5L+EyWwHMk0j2wpSyFGTaoVXklM9ImPpp2waAmG9AvBLloCeVk
	2hmQi3VqU3RJHujs+mX7/hGnt3JmrXs4V0bf5T432QhXd2uz3UHgF6tH9tuaFaMYFd+BMRwJ1GAU
	fl9f7yveIsotOybZL6E3CbnGXPGVHTp8EpH2J9KE29w4xKlIS/A+yyJLCkigdN0qdOehV2N80EiT
	FAsfU2jkqP8wsqB3+cUcWpUfIBm6uyu5TV81Fj3YTyBMijj7zCTlFtt/Zlza3hwCQRxu242OxV1+
	g0UhYj5euxqqe6QpuHyBvsz9v6ea9tsK6F4UTEXwORvLXwQj/eul3C822xHO1ecqEbGQ1ohK6z1P
	Ajeq4A5rAZGvwSgco66kcVWf5b4uB/e97basxzAPo7Uz66arXjxfu+LObAZ7YOFncSyIibiWKo0x
	uaPZZ3ZSbgxEc2zc0peNTwlj3csPIONcN4IC2hdjeqVL9SJmx6CQB0yuaCch3aszEwzQaU14gSKD
	w=
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[david-bauer.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[david-bauer.net:s=uberspace];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-33205-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@david-bauer.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[david-bauer.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,david-bauer.net:dkim,david-bauer.net:email,david-bauer.net:mid]
X-Rspamd-Queue-Id: 263E228253F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mt76 tracks the PSM state of a sta internally with a wcid flag. TX to
such clients is skipped based on the presence of this flag.

This flag was not added to the PS state notify handler for MT7915 chips.
Without this flag, mt76 queues pending frames to the hardware,
accounting for airtime when a PSM notification is received while in a TX
iteration.

Set the PS flag for the STA WCID to prevent this from happening. TX gets
skipped in presence of this flag.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 51a52ed072eb4..0598bea29e498 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -421,6 +421,11 @@ static void mt7915_mcu_rx_ps_sync(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (!sta)
 		goto out;
 
+	if (p->ps_bit)
+		set_bit(MT_WCID_FLAG_PS, &wcid->flags);
+	else
+		clear_bit(MT_WCID_FLAG_PS, &wcid->flags);
+
 	ieee80211_sta_ps_transition_ni(sta, !!p->ps_bit);
 
 out:
-- 
2.51.0


