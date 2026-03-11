Return-Path: <linux-wireless+bounces-32994-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LC+N1+xsWmXEgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32994-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 19:15:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D926879E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 19:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D63D3055547
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18333285CB3;
	Wed, 11 Mar 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/SwQrum"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DE3E866C
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252944; cv=pass; b=YzdDm27SqkxTItleVuYw+XFzTWm1By3DBNuyr5c04oG8y6IB9SzCmMLuaIMq0pwBcjbDv5Br4V0s8A0nP+Qouu7fZPwarAUiND94GSSvQ9NB+PZeO2jfy76ht7sTE5YF9aijscw2rm5/N6N40govycf2JZYjAQZDasTSAuWG4/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252944; c=relaxed/simple;
	bh=OVfOqi9kmHjE2GGS+gx2YQEZfTRNSPhoTo4MN0cMJUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0uGzTstub9FxdXcKDx/ZEU6zLVcqRRtZtEv7qRS4Aovl5Tq+3T12kYZRLriRkNI92+qDQJ087fLTvNIRdAy3YrTWxUwHYeoYxcrn6ufntodYvJ7BCGsG6n8V9V4PPg0iEjTL2kRnQtkFySVznHDQjP8zhRPyhWuxtsK4YP02VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/SwQrum; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79902e1fb71so1599937b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 11:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773252941; cv=none;
        d=google.com; s=arc-20240605;
        b=Cj2joCKLM47i7L38qFTwXj9oUXARPA/31JYMP97Nr1nNRv5DSNn0OO/gYxgHDk8vv5
         iOSWpyEK6GFAMZafG9bmE2fc5wEy1q5pDWuLlhxEizjGc/FkqbBoRQEmXy8SrsVpDJuc
         tGY9xaLARWPBehzTY5PIKniFdCXX+VWR/JoYeCdhmGvQDo0xPHLHUZkVN1yRf7a8LMdo
         N0lU5FuvjmheJOQFAo0Gv3Kjnuk6ACqf6DFpmPJWRgPdJeFPEzfXhu8b26zci8bnkToT
         rVQPhB67AUkm+uTsX96UWgMsl/MqjkEpXf5X/n/AkjynkSv7VNI8iWCPStf2EmvBOmCl
         H44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+cNiHFT+wY3afaQYyIxR6Q/+q0rxmvPgYN7lz3CIl1c=;
        fh=6hLpx8xQB6+L5tWvaEQc0xLs5kzhJv7zFpI+oc19LLk=;
        b=gLK/PnWr/qsZF/zp6Fx2kkYeTp3ePaDrKfzy86Rj3rRlB/fS4ko25qHamsyjTUbele
         3zTjyPG0F3RW8+Xx875WequY8Daqh0Z10jDqYYt/iN+JrIPRbNxtOgtfWzcw3Az4xUKC
         AOi+qsoGQZDDS10uDjtHpCxUeY8r39cVkkQF+D0A0JWvYCaDA8JKMsCFposZsxJXADnZ
         +uio/nl2qfZvfLfSBf90Uwh9p1K1FR0V1QQsiQdxLipS4Vptj0yYOJbyoVBbdQXN3E4H
         YsdYxRZN/CSq1eLHk1ZElLDdBnQFwlH4Qff9fnRRNXsY1ZOmwgarCZzf18kEwMvGj958
         e6mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773252941; x=1773857741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cNiHFT+wY3afaQYyIxR6Q/+q0rxmvPgYN7lz3CIl1c=;
        b=T/SwQrummYHFMUy1M13JiU3aO0R5+hIAqNeesCmge8ibgqLvJDzlHv4AVwITg3AEuh
         5kRvva3QzgX7w69FyDH4SrwXGBq1ABmpDuAa/m1yL1QzrXaqtWq+/2u26AFK9xPIYugz
         MnLK4qADtbz+SUEAI6ijE49bzf5gq/WR/FqPtHldenyM30WinpDS9loRWN1PnKvgvdKI
         Qhh+wm18Zmub97KOBb9MX0iMHFa5VgdKdVREzWxgAP/LOkS48lgMpYaScLGeR4FDb4rg
         LYVzx/8F5kDmdeYxVPACCe5Ijr/oRBBYj5wAPWe4qEabJpcu4XJylMyCAu+WdMPPPUv7
         43YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773252941; x=1773857741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cNiHFT+wY3afaQYyIxR6Q/+q0rxmvPgYN7lz3CIl1c=;
        b=ueHHz7aykxF84LSYEuO8DXbo81Kf7YleZ9/OmgcpNyS/8l6N89XE1tvSei/mxTp8HL
         yjD76vnuQcFr28Y//sTPUO53rAkAZuS+8CjPnO+OgXXkk4jwtWQ+RFGL8PRZMEHYNYDC
         qc2yFYdjvziRv4Yj5Ji+aLCAtJlfNKxmcUJBedQl3TUIjI002ojyrG/dCDBYKZYxQxhA
         bpNCGzUJ6cCFu/shqBqIKnxFaMZ/prj1pyiXrY36C6qaL7YUsSfP4hTfoWIDZfw22mqq
         QBjkgdrxKsljUOtXqzpXYGqPGYmJUi6o2Hjgpp2iuBCJNUlZ438ccbYX2P1rsAgdDkvG
         9IUw==
