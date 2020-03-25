Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39DE41922DA
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCYIfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:35:25 -0400
Received: from mx1.uni-rostock.de ([139.30.22.71]:59760 "EHLO
        mx1.uni-rostock.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbgCYIfZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:35:25 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 04:35:24 EDT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1585125023; bh=Y4ioLXxOvDre4illj3VzvvPLDiMOu0R18X56y1m7Wgo=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 HiDE3XarwLRbNh2b/C/CO4cZPc636vPDewU8aygI2bqfw+X+jS6jdIjWsCqrId5yUWB3Ni8AbAgc5TKGtw08Dw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1585125023; bh=Y4ioLXxOvDre4illj3VzvvPLDiMOu0R18X56y1m7Wgo=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 AiyvYdjYKprpwDvvYoHFMYv9Vc3JoqP+Bc5WMhvMmWGmtlfRzNW3EANtWQzMUuWBBhUwwDnf/1TojpvxGGH9KCrUCuKGtqKt3HmRPdUrCagRN3HeqZdzMFwalPn/PbinHEOelI3+9kyXYkdDMi9kGeKyHVrLRhG+u+vPGBwufFA=
Received: from 139.30.22.81 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Wed, 25 Mar 2020 08:30:23 GMT
Received: from [139.30.106.140] (139.30.106.140) by email1.uni-rostock.de
 (139.30.22.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1847.3; Wed, 25 Mar
 2020 09:30:23 +0100
Subject: Re: wmediumd MAC implementation/simulation
To:     Johannes Berg <johannes@sipsolutions.net>,
        Bob Copeland <me@bobcopeland.com>
CC:     <linux-wireless@vger.kernel.org>,
        Masashi Honma <masashi.honma@gmail.com>
References: <30484acdee4cd19078673f4f4229dfae49b17804.camel@sipsolutions.net>
 <20200324145344.GA17278@bobcopeland.com>
 <3bd9fa47c45cd983334ccae06b75501f161ed45c.camel@sipsolutions.net>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Autocrypt: addr=Benjamin.Beichler@uni-rostock.de; prefer-encrypt=mutual;
 keydata=
 xjMEW08D4RYJKwYBBAHaRw8BAQdARRw5LUE0LoG/3A8AuH6shJZQcVbm0p/m5fCc3FkaJ6vN
 KkJlbmphbWluIEJlaWNobGVyIDxoYWRyaWFuMjAwMkBmcmVlbmV0LmRlPsKtBBMWCAA+FiEE
 6qkQGP12r5eYfxTHFWm7+QrDkYoFAltPBEYCGyMFCQeUq78FCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AAIQkQFWm7+QrDkYoWIQTqqRAY/Xavl5h/FMcVabv5CsORilzwAP9xT8dX7YDDPEux
 Xl9lvWOhbI8p0wObh+avjjCTCBzwDwEAmPQCDUbN0wTzbEprAZF8SOH0ac0wN/U7Raq+1YBe
 pwrOOARbTwPhEgorBgEEAZdVAQUBAQdAXKZlSy6SUCT3Au2PIiBTqbIREfi6ogEIiUkupGXO
 2FADAQgHwpUEGBYIACYWIQTqqRAY/Xavl5h/FMcVabv5CsORigUCW08D4QIbDAUJB5SrvwAh
 CRAVabv5CsORihYhBOqpEBj9dq+XmH8UxxVpu/kKw5GK3/4A/1aEt8nV1aTTshyBPX758ZvW
 gBLd4HWFHLgoj8/+peqKAQCndMsWEsVLw90kV+kNkZChSA671e8Gf1FZXIf3S87+AA==
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
Message-ID: <12ddd641-1d54-7626-d177-cc2d12c2998e@uni-rostock.de>
Date:   Wed, 25 Mar 2020 09:30:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3bd9fa47c45cd983334ccae06b75501f161ed45c.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [139.30.106.140]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 email1.uni-rostock.de (139.30.22.81)
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
Am 24.03.2020 um 22:26 schrieb Johannes Berg:
>
>> That said, splitting them apart and having more realistic mac layer sounds
>> reasonable -- how do you anticipate it looking=3F
> Well, it depends how deep we go, I guess=3F I mean, we could go all the
> way down to the PHY layer, but then we're =5Freally=5F in ns3 territory and
> it's probably not worth it... OTOH, to fully integrate the firmware, we
> probably do need this eventually. But I'd rather not reinvent ns3 here,
> obviously :)
I think it's not the phy but the lower MAC layer, which at least need to
be adapted to the hwsim interface. Although it has no extreme
computational effort, its not that easy to implement. Depending on your
envisioned setup this might already be done in your firmware. Thy phy
layer will bring much higher timing precision, when the right models are
applied, but will greatly impact the simulation speed.
>
> I've been trying to come up with some kind of hybrid model, where
> perhaps we simulate the bare minimum for hwsim, and provide some kind of
> "mostly the transport" bits for integrating other things. Though I may
> still decide that even that is overkill, and right now I don't even care
> about the timing accuracy at all, I just want something to work first.
>
> What I anticipate this looking like is kinda hard to say, and we'd need
> significantly more API between hwsim and its MAC too, because even to
> simulate the ACK accurately we'd need to know the basic/mandatory rate
> bitmap - right now the code just does
>
>         int ack=5Ftime=5Fusec =3D pkt=5Fduration(14, index=5Fto=5Frate(0, fr=
ame->freq)) +
>                             sifs;
>
> but this is incorrect ... so arguably we need that *anyway*=3F

Actually you are right. Currently, we apply this by a priori knowledge.
Maybe a silly Idea, but could we interleave the cfg80211/nl80211
protocol on the virtio channel to get the configuration information=3F


>
> I guess I'd start with actually subjecting the ACK to "channel
> conditions", but I'd actually want to be able to hook into the TX/RX in
> some way from the external MAC too ... I just don't think we need to
> treat hwsim as an external MAC because that just complicates the whole
> thing=3F
>
> Well, honestly, I have no idea :)

Mhh I don't really get what you mean by that. Why can't you hook into
RX/TX with a simulated ACK =3F


>
>
>>> Or perhaps then that's too much complexity and I should just teach ns3
>>> the hwsim virtio interface=3F
>> Up to you :)

It should be definitely possible. But I'm asking my self how good that
interacts with your firmware simulation.


> :)
>
> johannes
>
>
kind regards

Benjamin

-- 
M.Sc. Benjamin Beichler

Universit=C3=A4t Rostock, Fakult=C3=A4t f=C3=BCr Informatik und Elektrotechnik
Institut f=C3=BCr Angewandte Mikroelektronik und Datentechnik

University of Rostock, Department of CS and EE
Institute of Applied Microelectronics and CE

Richard-Wagner-Stra=C3=9Fe 31
18119 Rostock
Deutschland/Germany

phone: +49 (0) 381 498 - 7278
email: Benjamin.Beichler@uni-rostock.de
www: http://www.imd.uni-rostock.de/
