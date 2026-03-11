Return-Path: <linux-wireless+bounces-32938-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKS/Oqu7sGlXmgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32938-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 01:47:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5509725A245
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 01:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D343305022A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 00:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159E936C9C2;
	Wed, 11 Mar 2026 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxb1RIb8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799A36C9C1
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190056; cv=none; b=rBAdUmyeNudc8VPrbrYufKNR3FBr3BuqZRxlUljYHWbSxlna7qg4KbuIFCaDMeqYYiL9t1d87ARoOP+TD8osDOrmefS0KG/fur03dZMUmJvVC0DRXNzCrrd3CVDsopCVyMUoAcbTJIv9q4xi95lQQ8NeGi7hXh6Kmjj7v46j/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190056; c=relaxed/simple;
	bh=b9EBZ6mQrK16ghPkVFvtoO52u0qitF8nXRbrA3sl9/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4a3kGT7FM/4cdgnaR0+IBmXjxasxe7Uwzu6A4HSaynR9Bn0xIhT47S1fnezXe3RRMu5tqEiaPFGMIdMlTGavQEP6+o2RDH42SMXwNQh0XuGHh9VcAl4IgmcRWLN00dj9bX6dfJZ1xR88HVAMdR0dL6e2DyHD++179pYNtHn89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxb1RIb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B89C4AF0B
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 00:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190056;
	bh=b9EBZ6mQrK16ghPkVFvtoO52u0qitF8nXRbrA3sl9/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lxb1RIb8FK1SKATqpfCN48igLCYJ+7SfLf+LfqPNbAIPSMVaUDCK7LPVzCXztHu6U
	 AieFjRagnXJeJzIBf6pxe7CLm6w2gyrPKYZgVJsOVlm+JkLKVLoaBwsZYNzha4aHO6
	 /F9veDm5Xr5YoPv8UrfTLOEyd4noGMzSc1SBZYscZ7jMphJrmrsEqDp6T0Y0VQchO6
	 XOCVjPQPc4usmJQV/eM5CrhnWVYuMlqNGjfbSyNHvOO5qf+U6QaMFpgiplTojiddze
	 c1IIO0VxkLpg0Mx4i6+9QEYC/4WR74jlqQhP6AaHJDFmAqGwNv+7+pDevysnXrD5gm
	 fB3Cy2O9PiJtQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38a2f92fab4so66287091fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 17:47:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YxmReUzddgE5TkHfcHa0WUSbTvk4IgsHKS7qf0sEIz6kknlNFAf
	Ly5QTh5oZD+aC6t+yf0YfhLspwbbSK7bzqJCkv0XIsp3uDqsuNzMNoL2QGdvWoFOJ7xMzSBTMqz
	ecemVPSZ2v46wWrpw0QyGIzGi94dg5qY=
X-Received: by 2002:a05:651c:54d:b0:38a:523a:7fb0 with SMTP id
 38308e7fff4ca-38a67dabe6emr2047781fa.1.1773190054254; Tue, 10 Mar 2026
 17:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFktD2eaVpRAJRkaGOj4y-m0woK-sNeCM+h_7A=9GELSce6TcQ@mail.gmail.com>
 <CAGp9LzrTMALkJKrGANTCzeG4KUDGwC1YJc8SRKNRriH3a9bnRQ@mail.gmail.com>
 <CAFktD2eG+nebKcNbw2imufSOz6MCR-SUXjcUQmDqJabNfwx4sg@mail.gmail.com>
 <CAGp9Lzp2s675kmTJG+iYgLXS=fjiD-JC6GYjom7i-bcWFDxWoQ@mail.gmail.com> <CAFktD2dbdccWFodfFNya_XnbKro-O+BKrs4cZRNa0uPrK6FFfQ@mail.gmail.com>
In-Reply-To: <CAFktD2dbdccWFodfFNya_XnbKro-O+BKrs4cZRNa0uPrK6FFfQ@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 10 Mar 2026 19:47:22 -0500
X-Gmail-Original-Message-ID: <CAGp9LzqeccDhKv9+KM1tWSA0uP0zJhC9WA2Jh3GozfJtiNxDnw@mail.gmail.com>
X-Gm-Features: AaiRm51ioNsWXVrvHJpApgBQKN3bda87LX_2LGpKJhziI8Pah1L27105Llmsbg4
Message-ID: <CAGp9LzqeccDhKv9+KM1tWSA0uP0zJhC9WA2Jh3GozfJtiNxDnw@mail.gmail.com>
Subject: Re: [BUG] wifi: mt76: mt7925u: probe with driver mt7925u failed with
 error -110