X-Forwarded-Encrypted: i=1; AJvYcCVjt8NQHM3BmmEcmIeJwhsKUVYGBo4C5jQAn7tbw0lXHVbMeGEmHB1Syo378WqWyAuU0vRUK4sDNWn0mwNflA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9OHCu49oNfyVBumceN/6qmYdVQirEa4tdTrJ1BnrnlXRfaqQ
	pR+LDvBD6/maCF4J5CUZMWHrdZdfFwe9T1wG950/0X3KFGGX/I9BtwrbE78XL6rn9nmEF056sWt
	3fz2ZV3CcfjL/BV/43JLCE5hBMsjS/bo+DA==
X-Gm-Gg: ATEYQzzwl/HDi5kiajWTKTKsa6CZlZbAVMncluNePq3JlVVmqboINobOSrS8r3m4u5k
	mdicc6GY/ffwSkG0VLlOgdNsjLz2st8h+EDiAb7EPn7HppbaVxTqt8gZzB6ASvtnv9TtlcR/S5G
	ZA9MgEl8McTcpOhzkYOp8b7z/H+CqN5bH243QpqIHnJK38un3QfjuCh8hozjB4G/xuv8O3XM0+n
	ikC4FNOrWiy1udBkOljVHojgv/FqXpCA119+CNDsx9ZtERA54iw8t5OojpK7n/3YtX9RYK7cLgf
	1QOOlry1M8jnTGtKMdA1Wv6pylQHzZ+aqGf14NHqaPp2SEd/suTPCrKgr7mOr1lG4cviZX104qY
	Qyd8LKUapZoNtSItuGg0/wVj5IhnZUqLf4rc4wUtMH3UTQfU1nl0eXtHtSXqhA8gkx5gWnTyrZ3
	5Y+OKulP3/RQlbtoyJsL/5H1D1WvtN//Vk3g==
X-Received: by 2002:a05:690c:6d83:b0:799:1f23:6e46 with SMTP id
 00721157ae682-7991f23716bmr18872717b3.33.1773252940653; Wed, 11 Mar 2026
 11:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311002825.15502-1-sean.wang@kernel.org> <20260311002825.15502-2-sean.wang@kernel.org>
 <CAFktD2cbFJrLS4ggc+yf582BYmw=jJsntfbDR65ssMpVGM2BKA@mail.gmail.com> <CAFrh3J-PsVQ1u_hGFxTVKK0uOs6KxT=euK+jbGvWCueqvynAgw@mail.gmail.com>
In-Reply-To: <CAFrh3J-PsVQ1u_hGFxTVKK0uOs6KxT=euK+jbGvWCueqvynAgw@mail.gmail.com>
From: Satadru Pramanik <satadru@gmail.com>
Date: Wed, 11 Mar 2026 14:15:29 -0400
X-Gm-Features: AaiRm53p8hfe8wBrpyGcXoM78Zv_gF9F9NSxVY9UXwSZNnh9JUTRTDRcyeNi0YQ
Message-ID: <CAFrh3J_4N5j9eZAgbP0gzj5gTGVABat9-4xWZBicKMfgL85LRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
To: Nick <morrownr@gmail.com>
Cc: Sean Wang <sean.wang@kernel.org>, nbd@nbd.name, lorenzo.bianconi@redhat.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Sean Wang <sean.wang@mediatek.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32994-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satadru@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 622D926879E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After rebuilding the kernel with 7.0-rc3 and the two patches at
https://patchwork.kernel.org/project/linux-wireless/list/?series=3D1064695,
I can confirm that after a warm reboot booted from that kernel, the
mt7925u-based adapter is once again visible.

