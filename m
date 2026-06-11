Return-Path: <linux-wireless+bounces-37674-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mrfhMGfGKmoywwMAu9opvQ
	(envelope-from <linux-wireless+bounces-37674-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 16:29:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398A9672B88
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 16:29:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=toke.dk (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37674-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37674-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472F5308CBF0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900243D5226;
	Thu, 11 Jun 2026 14:29:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB829C328;
	Thu, 11 Jun 2026 14:29:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188197; cv=none; b=mHzw3Yv0F0XDBoC7UGd4dU6GNz8DGx/++nz8YIGGCdSA0onh8c3v9HOzqPKYoeyjetQDWdm/5Y6SJsk9MjEsDF7tvW21XZhCFuUqA9VoSNlRH4gYMgPtDL26av1OgWBuJvlQUFLG4lhXj/xXo6oLPudrxTJ+vKVuoaC2IidnL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188197; c=relaxed/simple;
	bh=5PLKPAmVaLvUJC4z5tkbTyARHNTEluXPAGsDGR03CFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eWGuTXjcJ1QrRSkpGWNzK36KOMaxVHD+En8SNrdEF24yoc+Bnd7UTmCmD0UDN+JX/j5MqMdMj5mQ4qC6tLenmMN8+/ahn0ASWKo5OU2d1J82Rn1UvkKrdevUWyIn55rbmnpbnZ2lkTs0Kb3ibqYhevBVopYOPrLFV/ZPs7yLMdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: xiaoblac <teel4res@gmail.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Cheng
 Yongkang <teel4res@gmail.com>,
 syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com
Subject: Re: [PATCH] wifi: ath9k: hif_usb: don't dereference hif_dev after
 re-arming firmware request
In-Reply-To: <20260605153210.20471-1-1020691186@qq.com>
References: <20260605153210.20471-1-1020691186@qq.com>
Date: Thu, 11 Jun 2026 16:29:45 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87h5n98812.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.73 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[toke.dk : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37674-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:teel4res@gmail.com,m:linux@rempel-privat.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[rempel-privat.de,vger.kernel.org,googlegroups.com,gmail.com,syzkaller.appspotmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,50122cbc2874b1eb25b0];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,appspotmail.com:email,vger.kernel.org:from_smtp,toke.dk:email,toke.dk:mid,toke.dk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 398A9672B88

xiaoblac <teel4res@gmail.com> writes:

> From: Cheng Yongkang <teel4res@gmail.com>
>
> ath9k_hif_request_firmware() re-arms an asynchronous firmware load via
> request_firmware_nowait(), passing hif_dev as the completion context, and
> then still dereferences hif_dev:
>
> 	dev_info(&hif_dev->udev->dev, "ath9k_htc: Firmware %s requested\n",
> 		 hif_dev->fw_name);
>
> The re-armed callback ath9k_hif_usb_firmware_cb() runs on the "events"
> workqueue and, when the firmware is missing, walks the retry chain into
> ath9k_hif_usb_firmware_fail() -> complete_all(&hif_dev->fw_done). That
> releases the wait_for_completion(&hif_dev->fw_done) in a concurrent
> ath9k_hif_usb_disconnect(), which then kfree()s hif_dev. The trailing
> dev_info() in the frame that re-armed the request can therefore read freed
> memory (hif_dev->udev, the first field of struct hif_device_usb):
>
>   BUG: KASAN: slab-use-after-free in ath9k_hif_request_firmware
>   Read of size 8 ... by task kworker/...
>    ath9k_hif_request_firmware
>    ath9k_hif_usb_firmware_cb           drivers/net/wireless/ath/ath9k/hif=
_usb.c:1247
>    request_firmware_work_func
>   Allocated by ...:
>    ath9k_hif_usb_probe                 drivers/net/wireless/ath/ath9k/hif=
_usb.c
>   Freed by ...:
>    ath9k_hif_usb_disconnect -> kfree   drivers/net/wireless/ath/ath9k/hif=
_usb.c
>
> The fw_done barrier only makes disconnect wait for the firmware chain to
> *terminate*; it does not protect the outer ath9k_hif_request_firmware()
> frame that re-armed the request and keeps touching hif_dev afterwards.
>
> Drop the post-request dev_info(): it is the only use of hif_dev after the
> async request is armed, and it is purely informational (the dev_err() on =
the
> failure path runs only when request_firmware_nowait() did not arm a callb=
ack,
> so hif_dev is still alive there).
>
> This was first reported by syzbot as a single, non-reproduced crash that =
was
> later auto-obsoleted, and was independently rediscovered by the reFuzz fu=
zzer,
> which produced a C reproducer (USB-gadget connect/disconnect of an ath9k_=
htc
> device whose firmware download fails). The vulnerable code is unchanged a=
nd
> still present in v7.1-rc6, where the slab-use-after-free reproduces under=
 KASAN
> once the (sub-microsecond) race window is widened.
>
> Fixes: e904cf6fe230 ("ath9k_htc: introduce support for different fw versi=
ons")
> Reported-by: syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D50122cbc2874b1eb25b0
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>

Thank you for the fix!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

