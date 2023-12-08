Return-Path: <linux-wireless+bounces-576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD64809D3C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 08:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A602D282729
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 07:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C0C10780;
	Fri,  8 Dec 2023 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="iUzZ0Out"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F3A1721
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 23:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702021056; x=1702625856; i=zerobeat@gmx.de;
	bh=C4rTA2zpZU31BmjWwnFs+nhXHpERgvSqyOqlzRcfxrQ=;
	h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:
	 In-Reply-To;
	b=iUzZ0OutxJsXFIpxc1ApwNNp9j/DYEdTylmN+Oyp3DWKsXS9LlYfdN1vlqMCXa8V
	 5C410fGkAKoZRZPdMhZiPFP1VZoJ+wnyMfja/Pl+nQxgjxX1IpXT/eNHZkg1N8xK6
	 R9RyD4q99RkOAg1DRiHoTJ/Dun20k67MvaisUMtpbzCeWB6ZpuwaKc+fUm4BBuQjc
	 pSx5SXpohscS1VUMMrzdaexUuDlDI0UlUrwv0LWSlEfhQHwk8gYLcwOsDz8bZ27ix
	 zonWk7v8eedWTwreoUCQMVVp4RFX4Ovxh3LLVdxsko2al1rJugRnY/x0PdnBrk11p
	 2pmo4l5DVyAidrmxPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([217.244.241.184]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1rScTL1yBn-00rqHg; Fri, 08
 Dec 2023 08:37:36 +0100
Message-ID: <62d86532-ca57-4c61-8662-9d615e587c97@gmx.de>
Date: Fri, 8 Dec 2023 08:37:35 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
References: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
 <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
 <09b41f73-33c9-4c82-82ad-09c51840149f@gmx.de>
 <d654be3682e545d09bc7ca7a91e1b58a@realtek.com>
 <a6a23ccf-b571-49bf-855b-4fba3501f09b@gmx.de>
 <05c047080464492b8701f4e6a45c7cc2@realtek.com>
From: ZeroBeat <ZeroBeat@gmx.de>
Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
In-Reply-To: <05c047080464492b8701f4e6a45c7cc2@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/JpP3Fq7sAiOYUOQnTWMvjQnyB4xqHrNmN3FA19c7U/0ggdU95K
 IvxSBBBw1WBtzE+qHLVkJLDiAQUuLKh/FB4h0gKp8CMlpctbMz0GMnaj9YLOBL8ikschVQZ
 XuB+B7UHd95wvjMYw8M+9PGpG7gCIQy2Eeh6O1Imza8Ya2wbtki22JEjRylrStUEiJFciJJ
 /kNJhFnNYoS2bDTLMZrHg==
UI-OutboundReport: notjunk:1;M01:P0:EmmVFIhA/94=;gRm+nlnjcuo+UWFkn4MMM3DxoZE
 E/bzIG4C0H9C80fB7vzPev1H3uwtILr3NRoi95BDVlkbo8pdBMvppxogFOFvM7b709bH2u1L1
 8NGcVo7oNX6OwLszHanf9AXbxfbi422wCfNprIsRI5ZuFf7RXmAev6XWHWIq0mfva59vi2sKA
 lmzmXYpkTxs7DfpJcBFMM+ipDCzlz/wVOrmG9VxpvRKjY+l9IETud608JOF6D/sOUVP7N6juC
 9WqQbe2E144w7Ik23IQcmIqFcjR2KZuLi8dlZkg2bby+APFb2hrYs0uklGXGHSuj89ajBJs9J
 FqIgvmGQk2hqo1bahscUm6gQg+FNAF7Z4khozzPXLmUHbiRyMYhBibgx9hNiuCfc5SqGQ4Oq4
 XO9GU1JfpjQhi0wIpQoilt75xb5q6qrLs+QIPa5uhuzLDcTlQjlhNGD7en5vNNkSy42Bn8QCH
 8lUo0ACCPIbtjPz4G6DqL1jtDJvbJaVDPwM/lcP27qEz4QSR05HBYB/7JDkH4o+pB25/0tZpG
 Xuw9DgDWc+QYEm0zJJgi8SJaprcUzPRmXYzAEDh3YxOEz+lXwk1p/olitcK+V+ZNFcgfUQsge
 q8HLYDLDabcjEvCc0SUjbvMUMrb9aKJaJSg3tgSCp7G136lR+DV61mevnsuMg/9cgzbrqcfZu
 7tO7g/LxRzLmfTdBBBcooEwsSXZ/XFTqAWP1WdZ9f1y4vagAvFddXdfFGlx7DOX4ytCDnsNFY
 rLV0acgCT0PkzT6O3jhF1AjjA322SP9OgXLs3ZjhYYVoaEpn7ULz5WEbeprPGL2pXOhaDW0KM
 1eYGDwk53z1fA/PoA3XCEh8RpbAK7fUqiHBJCFHTkQmH6f+6E1BybA7mu2UiGO9yZZTNP6WkI
 B1KuvwrPgn4gbXGmV4it85F1VCql4qjWdoyGG/ugcajBVUFzFxBeD3gIpxvLQDyh+AiSSMtUB
 rtMvbEJ9s8WRABksM6B36HU8Nd0=

Thanks again. Now I'll continue to hunt for the real problem
which is a more a general issue (device do nothing)
than a performance issue.
I code penetration testing tools. This tools should penetrate
the target only and not the used driver on the host.




Am 08.12.23 um 08:01 schrieb Ping-Ke Shih:
>
>
>> -----Original Message-----
>> From: ZeroBeat <ZeroBeat@gmx.de>
>> Sent: Friday, December 8, 2023 2:42 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: linux-wireless@vger.kernel.org; Jes.Sorensen@gmail.com
>> Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
>>
>> Thanks for this very helpful information.
>> It is much better to understand than this ones:
>> https://www.kernel.org/doc/html/v4.11/process/submitting-patches.html
>> https://wireless.wiki.kernel.org/en/developers/Documentation/Submitting=
Patches
>
> The links describe more detail things, and I think you will need them if=
 you
> keep submitting more and more patches.
>
>>
>> At the moment I still have no idea why the TP-Link TL-WN8200ND(UN) v3.0=
 sometimes work and
>> sometimes not (after its device idea has been added).
>> But I have seen this behavior (rtl8188eu), before:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D217205
>> Confirmed and fixed, now.
>
> Sorry, I don't have much time to look into the thread, but as the title =
mentioned IQK,
> I would say IQK can affect _performance_, so keep distance of your usb W=
iFi stick
> about 50cm far from AP, and check it can work stable.
>
>>
>> Maybe the problem of the rtl8192eu is similar to this - but I'm not sur=
e, because
>> I haven't fully understood the entire driver code (relationship driver =
code and
>> firmware) yet.
>>
>
> You can search for a vendor driver somewhere like github, and then try i=
f the
> out-of-tree driver works to you. If so, compare their initialization and
> set channel function basically.
>
>

