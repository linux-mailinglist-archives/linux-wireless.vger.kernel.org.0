Return-Path: <linux-wireless+bounces-574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE82D809C8B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 07:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1651F2106D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E563AD;
	Fri,  8 Dec 2023 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="fNBxo/JH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDEB1708
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 22:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702017720; x=1702622520; i=zerobeat@gmx.de;
	bh=OSeDY6wOAQMP5ADfuKvLvTt35aIhjEpu21Hjs8GYJ8k=;
	h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:
	 In-Reply-To;
	b=fNBxo/JH301V2JHsL5OAzYTkkF1OgcljR5WVGY+YnmbJWoqiYJba4hTb3I+H51+6
	 r3FPgFUPA1B+3/BsvjOh42e4HG1zpXgEs+3Vb2TkSucROJ7kdVlZeHhSlRFRpGYQA
	 jUU72SgDBaUqkWk1VO935eMJpV6ZeldFZZ6vcfhsG2jO+rd066ztLDxzPfaux5lbG
	 ZKHVJAXRkkL2cIXvRyUCPz1rROqU/hfKrK51xqokvy1CXCo5mik9POD+n+sbtb5pl
	 x3jOEZorsgBdq254sI7UYHAyxtVB1O2njRDagfdxmNwAWNDUeKe4yS35yJFWIz5N7
	 ajTCJ4IRzhvRP5mPwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([217.244.241.184]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpnm-1rYwKY3JIg-00pL1j; Fri, 08
 Dec 2023 07:42:00 +0100
Message-ID: <a6a23ccf-b571-49bf-855b-4fba3501f09b@gmx.de>
Date: Fri, 8 Dec 2023 07:41:59 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
References: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
 <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
 <09b41f73-33c9-4c82-82ad-09c51840149f@gmx.de>
 <d654be3682e545d09bc7ca7a91e1b58a@realtek.com>
Content-Language: en-US
From: ZeroBeat <ZeroBeat@gmx.de>
Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
In-Reply-To: <d654be3682e545d09bc7ca7a91e1b58a@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GTVpZNPu7kEWhm6/eOuVtVIJSkgi4tzIP4j9KTr714rwEXjizgV
 cdJpU1uJiXjXQo37GYb+i+va/4eUZ/cmTECcBl2VmSXTIrF44JjPOzh6+2CQuEfMDxhJHoI
 GgDy2ssdYvthF63pAB9lGtYhBiDJ7qF05dUlTSmtgXpgHPzNUeFyfZaHkeYI2ZAFA1HtbhU
 8ohmMCGx16595BfimTitA==
UI-OutboundReport: notjunk:1;M01:P0:GJem9NalXpU=;aOxvKBDYazYtHgyyJFaWcsurrSt
 LUjXUMWNsc90DbTRmi4TFyPNxF3JOjNqR53smoL2d2PFdJI19De1djUDXbM7EvdQxROmdY3qn
 OrFegLX/UxEYgkXzBy6qdqKOj+C6p2aa958onKWByLuwqQMOhi69qzQ1acf9QICRgQf8q/7uL
 AJhxykxG+o7sLC5FkM85Nl9PCru888EQ70XwSCGSK74BZYRY1nWDxqcZ6ppdMT1D/jV/pOFwF
 dY0qN/vOJsj5OoYkwZHTd7ZL9/T4Qd4onb/lY7BZvN8qzVixZJhLhXNI5V/K0OraEM/4o/mKp
 LEs3lRjhC3u6lYn/6HOMmyrvnMZoU66axyig1tsWLO7LRjUuE6OQZGSgjq54BGlOF+Aiz2iyQ
 aN6kQsI6ZZElDb4NW+ZT4mc1s8PRi40OEXGoAOfK/g7YEpmid2CxE4O9hcEzLDOpEMeFVYchm
 au8PGDO8cTqYJ0okcUQGDNnIcg9NWVtaGLHMNSkFuVafu+EXJKrnNLkY9bxOnuxOfCsWiQ+Dm
 Bri01rIyYDpvyiKZbyTWb/8Bukk3bL27+IudftT5qHIh+EKNa4SkXBocPhU0wPtH3X0zHLrbu
 fSt+87LWeZUalx6Oy20oLpYCLr4G/x/H1T10G4eP2SeAJ3ULFdouSI+Q0aPrsy1My1B4VpeSj
 dCAk8NCFaTAOO88uMUpN7h1C0cH90NsxcFHVjz4AleWZGr4f7Z0wmKMTdpYSXj1Gc9UjAiuOy
 4LjwL0VM2ioMFqndISW/ccoo5cUdwh0ntESJRs5EQEXZaLQ6ZofBKxOInGyit6sN5nO2nMz+n
 g4/zzRprhseG46Yh7i+7vtXXdNmjpyIH3eDDbI34sz7qWrQOfRBxy3e6sMgmElCio0VVxp2Vm
 U+diz0OeBuU8MqLnxHn23GgcavDyC4CHeBYHReCIWjUfADl2brAB4l6EF7p7M6BGgtICDZetd
 ciNOpUH84HwBV49Dq7l+ps7qu8E=

Thanks for this very helpful information.
It is much better to understand than this ones:
https://www.kernel.org/doc/html/v4.11/process/submitting-patches.html
https://wireless.wiki.kernel.org/en/developers/Documentation/SubmittingPat=
ches

At the moment I still have no idea why the TP-Link TL-WN8200ND(UN) v3.0 so=
metimes work and
sometimes not (after its device idea has been added).
But I have seen this behavior (rtl8188eu), before:
https://bugzilla.kernel.org/show_bug.cgi?id=3D217205
Confirmed and fixed, now.

Maybe the problem of the rtl8192eu is similar to this - but I'm not sure, =
because
I haven't fully understood the entire driver code (relationship driver cod=
e and
firmware) yet.




Am 08.12.23 um 01:43 schrieb Ping-Ke Shih:
>
>
>> -----Original Message-----
>> From: ZeroBeat <ZeroBeat@gmx.de>
>> Sent: Thursday, December 7, 2023 5:39 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: linux-wireless@vger.kernel.org; Jes.Sorensen@gmail.com
>> Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
>>
>> Is this correct to commit inline patches?
>> Looks for me similar to this one
>> https://lore.kernel.org/linux-wireless/20231127162022.518834-2-kvalo@ke=
rnel.org/T/#u
>>
>
> The basic steps to submit a patch are:
> 1. add this patch to wireless-next tree locally
> 2. git format-patch -1
> 3. run ./scripts/checkpatch.pl with your patch and fix warnings
> 4. git send-email to send out the patch.
>
> With above steps, your patch would be much similar to others.
>
> More detail can reference Documentation/process/submitting-patches.rst a=
nd
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp=
atches
>
>
>

