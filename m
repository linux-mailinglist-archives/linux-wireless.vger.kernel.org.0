Return-Path: <linux-wireless+bounces-36823-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNILJvbNEGobeAYAu9opvQ
	(envelope-from <linux-wireless+bounces-36823-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 23:43:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0C5BA993
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 23:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254E83009538
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B631838BF70;
	Fri, 22 May 2026 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHxe7/ZF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB038B7A6
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486191; cv=none; b=VLGgq6ZbzkP8Qs/TJGFRgGJPHQLlf4w9STXUmxPE05V+qRydT/nmUMiW9VxGuoz3m3FzmOInLFX1AlZq4DA3ShKK52M/P4yfE5m3N5ItIe6fiKA6ZAIio29ANkUgLgqNpMUKE+VsflmVAdPtjo2l/UN1lPlPFJRo5MuY+101Q3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486191; c=relaxed/simple;
	bh=TAjKs+cCa9FfDgqgnw2Tb3FB0pdnlmBfwC3HSX/nqJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZD8PnGDiWuTD9VxYtZNDUfvaBdwVCSy1QRgvp00+MQems4A8vWhR9wFB/fnmtp8Y2X6PoscXqxse3Gr3eXmHdrGuh6weOD4oymuCGD5zNHvehIo/HSmKSCnGfH8We9//RQMFDYmjHLJEEWD9AzOrOIZErShiR1djVtceq1CVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHxe7/ZF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F1A1F0155F
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 21:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486190;
	bh=FffONThYOFDd8hqOohQgrr5jtz9AxXTVlEYZ6tX2AB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZHxe7/ZFG+hOd6DfGNNz92Bv1Hv9YY51vJVnnhv8B84+dX6jScvE8X4tCD3KxiTDD
	 SZyB+PCxBDeRazcNTKi3oFtpQzuQFnmAbEhwtC/eI0MZCF0R0+tdf8GViSVkHW62JC
	 f0F27atk/yQ/z6z6KvfMwzKsFrAYVV5nAUwEIPrxIEyOhDPQI9pM8GCO481IQzUKj7
	 dC9C95LtPFlDTYcEMfBgkGhABezL3KE97lBNM00w3S2eOH22BN0fV5GWCDveVYTObF
	 I6MjR5nCcYttDbNVAPUrPEpR7JXIDOnLfA8nZGln21cRuyexuEhpRV7H9MaG0o8Jrn
	 Wg9IQlxbQAmyw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-393c93a0166so75891441fa.2
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 14:43:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YzL682DZf+eFrQoLdk3qvZDH2G1e/xoJaEfyf9tYAKaoiddvczP
	DNGFu7+kPA1zjcErVlSAfgI0Kov1Vxi2BUcsWkZ/ZmSZjQcwEw+OIu7OYF39rhkmhngSY1X6rEX
	3+VpWwb/ZO8OPcK1WAbVupz0nDFtPJns=
X-Received: by 2002:a2e:a54e:0:b0:393:d6dd:e8a1 with SMTP id
 38308e7fff4ca-395d8ba6748mr20082661fa.2.1779486188683; Fri, 22 May 2026
 14:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agEbiurBZzZv_Yt0@wico-dev.wnam.ru> <79943c87-b920-4ef8-a471-61b03792e097@gmail.Com>
In-Reply-To: <79943c87-b920-4ef8-a471-61b03792e097@gmail.Com>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 22 May 2026 16:42:57 -0500
X-Gmail-Original-Message-ID: <CAGp9LzpW1Xo+fKOAVfpxRKg=fe-OGESbMf=nXbSoRox-gLjb8w@mail.gmail.com>
X-Gm-Features: AVHnY4KO24WKHa6nVlmG1jGJTO_gxpUXXDS4whP4AuXi5WUpy7oYieFh4__JH-M
Message-ID: <CAGp9LzpW1Xo+fKOAVfpxRKg=fe-OGESbMf=nXbSoRox-gLjb8w@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: disable rx napi before queue cleanup
To: Ruslan Isaev <legale.legale@gmail.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36823-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0FE0C5BA993
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sun, May 17, 2026 at 5:46=E2=80=AFPM Ruslan Isaev <legale.legale@gmail.c=
om> wrote:
>
> Gentle ping for review
>
> May 11, 2026 02:58:02 Ruslan Isaev <legale.legale@gmail.com>:
>
> > mt76_dma_cleanup() already disables tx napi before deleting it, but
> > it still removes rx napi instances while they can remain enabled on the
> > normal device remove path. On mt7915 this triggers a warning.
> >
> > Disable each rx napi instance before netif_napi_del() and page pool
> > destruction. This fixes repeated warnings on rmmod mt7915e on
> > mt7915e/mt7981b.
> >
> > Signed-off-by: Ruslan Isaev <legale.legale@gmail.com>
> > ---
> > drivers/net/wireless/mediatek/mt76/dma.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wir=
eless/mediatek/mt76/dma.c
> > index f8c2fe5f2..12183142f 100644
> > --- a/drivers/net/wireless/mediatek/mt76/dma.c
> > +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> > @@ -1189,6 +1189,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
> >     mt76_for_each_q_rx(dev, i) {
> >         struct mt76_queue *q =3D &dev->q_rx[i];
> >
> > +       napi_disable(&dev->napi[i]);
> >         netif_napi_del(&dev->napi[i]);
> >         mt76_dma_rx_cleanup(dev, q);

  I do not think this is safe as-is.

  1. I tested this on mt7925, and removing the module causes a machine
hang. I found that we can end up disabling NAPI twice on mt7921 and
mt7925. If we still need this patch, it
     should be fixed together with the mt7921/mt7925 cleanup paths.
  2. mt76_dma_init() skips WED RRO queues when adding RX NAPI, but
this patch disables NAPI for every allocated RX queue during cleanup.
On mt7996/mt7992 HWRRO, WED RRO queues may have
     ndesc !=3D 0, so cleanup can call napi_disable() on queues where
mt76 never added/enabled NAPI.

  Please make the cleanup path use the same condition as init, for
example by skipping NAPI operations for mt76_queue_is_wed_rro(q), or
by adding a shared helper for the init/cleanup
  condition.


> >
> > --
> > 2.39.5
>

