Return-Path: <linux-wireless+bounces-37448-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zSuULBW4I2qixQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37448-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 08:03:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE564CA9D
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 08:03:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="RwAHXG/C";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37448-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37448-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE366300E333
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAAD262FF8;
	Sat,  6 Jun 2026 06:02:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA61D5CFB
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 06:02:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780725776; cv=pass; b=gFc83OZMJ0qF+YBABQbO7zVrkCn1t6cJFFE2AkodmS25XQ7BglnMx8QELmR7fNykYUy8N4oIqbGcgmuW8sWAGj7D47XW6gZzlwmq2ihP0Zw6Hn8VLP3n6zOYOvMLMjr+vmAcD1kMK+Am3BxTZmLjjBQ+txEKHEamgJVzeedBl40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780725776; c=relaxed/simple;
	bh=3fKqA2z7A4gqOX3PDriOZIyYVbZt8sUe+A0GlXQWn5U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XUhh07WFvaelafhRLmA9T52Dx/yjU1Ucqlw2doo5gDXHiGTJvpX9bchmMNJogz+eYjCPDmaUDhaw51/ESfWl71EeNpBQyreuvDfNJ5BWcS8urKPPw5Gr/Hn0ZFpSgMhbsXYJ3FsLB8MXBSWLlDt2IUe6r+pxLazAhOCTz3Gjbr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwAHXG/C; arc=pass smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1370417c01cso3734358c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2026 23:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780725774; cv=none;
        d=google.com; s=arc-20240605;
        b=RqU4cg3zNJzrTNSX5joHfmdJN9ALiqVZYV+U5mdQsT8bnzjmWLtdV80A85YsqHJogk
         IxMtit792UghPst6tGXS1Dv+SmFzid7LbHw3g8QEsf/E+z22wEYA+xlCv/QhuF0xMGjY
         2yu5zrN66yrLkNoxTc7NnKLXhTSbo3sTYhZeiBX4fILkQTRqZPfGBFgPf8QtQKBVjDO6
         9JeXpSSGfYcGAiRdo5qXuGg9/kf9x7P/dy/mQrZLW24NY617lExAdlA29oYt2f5YSvUh
         GhikQv59ZkSZyKy+9DF5AtFnWA4/sCPFJPVDcw2b7Bkz9dbIYobJUrXijroE3OD9DFsJ
         7pZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=j6onadKO2fgtpaiH1OdJ7P6FTRMuLxhIoqVI35Kfww8=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=EqJLPDGQuArHaakGYCi++OjuZCS5lN6dFch+cIJ9ZiUQbBjVJjcY1JJ0XAeu8ZfXcY
         DMm+OudoI7UB279aZkcX+dZDGemLBWA4Glt8QiIWEeoaJlp56HtAeL0iOlS/Cp7DP4i4
         +T+b2RZ5SefIujw1EVJ8H8LBiykghjD2n32sWXfW9t9hSBcg+d94uxUIQZwjyitGoPeL
         vRhjisf/O476r+MOm8RAwYZuGximZQKV0Rcf7kAYkznjQWwSHb0JkKL98e0uiHyYZZ3G
         iKaMk3K16i547X9BVEkL+MY0GMTcGyuq0OjGY2AIVhu0DqmND1Yy+iFf5xbmSvPHQygH
         vGhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780725774; x=1781330574; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j6onadKO2fgtpaiH1OdJ7P6FTRMuLxhIoqVI35Kfww8=;
        b=RwAHXG/CKyJOmHMAbvInkLMwRILFP/lSGE6kk72VijEGmxB9zFN5dNe1rPquT2cjnE
         lpETcWXS9YfQ52A4zlJAvxZBaKFjS6EaSYwbHT+NrjVBt/C9PdbYYrUoDglqDvmdZG8o
         gtRspZt2pXojEgbnPfRHYiU12lJNTJ8ISnr2un8/YWNVBsJuBtzNp8IjJH1g3WlMEdLJ
         Ts1k9wL2bTH0grK2+mvMzYUZfYdVICWjW9P0NlEqqBHFrC9RvomZ/WWEUtZkBs+yGlt2
         Y1MHfp9PUCkyWkbV84qO+3UVet1Cl023LHcikGnCmOztbJS8SepiuUJTUKHrIdLQiWLT
         j3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780725774; x=1781330574;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6onadKO2fgtpaiH1OdJ7P6FTRMuLxhIoqVI35Kfww8=;
        b=rQXB9Om+5AMoyu/tgk7qgor1O62IJULi5DAIrtsoBSyIdgqPwHX+/TH9Nl9DZr21sL
         TDvrUpb7OBJAddie7uAu3bPQmtbLJ25s5JnjIx4T6LJRefOYdO6RbSunSzpwd/RrsYZG
         ONDN+yt9s8rnGDc5jKArq+8LfYAOj3gEWgswNXIj92hLPRWSCW5JDSM63nrBIuXVR7lD
         bcaLe1HsQyddmGoric12nZmMEDtlh3WypPq/WnWYKtNsfdPnUPJvbwWx9eR9opejtU7u
         gOPOxXk5hOC274aw3+74QQODdDNgn6O87x2ff+y43AvM0hIrQ6gpivP7DAJwSKs2l4p5
         +JIw==
