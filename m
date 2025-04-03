Return-Path: <linux-wireless+bounces-21125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE95A7A31B
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB417A3FB6
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 12:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820872E3385;
	Thu,  3 Apr 2025 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7OqQMPD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5BE1A704B
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743684378; cv=none; b=FiZ1censMJcEpPP+h1X/ERGfTaWSx5xw4jmB0AQsiTYqzYlSpS0sQfjlSkOFZwsD87l8H51o8UoidNRbuCTW2xQUbk7nnGpE1AqJ/HnBm3sO+fXQjmINECLXwpW3lP1kFbd7M/gwAOCAZWrs7eSGNhKh6qews9eUxT9F3tqTU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743684378; c=relaxed/simple;
	bh=kVDbMRccG592Brp1t4bC5wALWRrpFz42TX4DAxY1+ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYOmP+uIJvtGlpOfNP9KxHWzZwNqDT1sNLIGXnEmKqtXSgrOwj+16BXGCWJe1KWDHRV5IsQmWUD7OCk8RJPPiXJTt2Du25r2M69rw11Q2rfa9n3+tx17dNOsFeSpnBhkeVLrq8+X5EIX+43gRDc7M/zd70qnu9J6dedcSuhyd/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7OqQMPD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so1469016a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743684375; x=1744289175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5u3sL2yzlJRQOm0fvUzyonRxpMlPosrwrOT6XH6urs=;
        b=S7OqQMPDD7Z/FEd9fhlt9E0NBW4b5VBvFClFvC/ydYx1hfm2Dv5dZLPYplBVNQj6Yr
         lTQDvpSIaFQrFTnck7XVJZe9/NB3LMjogGfUGSp024DwrGZy0hp1PURYcg4QfvZ3Li0O
         dGaC8gPDxeq57AxOwItXPFFU/9zlXGC/27pXFtydOAURxeozUdVfPttLa5EaHhYI4//W
         uBRPjckd1e1DV46KyETuW3RoZXMQtZPl2a3JWzZjQUXvKpEapZ1MG4cfAxpVerqamDyv
         I1yaFm8oKBaAgAHVklQABm+0RWkEP04mysygcn3FV5kMyihjLH2ljc7OWZbUlOatTqOq
         cg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743684375; x=1744289175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5u3sL2yzlJRQOm0fvUzyonRxpMlPosrwrOT6XH6urs=;
        b=s5/boDt8GxatqmPvOo1tItQLpbakMnnBage1qH3D7i9tHEItEkjSSpAshI2Zvwoz1o
         xaRk0cbrT2nZnIUn7o88mLrqU/JmCJUWMpWNvJjoUiplp5MjNZt3g/JUIZ2tXFDb7WBv
         8tZh+nVMWtBL77PPHTcbAAfjGyL6y7pplNS8Ncy5RZ/peXzy31f/PCvDE49QCm1V6Fht
         1JQVUxpXJlltFagbSSasljNuufucspPzELYN8PBtDvspW+HYkfPaCfgs+PIeo+riJ5ma
         wOh6lMmJ64BunA/fts7pt885VkHQ04vtHs26a2Du7RJ5dAifD1lqyYJblQnKmTmr9TEQ
         l5QA==
X-Gm-Message-State: AOJu0YwPGo2xlOMnnr1N/AyQvZ3VKTmNu+N/VjCMyxX2uBmH5JR5JVVK
	rihZEOUedJnxx4TFiW9BoqJyaTPZL/eqpZ/eBDGO0kQWNtlo1S2HYxP5FhlYFzXJUjD5+oh22AN
	GpA4Ok6WDu0p5eBNA97ahZu6cboo=
X-Gm-Gg: ASbGncuIe7KfC+gUzSkvT0E16TzqrQlr4OcE3ATkPRhh6CfbTFdlVBn+baNo4F7eaLV
	Rxgvad+bs7aOtmC3bCO0EiCRrI+l+2YK2AUhkErcITbdWZaZcT/0HOYYsO59YckktDwi4Sgj108
	mclm65w4GUoV4JaxgGgblOcL7P1D2J
