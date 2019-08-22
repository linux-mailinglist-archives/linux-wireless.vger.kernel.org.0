Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCC9A1AE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfHVVGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 17:06:49 -0400
Received: from ocelot.miegl.cz ([195.201.216.236]:32972 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbfHVVGt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 17:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=miegl.cz; s=dkim;
        t=1566508005; bh=oS+W+U0LENqjrKjT0VVEx1eyDvgQSHg/pCPsP97vWT4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From;
        b=BdXAq/mydfr5k0AIt6vddfzFM8DoSoRJvqTi4mnU/7zga2GQ/siQvMkM1ANXjrkGL
         rLi8Bak00lV3zbUsEONRvkuPLwV1aHJwrQWY0vXBQJEdTLsrwcQ2GMPTPYtaFpDkZ1
         l0A/akgBz3CRWUYGt+//nZ7CdF794hYPNeXys/UmlnTN4lKF2DdohWwfcLMjY4XON/
         YF3dLllF5PkioHnEBYBoKOaBpuajXjP1jH+Im6Bzndesm6n05SYHLabJojYkN/82EI
         1TdJdu0hacGC1gwQBZovccn8GZwbLMbk5dBB6Airt1mGkdvusVzlSdLi6R8infEw3B
         694zg424ZtMjw==
Date:   Thu, 22 Aug 2019 23:06:41 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <0452a0cbb36bcffa8371a58dfd931864c1f79eef.camel@sipsolutions.net>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain> <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de> <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain> <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de> <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain> <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net> <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain> <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net> <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz> <6efb9b56c77cd9ea945f89c3371b49c301dc2b4e.camel@sipsolutions.net> <58A25955-2A17-4DE7-82FB-3B20E00C96EC@miegl.cz> <5ee160209eb1f9e70f6224c393389266280d7d80.camel@sipsolutions.net> (sfid-20190822_090033_537095_4B41631C) <0452a0cbb36bcffa8371a58dfd931864c1f79eef.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Implementing Mikrotik IE
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
From:   Josef Miegl <josef@miegl.cz>
Message-ID: <68A3B9AF-8864-4C0F-A50B-71CCB76AE81D@miegl.cz>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 22, 2019 10:08:13 PM GMT+02:00, Johannes Berg <johannes@sipsoluti=
ons=2Enet> wrote:
>On Thu, 2019-08-22 at 09:00 +0200, Johannes Berg wrote:
>>=20
>> Perhaps it expects the 4-way-HS to already be in 4-addr frame format,
>or
>> something else special in the 4-way-HS if you have WDS?
>
>I think this is actually the right guess=2E

Yes, it indeed it! Thank you so much Johannes!

>As a hack, you could do
>
>--- a/net/mac80211/tx=2Ec
>+++ b/net/mac80211/tx=2Ec
>@@ -2623,8 +2623,7 @@ static struct sk_buff *ieee80211_build_hdr(struct
>ieee80211_sub_if_data *sdata,
>                     memcpy(hdr=2Eaddr2, skb->data + ETH_ALEN, ETH_ALEN);
>                       memcpy(hdr=2Eaddr3, sdata->u=2Emgd=2Ebssid, ETH_AL=
EN);
>                        hdrlen =3D 24;
>-               }  else if (sdata->u=2Emgd=2Euse_4addr &&
>-                           cpu_to_be16(ethertype) !=3D
>sdata->control_port_protocol) {
>+               }  else if (sdata->u=2Emgd=2Euse_4addr) {
>                        fc |=3D cpu_to_le16(IEEE80211_FCTL_FROMDS |
>                                          IEEE80211_FCTL_TODS);
>                        /* RA TA DA SA */
>
>
>in mac80211, then it should send 4-addr frames even for EAPOL=2E

Works great=2E Is there a possibility that a toggle for this could be acce=
pted upstream? After all, WDS isn't really standardized=2E

Thank you!

Josef
