Return-Path: <linux-wireless+bounces-4675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749887A821
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 14:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4A2283629
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9293B798;
	Wed, 13 Mar 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="SHuBU7Uw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DEF3FEF;
	Wed, 13 Mar 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710335752; cv=none; b=sXRIs53dTaEtKB8wpu8Si9CVLtFXgNv/7b4dVAB4gQCCUroXP+CkIkrFx/JO/oJPLhFP0dVJkaXp4jwg5EWh6nx4V+sySxaC5HeK5LkZRFI+24esGlHgzXNXJ0RzMjtMbCxasNVTbDaXg/VkI/llemg6B65PfGvkqw+QEvqkYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710335752; c=relaxed/simple;
	bh=niIAXP2a6FC1ELcNLzkENH9jKP9MG5yoJe5Xzct7vsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dr/PS2VwZz5mG4VTpeRBlBNuGnG9SnIdTXLEzdAFhDvzj4L/lhQLXPHGZhBarJaMcP9juMYCzBi8Czpph34qm/RMXXKof1sHHFK53XgLPXJ+wyOZT3VyELqS0uHa4ZxyM8LMUQEhZm3EStrxVIZW2JueKWdvWzgTG+zeZVyqlVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=SHuBU7Uw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710335737; x=1710940537; i=fiona.klute@gmx.de;
	bh=niIAXP2a6FC1ELcNLzkENH9jKP9MG5yoJe5Xzct7vsI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=SHuBU7Uwko3RYYxOGhMijABBghoAddZZ3vv8Rx4NS4EQRi3rVRNBuPfFDk6GX3/4
	 NJS1FceOgJJUvDXm1SiabAgzVblhmut4ah07Asw/f7clwO37C8miU2teWzmOHGMGN
	 z7XlmWndq2sn5SVsBL21wsaaEvltHHP1X0bSgfsP0RJFOzXSKTq0yCFTPtSIvk9oW
	 H17rkhfy9NF1ak4QZBlvkPY0HxCpE1pK4VycdNCh8GJSyrz4HmJcL4SwUhnGV8Yz8
	 9FhEhptWT9ct89rpJci7bHd4IoLW+qGeFf5tuvXaeQ1Avgn9yruGbtT2plwhpOks/
	 dkJwFLo/CO+FAP1MqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.118.51]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQv8n-1rPqlK1GH1-00NzZb; Wed, 13
 Mar 2024 14:15:37 +0100
Message-ID: <38fc27be-0e46-4677-bbe3-c0b9689dfbd5@gmx.de>
Date: Wed, 13 Mar 2024 14:15:35 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
To: Ping-Ke Shih <pkshih@realtek.com>, "pavel@ucw.cz" <pavel@ucw.cz>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>, "megi@xff.cz" <megi@xff.cz>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20240311103735.615541-1-fiona.klute@gmx.de>
 <e540243c657043f9a6d0a8d5314191d3@realtek.com> <ZfAVlEhsMwYMq9BY@amd.ucw.cz>
 <6c73784ecc04cadbcaae3f7e073ffb120e13853c.camel@realtek.com>
Content-Language: de-DE, en-US
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <6c73784ecc04cadbcaae3f7e073ffb120e13853c.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zO0sEf/uTvpLxr3SK13vjwkpoXW9+ivmYo0YIMmKBXyr+Qym5aM
 iS+4WPsn5FtMOP/JdkR3c/ylG5CHaAgURO3fPlinJY0OzI3Qu3TyYjX7zoE8EQ0weTsq8uo
 JcH/+W6lUXyQ+u7HqGDQZ+QU/KcnQ37svieaMpfT2L+GwOjdsPoOjVIBTg9spBsevg74HRp
 jjKNXhNTRWxh8D7MK9iaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/T4KMR+DYIM=;gk5j3+3DiQlG5vZ7jOi6WwfVYYJ
 JMYWQQU40qW412NLBW1P/YSV5pilJrS12Lw3YbZZanSUyeC6hcPgkZeOw+bias/yeD/t6XoVm
 TP2TFK8oslTBk/mx//aOyuTpfHL7pR4kLXOdO5BQQrIn2uPsBqb1XpIjqw6uuwLBRsI5VEoZ8
 hxZsFSJTvQy/LOdImClLFMmVQOSOKDos7L8KW6PWeVDdvAWav0IXhqJtJC3wxm89A+F8tq11G
 1xASsDBLRyePfMC9ff6Clv+rwwfjhH8ic7+8fIX/bnmvdV4cV5eRYp+2vtiDxjW6OWyhZN+ZX
 BF0rjIIbIcqRbi0nOlqU9MplVccP7wD8jPRLzoD/g5/PyXOJBq3GSJkxJWNc9n67kPqDF8pjd
 s67roLX4yP34lAyhKnKfMeDocJ7Ow9wKLsVbpIRy7VHxhWfSb2bxOuyrDlH1XUqDAQzsbptOQ
 034gZzYZ9qgnRN7HO709K2HqoS3wTdoVSK18PmNNrOHe5ihlBYxnOyJtWXZiUgon6FSb/hbes
 M7oCAg9aK4VRqWv/Y/4K+qgaQ5qu+LG7y1EeMjWupZfFPwR6OA6vbnk3kGiCc26h0fdvIAxOi
 zMOS42nepuCnK2GmW4FGnlB72VqFV0Oy2KGoPkiiKuzPnwKbOsgSMa0+GY5bNowr6LZkfsyI4
 evBz0oDIhzrNq1Eh7x4YAV/pG6RLkGv76MXSluaSnrme5u+ScLdmwZTE3NQcaf6aD2UscL0La
 st0BbAZnTKAfgLMBU7s4zPoGrIm4TRjAMx8H3Yq/USJa1jL9pqpqO1oSNaaGgwCl6tL5hnNqB
 zx8RR3plBh8qXZgJZ5gTVHm5nENnCs80J8E/m00LQoNT4=

Am 12.03.24 um 10:00 schrieb Ping-Ke Shih:
> On Tue, 2024-03-12 at 09:43 +0100, Pavel Machek wrote:
>> Hi!
>>
>>>> v4:
>>>>    * Move definition of GET_RX_DESC_BW from rtw8703b.c to rx.h (now i=
n
>>>>      patch 3/9 "wifi: rtw88: Add definitions for 8703b chip")
>>>
>>> v4 looks good to me. Thanks for the great work!
>>>
>>> I also have run sparse/smatch with v4, no warning/error.
>>
>> Does it mean you queued the patch, or is someone else expected to do
>> that?
>>
>
> I mean this patchset is okay to me, and Kalle will help to apply this
> patchset to wireless-next tree. I suppose next next kernel v6.10 will
> have this.

Thanks, you two asked and answered the question I would've asked
already. :-)

Is there anything I still need to do to get the firmware into
linux-firmware?

Best regards,
Fiona


