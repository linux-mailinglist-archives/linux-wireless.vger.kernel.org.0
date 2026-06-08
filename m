Return-Path: <linux-wireless+bounces-37473-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aEj+MFNPJmqvUgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37473-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 07:12:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490B652BD7
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 07:12:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JDMiNEAe;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37473-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37473-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F0813022942
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 05:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CEA3559E1;
	Mon,  8 Jun 2026 05:11:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29D35B62C
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 05:11:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895483; cv=none; b=omxY5i4wdGTrXV6Djj4mtGNURkbG0yvrZ9/LybbswdL9aeffRDJN0QhkAZfpxqRufs1WmJeJN+tZazLu+ppTjAF3rxBIiEGfr4/KlVGdnyyvm6UlQNkT9gXvJVZXgi9VTb0LBD58RzseHF2YH1hXu6kjopcy/r/7cShtV95Zrks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895483; c=relaxed/simple;
	bh=3yHplyP6cPTk7dA8Fbu6IQ+wvbJ9YuU8YxRM56PGb9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWH4MTb0lmH9iagujGp1Cvsm6uZkJHuKC69qtfkoaNZgVwlZPbRqXv6AJ0vyLGOL24aSxH3BWmSWgCQi3yfaQ+bNiqUknQ+IsByeFkflLRdpvXGJZt91l25IOcKt/1qysUYoJCIMtypoD8aZjffbFgypynkCJzbYaYrWXK/jU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDMiNEAe; arc=none smtp.client-ip=74.125.224.46
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6605c3453f2so3702405d50.1
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 22:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895481; x=1781500281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcd8e+vHsZv7J6v8xRkTQl7Dt+2KjrNT33WGd/GWDII=;
        b=JDMiNEAe8x2xRxepjM3f7GUcJNFlSa59APcZdMmgwLVIrWhtKo36JLSCXkRN+XOd+p
         lVx+pun7EPjWJXTUjmdTksqHeOABlGeuTomiaeM4ijiUegL+YswHtZV4i6crOsojiMf4
         HcOUGh2RGU9kAXBeGk+1n5YYJtVCoPl5nBVet4v/xG5BdouJ4KrjXIXgw3XOZU+tqTSR
         U5qP6MLr0+edpAo6BxX0G9MbHPFlpucNsVuCM0JTbjp5MzY/F85wbyu8pPUAOvS061tf
         MTVXOMe1e+HEGBIa59rG9o3V56aTPe1nWFxPu5yiO7nqqx5cqNRbc1r68C3gx2TmImgq
         ER0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895481; x=1781500281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zcd8e+vHsZv7J6v8xRkTQl7Dt+2KjrNT33WGd/GWDII=;
        b=eb9KzH0dYVAjC1IPpo4ZefLBFFV97SDT/X4TbqrPscgRcpuKYNELtMtsVHeKcQMCcB
         miFti7eFrIEvX286LfccjT/E/Q1fi4BwzGFiYUTDk/gvNu39EdL+horqQ8SMayZzLZNp
         9aBExpk9byUlJreP9UG31GpTUZZQo0aESjGtVLMR7rtCwQwubrmjutjZREIR55ZUuZgh
         G4x8F+na5TqRd9Vfe0ZxhZ32eDkJf36OG+zbFi9WpdkTfhKx8vZprneor7ei4lxikALS
         2mY1ICaXe3RKCkwmgkyuhuk9FT47ZsQRxiy9fpX+ctZn5i4Qdc6PZfCbhXy1E0BUPWIc
         YNXQ==
X-Gm-Message-State: AOJu0YyF9T1FXghy9rlC1/XLGzNNxyqohGZylIF/rqvpH8VnhfOJumEx
	SErJNJjWAoqC9xo6Nlr5Bl5bxdMG2SRAob7YXxIJ7TiGKEu2rVOA++O6Ww2ffgJe