To: Nick <morrownr@gmail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.wu@mediatek.com>, Leon Yen <leon.yen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5509725A245
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-32938-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 7:31=E2=80=AFPM Nick <morrownr@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 6:46=E2=80=AFPM Sean Wang <sean.wang@kernel.org> w=
rote:
> >
> > Hi Nick,
> >
> > Thanks for the detailed report  this is very helpful. I don't  have an
> > MT7925 USB device to detail look into the issue, but based on the
> > trace I wrote a small change to try a different MT7925 reset sequence.
> > please help test.
> >
> > --- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> > @@ -234,6 +234,36 @@ int mt792xu_dma_init(struct mt792x_dev *dev, bool =
resume)
> >  }
> >  EXPORT_SYMBOL_GPL(mt792xu_dma_init);
> >
> > +static int mt7925u_wfsys_reset(struct mt792x_dev *dev)
> > +{
> > +    u32 val;
> > +    int i;
> > +
> > +#define MT7925_CBTOP_RGU_WF_SUBSYS_RST        0x70028600
> > +#define MT7925_WFSYS_SW_INIT_DONE_ADDR        0x184c1604
> > +#define MT7925_WFSYS_SW_INIT_DONE        0x00001d1e
> > +
> > +    val =3D mt792xu_uhw_rr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST)=
;
> > +    val |=3D MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
> > +    mt792xu_uhw_wr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST, val);
> > +
> > +    msleep(20);
> > +
> > +    val =3D mt792xu_uhw_rr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST)=
;
> > +    val &=3D ~MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
> > +    mt792xu_uhw_wr(&dev->mt76, MT7925_CBTOP_RGU_WF_SUBSYS_RST, val);
> > +
> > +    for (i =3D 0; i < MT792x_WFSYS_INIT_RETRY_COUNT; i++) {
> > +        val =3D mt792xu_uhw_rr(&dev->mt76, MT7925_WFSYS_SW_INIT_DONE_A=
DDR);
> > +        if (val =3D=3D MT7925_WFSYS_SW_INIT_DONE)
> > +            return 0;
> > +
> > +        msleep(100);
> > +    }
> > +
> > +    return -ETIMEDOUT;
> > +}
> > +
> >  int mt792xu_wfsys_reset(struct mt792x_dev *dev)
> >  {
> >      u32 val;
> > @@ -241,6 +271,9 @@ int mt792xu_wfsys_reset(struct mt792x_dev *dev)
> >
> >      mt792xu_epctl_rst_opt(dev, false);
> >
> > +    if (is_mt7925(&dev->mt76))
> > +        return mt7925u_wfsys_reset(dev);
> > +
> >      val =3D mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
> >
> >
>
> Sean,
>
> Testing complete. Results are good. You can show the following:
>
> Tested-by: Nick Morrow <morrownr@gmail.com>
> Tested-by: Satadru Pramanik <satadru@gmail.com>
>
> Thank you for working on this issue. If it is possible for your patch to =
go
> directly in to be in one of the next rc's, that would be great and settin=
g
> it to backport would also be much appreciated.
>
> Nick Morrow
>

Hi Nick,

Thanks for testing!

I=E2=80=99ve already sent the patches upstream with a few small cosmetic
tweaks. If you have a chance to test the latest version again, that
would be great. If it still looks good, you can just reply with the
Tested-by tags below. I think we can let Johannes know if it is okay
to wireless.git directly I also CC=E2=80=99d stable so the fix can make its
way into the stable trees.

      Sean

> > On Fri, Mar 6, 2026 at 1:24=E2=80=AFPM Nick <morrownr@gmail.com> wrote:
> > >
> > > > > Reference: https://github.com/morrownr/USB-WiFi/issues/688#issuec=
omment-3999038526
> > > > >
> > > > > The above thread is rather lengthy as we have been working on thi=
s
> > > > > issue since Dec. 25.
> > > > >
> > > > > Testing with a Netgear A9000 USB WiFi adapter (mt7925u driver). K=
ernel
> > > > > 7.0 rc2 and a x86_64 system. Additional testing with older kernel=
s was
> > > > > also performed with the same results.
> > > > >
> > > > > Problem description:
> > > > >
> > > > > Cold boot shows the adapter coming up and operating normally.
> > > > >
> > > > > Removing the adapter from the USB port and replacing it shows the
> > > > > adapter coming up and operating normally.
> > > > >
> > > > > A warm reboot does not provide a WiFi interface and shows the
> > > > > following in the system log:
> > > > >
> > > > > mt7925u 2-3.2:1.0: probe with driver mt7925u failed with error -1=
10
> > > > >
> > > > > Using the commands rmmod and modeprobe do not provide a WiFi inte=
rface.
> > > > >
> > > > > Thoughts: The problem likely is not the module teardown. The prob=
lem
> > > > > seems to be that the firmware (or the mt7925u driver) leaves the
> > > > > adapter in a strange state such that a power cycle of the adapter
> > > > > hardware is needed before the mt7925u driver can properly initial=
ize
> > > > > it a second time.
> > > > >
> > > >
> > > > Hi Nick,
> > > >
> > > > Could you enable debug logs and check whether the driver can still
> > > > read the correct chip ID after a warm reboot, and at which step the
> > > > initialization fails before the -110 error? Thanks for continuing t=
o
> > > > test and gather this useful information.
> > > >
> > > >          Sean
> > >
> > > Hi Sean,
> > >
> > > Github user @exct has performed the testing requested and provides th=
e
> > > following report:
> > >
> > > mt7925u Probe Failure Debug Report
> > > Adapter: Netgear A9000 (USB ID 0846:9072, MediaTek MT7925)
> > > Kernel: 6.19.6-2-cachyos
> > >
> > > Summary
> > > The driver can read the correct chip ID after a warm reload. The
> > > failure occurs before firmware is loaded, inside
> > > mt792xu_wfsys_reset(), which times out waiting for the WiFi subsystem
> > > to reinitialize. -ETIMEDOUT (-110) is returned and the probe aborts.
> > >
> > > Findings
> > >
> > > Question: Chip ID readable after warm reload?
> > > Answer: Yes =E2=80=94 MT_HW_CHIPID =3D 0x7925, MT_HW_REV =3D 0x8a00
> > >
> > > Question: Which step fails?
> > > Answer: mt792xu_wfsys_reset() =E2=80=94 WFSYS_INIT_DONE never asserte=
d
> > >
> > > Question: Does it reach mt792xu_mcu_power_on()?
> > > Answer: No
> > >
> > > Question: Does it reach mt7925_run_firmware()?
> > > Answer: No
> > >
> > > Probe Sequence Trace
> > >
> > > mt7925u_probe()
> > >   =E2=94=9C=E2=94=80 mt76_alloc_device()             OK
> > >   =E2=94=9C=E2=94=80 __mt76u_init()                  OK
> > >   =E2=94=9C=E2=94=80 read MT_HW_CHIPID (0x70010200)  =E2=86=92 0x0000=
7925  =E2=9C=93
> > >   =E2=94=9C=E2=94=80 read MT_HW_REV    (0x70010204)  =E2=86=92 0x0000=
8a00  =E2=9C=93
> > >   =E2=94=9C=E2=94=80 read MT_CONN_ON_MISC (0x7c0600f0) =E2=86=92 0x00=
000003  =E2=86=90 FW_N9_RDY is SET
> > >   =E2=94=9C=E2=94=80 enters mt792xu_wfsys_reset()    =E2=86=90 trigge=
red because FW_N9_RDY =3D 1
> > >   =E2=94=82    =E2=94=9C=E2=94=80 write MT_CBTOP_RGU_WF_SUBSYS_RST  (=
assert reset)
> > >   =E2=94=82    =E2=94=9C=E2=94=80 write MT_CBTOP_RGU_WF_SUBSYS_RST  (=
deassert reset)
> > >   =E2=94=82    =E2=94=9C=E2=94=80 poll MT_UDMA_CONN_INFRA_STATUS (0x7=
4000a20) =E2=86=92 0x00000000
> > >   =E2=94=82    =E2=94=9C=E2=94=80 poll MT_UDMA_CONN_INFRA_STATUS (0x7=
4000a20) =E2=86=92 0x00000000
> > >   =E2=94=82    =E2=94=94=E2=94=80 ... timeout after ~212 ms =E2=86=92=
 return -ETIMEDOUT
> > >   =E2=94=94=E2=94=80 goto error:  (mt76u_queues_deinit + mt76_free_de=
vice)
> > >
> > > Root Cause
> > >
> > > After rmmod, the firmware leaves FW_N9_RDY asserted in
> > > MT_CONN_ON_MISC. On re-probe, the driver correctly detects this and
> > > calls mt792xu_wfsys_reset() to recover. However, the WiFi subsystem
> > > never signals completion =E2=80=94 WFSYS_INIT_DONE in
> > > MT_UDMA_CONN_INFRA_STATUS (reg 0x74000a20) stays 0x00000000 throughou=
t
> > > the retry loop. The subsystem is stuck in a state that the software
> > > reset path cannot recover from. Only a full USB power cycle clears it=
.
> > >
> > > Hope this helps,
> > >
> > > Nick

