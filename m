Return-Path: <linux-wireless+bounces-32673-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNO0MAFiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32673-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582B228A06
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C253036E89
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8135F8D1;
	Fri,  6 Mar 2026 23:23:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68A374194
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839416; cv=none; b=HzAgdY8HsumB0queGopjjJUf0UM/78pIhJJbunOjIoKSOd7LDv540KLfl39Hxy8AXYWGV5ag3mQGrqEEIOh3DKgW1B1GNyCjAhuTp6UuO34qS6NzMmSbete1cBRuk9rYCiGa/PxQNQ6P/9hc8v3PFG0ppRmYg/ntFnJhc57/4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839416; c=relaxed/simple;
	bh=o6nBpAhcYLPZD0jtf2ngucOlBaSpPu7cvIdammeSQ0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szqB4CC8ytsquZiiuBlWi54KADKEqbVOFiixFYkks9io5yMnT8oNBaaHqObYAM26tj15tg8sLx7AGzsGqAN0gJYMQTjzFdRo2+kEz8QnFHv7nxa7B+k3XdGriXC/ZXPGKE7heQThjvA4sDt03vREBO9Fbakz8pTgTUb4CP2fzXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4094b31a037so3177164fac.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839414; x=1773444214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bhrkUPLYEPGp9v5WMepaYyb+dL3jmL0m4QvuAMzcOMk=;
        b=WNYvZy5/Vi8vOZHdIrgWTjQozJCpYyY+Sg59OYuyc6uJctD3sP4Qpp5oBt3SzULCVh
         v2hpiHsz0fvSZ5QmBnKcZqwDu9gKH9aIkx+0dpurHWtTEcAnAfc9tOv95aeqNz0hUefT
         WVPs/gdNJ5RrRJUoaTJPv4FCTsPZYwGX5ptfi2hEIl9tE38uOEd6jwWWowQnFfRh0/Po
         RiQ8O5kNAF10OXHPmYmCqkpiW6I7WJYrH86+kfAYQQ5onCqIhM8Jc5CF9UD5lh/mxwIz
         F/yDhiyN9eGVgXOYGl1fK7aHksZX51QXv8aPuhlUqZ36/Gik+BOlvXqNaiymBGC/jzHT
         LPoA==
X-Gm-Message-State: AOJu0YwCchkTAvHyx37oLxNL8Gk/zXU8dfxoB5n9axX0K6pSuK1nr8Il
	zlExZi3rok8/ZeozgmkfMxEwUqwPiitSXlig1xpFKvKPOU5Ha+a+fz7Vuc1MxQ==
X-Gm-Gg: ATEYQzymE139KqweREejUKj5brGo3sitX7aiGIct2UFNP/Xo7N2GKysGXC5Ig54zK92
	7gkRSw4tmcRhOYx60rDq3rkEL+JcoWxvWJkcbTPPw5kLG3Qax/tgFl8CmL0l1PB+/Uv8CUTppmF
	ch5oufUOWsJbZEb5r3foGAYHRjrru2OPrEwwiq30QndBKmGkVZBYfmY6R/+uy7UgstopluVMh5A
	7boYFuxpa2h/EQuniy9luAJE2nAuXPoSETRTxexJaUY3/J+8a6nC8R2FA7LPa1YCldkpt034vfQ
	yNs5qAzMPgLywQ6I9FeRSI8fch8ulT996LZQhQJjQ9NAGqu13Eg58SiTD4zl8JhPGs2MBwhOIcV
	QGyq69DdudQb+Y8uKVLFrP5B2ShctKoNhfv5/T9WYuXfu7qTlyflc5q7z1Z9xKQPLEX9rmLZiC/
	+W/vqXVF9mnDB1Yt7Fwd6ADi3GR1HsYEzgv3tr6r+3KATlkUE=
X-Received: by 2002:a05:6870:8189:b0:3d4:fe66:28f6 with SMTP id 586e51a60fabf-416e403e732mr2191471fac.27.1772839414389;
        Fri, 06 Mar 2026 15:23:34 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:33 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 08/19] wifi: mt76: mt7925: validate mlink in sta_hdr_trans_tlv()
Date: Fri,  6 Mar 2026 17:22:27 -0600
Message-ID: <20260306232238.2039675-9-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306232238.2039675-1-sean.wang@kernel.org>
References: <20260306232238.2039675-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5582B228A06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32673-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.392];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Replace the dead wcid NULL check in mt7925_mcu_sta_hdr_trans_tlv() with
a WARN_ON_ONCE() guard on mlink before dereferencing mlink->wcid.

wcid is always derived from mlink, so mlink is the only meaningful
object to validate here.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index c474dd358650..03515b891643 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1082,11 +1082,11 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 	else
 		hdr_trans->from_ds = true;
 
-	wcid = &mlink->wcid;
-
-	if (!wcid)
+	if (WARN_ON_ONCE(!mlink))
 		return;
 
+	wcid = &mlink->wcid;
+
 	hdr_trans->dis_rx_hdr_tran = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
 	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
 		hdr_trans->to_ds = true;
-- 
2.43.0


