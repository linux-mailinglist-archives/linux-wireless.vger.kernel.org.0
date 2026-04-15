Return-Path: <linux-wireless+bounces-34824-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ka+AkEQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34824-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE74408972
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 779E2314F683
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC43392C4A;
	Wed, 15 Apr 2026 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUjYv7tC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9954C394463
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291797; cv=none; b=GmT9X8LINjmurcckehW+MAIkPo3jVEt5KNxFj2PqEJ+wxd254d76fFFIP49rMxFyI2Co6571CT+jMGK2DaHStvjy/ie9ZAOFNVN4xW4Ylm/8jqYOM1ZNN2b4ND1YgMoUP5zkChFkGttJYt+ebdb1w7eCWeUQfYRBrji/+IGd6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291797; c=relaxed/simple;
	bh=lvIZcEnA1Xr8BvwLhhibnIOHVWeM+A2VwaOHYI2m2Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDlEDqUzmbgYI9fKXmto1h5T+UfmJ7C9qyHgpWc8KYOk7C05/9Af5XTNzHRMZvf5ExUFq+galX+8CEunKTKyxAzPDEbG5sUCNP9Svq3P+uQrb83cNmNeYBZkd4LNdunQOxerBAsEyKldYov46Lsb9PVnLonl7vOvJp7SpIgnKiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUjYv7tC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso74536715e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291794; x=1776896594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGRAAzpvd07h97fVtYsZEQ5p5WwJfIFgjHO7stV6AD0=;
        b=EUjYv7tCtLn4Lw40LM/cqaTSeuRVqJT3CNYzT/N90euxOz6vDH8PYtkg8RqE9Zfv+e
         0l5aWvwaL8ORCEvqHb7PL7QQevNbtzsqMBU/c96qogoQW+FUDA0cHbvD2GVvIl+hdqgR
         k51FK3YK4W8anm/OzLAaW480UBPDTKBQeKTt8V8m7nqqrArmIXJmB6NeC84231Z6mn5G
         34VDotQA633BdQhLHMNhAF+Us44weYyU/IXeahScAngGRLZRiyqIqZ2paW17ml7ZbxVC
         jGx19mvSkzqNIRFHMtXfXfy9xh6akMfYEQBko5vGjtXh31szKtAnOMJahRYyL/4b93xR
         LU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291794; x=1776896594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pGRAAzpvd07h97fVtYsZEQ5p5WwJfIFgjHO7stV6AD0=;
        b=G54DIqO6xZWBy15mk1dDN2GfWdanILh6NDhH13BLVsoj0BgAEwfL++vkkEU6W0xUQJ
         mWh3+WOjA8FG2E5u7TOhlQqOVehpQn5rk/0dIdLieJ7J+z66Bx1G9ROqIV3f6NcazC2J
         1aAlcOi19g3+40JYReqML+4Na6zao0hbDOuwPLuJOxE21G09HBX4NURUUsAQT0kwuxmJ
         jRXp49fkrWZrj1vdiiw4fpvT9KhO0wkQkc0qFRRPc1unFRd5WVI8au+G4fB1WfjINGMk
         8g0EYyA6Lk+gQjvaVeA7Lp3ge1Sp3nVWr/Z0Iky4jR8rBpiUBEj0dp/m2JRR40qwZxXB
         Ffew==
X-Gm-Message-State: AOJu0YxkQnDui5zcP7yU+SAosnP0hrVbM2HkHKUSwJeFP+eqc4J+nfZl
	cKR8vMj9Nrh8pJVwuSpm2d6tDg9XiMK3VHNqSCc/tZOjqSWvNmJhcWNrU0iUCfQQWw==
X-Gm-Gg: AeBDietfjaZXKyEjiIP9XNUhMw4Ej5qTIMW99rGHccloObWA8JJlmEBeMMaqCXFwzv6
	BFGSsh6UWI171v71ujnOAcS3kGfNt/elxrmjhOTV8ChN9bU0OtBhncq/hN8hN+pNs5KqcqXVqbP
	c3adXg56AArxiEQI2JhyJuEbUVhhKdZ3/J3B4lGDARdCNvx6ARp77eJVgccs/QKZ9lvgszWkcZZ
	8qWsuw6hrwjivRlrSIwq8+qD2S7gM0jpk2damT5F4gDd50FyXz6rPtVLlNN3kHTV/cmT48lySfN
	FgU1Tp4h8uu02MRnqVZbsrfrLwEwrz5+oV0ZN0ALhrEQxvfWs+ZRL0rzMK8ORt/wUgdfyNxLEUw
	zAkE8RgaDVWSBrb2ybAMsNtWGAEsPTII4CozXp9GMqj/jP/0KLdP50HFckJdeqxAWNhjfMwzWDh
	mC4+F+5A1sv8z8yQ==
X-Received: by 2002:a05:600c:46d0:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-488d689dbfcmr327948095e9.30.1776291793932;
        Wed, 15 Apr 2026 15:23:13 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm8662959f8f.20.2026.04.15.15.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] wifi: rsi: fix infinite loop when firmware sends zero-length packet
Date: Wed, 15 Apr 2026 22:23:07 +0000
Message-ID: <20260415222307.1537309-6-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222307.1537309-1-tristmd@gmail.com>
References: <20260415222307.1537309-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34824-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 5AE74408972
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

rsi_read_pkt() reads actual_length from the frame descriptor as a u16.
When the firmware returns actual_length == 0, the loop's index and
rcv_pkt_len counters never change, creating an infinite kernel loop.

Check for zero actual_length immediately after reading it from the
descriptor and bail out if invalid.

Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/rsi/rsi_91x_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -168,6 +168,9 @@ int rsi_read_pkt(struct rsi_common *common, u8 *rx_pkt, s32 rcv_pkt_len)
 	do {
 		frame_desc = &rx_pkt[index];
 		actual_length = *(u16 *)&frame_desc[0];
+		if (!actual_length)
+			goto fail;
+
 		offset = *(u16 *)&frame_desc[2];
 		if (!rcv_pkt_len && offset >
 			RSI_MAX_RX_USB_PKT_SIZE - FRAME_DESC_SZ)
--
2.43.0


