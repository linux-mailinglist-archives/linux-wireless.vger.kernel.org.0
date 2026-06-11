Return-Path: <linux-wireless+bounces-37683-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TErGFZAoK2pq3QMAu9opvQ
	(envelope-from <linux-wireless+bounces-37683-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 23:28:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B94C567570C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 23:28:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QxKLmXbz;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37683-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37683-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E556313278A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 21:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379337FF6D;
	Thu, 11 Jun 2026 21:28:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817E37CD45
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 21:28:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213325; cv=pass; b=hiD/8o9UVonPmj6uRu3oWflFuSuvpgIh9wkwHWs7XNHQhFEYpYgYTHAtZrNEEqBDS2yKEBqcStgWiXqI6FqmVEcWh2aMu5J6lYhf8RaDOK4eNw0RKMS+qrf2OhYwMNdEN4Xmzybk4JawP/dyUg73HM/bVqb4yMHCZnjjwqXeWP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213325; c=relaxed/simple;
	bh=JG0UY0hvctnnEYPQF9ZNiBocNFE2TPO4VyqhkwRG92g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9JWfsWxgTCsJTxH5hJ/C0e/vVxqR/4xKHZdXm1yReFziPQAgF2FoOJhIPfl6cUODrEaqOUMDqLLLmRKjcGOm15j1l76DHzGgjZW/7MVbbywtWTFRAm0z8EXsg+3LcDhP5u0hMuqrkgDjVP/EkuX/c6SPwaZirurG0rGA/tpXKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxKLmXbz; arc=pass smtp.client-ip=209.85.208.173
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39676d82b7fso2976661fa.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 14:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781213322; cv=none;
        d=google.com; s=arc-20240605;
        b=YIU8NbDRKGrTzikOXX9in9It0kBmHxQjyrVK3tZ4m4m3FjtKk4fA83cUeYc7Z02w7H
         R4TW3aKFYBjPbXTwcnq9tI/l96CA9LZBn3yAI03pGzSKLWPzpAkWKcgLXqUnT/ZkcKPm
         cRydpf71GgnFIHyqkd0Jo3sQUukTmuSZNQbN5qt2z3xrNqLr6qtdv8cw3AMoWi55i9tQ
         AKPpouXIZn7FdQfwkBdyYjpW5GI5ktRxTOS4APQtUlKLWP2k6KmGlKowCrhEX7X3M2CZ
         aIT+Ly9aV2p1ce80kCDFcOtctTfBhlXl9EGc6Ycd6nUJvSU15TobAqzxnTD917/C0N7P
         ceWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kSiS9b/TUc41z1o4dQeNRT9cctSComdBL7vLtn1IdDE=;
        fh=JT1JipfLyZkpr0ZyOU5787oqgL7gKLmxQLkEUEvzHS4=;
        b=lE5JGR3iVNIIOattqqqjR6WBbDGup0WdJFrjTG7bfDkhkeTTD0Qao18LMtJN14SFBa
         4SGlxUyBZXbJYKBfE2a6i0yv9eMQmOEn/CDhmOWw1ET2GL2T7WMj6TTgxyftnM+hmgM1
         npr0+EJZag0Y/+5H3LjNK07bZ2qSIfIaEj4+4chsSkM/gwK4ZQYWyKoR2Ppj/xLVZUZv
         jJovNf6z+P3Z6phfGKbfCndQuKyW/158k7wotAQaSaHGFXdrT0SpghqOCHWThm/vuE8s
         lBPxIBtyznAXF96le1o2+L3UNoOvnjL+TECZA31+NSJ4gTL2pt3P5XGF0Ymz5jidiJNE
         l3Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781213322; x=1781818122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSiS9b/TUc41z1o4dQeNRT9cctSComdBL7vLtn1IdDE=;
        b=QxKLmXbzSrkfMbSN7IcFxO/glPZNelMpCBHTyFR/1Qx9lK0WYKcQTHifBw4NuJ29r+
         dlbIe4A/VwmiMmYc2PX6SmZp/4520tClKBuvInjVtTkKGAmjZrtuZLnRvX9J+rF6uF1w
         8c0AoR2gdrmjzSvgmu/++jpXZKnhdr2GXGATaI5anogSch/t5UVAp1lB088kZAmhCvhf
         qqLSjZBpdCO7NuAnQxVvhys4HF1ZfVljnx+hAzD3wpNnujQIgGK0WPepKXNmkBeAtbll
         xW9801Er2jeIp9X2DsG7PE7YX9+u7wy6nVqCdLEOOULI/2fyuKabIAvcvE3HLg56n+c5
         bnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213322; x=1781818122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSiS9b/TUc41z1o4dQeNRT9cctSComdBL7vLtn1IdDE=;
        b=NfLquh4CIjql9aUF5fcQZIsHgKxmu0MWNKtv3WBmFsfwHQNR5gRw6MLO4bHSJGcsyt
         T39ls2xL4nFSxu0yrkzZICLa0ARreiX0LKAddlUnPBLsyADdRKFUEZHVR77Tvb7oZ664
         y65/j+2UkiuHRF82sqxceUWBwjXfHznYQyT+/Xqu3CtwS8icReNgUqiOzMuDVvmthCHu
         EsE3KvyC3eQkAEcPNZ70OTn/C7mkUmHYf6vbPiolmAtQCqlBf8xM3IV1Uj6Fnt/2luG2
         jhlrFFfvyb68zaQi4cgRljDPFvnKn/ztATxlS0HwWlvO1KHSLNYMTG4/5un25TzVtRvt
         N+Kg==
X-Gm-Message-State: AOJu0Yys2rKK0w9XKxf7IApTbY3iDF/cOALUAwIchws4uXZpSDZtxDs8
	whfkqx6PfUlC1PbJlQCoPjIOj9s8dr6PO5Jbe9xVmXm8e6RJWJRT24k/bsrREA9b374uHow59lb
	SfcEzRuoeHu4TctJveC9Tip1RPRed8Ho=
X-Gm-Gg: Acq92OGSk8zDrzj5mAahxYC/sWhyDBgVY6NgDxXh7sFQJlZtz5FrKCuqIkM2x/W//8v
	ZdrOQCHCMopXxRuylzlaolnIijmnGAc+9ZnbWCCDGk03Bik+tYrpk/Yk9WFh92ZT/8h0c2Crp5o
	tmHjZ+XG8JiEqFCCho6mbK7NUgI6pGJUvgkJmysxOhMY9Godl/YWlb7PdK7y06ZBvxkeB7anvD8
	6xFFnyDhqZls8qUh+ggz6Z3nYkbCLX6dlseMzBO+gGmYGFK9Hph9mGeJqhU1jGcivKsnv3njTJw
	pSePTsQV
X-Received: by 2002:a05:651c:2107:b0:38e:d3ec:4f87 with SMTP id
 38308e7fff4ca-3992b27b888mr126891fa.21.1781213322252; Thu, 11 Jun 2026
 14:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611151848.2573316-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260611151848.2573316-1-runyu.xiao@seu.edu.cn>
From: Steve deRosier <derosier@gmail.com>
Date: Thu, 11 Jun 2026 14:28:04 -0700
X-Gm-Features: AVVi8CcdEwJqkM5Tqp2QM09ml7ba32VLHw3QbyaKpzeUkeRS1S1Zxfwfe-iE90c
Message-ID: <CALLGbRKs0ETDKNQXyCEJniGMj3htJgYmNn55_upcwjvS+0poyg@mail.gmail.com>
Subject: Re: [PATCH] wifi: libertas_tf: kill shared URB before resubmitting it
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: linux-wireless@vger.kernel.org, libertas-dev@lists.infradead.org, 
	linville@tuxdriver.com, luisca@cozybit.com, linux-kernel@vger.kernel.org, 
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37683-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:linux-wireless@vger.kernel.org,m:libertas-dev@lists.infradead.org,m:linville@tuxdriver.com,m:luisca@cozybit.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[derosier@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derosier@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B94C567570C

On Thu, Jun 11, 2026 at 8:19=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> libertas_tf's usb_tx_block() reuses a shared send URB and immediately
> does usb_fill_bulk_urb() plus usb_submit_urb() on it. Depending on the
> caller, that shared carrier is either cardp->tx_urb or cardp->cmd_urb.
> There is no patch-local usb_kill_urb() before reuse, and the file-local
> completion path provides no busy flag, completion, or other ownership
> handoff that would make active reuse safe.
>
> A running system can reach this through if_usb_host_to_card() for normal
> data or command traffic, if_usb_issue_boot_command() for firmware boot
> commands, and if_usb_send_fw_pkt() for firmware download packets. Those
> paths all feed back into the same helper, so a second submission can
> refill and resubmit an URB while the previous transfer is still active.
>
> The issue was found by our static analysis tool and manually audited on
> Linux v6.18.21. It was further validated with a focused QEMU no-device KC=
SAN
> harness, which reproduced active reuse of both shared carriers:
> cardp->tx_urb through if_usb_host_to_card(), and cardp->cmd_urb through
> if_usb_issue_boot_command() and if_usb_send_fw_pkt().
>
> Call usb_kill_urb(urb) after selecting the shared target URB and before
> refilling it, so both tx_urb and cmd_urb are quiesced before reuse.
>
> Fixes: c305a19a0d0a ("libertas_tf: usb specific functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/net/wireless/marvell/libertas_tf/if_usb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/=
net/wireless/marvell/libertas_tf/if_usb.c
> index 5662a244f82a..7542956d3c47 100644
> --- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
> +++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
> @@ -387,6 +387,8 @@ static int usb_tx_block(struct if_usb_card *cardp, ui=
nt8_t *payload,
>         else
>                 urb =3D cardp->cmd_urb;
>
> +       usb_kill_urb(urb);
> +
>         usb_fill_bulk_urb(urb, cardp->udev,
>                           usb_sndbulkpipe(cardp->udev,
>                                           cardp->ep_out),
> --
> 2.34.1

So, If I'm reading this right, you've basically compile checked and
such on this, but you haven't actually tried this on real hardware. If
you had, you'd have noticed it splats all over the place.
`usb_kill_urb()` can not be called from within an atomic context and 3
of the 5 contexts where this is called are atomic.

You've gone and fixed a very unlikely but theoretical race condition
in a way that causes actual real damage.

This is targeting an old Marvell 8388 which is a 802.11b/g chip. With
a custom thin-firmware created by Cozybit for OLPC and AFAIK only ever
used on those units. While I appreciate the "fix it for sake of
correctness" (if indeed this would fix it, which clearly it doesn't),
I'm not sure what the value proposition is for fixing something that
basically isn't used anymore.

Anyway, this is a hard NACK.

- Steve

