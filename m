Return-Path: <linux-wireless+bounces-12131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D431962224
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8084A1C23038
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A515ADA6;
	Wed, 28 Aug 2024 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="eJZPsx1R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9215B966;
	Wed, 28 Aug 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833065; cv=none; b=RjpO6Fz3sp/fl4NY4o2ICproFpoRYupttey70OXCU961FUE2PvHq/MW2GX775DQU1rH/Yg0q0XyV6D9zREyLD/4BNSzi/cIH6kfY2sDd9Y1LFbRMrWsSv5QcxDCiTxmU/tBuVEq3axtC5kkw54WGhsa7fwqVO8VdIjuW0TGPTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833065; c=relaxed/simple;
	bh=g8G3n2oC9BGSDr5dj4Ln70/JKkFb0GSJhpHopVzdlu0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UggavNw61R0RaXLcTZ2cxx0FJtHlhpaVzv+0EJ5EK3VXV5m9jpuKUySHdGwI9omlOvfWJ1asd0Gg2WEv//lPF6VaSZDo4wF6KeNQtFyhy5SFesq4/idP4UfsfEWnp7l+3/YId78SgXvTdVBep9c/RZZeCNbR3YgaciCxYY+SxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=eJZPsx1R; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724833043; x=1725437843; i=spasswolf@web.de;
	bh=HJ9gN2dyG0tELFDyIaVWwxco35Ny0zFkmQvcfIA5lIw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eJZPsx1RySSUEgyds5+XOD9GkIHMzH6AYc4WK5/9l8p7j2cF/hzP1qw9xgOticWr
	 CyVT5dUiVAPT1tASK3b7RszrWNCbIhdZdnm/RZOefeRR25bcs4ZTJK3WtOO9pj3PQ
	 fHGP9o+0V5ZqLn58ztF3m1QIkkSDlfKX962aaUz+3R+gk0hvv24V9x9N+Ltw3+BBF
	 3uvZyHbFtM5fp/TR3H5rd0b1OMZ9a2F0/fqGvyVTgxxx6ug5dPIaiPh49N+rDxfMq
	 Ooa/Snb2/6dEvWqC4GYvevwl1YsahaNDencN9yvAg/Frh3zKsALI8q0ZgmhbIP08T
	 uproA0TRoHJ2Avp1lQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1s4bg73m1F-00wkGg; Wed, 28
 Aug 2024 10:17:22 +0200
Message-ID: <980698e0d6dfa1e0043edfed6e174ff17705e053.camel@web.de>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix null pointer access in
 mt792x_mac_link_bss_remove
From: Bert Karwatzki <spasswolf@web.de>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com, 
	sean.wang@mediatek.com, deren.wu@mediatek.com, mingyen.hsieh@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	spasswolf@web.de
