Return-Path: <linux-wireless+bounces-38220-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6q5uFhTvQGp0jgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38220-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 11:53:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C06166D388E
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 11:53:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ViceLwCZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38220-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38220-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66077300B3E1
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2834E74D;
	Sun, 28 Jun 2026 09:53:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5813B293
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 09:53:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782640400; cv=none; b=PGzmt03zTvCii7YKFe6V9m+KhqQKrMmqrT9TU5Az7cKdVgubYqChr3ipnvQgQFqAPEqp+Q49Xb/rRa0e9jLPxwIKeTymZAGUpvodUbe4sdZOhbTSd8Bpgpb8UpoaVJUfV3E5SNhzCKvb4XwOXMHbxi0IJ2J24K5V9eHWIufXjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782640400; c=relaxed/simple;
	bh=OPtltYAVgW1WveaIKCGmOVle8Mjcb73IOM2f2RVXiis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLewk7zeyDBHfBSQVbgsXAsGvB3EDFnNAIEddNVJmLY5n6R0ETfFt9zDr+s+VZbAtxkRCRmFBqQzFbkMxd24uIoQqk5XdU0ZMsvBGCqGeU/fwx7l3RT6gJMNgC3dRcfLHj+lh/z1ERfloR/AQ2BTK5bOOv+udOEoY5rPG4dLfVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViceLwCZ; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49395888c7bso12402325e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 02:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782640397; x=1783245197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ob/ELKUAPnlxj32HFQpLhwFWy52qcG/tiNHQcKZ/Yus=;
        b=ViceLwCZ3pmjicwEsztSHwKqVWgZrUIDh0UeDJAFn18+15AsrzBYMlUaZZPH2g28Gi
         o288UTfGZNRJfweT85YbGemODWeoBVDJOrWnrK3D6Sm38d8Ksd2T1nduItc3AMFOEXa+
         vWTwDbskEbaOVOCMS/5j85pGYOCr3m6MmuD9jVyzfm+S+Jwh2c0rcMGuQB7vb9XKn4ZR
         zWBNuKIF0tCrX6yRzedNTjYPEhK3ZeGhuTPZi/FJ5WG7FiGiSEcQU3ucJYNuTQMBrUqE
         jXHHkT70cBQTagK80QDUYc2Q7GP8y/FBJJean+blUCXggFTCqyXEdFepf3cTTzI0WTIk
         vFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782640397; x=1783245197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob/ELKUAPnlxj32HFQpLhwFWy52qcG/tiNHQcKZ/Yus=;
        b=iO7lfgeK3MbqQLBgHzAGebINlNa545Kc8xhYoQIim8BJYkMeDHdcO8OLPCZAMctouM
         n5IzB5vkU+0pdPclynPnP0KKAPuxpNFwNbRdZMmCbL9h8+LZDKYy3ROVOZmvh7IYKF44
         FRVXT22RftQb0BEfcGIYN67qcSuduD6nlwQK8YCkoK8pohSbrs0rDzt8w6gJtzdAW+js
         fpFGVn/7huhLgPauiJ4ghcUWmwl/WbRLo9bktaJo8tdTeEcG9clDj8spo4wVRmQZkNzp
         ZkpPobm1avEAevD6/vm9ViUNyGUDNXq1oTGM+z/lrKtXQilDBH7OZTh/OhS5/onFS50i
         +9cg==
X-Forwarded-Encrypted: i=1; AFNElJ+Nd+00HQtFGDKXnx0+6WX/r4p8CG00iJ8rarRHVKkbal5eAd7DvcJkEZi1/HGwRWz32p7ebFtq2uASIrUKAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/uxoNMkkHSt/edL+MA0Rp8WZuEuFEXIyNZb10xG45OW5AM+I
	JiGta4opEhpIN9UZvRy4XfU+gD93hKxOlr1tOncZupRMEu2zcHSeoJ7b
X-Gm-Gg: AfdE7cnsAYkhBP2K7TaswylACgiwphkA7zHMyBUkkXlgKQjhe98bZjrIjbVgsFJKC55
	yVrIyTgkNNF+iqWO66w4i9nx1o/IFmugkJDo5wVF7zg+v2CfcdK541cWddjDZX+Dzyzih+JSYQk
	o5OA/M/lmBmPBpSKNm3AT2OYcDZ3r2o2rgEMNljIDXoPqvi3VNB2MNf2XlO57pJnhPfv89Mduck
	0HnDNlYD3UZNST3DN0fWln6+q8iFW41o5B+yqU0/zXJt+cOJi5T7bUZGlQvkgnn7/C5s1EWmzCX
	Zen+9wI8Dv50LzGLv+oyY1IV7MGuBy9zsoZMbrE1qRWVycvPvtu7CGx14Dmtr5aEbkXbB8CUHTn
	/UEeCDbm2colXiSSDL4jwb2TFvjGFqpemi2GBgh6nqAS/il0JMT+Bi1ytm3FITdEBEpT4dNGYBV
	xjeQ2OBmEtmvXHBgTkFLjYy3ZYgtjlO1eIMarRufZeVgelG3fO8z/aMEgkQIblxgzvPCEmbax/t
	w1Lprw=
X-Received: by 2002:a05:600c:6296:b0:493:a435:d870 with SMTP id 5b1f17b1804b1-493a435dab7mr43595425e9.27.1782640397189;
        Sun, 28 Jun 2026 02:53:17 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28673dsm189602075e9.2.2026.06.28.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:53:15 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH 0/2] wifi: mt76: fix per-band LEDs under single-wiphy MLO
Date: Sun, 28 Jun 2026 11:53:11 +0200
Message-ID: <20260628095313.7790-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38220-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C06166D388E

On MT7996 (and other single-wiphy MLO mt76 devices) only the 2.4 GHz LED
was ever usable: the 5/6 GHz band LEDs stayed dark and a WARN_ON() was hit
during probe.

Two issues are involved:

1. mt76_led_init() calls ieee80211_create_tpt_led_trigger() for every band,
   but that helper supports only one trigger per ieee80211_hw and
   WARN_ON()s + returns NULL on the second call, so the secondary bands got
   a NULL default trigger.

2. mt7996 assigned the LED brightness_set/blink_set callbacks only to the
   primary PHY, so mt76_led_init() bailed out early for the 5/6 GHz bands
   and never registered their LED classdevs.

Patch 1 shares the throughput trigger across all bands; patch 2 registers a
LED classdev for every band. With both applied, all three band LEDs
(mt76-phy0/1/2) come up and blink on their band's traffic.

Tested on a BPI-R4 (MT7996/BE14): all three per-band LEDs register at boot
with no WARN_ON(), and each blinks on its own band's activity (verified
with single-band and MLO clients).

Petr Wozniak (2):
  wifi: mt76: share the throughput LED trigger across bands
  wifi: mt76: mt7996: register a LED classdev for every band

 drivers/net/wireless/mediatek/mt76/mac80211.c  | 18 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7996/init.c   | 18 ++++++++++++------
 2 files changed, 25 insertions(+), 11 deletions(-)

-- 
2.51.0