X-Gm-Message-State: AOJu0YxE+rns3ImqZ82Wy20B9yEjmbMEmwjL4Y2G+/TAje0KJVFYTJ67
	7Um3bizQKXmKFeDrchmrKw32lh1x9CBknkvfR5I8GJxYVxap3Z72q1vjxFWCtvu17oeFcbbCVu8
	vh/Drt0TbVqRKMb6WTHnU7fCYSJ1L3ZwDRm+w
X-Gm-Gg: Acq92OFRIh/sQpjgwDRFOaonNXdgr6RTPPaUv6TYvdZ0WY85zzcZkVacrJGh/qYj6qo
	8yqDHAjjHjguvTidr6AwwMA1iZNclHxjkW4LlpL+ZDy9yViBlOuMnYBNBBGHdn1MGNdcKbxMjgu
	33jA7lpUoC9Qhhfrj1K0kCIXCTX0KoReQeGbGeQwFzbcQ8rWy+MCEsImCdnSZ7D2+SExMsl6yIA
	MEBTmV5mJB5gPA1WfEjt2NeUnBq+ovAOnaX5l1/4z/zUGZsT55pdlveIi3i2RoiLd50K6uHYvcR
	l7KITleprFKswXOqfUE5yeswkTa0dlF/Eeobk5RXSsueF6cVtb8=
X-Received: by 2002:a05:7022:419e:b0:137:4061:8cc2 with SMTP id
 a92af1059eb24-1380670e1f3mr3541837c88.35.1780725774467; Fri, 05 Jun 2026
 23:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Armando Torres <armando.j.tor@gmail.com>
Date: Sat, 6 Jun 2026 02:02:43 -0400
X-Gm-Features: AVVi8CfHcYGJqZx7J0r9_A0FhHoybfqp8QsBWMLTHNoamxxjme8ZcoWbPaZPxVk
Message-ID: <CABL2O_yyUvY42EVRV1X213vH1WPe086DJp7ie02ofXoY2wSFjw@mail.gmail.com>
Subject: mac80211: fix HT MCS verification to ignore multi-stream basic rates
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37448-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[armandojtor@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armandojtor@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8AE564CA9D

Hello,

mac80211 currently fails HT association if the AP marks any MCS rates
as basic that the STA doesn't support. Some APs (observed with a
Netgear CGM4331COM/Xfinity gateway) mark
3-stream MCS rates (basic_set byte 2 = 0xff) as required, even though
the 802.11 spec does not mandate that all clients support multi-stream
rates.

This causes Intel BE200 cards (2-stream only) to fall back to legacy
54 Mbps mode instead of negotiating HT/VHT/HE, even though the AP
and card are fully capable.

Fix by only verifying single-stream (byte 0) basic MCS rates, which
are the only ones truly mandatory for basic interoperability.

Tested with:
- Intel Wi-Fi 7 BE200 (iwlmld driver, firmware 103)
- Netgear CGM4331COM gateway (Xfinity)
- Linux 6.17.0-1025-oem

Before: width: 20 MHz (no HT), rx bitrate: 54 Mbps
After:  width: 80 MHz, rx bitrate: 680 Mbps (HE/Wi-Fi 6)

Signed-off-by: Armando Torres <armando.j.tor@gmail.com>
---
 net/mac80211/mlme.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff net/mac80211/mlme.c.bak net/mac80211/mlme.c
522d521
< ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
535,540c534,539
< /* Simply check that all basic rates are in the STA RX mask */
< for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++) {
< if ((ht_op->basic_set[i] & sta_ht_cap.mcs.rx_mask[i]) !=
<    ht_op->basic_set[i])
< return false;
< }
---
> /* Check that single-stream basic rates are supported (byte 0 only).
> * Ignore multi-stream requirements as client may not support them.
> */
> if ((ht_op->basic_set[0] & sta_ht_cap.mcs.rx_mask[0]) !=
>    ht_op->basic_set[0])
> return false;