Date: Wed, 28 Aug 2024 10:17:20 +0200
In-Reply-To: <CAHbf0-HYi=x11bc-sMJFbZ4cbkdphMYQ_hjzD_wrPvJevVwyYg@mail.gmail.com>
References: <20240718234633.12737-1-sean.wang@kernel.org>
	 <0124ff39-7d63-49f8-bacd-3a40ce37ec4d@leemhuis.info>
	 <CAHbf0-Hn=ZyYpk7bS1yLK7K3ZpfWKgt3-t=c9Nhdj3Ov3H84mQ@mail.gmail.com>
	 <f7197c55d059cc8ddbf6c3def16dc414c5ec0b42.camel@web.de>
	 <CAHbf0-EBHERbxPGakY4-1jTQWqGqua3F0OYZjxcakdemJ5Soqw@mail.gmail.com>
	 <51e80bde6e3f3256ecdea2e5260463341e65578e.camel@web.de>
	 <CAHbf0-HYi=x11bc-sMJFbZ4cbkdphMYQ_hjzD_wrPvJevVwyYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6oZ+XXROi7lRrCqTGJQrAaf7+UZos3uRqJi6w9SfVRwy3Ai+6+X
 VzH1v1dTV1y4A0Cl5+yWA5cmtgmRpW2t5ytde1rRiTN9cNqTtss/hmQucySD9gu+k15mH3a
 BZfb7GJYdp3aB8FgVb/GySZpvBBrCMi73kG/vIIt3bxxzHK1Y0Qn8yi4Ezt+szteelBQZOg
 mtdxWhT5F6uPFlxVtsD4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O3/Xpm7KHVc=;ysiL236UkqiGFos3wisn3TRiVc6
 GhTDxBq0Djzm9fPbS0xNeJwtQrVvhB+vRwQNb6+N/fdcROdszFTxugwasFNfn4gQAvpDHIcJL
 aoIzqHw/2Iq71Da21fBh6DQbs425oHcSYLxsSomUFn5nEA35tVwQalsycTkTRastmIYw7GzTs
 sQPwQvFdXoyGKmCeLhg2+Uw1kQkeQhh6l5uwiJ6zZ97VZikxqjvpQlBFFJlwg67rg4rTdUVaM
 8unT1Dmg/w2jMtpii8YDXpSttgDPAu5YqTsFlwtNEBKScvCRPqnU9iP7HKyUlX9sOQW2W8rd5
 7M6+408V9i6vBIE2doqJnqhkh72gpvX7VsCQ2btld3Ei+OLoYggLWXUnoG51YgyUpOWCGaHIn
 PnzdQV78WJP0kUM6KKirPCW3WGGDvenxBpBxLHzDhXFSE1a7ILHjh5O7U52Twda60xTB5Hr47
 AdNaNlsOGbHGzPzbY67EGUs4JVY2QVd3FIU9ygMCgFPOejMpZZuc1ZH21sfRGcLQUV6P4Dr0p
 Ocx4qBHM9KS/scxnIWNGOXufot7PegDlWDe5MgealQf1EHwUD1oYliMNBencoiFllqqyCZ5yj
 uKj7Y4JRXiImOu8ydcWY1K/YqCaR947FgBTy3L7r2RRp0wJSdojLTqJQ7Q/Z3LsVwuHXoRmbV
 80kcM4n6eCWWWvCsCjObQCKlPCoynUMTefRV9q9cFgMhhao6j/vaagnCDFNwHO/BhWl6Lq0cO
 d1Cx5UbRetKYW2fFL297XAm8D8/dHzu9XK9WHk8gPRq9B+zqBlN2rBi9Zb339xR/CLsSLjSrC
 edKkU4Y2rApJYpGJ4b35RZwg==

Am Mittwoch, dem 28.08.2024 um 00:38 +0100 schrieb Mike Lothian:
> But not the follow on fix which fixes suspend...
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 2e6268cb06c0..a85c19da77e5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1182,7 +1182,7 @@ static void mt7921_ipv6_addr_change(struct
> ieee80211_hw *hw,
>       struct inet6_dev *idev)
>  {
>   struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> - struct mt792x_dev *dev =3D mvif->phy->dev;
> + struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
>   struct inet6_ifaddr *ifa;
>   struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
>   struct sk_buff *skb;
> @@ -1205,6 +1205,9 @@ static void mt7921_ipv6_addr_change(struct
> ieee80211_hw *hw,
>   },
>   };
>
> + if (!mvif->phy)
> + return;
> +
>   read_lock_bh(&idev->lock);
>   list_for_each_entry(ifa, &idev->addr_list, if_list) {
>   if (ifa->flags & IFA_F_TENTATIVE)
>
> > > >
> >

That is interesting (or odd) because suspend (s2idle) works for me in next=
-
20240827 on this hardware:

04:00.0 Network controller [0280]: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E=
 80MHz
[14c3:0608]

are you using a different model?

[  272.780054] [    T848] wlp4s0: deauthenticating from 54:67:51:3d:a2:d2 =
by
local choice (Reason: 3=3DDEAUTH_LEAVING)
[  273.067438] [   T3437] PM: suspend entry (s2idle)
[  273.151140] [   T3437] Filesystems sync: 0.083 seconds
[  273.157029] [   T3437] Freezing user space processes

Can your the post the backtrace of your error (when commit 479ffee68d59c59=
9f is
applied)?

Bert Karwatzki

