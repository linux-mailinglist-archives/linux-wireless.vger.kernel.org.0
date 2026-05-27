Return-Path: <linux-wireless+bounces-36975-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ksuOI6JFmounQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36975-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 08:05:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 275565DFA6A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 08:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95AF53030B04
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AB8199FB0;
	Wed, 27 May 2026 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+ifHbzU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3928371
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861900; cv=none; b=KB+v8vkYHJdKavPMdWtHYFH7lgLlRUqfyCOPcyaaZc2G6shPo1Jv0d1cuMayOYQAESGeMhBeqzzR/hRmhLy8y8Z5ZXHhEfWkZotl0yBPrKz/F2E9XxAGlPPk3eK2OociwPIbFUpjOho/m/A/cKRLyiAeA0HKFbzTjUfmYm8wCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861900; c=relaxed/simple;
	bh=44dQ0Q0TXtC8v4rQyhZChD2//RdSKE5Oy1yNpvzYbRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOU441U4tm6QH1zRwMw4rx2Gi9CMC2oxwg4y7IVB0l5liRLnLTHZpSgls3wtL7NOXRIiJTJBpe2FiQakPCs0hSklY+GUUnaun5m5DBzv7WN4M5pmOttamf6O1CblnyaefCwqir7ZJfFH0R1vVJspIA+CHKuGFR0jZMzL4apaW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+ifHbzU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD991F00A3A
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 06:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779861898;
	bh=vU21y0SHIUC3cwSTRp3cyIqWh6U++lSJj5SFMbybo8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=S+ifHbzUmIOr+lzuAsL76dhOFNLokxqTns3dnCJjYZaUJyNrTYZhHW2pMvCK30hBx
	 AD2Gr6o+9qQeYAK30TgQUY+t009I/8Jj+JUzb5giAiLSUFYviHET/KjG4rk4hy+uhv
	 QB6kKh9sPbI6Yt99aJnky8tiHG6VydaWHdZA0PFDu0IQuc62yOSEV9sTQR4t2fZnir
	 iyFZGRgt9KyPoOfOg/c4s+K0YyPBqv5JD5FYehmUUekPj+GYIVkz6AwfrmUrU+qMGN
	 oYs07bPW9pnPDaMhQv5cWJM7b258L8Z4gmTXltdQfXyLE4khPZdDVlcBeBhvYPUbLd
	 cgSBNruWdyRjA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a40502e63bso11359671e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 23:04:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Cw+rYdPdn30JE8M6L5qTb/eZQhMFfABPiWhnaZZyhS0JzUFSzScgxSYUeIzKEPSpJ5O5oJ9Jv/Gfp7Y5pxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9sVhDVd5gu8evIK/ggwFIQHIIeI69FGE/okukLUTYK6/OSITl
	jW8lg2oXehCMyUsKxRK2wBxSDA/Y3XehtbRBwPoBY6b2f0xBXg9nD0g6Z28BqjDWgpy4a3FRpCl
	paXf0lXYKnGcVwXpvoJSuf4BvFlxeNvs=
X-Received: by 2002:a05:6512:114c:b0:5a8:ee4b:7011 with SMTP id
 2adb3069b0e04-5aa323707efmr7257719e87.17.1779861897086; Tue, 26 May 2026
 23:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326190346.415226-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260326190346.415226-1-lucid_duck@justthetip.ca>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 27 May 2026 01:04:45 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzo4p6=a1rjpGrNPb8Ttk8R25e0WAgP-D_mNEFfytfW6Tg@mail.gmail.com>
X-Gm-Features: AVHnY4ITbiyF4hU0cSqL4c0GJRlAxhTxxdLEs7nBxxlGfRFFyanpVtA0JdWqcLE
Message-ID: <CAGp9Lzo4p6=a1rjpGrNPb8Ttk8R25e0WAgP-D_mNEFfytfW6Tg@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: mt76: mt7925: add Netgear A8500 USB
 device ID
To: Lucid Duck <lucid_duck@justthetip.ca>
Cc: nbd@nbd.name, lorenzo.bianconi@redhat.com, sean.wang@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	morrownr@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[nbd.name,redhat.com,mediatek.com,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36975-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 275565DFA6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Devin,

On Thu, Mar 26, 2026 at 2:07=E2=80=AFPM Lucid Duck <lucid_duck@justthetip.c=
a> wrote:
>
> Add USB device ID for the Netgear A8500 (0846:9050) which uses
> the mt7925 chipset.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>

Sorry for the late reply.

I ran checkpatch.pl on the patch and got the following warning:

WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:'=
 tag?

Could you please send a v2 that drops the Cc: stable tag and uses:
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>

to keep it consistent with the other patches you sent?

Thanks.

> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/usb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/usb.c
> index d9968f038..e44f0cafd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
> @@ -12,6 +12,9 @@
>  static const struct usb_device_id mt7925u_device_table[] =3D {
>         { USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7925, 0xff, 0xff, 0xff)=
,
>                 .driver_info =3D (kernel_ulong_t)MT7925_FIRMWARE_WM },
> +       /* Netgear, Inc. A8500 */
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9050, 0xff, 0xff, 0xff)=
,
> +               .driver_info =3D (kernel_ulong_t)MT7925_FIRMWARE_WM },
>         /* Netgear, Inc. A9000 */
>         { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9072, 0xff, 0xff, 0xff)=
,
>                 .driver_info =3D (kernel_ulong_t)MT7925_FIRMWARE_WM },
> --
> 2.53.0
>
>