X-Google-Smtp-Source: AGHT+IGhFIxuWlWRnkGLKj5tJZtHDmXkLWLwEwPglg4TzNkZtvxw/uT92DUyKtvF0/gctWQzG9L2WNC4AhxZP4v6I94=
X-Received: by 2002:a05:6402:84e:b0:5e5:e78a:c501 with SMTP id
 4fb4d7f45d1cf-5edfceaf2a6mr16582492a12.13.1743684374677; Thu, 03 Apr 2025
 05:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
 <9481e6a3844f897d03f8f4bfef335092f4ac76da.camel@sipsolutions.net>
 <CAFED-jm3Ot3urZuDnYaWE1vyXuAMDvw_W7vuxUOjQtRqN-y0uA@mail.gmail.com>
 <abf1538df6f224e38b1e42b66cc71b76c2645288.camel@sipsolutions.net> <CAFED-j=5KTpaCm8p7rbHnHVykTLvnRYu+ZO08ggh4jgxfuyoPg@mail.gmail.com>
In-Reply-To: <CAFED-j=5KTpaCm8p7rbHnHVykTLvnRYu+ZO08ggh4jgxfuyoPg@mail.gmail.com>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Thu, 3 Apr 2025 14:46:03 +0200
X-Gm-Features: ATxdqUG9XrIr6QEOV1mK3GTGTIQdL9LOLwaSOUY9pmoRtZBJsN-PT0OYDQpb_FU
Message-ID: <CAFED-jmMT+jdMx=2cYOxMC-ybYVg0aSOMvcewBqD6kHuW5_UVA@mail.gmail.com>
Subject: Re: [RFC wireless-next 0/2] wifi: allow tagged control packets
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, j@w1.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 2 kwi 2025 o 09:55 Janusz Dziedzic <janusz.dziedzic@gmail.com> na=
pisa=C5=82(a):
>
> =C5=9Br., 2 kwi 2025 o 09:24 Johannes Berg <johannes@sipsolutions.net> na=
pisa=C5=82(a):
> >
> > On Wed, 2025-04-02 at 09:17 +0200, Janusz Dziedzic wrote:
> > >
> > > Just do minimal imp/check and share RFC, while don't know this
> > > approach could be accepted.
> > >
> >
> > What choices are there? What's the alternative? Go back to sending the
> > frames via raw sockets? I guess it works but it's not great?
> >
> Yes, back to netdev/bridge eap read in hostapd should fix receive path.
> But, don't see it on netdev/bridge when use tcpdump - guess we change
> smth here for rx path (or skip not protected when control port used).
>
> Some background:
>  - backhaul AP send primary_vlan_id in assoc resp in multi_ap IE
>  - backhaul STA (agent) if support multi_ap profile >=3D 2 should tag
> EAPOLs with primary_vlan_id
>  - with control_port we have today hostapd backhaul AP don't get this
> tagged EAPOLs
>
> Other issue is sending tagged EAPOL from hostapd when backhaul STA
> multi_ap_profile >=3D 2.
> But RX path looks like regression compare to raw sockets.
>

OK, even if disarm control_port in net/mac80211/main.c
(NL80211_EXT_FEATURE_CONTROL_PORT_
*) still need this for rx path:

@@ -2560,13 +2561,16 @@ static bool ieee80211_frame_allowed(stru
       static const u8 pae_group_addr[ETH_ALEN] __aligned(2)
               =3D { 0x01, 0x80, 0xC2, 0x00, 0x00, 0x03 };
       struct ethhdr *ehdr =3D (struct ethhdr *) rx->skb->data;
+       struct vlan_ethhdr *vhdr =3D (void *) ehdr;

       /*
        * Allow EAPOL frames to us/the PAE group address regardless of
        * whether the frame was encrypted or not, and always disallow
        * all other destination addresses for them.
        */
-       if (unlikely(ehdr->h_proto =3D=3D rx->sdata->control_port_protocol)=
)
+       if (unlikely(ehdr->h_proto =3D=3D rx->sdata->control_port_protocol =
||
+                    (ehdr->h_proto =3D=3D cpu_to_be16(ETH_P_8021Q) &&
+                     vhdr->h_vlan_encapsulated_proto =3D=3D
rx->sdata->control_port_protocol)))
               return ether_addr_equal(ehdr->h_dest, rx->sdata->vif.addr) |=
|
                      ether_addr_equal(ehdr->h_dest, pae_group_addr);


BR
Jansz

