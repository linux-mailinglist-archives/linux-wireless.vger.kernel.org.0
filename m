Return-Path: <linux-wireless+bounces-1180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2381BFAB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 21:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547671F2587C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 20:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA47690C;
	Thu, 21 Dec 2023 20:39:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017A1768EC;
	Thu, 21 Dec 2023 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id E1C15CECC7;
	Thu, 21 Dec 2023 21:39:35 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGRGNgW0h_uqHn0rKwGx0L41R+YgzgWPEh83kSKVCeqfCDeOug@mail.gmail.com>
Date: Thu, 21 Dec 2023 21:39:25 +0100
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>,
 Hector Martin <marcan@marcan.st>,
 Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Daniel Berlin <dberlin@dberlin.org>,
 linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com,
 linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3F2FB99-C022-4BEE-8F1C-8B6F0E14DAA1@holtmann.org>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st>
 <c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
 <CAGRGNgW0h_uqHn0rKwGx0L41R+YgzgWPEh83kSKVCeqfCDeOug@mail.gmail.com>
To: Julian Calaby <julian.calaby@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Julian,

>>>>>> Using the WSEC command instead of sae_password seems to be the =
supported
>>>>>> mechanism on newer firmware, and also how the brcmdhd driver does =
it.
>>>>>>=20
>>>>>> According to user reports [1], the sae_password codepath doesn't =
actually
>>>>>> work on machines with Cypress chips anyway, so no harm in =
removing it.
>>>>>>=20
>>>>>> This makes WPA3 work with iwd, or with wpa_supplicant pending a =
support
>>>>>> patchset [2].
>>>>>>=20
>>>>>> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
>>>>>> [2] =
http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
>>>>>>=20
>>>>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>>>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>>>>>=20
>>>>> Arend, what do you think?
>>>>>=20
>>>>> We recently talked about people testing brcmfmac patches, has =
anyone else
>>>>> tested this?
>>>>=20
>>>> Not sure I already replied so maybe I am repeating myself. I would =
prefer
>>>> to keep the Cypress sae_password path as well although it =
reportedly does
>>>> not work. The vendor support in the driver can be used to =
accommodate for
>>>> that. The other option would be to have people with Cypress chipset =
test
>>>> this patch. If that works for both we can consider dropping the
>>>> sae_password path.
>>>>=20
>>>> Regards,
>>>> Arend
>>>=20
>>> So, if nobody from Cypress chimes in ever, and nobody cares nor =
tests
>>> Cypress chipsets, are we keeping any and all existing Cypress =
code-paths
>>> as bitrotting code forever and adding gratuitous conditionals every =
time
>>> any functionality needs to change "just in case it breaks Cypress" =
even
>>> though it has been tested compatible on Broadcom chipsets/firmware?
>>>=20
>>> Because that's not sustainable long term.
>>=20
>> You should look into WEXT just for the fun of it. If it were up to me
>> and a bunch of other people that would have been gone decades ago. =
Maybe
>> a bad example if the sae_password is indeed not working, but the =
Cypress
>> chipset is used in RPi3 and RPi4 so there must be a couple of users.
>=20
> There are reports that WPA3 is broken on the Cypress chipsets the
> Raspberry Pis are using and this patch fixes it:
> https://rachelbythebay.com/w/2023/11/06/wpa3/
>=20
> Based on that, it appears that all known users of WPA3 capable
> hardware with this driver require this fix.

the Pis are all using an outdated firmware. In their distro they put the
firmware already under the alternates systems, but it just lacks the SAE
offload support that is required to make WPA3 work. The linux-firmware
version does the trick nicely.

I documented what I did to make this work on Pi5 (note that I normally
use Fedora on Pi4 and thus never encountered this issue)

https://holtmann.dev/enabling-wpa3-on-raspberry-pi/

However you need to use iwd and not hope that you get a wpa_supplicant
released version that will work.

So whole game of wpa_supplicant is vendor specific to the company that
provides the driver is also insane, but that is another story. Use iwd
and you can most likely have WPA3 support if you have the right =
firmware.

Regards

Marcel


