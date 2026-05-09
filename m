Return-Path: <linux-wireless+bounces-36132-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gVndImG5/mkRvgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36132-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 06:34:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C904FE11B
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 06:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2EB8301FA9E
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 04:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A0346AC3;
	Sat,  9 May 2026 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za4zVImj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB4231A23
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778301277; cv=none; b=b9Ufz5b/eXPTeQ6vRI2cronnDg4LIbUdnQrq2qP3NpcOZipuGHnoNab+i2zNituv/1gfTr23STnT8QiJuulQJ7HJyF9kaJgrS0616YkjLTuDE29Bk5Jp8ucDzDzuC9TFj2kGp1xMNiCo208RZv8rXmvhScS8aqhkRFN6fz79iR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778301277; c=relaxed/simple;
	bh=gtxY+4TOi0oA41qVHGkJ/QLj89NC1FA7J5o+n/DdpMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atKNtBx7o8rmxtQyqpK2Ys3WoezUx4TKHU1f/GuPX64aowFAblSOnwx4ui8/7RUNhuEKehXlZy6OmcTmYVwRjPHh5rxC1LaUt59CBRjNkJQElhR2M+PONMIWJ3xzl+2+tISLYsxnYKMA+iI7wC9PAhDiPGiNtte9vtph6vmEYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za4zVImj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba0714574fso15600365ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 21:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778301275; x=1778906075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHby+hWH9+W424QK2ah85IJT+/j+8nWOsWmsllDI9MU=;
        b=Za4zVImjLqNml7p+0s6UTUqQNeP/SEyVIro4wSxgQJ3NUs1cEW6A0wMYtf5GYWNxbF
         RozOOdcDWYT8rrT8qoTcmfE0eur2Ww3qEHDWFFL8PYSrs4LJkV4vk8MYH6DGLlJXDdtG
         rBNuZ5iokYX+8c/Qvh5TxFToyqcJF4XBLdYadxvAZMIk3OCbMazgcVCN+ZIk0+Rp+UTk
         0aivQHBlXrubf8pjMOqvmPFM+/AB6T+5guxoTaQl1UHAuonJIPHLvzlW60y0de2RHIx2
         XilEO1tk+qWqoo0SZUXLKps+Lh1DhphCEINTi+fCq9KzsTiljloMQtKW/rKD2mOK4F/v
         BqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778301275; x=1778906075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHby+hWH9+W424QK2ah85IJT+/j+8nWOsWmsllDI9MU=;
        b=DZ3IaXJyIr+WpLft64jsa4J0Ax2mhFIH9EabAP12ZoywznVZetHnlPYvDU7zpacuWD
         QmGz/Rl2aA9eahgTeEg8RfyG9dLaEgJl59R5ZRPqk6TFSw3AZDT3hzkz3uARmAB7F6A3
         p7Onl6px8t3qHYWxfrv0+upmitL5Lqa0mnnzjY4UaotC9Dm+9c4L8BFa8NCP1wHX/AtW
         cMVGRZLVQtVbHeesvW6rFMYZBlIwfHS5jOvf4N0p3V35Gd/cKtmS13PBmzldflO4athC
         reRlpbkZe0V7WzJHuGRez8fFwQ0pIxHCV4c+fBSHUw6n9gx2TOb6gAoZVgf701oXU3Ds
         z3uw==
X-Gm-Message-State: AOJu0Yxr3PRqkXiC026omcCKe+s20Cxuo9aexsW8uHlFAp3lIU26d45y
	2InNtk0Jlf7tFhpDRF3EUh8BgdZZiglNrCcReKdesdzsZGrLr2o2juDfhnTRsQj76Xfdkg==
X-Gm-Gg: Acq92OGbR5b37Qm3N6ZKtjk3riy+qw/Yw3Bx1dx57o2peO3PU7he5PfCWdlKWPsOYYq
	6gcWuhPKQ6zK1UdbJ3XO+hfPVGHlwzvtr0bQo0Mvjajs+/XEgoANEeFZU9jcitzvKxN/Pctte7J
	Lb2nvfn0xITdPE4xm+esnYGYqRy9QduYKYDYwox2YucBmQcHoPvWM7heEt/3rKxZAuSRqTGInxF
	pSgsX0MHFpPL8jXgghVchonykuFvbK2eoQlZ1TEpUpgBYTE73uqyleOzVmK/9Md45aSNCYFRdyx
	9PXz8mm1Rf4Wh8K7sNf80a7sfsNpFIXrGaGkVESrTTLc1/CC+eH1+IwH3tQ/qp6wyN9qrT5W6mw
	i5B2rIuDDp4lgclwqf5KQ55cVpHiGu+0XvumogFS/FPJ6SqtEbck8xHdfv8RNUPja/pSzGqspav
	57DYpXGhk7C6/JIzswOgRfZbQiCnPskjimeoBHnJHSTdX3NW7w3adR0oE=
X-Received: by 2002:a17:903:1d2:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2ba7908bfb1mr159909685ad.13.1778301274960;
        Fri, 08 May 2026 21:34:34 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e6199csm52018435ad.55.2026.05.08.21.34.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 May 2026 21:34:34 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: capture fast-RX rate before mesh reuses skb->cb
Date: Sat,  9 May 2026 12:34:28 +0800
Message-ID: <20260509043427.60322-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E7C904FE11B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36132-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ieee80211_invoke_fast_rx() reads RX status through
IEEE80211_SKB_RXCB(skb), which aliases the same skb->cb storage
that ieee80211_rx_mesh_data() reuses as IEEE80211_TX_INFO.  In the
unicast forward path, mesh_data does:

	info = IEEE80211_SKB_CB(fwd_skb);
	memset(info, 0, sizeof(*info));

on the same skb the caller still names via rx->skb, then either
queues the skb for TX (success) or kfree_skb()'s it (no-route)
before returning RX_QUEUED.  The caller's RX_QUEUED arm then
calls sta_stats_encode_rate(status) on memory that is either
zeroed (success path) or freed (no-route path).  The latter is
KASAN slab-use-after-free in ieee80211_prepare_and_rx_handle.

Fix by encoding the rate from status before invoking
ieee80211_rx_mesh_data(), so the RX_QUEUED arm consumes a value
captured while status was still backed by valid memory.

Fixes: 3468e1e0c639 ("wifi: mac80211: add mesh fast-rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/mac80211/rx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4984,6 +4984,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		u8 sa[ETH_ALEN];
 	} addrs __aligned(2);
 	struct ieee80211_sta_rx_stats *stats;
+	u32 encoded_rate;

 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
 	 * to a common data structure; drivers can implement that per queue
@@ -5090,11 +5091,14 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	/* push the addresses in front */
 	memcpy(skb_push(skb, sizeof(addrs)), &addrs, sizeof(addrs));

+	/* capture before mesh forward may memset or free skb->cb */
+	encoded_rate = sta_stats_encode_rate(status);
+
 	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
 	switch (res) {
 	case RX_QUEUED:
 		stats->last_rx = jiffies;
-		stats->last_rate = sta_stats_encode_rate(status);
+		stats->last_rate = encoded_rate;
 		return true;
 	case RX_CONTINUE:
 		break;
--
2.50.1


