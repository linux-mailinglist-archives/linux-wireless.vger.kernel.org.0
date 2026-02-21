Return-Path: <linux-wireless+bounces-32073-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mjYiNQOEmWnUUgMAu9opvQ
	(envelope-from <linux-wireless+bounces-32073-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 11:08:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0090A16C97C
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 11:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B026300291A
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1062EFDA4;
	Sat, 21 Feb 2026 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="LGWMXvjR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC462C375A
	for <linux-wireless@vger.kernel.org>; Sat, 21 Feb 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771668476; cv=none; b=UCccm3M9G0oPWwvMBNt9gMJAVI/6dZksq+nB3rW7VFYe8T6mvXMjkW1I928ApXjFegYaDm+JYT52gbA+Ab8TiK61f12i/3fsj4nKRY6UpK9IUhRPaiNmH7ktwAyC7yutHXSugGd7ojv58vIhP7DmPtObpELgo7d9qaYoNLY2cqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771668476; c=relaxed/simple;
	bh=iVw1HVSiTMw4bZ+cqRx8IQfw76zVemzdRWQ1EP9QMj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnvTPH6uR10AIziPxtoABb5TGOtzCSqCTuQMvYiHj8weL2kvRvvyPYE7G12UOjl4eqLm4sqedv4egw7o/2dPYWQMThom6xf/MQKjDVoA8DfaZRzXQQfUJBbjyLWourqbU/OoPRPYH+dhAuPLcY6CTRvKHUgWyXZfCteFWTC0RYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=LGWMXvjR; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 15318 invoked from network); 21 Feb 2026 11:07:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1771668471; bh=gvcQcgZ9/Edyb3cXnLgqPNfRojiY4ttZwqd54VF0Ay0=;
          h=From:To:Cc:Subject;
          b=LGWMXvjRS5xOTIKLYoUqhnEh2HCmYd1MKAcbTatiPFdR35VvmmNDqIKCL39RQLDKn
           a8KZ+jxkU99gKMvAKNtoLk4ErpzqyB3M7i/vfVE0l4IDXVisNmSC25phmD9tj1hkMD
           ubMsyqo4EyDcsmHUCprnqpipHTqTMC3RAZ7vYFUMKv018ycLOzEBGGwiBDSGzyERmZ
           HUA98PVviCyqieBibQ/0HTNVfBaSdNT3LUTs8w0ry8gSdEvruWOOAS4CERbOB+CpEE
           NN2FlRgMVgIjux6dJCVKP6NOQYHOzLSOOOZ1K1vA8j9rpSOroxXYLs2w+FGgKiMl59
           GS4Twyrr2yxpg==
Received: from 89-64-9-107.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.107])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 21 Feb 2026 11:07:50 +0100
Date: Sat, 21 Feb 2026 11:07:50 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: rt2x00: use non of nvmem_cell_get
Message-ID: <20260221100750.GA62045@wp.pl>
References: <20260220020908.40115-1-rosenp@gmail.com>
 <20260220103739.GA20961@wp.pl>
 <CAKxU2N9teQSu+JTszxo_jbaYwfOT63513DziRq0X8KNkVj_jqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9teQSu+JTszxo_jbaYwfOT63513DziRq0X8KNkVj_jqw@mail.gmail.com>
X-WP-MailID: 72b8da6172d50e35f4a4fc2f94e658dc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [AcNB]                               
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32073-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[wp.pl];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0090A16C97C
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:32:55PM -0800, Rosen Penev wrote:
> On Fri, Feb 20, 2026 at 2:37 AM Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> >
> > On Thu, Feb 19, 2026 at 06:09:08PM -0800, Rosen Penev wrote:
> > > The library doesn't necessarily depend on OF. This codepath is used by
> > > both soc (OF only) and pci (no such requirement). After this, the only
> > > of specific function is of_get_mac_address, which is needed for nvmem.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> >
> > > ---
> > >  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > index 65d0f805459c..93e4ce604171 100644
> > > --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > > @@ -10965,13 +10965,13 @@ EXPORT_SYMBOL_GPL(rt2800_read_eeprom_efuse);
> > >
> > >  int rt2800_read_eeprom_nvmem(struct rt2x00_dev *rt2x00dev)
> > >  {
> > > -     struct device_node *np = rt2x00dev->dev->of_node;
> > > +     struct device *dev = rt2x00dev->dev;
> > >       unsigned int len = rt2x00dev->ops->eeprom_size;
> > >       struct nvmem_cell *cell;
> > >       const void *data;
> > >       size_t retlen;
> > >
> > > -     cell = of_nvmem_cell_get(np, "eeprom");
> > > +     cell = nvmem_cell_get(dev, "eeprom");
> most usages of nvmem_cell_get in wireless use devm instead. Seems
> pointless to extend the lifetime of cell until removal but what do I
> know...

No need for devm_ here, we release resources locally. 

You can change other  drivers, to avoid keeping nvem cell reference
needlessly, if you think that's beneficial.

Regards
Stanislaw