X-Gm-Gg: Acq92OHAUCr/WeZvycn9Lp9BjtY+a0V3nAaAzVoVwKJ6iZn3ojqoWAbnP2UePApwIZI
	M2w4FsiAGEgVaU7UtUWjk2XTE9fcMiRa+vbfZY2TD9CplB7I2/JafFvWeo6iKm1QCdLq1c0HE6W
	K0OAmVAVpKaYdWPPskx5SleR88VJEw/LZSTrtkna9YOJEzgotlEVqh1E5DgmqSAQfWII7hp9jsy
	pdd0Jkyc4maP+XceJRx2s7vxA7UmnNy9ZjGbR/ud3B0hii97c4SSoM0M4ufjXCB5PRyWBuomMr1
	pEp4KIS2q6bk9dJ61W5xxVcCSv0+lsJt+ox9sE429CKVepjs2xP52Wh0hApLqKa91MJhWV6sfjn
	7sPPtXLLyDSF+VxsYB8bmNYS2MLaUor+qF1IecKNv76YSEK8xM6XWCbYv7tG2J+LMEqr/FW44Rb
	vRVvDEvUVpcxrPWvJihNQ6TH5K2bxtHI1TBLa0mNhKbceHGaYbJjtu8WcgMZmZXXJeTZHlSgVAr
	jGMnj+K/MbN2BBk+gpmqUk2bgfjxejKTWMozyodb9GsKA==
X-Received: by 2002:a53:d016:0:b0:65e:41a4:54c8 with SMTP id 956f58d0204a3-66106f8de50mr11106352d50.56.1780895481549;
        Sun, 07 Jun 2026 22:11:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f883e2sm8853478d50.6.2026.06.07.22.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:11:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH wireless-next] wifi: brcmfmac: flowring: simplify flow allocation
Date: Sun,  7 Jun 2026 22:11:02 -0700
Message-ID: <20260608051102.6698-1-rosenp@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37473-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:arend.vanspriel@broadcom.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2490B652BD7

Use a flexible array member and kzalloc_flex to combine allocations.
Simplifies code slightly.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/flowring.c    | 10 ++--------
 .../wireless/broadcom/brcm80211/brcmfmac/flowring.h    |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
index df7e3bee19f2..35cbcea0abc9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
@@ -360,20 +360,15 @@ struct brcmf_flowring *brcmf_flowring_attach(struct device *dev, u16 nrofrings)
 	struct brcmf_flowring *flow;
 	u32 i;

-	flow = kzalloc_obj(*flow);
+	flow = kzalloc_flex(*flow, rings, nrofrings);
 	if (flow) {
-		flow->dev = dev;
 		flow->nrofrings = nrofrings;
+		flow->dev = dev;
 		spin_lock_init(&flow->block_lock);
 		for (i = 0; i < ARRAY_SIZE(flow->addr_mode); i++)
 			flow->addr_mode[i] = ADDR_INDIRECT;
 		for (i = 0; i < ARRAY_SIZE(flow->hash); i++)
 			flow->hash[i].ifidx = BRCMF_FLOWRING_INVALID_IFIDX;
-		flow->rings = kzalloc_objs(*flow->rings, nrofrings);
-		if (!flow->rings) {
-			kfree(flow);
-			flow = NULL;
-		}
 	}

 	return flow;
@@ -399,7 +394,6 @@ void brcmf_flowring_detach(struct brcmf_flowring *flow)
 		search = search->next;
 		kfree(remove);
 	}
-	kfree(flow->rings);
 	kfree(flow);
 }

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h
index 818882b0fd01..f3d511f9a3c9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h
@@ -38,12 +38,12 @@ struct brcmf_flowring_tdls_entry {
 struct brcmf_flowring {
 	struct device *dev;
 	struct brcmf_flowring_hash hash[BRCMF_FLOWRING_HASHSIZE];
-	struct brcmf_flowring_ring **rings;
 	spinlock_t block_lock;
 	enum proto_addr_mode addr_mode[BRCMF_MAX_IFS];
 	u16 nrofrings;
 	bool tdls_active;
 	struct brcmf_flowring_tdls_entry *tdls_entry;
+	struct brcmf_flowring_ring *rings[] __counted_by(nrofrings);
 };


--
2.54.0