Thanks!

Regards,

Satadru Pramanik



On Wed, Mar 11, 2026 at 12:42=E2=80=AFPM Satadru Pramanik <satadru@gmail.co=
m> wrote:
>
> Hello all, I'm rebuilding this kernel one more time in case I mispatched,=
 and will let you know shortly if a new kernel build works.
>
> Regards,
>
> Satadru
>
> On Wed, Mar 11, 2026 at 12:15=E2=80=AFPM Nick <morrownr@gmail.com> wrote:
>>
>> > From: Sean Wang <sean.wang@mediatek.com>
>> >
>> > mt7925u uses different reset/status registers from mt7921u. Reusing th=
e
>> > mt7921u register set causes the WFSYS reset to fail.
>> >
>> > Add a chip-specific descriptor in mt792xu_wfsys_reset() to select the
>> > correct registers and fix mt7925u failing to initialize after a warm
>> > reboot.
>> >
>> > Fixes: d28e1a48952e ("wifi: mt76: mt792x: introduce mt792x-usb module"=
)
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> > ---
>> >  drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  4 ++++
>> >  drivers/net/wireless/mediatek/mt76/mt792x_usb.c  | 13 ++++++++++++-
>> >  2 files changed, 16 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/driver=
s/net/wireless/mediatek/mt76/mt792x_regs.h
>> > index 7ddde9286861..d2a8b2b0df32 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
>> > +++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
>> > @@ -392,6 +392,10 @@
>> >  #define MT_CBTOP_RGU_WF_SUBSYS_RST     MT_CBTOP_RGU(0x600)
>> >  #define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
>> >
>> > +#define MT7925_CBTOP_RGU_WF_SUBSYS_RST 0x70028600
>> > +#define MT7925_WFSYS_INIT_DONE_ADDR    0x184c1604
>> > +#define MT7925_WFSYS_INIT_DONE         0x00001d1e
>> > +
>> >  #define MT_HW_BOUND                    0x70010020
>> >  #define MT_HW_CHIPID                   0x70010200
>> >  #define MT_HW_REV                      0x70010204
>> > diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers=
/net/wireless/mediatek/mt76/mt792x_usb.c
>> > index a92e872226cf..47827d1c5ccb 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
>> > @@ -224,6 +224,15 @@ static const struct mt792xu_wfsys_desc mt7921_wfs=
ys_desc =3D {
>> >         .need_status_sel =3D true,
>> >  };
>> >
>> > +static const struct mt792xu_wfsys_desc mt7925_wfsys_desc =3D {
>> > +       .rst_reg =3D MT7925_CBTOP_RGU_WF_SUBSYS_RST,
>> > +       .done_reg =3D MT7925_WFSYS_INIT_DONE_ADDR,
>> > +       .done_mask =3D U32_MAX,
>> > +       .done_val =3D MT7925_WFSYS_INIT_DONE,
>> > +       .delay_ms =3D 20,
>> > +       .need_status_sel =3D false,
>> > +};
>> > +
>> >  int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
>> >  {
>> >         int err;
>> > @@ -254,7 +263,9 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
>> >
>> >  int mt792xu_wfsys_reset(struct mt792x_dev *dev)
>> >  {
>> > -       const struct mt792xu_wfsys_desc *desc =3D &mt7921_wfsys_desc;
>> > +       const struct mt792xu_wfsys_desc *desc =3D is_mt7925(&dev->mt76=
) ?
>> > +                                               &mt7925_wfsys_desc :
>> > +                                               &mt7921_wfsys_desc;
>> >         u32 val;
>> >         int i;
>> >
>> > --
>> > 2.43.0
>> >
>>
>> Sean, testing results from: Satadru Pramanik <satadru@gmail.com>
>>
>> "The updated patches from
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D10646=
95
>> do NOT work. I get the -110 error with them on a warm reboot.
>> Reverting to the kernel with the older patch restores my adapter
>> connection on a warm reboot."
>>
>> You are welcome to stop by the Github issue where this issue is being di=
scussed:
>>
>> https://github.com/morrownr/USB-WiFi/issues/688#
>>
>> Nick

