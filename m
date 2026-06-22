Return-Path: <linux-wireless+bounces-37978-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JCQ9FLlLOWqTqAcAu9opvQ
	(envelope-from <linux-wireless+bounces-37978-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 16:50:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC16B0786
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 16:50:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="roF/QQ5f";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37978-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37978-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59AAC300A115
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3C2F745C;
	Mon, 22 Jun 2026 14:47:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172083033F7
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 14:47:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139655; cv=pass; b=gkJwuhgB/UiciEa70TrVcDKLP1AYlzSoViBUOB9K0frFNtai8ZCQei1UdaL/+Cns4jjRXv/6BdF4txY9GBzb8tIFhMFC1OdPeOu86VFhIvjHuNB2cUS0yXnVJIweC6MeiEM816l5TAOtrSii8/0qgYErcsJY6zK5vM/Ne2ttbWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139655; c=relaxed/simple;
	bh=cIhFMAoZIcWJjJE3XTGoxfKbK783VMx0OoH8h3QFvnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJD0SEmkWpcdhF7sgK65LqrmoREM8gzwUiBu+PcNzImThV5EAFj+pYEhcmnI15v5HAvrjsAIU03Cm4EJHdVZ5t+tQth24SS0N/RGBTPyxaxZHnJMxCfHqHlzt1uivI0qFPWp9ZjO5IZGpFX3elcaOVKlNTaMWz65pRe+LKW0JVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roF/QQ5f; arc=pass smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69775980397so3936158a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 07:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782139650; cv=none;
        d=google.com; s=arc-20240605;
        b=D+BiSEYIsrX4euIEu6y+rpZp8J7cQpl5Gjxb5LBUNZU7FgaJRriUOOLJssQfBSiqiU
         jlijJgKKSMts4dSD98oAIVtkTwZyBKHEmX+tEAlGCQ0wfU87St/NgJEqCnelUzc2V8YP
         JuHNYu1cKeY1mG3QYGMP/k6raMlWRLnk1lf92fDrBvUUWNJ2QngRZhTsovRYwGSY9IeZ
         DOTj8wPt9ZhmBPsyyr6sDknA3pmdnVxBLvKckyOE8BO6sRRNdWP48N+qabCcLSnIwp2v
         BUJ+kPVS5kOWQVzo4YD5oltnyEFSA5cMFn0OSW9icVUgFEq2zjy11DMKG8H04U5H5sCM
         NPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qHbcnzvx/9cpKl4xbjllHs2z8IgKM+rmWA0KM7paHK4=;
        fh=XJ0FIn4Np4T5Ax7PVRumpNY9xZnOGX07/9AC1YeXceI=;
        b=YThojWS5XN0sVjB5xqFEdnPBahsbvLlsoOvshAkdJOScNOBxBTdLJdXdsThhTe9Ng+
         ypzopc3/cFW41bLRnZhw3D9Tdphw24W3zKEwQu2C/sS4UmFj5VDZRu/exEyUDtDZxkd5
         YyaE6mEYmBxFpU/Jw2pk2/OqslVMuHVvQ87pU6SboRoUBEVRHtTXMEXl5g878nG5tcAz
         YQPpHi6JyhFAl2dvxBfnvrE0j6HTZhV6GNz1EGfMgU+Ev3/oRuEqR8VSd/5B+q5lCLvm
         mEmUdtkSpogXpDlep9m4p1P0wRqCtHxSXHMiwk0BBXbPn2uVSAbDMvDSVXV8u5xc3HNB
         BBvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782139650; x=1782744450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHbcnzvx/9cpKl4xbjllHs2z8IgKM+rmWA0KM7paHK4=;
        b=roF/QQ5fBBhv6K970xkOLKYrODwwqpzfqC/UMmxmEtJtyglP/hBdPrVDLqzHt3QJFx
         B8D3wGGkB9akJGfHJeVmRYw9HD1/3dzpmaOCc09CfXx8t9fTNg26jGYrjcBPe1OIr7sA
         RaqrHJlqTTDzTEDWWv56plDJ4xfBU0wSg4T3Ox1nqf1QBB97GlrenLfRlWhpLWTwaWGB
         Nm21szrS8XUDWKOFmowlg2Z0NVo9TdKx4PwuO5JlCTFVSdSvlrKuFq4vNhNpD7fxCtO5
         Njam3MXGM0thB/YBsqKr5Xq2XJNgIgioblYsrbA0Awr5ayd1L7hJ2E/vfb+MuCFoC9A7
         iaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139650; x=1782744450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qHbcnzvx/9cpKl4xbjllHs2z8IgKM+rmWA0KM7paHK4=;
        b=hJ79gEO1dBXKnfMJKH1GvkuX7wyiVyBLuNAcUxtYRY0908ESJn2An99k3/21AOtyfq
         5qqNHAPf/8Ip5OQAU0szKEBe/3gVUOLIeBBWYNanFnvWEmAESYovx2iuAOmHKjN6rjDU
         FUIt1yuFJb4KrPYuAjDDm97xuCgM8V+zzyOPyC2wIepta70WOiCOHwMp51v1sCz85k51
         ZOfJYG6X+HXlgGr/REyZR1/D7guc541y2p8h9VH4IwONPIeLy7LcAe6Py87pXT3jxIFc
         x7b9mVvVDnTF2SqVaet7c3+M9idIadWIzS0THVYPLIwIiiPWfSFee4JV/EUiHrdfROn7
         nlVw==
X-Forwarded-Encrypted: i=1; AFNElJ+JaDu4XoeJi4QeeJVQnys9v2Sqc/hk68Md+QJFCVwB3THvuyaKDIT7YrYxmw1X48FybeDhcsNKIUeOcdV4FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwClv8RAYXjY3yrxL+C3JElWUBQXe4rcwUORFWAO6TIl5fEpoP5
	/1W725F2zsq7OzD8gYyf4ikEZkFvk9O46MimsRTcNaIqlcVe7U6u57rNjvNJTfIhB0eAIIG05jm
	PBDZr/Z2y9H78A6geTyaL3lwH6zc7DlA=
X-Gm-Gg: AfdE7clyFBOMKD+Frd5ieCRJUTqr2gU1nW9uCtTBZ/xmzCj8Y3bJ7lccWsvHucraIIi
	24LGEd3ssgkyJFSJ3AkmW7Y/bA0AqBHLgp6YS7reonpUCoo5IstRLhyV66CiGxia6jGmZnMb59O
	/iylEJgy1cEg/0ZOsE+/ndBS2knPcJMvK5ScpK3O4uIFgYbngDSUjcTeCD/xYkguP3GSF9xgU5b
	a11KKneiRG8kphkjR4IgVGm812P2hi+KmjDgZoNeBbRos8m0idKncGIPYf73nZT3shZK/wN
X-Received: by 2002:a05:6402:551a:b0:681:2472:4b2d with SMTP id
 4fb4d7f45d1cf-696edc5b1afmr6155530a12.2.1782139650050; Mon, 22 Jun 2026
 07:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613173109.849-1-hujy652@gmail.com>
In-Reply-To: <20260613173109.849-1-hujy652@gmail.com>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Mon, 22 Jun 2026 22:47:18 +0800
X-Gm-Features: AVVi8Cer6FyHrG2MFFDZNl2gD33yKhTThKSHKqy9TvNIP7qrWJCYwREn7R846mg
Message-ID: <CAHGaMk_-UP4pFTFaof94CqFv4s1Z_g9mrxVJcworzvLqe20HTg@mail.gmail.com>
Subject: Re: [RFC,mt76] wifi: mt76: wed: fix kernel panic on single band MT7986
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37978-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hujy652@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hujy652@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1AC16B0786

On Sun, Jun 14, 2026 at 1:31=E2=80=AFAM Zhi-Jun You <hujy652@gmail.com> wro=
te:
>
> In mt76_wed_init_rx_buf, it's hardcoded to use MT_RXQ_MAIN.
> But for single band MT7986 MT_RXQ_BAND1 is used for RX data queue which
> leads to kernel panic when attaching WED.
>
> Use the correct RX queue by checking WED version and band_idx.
>
> v2 and band 1 -> MT_RXQ_BAND1
> Others -> MT_RXQ_MAIN
>
> Kernel panic:
>
> Unable to handle kernel access to user memory outside uaccess routines at=
 virtual address 0000000000000000
> Mem abort info:
>   ESR =3D 0x0000000096000005
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x05: level 1 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
>   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> Internal error: Oops: 0000000096000005 [#1]  SMP
> CPU: 1 UID: 0 PID: 925 Comm: kmodloader Tainted: G           O        6.1=
8.26 #0 NONE
> Tainted: [O]=3DOOT_MODULE
> Hardware name: Acer Connect Vero W6m (DT)
> pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : page_pool_alloc_frag_netmem+0x1c/0x1bc
> lr : page_pool_alloc_frag+0xc/0x34
> sp : ffffffc081dab660
> x29: ffffffc081dab660 x28: ffffffc081dabc60 x27: ffffff80091af040
> x26: 0000008000000000 x25: ffffff80091a8898 x24: ffffff80091a5440
> x23: 0000000000001000 x22: 0000000140000000 x21: ffffff80091a2040
> x20: ffffff8003f1d780 x19: 0000000000000000 x18: 0000000000000020
> x17: ffffffbfbf0ac000 x16: ffffffc080ee0000 x15: ffffff80049d47ca
> x14: 000000000000037b x13: 000000000000037b x12: 0000000000000001
> x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> x8 : ffffff8003f1d7c0 x7 : 0000000000000000 x6 : ffffff8003f1d780
> x5 : 0000000000000680 x4 : 0000000000000000 x3 : 0000000000002824
> x2 : 0000000000000000 x1 : ffffffc081dab71c x0 : 0000000000000000
> Call trace:
>  page_pool_alloc_frag_netmem+0x1c/0x1bc (P)
>  page_pool_alloc_frag+0xc/0x34
>  mt76_wed_init_rx_buf+0xf8/0x2ac [mt76]
>  mtk_wed_start+0x79c/0x12ac
>  mt7915_dma_start+0x274/0x63c [mt7915e]
>  mt7915_dma_start+0x5b4/0x63c [mt7915e]
>  mt7915_dma_init+0x49c/0x81c [mt7915e]
>  mt7915_register_device+0x24c/0x530 [mt7915e]
>  mt7915_mmio_probe+0x91c/0x1980 [mt7915e]
>  platform_probe+0x58/0xa0
>  really_probe+0xb8/0x2a8
>  __driver_probe_device+0x74/0x118
>  driver_probe_device+0x3c/0xe0
>  __driver_attach+0x88/0x154
>  bus_for_each_dev+0x60/0xb0
>  driver_attach+0x20/0x28
>  bus_add_driver+0xdc/0x200
>  driver_register+0x64/0x118
>  __platform_driver_register+0x20/0x30
>  init_module+0x74/0x1000 [mt7915e]
>  do_one_initcall+0x4c/0x1f8
>  do_init_module+0x50/0x210
>  load_module+0x15f8/0x1b10
>  __do_sys_init_module+0x1a8/0x260
>  __arm64_sys_init_module+0x18/0x20
>  invoke_syscall.constprop.0+0x4c/0xd0
>  do_el0_svc+0x3c/0xd0
>  el0_svc+0x18/0x60
>  el0t_64_sync_handler+0x98/0xdc
>  el0t_64_sync+0x158/0x15c
> Code: aa0003f3 a9025bf5 a90363f7 d2820017 (b9400000)
>
> Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> ---
> Hi maintainers,
>
> I am trying to fix WED on a MT7986 + MT7916 board.
> With this patch applied, WED loads without kernel panic.
> Client can connect but there's no traffic.
>
> Maybe there's somewhere else that need to be configured for single band M=
T7986?
>
> I can provide the rxinfo, txinfo dump from WED if requested.
> ---
>  drivers/net/wireless/mediatek/mt76/wed.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wirel=
ess/mediatek/mt76/wed.c
> index ed657d952de2..f210a0c57d81 100644
> --- a/drivers/net/wireless/mediatek/mt76/wed.c
> +++ b/drivers/net/wireless/mediatek/mt76/wed.c
> @@ -33,10 +33,15 @@ u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, =
int size)
>  {
>         struct mtk_wed_bm_desc *desc =3D wed->rx_buf_ring.desc;
>         struct mt76_dev *dev =3D mt76_wed_to_dev(wed);
> -       struct mt76_queue *q =3D &dev->q_rx[MT_RXQ_MAIN];
>         struct mt76_txwi_cache *t =3D NULL;
> +       struct mt76_queue *q;
>         int i;
>
> +       if (wed->version =3D=3D 2 && dev->phy.band_idx)
> +               q =3D &dev->q_rx[MT_RXQ_BAND1];
> +       else
> +               q =3D &dev->q_rx[MT_RXQ_MAIN];
> +
>         for (i =3D 0; i < size; i++) {
>                 dma_addr_t addr;
>                 u32 offset;
> --
> 2.47.3
>

dump of /sys/kernel/debug/wed1

root@W6m:/sys/kernel/debug/wed1# cat rxinfo
=3D=3D=3D=3D=3D=3D=3D=3D WPDMA RX:
WPDMA_RX0 BASE                   00000000
WPDMA_RX0 CNT                    00000000
WPDMA_RX0 CIDX                   00000000
WPDMA_RX0 DIDX                   00000000
WPDMA_RX1 BASE                   4a7c0000
WPDMA_RX1 CNT                    00000600
WPDMA_RX1 CIDX                   000000ea
WPDMA_RX1 DIDX                   000000eb

=3D=3D=3D=3D=3D=3D=3D=3D WPDMA RX:
WED_WPDMA_RX_D_MIB(0)            00000000
WED_WPDMA_RING_RX_DATA(0) BASE   00000000
WED_WPDMA_RING_RX_DATA(0) CNT    00000000
WED_WPDMA_RING_RX_DATA(0) CIDX   00000fff
WED_WPDMA_RING_RX_DATA(0) DIDX   00000000
WED_WPDMA_RX_D_PROCESSED_MIB(0)  00000000
WED_WPDMA_RX_D_MIB(1)            000000eb
WED_WPDMA_RING_RX_DATA(1) BASE   4a7c0000
WED_WPDMA_RING_RX_DATA(1) CNT    00000600
WED_WPDMA_RING_RX_DATA(1) CIDX   00eb00ea
WED_WPDMA_RING_RX_DATA(1) DIDX   000000eb
WED_WPDMA_RX_D_PROCESSED_MIB(1)  000000eb
WED_WPDMA_RX_D_COHERENT_MIB      00000000

=3D=3D=3D=3D=3D=3D=3D=3D WED RX:
WED_RING_RX_DATA(0) BASE         00000000
WED_RING_RX_DATA(0) CNT          00000000
WED_RING_RX_DATA(0) CIDX         00000000
WED_RING_RX_DATA(0) DIDX         00000000
WED_RING_RX_DATA(1) BASE         4a7b8000
WED_RING_RX_DATA(1) CNT          00000600
WED_RING_RX_DATA(1) CIDX         0000004f
WED_RING_RX_DATA(1) DIDX         00000050

=3D=3D=3D=3D=3D=3D=3D=3D WED WO RRO:
WED_RRO_MIOD BASE                151f8000
WED_RRO_MIOD CNT                 00000010
WED_RRO_MIOD CIDX                0000000b
WED_RRO_MIOD DIDX                0000000b
WED_RROQM_MID_MIB                000000eb
WED_RROQM_MOD_MIB                000000eb
WED_RROQM_MOD_COHERENT_MIB       00000000
WED_RRO_FDBK BASE                151f8800
WED_RRO_FDBK CNT                 00000400
WED_RRO_FDBK CIDX                000000eb
WED_RRO_FDBK DIDX                00eb00eb
WED_RROQM_FDBK_IND_MIB           000000eb
WED_RROQM_FDBK_ENQ_MIB           00000000
WED_RROQM_FDBK_ANC_MIB           00000000
WED_RROQM_FDBK_ANC2H_MIB         00000000

=3D=3D=3D=3D=3D=3D=3D=3D WED WDMA TX:
WED_WDMA_TX_MIB                  009b009b
WED_WDMA_RING_TX BASE            00000000
WED_WDMA_RING_TX CNT             00000000
WED_WDMA_RING_TX CIDX            00000001
WED_WDMA_RING_TX DIDX            00000000

=3D=3D=3D=3D=3D=3D=3D=3D WDMA TX:
WDMA_GLO_CFG                     58404e77
WDMA_RING_TX(0) BASE             00000000
WDMA_RING_TX(0) CNT              00000000
WDMA_RING_TX(0) CIDX             00000001
WDMA_RING_TX(0) DIDX             00000000
WDMA_RING_TX(1) BASE             4a7c8000
WDMA_RING_TX(1) CNT              00000400
WDMA_RING_TX(1) CIDX             00000000
WDMA_RING_TX(1) DIDX             00000000

=3D=3D=3D=3D=3D=3D=3D=3D WED RX BM:
WED_RX_BM_BASE                   4b400000
WED_RX_BM_RX_DMAD                000006c0
WED_RX_BM_PTR                    16f93050
WED_RX_BM_TKID_MIB               000016e9
WED_RX_BM_BLEN                   00000000
WED_RX_BM_STS                    01100000
WED_RX_BM_INTF2                  00007800
WED_RX_BM_INTF                   00000000
WED_RX_BM_ERR_STS                00000000
=3D=3D=3D=3D=3D=3D=3D=3D WED Route QM:
WED_RTQM_R2H_MIB(0)              00000000
WED_RTQM_R2Q_MIB(0)              00000000
WED_RTQM_Q2H_MIB(0)              00000000
WED_RTQM_R2H_MIB(1)              00000050
WED_RTQM_R2Q_MIB(1)              0000009b
WED_RTQM_Q2H_MIB(1)              00000000
WED_RTQM_Q2N_MIB                 0000009b
WED_RTQM_Q2B_MIB                 00000000
WED_RTQM_PFDBK_MIB               00000000

root@W6m:/sys/kernel/debug/wed1# cat txinfo
=3D=3D=3D=3D=3D=3D=3D=3D WED TX:
WED_TX_MIB(0)                    00000000
WED_RING_TX(0) BASE              00000000
WED_RING_TX(0) CNT               00000000
WED_RING_TX(0) CIDX              00000000
WED_RING_TX(0) DIDX              00000000
WED_TX_MIB(1)                    0000002b
WED_RING_TX(1) BASE              49f10000
WED_RING_TX(1) CNT               00000800
WED_RING_TX(1) CIDX              0000002b
WED_RING_TX(1) DIDX              0000002b

=3D=3D=3D=3D=3D=3D=3D=3D WPDMA TX:
WED_WPDMA_TX_MIB(0)              00000000
WED_WPDMA_RING_TX(0) BASE        00000000
WED_WPDMA_RING_TX(0) CNT         00000000
WED_WPDMA_RING_TX(0) CIDX        00000000
WED_WPDMA_RING_TX(0) DIDX        00000000
WED_WPDMA_TX_COHERENT_MIB(0)     00000000
WED_WPDMA_TX_MIB(1)              0000002b
WED_WPDMA_RING_TX(1) BASE        49f18000
WED_WPDMA_RING_TX(1) CNT         00000800
WED_WPDMA_RING_TX(1) CIDX        002b002b
WED_WPDMA_RING_TX(1) DIDX        0000002b
WED_WPDMA_TX_COHERENT_MIB(1)     00000000

=3D=3D=3D=3D=3D=3D=3D=3D WPDMA TX:
WPDMA_TX0 BASE                   00000000
WPDMA_TX0 CNT                    00000000
WPDMA_TX0 CIDX                   00000000
WPDMA_TX0 DIDX                   00000000
WPDMA_TX1 BASE                   49f18000
WPDMA_TX1 CNT                    00000800
WPDMA_TX1 CIDX                   0000002b
WPDMA_TX1 DIDX                   0000002b

=3D=3D=3D=3D=3D=3D=3D=3D WED WDMA RX:
WED_WDMA_RX_MIB(0)               00000000
WED_WDMA_RING_RX(0) BASE         44f40000
WED_WDMA_RING_RX(0) CNT          00000010
WED_WDMA_RING_RX(0) CIDX         0000000f
WED_WDMA_RING_RX(0) DIDX         00000000
WED_WDMA_RX_THRES(0)             00040020
WED_WDMA_RX_RECYCLE_MIB(0)       00000000
WED_WDMA_RX_PROCESSED_MIB(0)     00000000
WED_WDMA_RX_MIB(1)               00000000
WED_WDMA_RING_RX(1) BASE         49f20000
WED_WDMA_RING_RX(1) CNT          00000400
WED_WDMA_RING_RX(1) CIDX         000003ff
WED_WDMA_RING_RX(1) DIDX         00000000
WED_WDMA_RX_THRES(1)             00040020
WED_WDMA_RX_RECYCLE_MIB(1)       00000000
WED_WDMA_RX_PROCESSED_MIB(1)     00000000

=3D=3D=3D=3D=3D=3D=3D=3D WDMA RX:
WDMA_GLO_CFG                     58404e77
WDMA_RING_RX(0) BASE             44f40000
WDMA_RING_RX(0) CNT              00000010
WDMA_RING_RX(0) CIDX             0000000f
WDMA_RING_RX(0) DIDX             00000000
WDMA_RING_RX(1) BASE             49f20000
WDMA_RING_RX(1) CNT              00000400
WDMA_RING_RX(1) CIDX             000003ff
WDMA_RING_RX(1) DIDX             00000000

=3D=3D=3D=3D=3D=3D=3D=3D WED TX FREE:
WED_RX_MIB(0)                    00000bed
WED_RING_RX(0) BASE              42784000
WED_RING_RX(0) CNT               00000200
WED_RING_RX(0) CIDX              000001ec
WED_RING_RX(0) DIDX              000001ed
WED_WPDMA_RX_COHERENT_MIB(0)     00000000
WED_RX_MIB(1)                    00000000
WED_RING_RX(1) BASE              00000000
WED_RING_RX(1) CNT               00000000
WED_RING_RX(1) CIDX              00000000
WED_RING_RX(1) DIDX              00000000
WED_WPDMA_RX_COHERENT_MIB(1)     00000000

=3D=3D=3D=3D=3D=3D=3D=3D WED WPDMA TX FREE:
WED_WPDMA_RING_RX(0) BASE        42784000
WED_WPDMA_RING_RX(0) CNT         00000200
WED_WPDMA_RING_RX(0) CIDX        01ed01ec
WED_WPDMA_RING_RX(0) DIDX        000001ed
WED_WPDMA_RING_RX(1) BASE        00000000
WED_WPDMA_RING_RX(1) CNT         00000000
WED_WPDMA_RING_RX(1) CIDX        00000000
WED_WPDMA_RING_RX(1) DIDX        00000000

Best regards,
Zhi-Jun

