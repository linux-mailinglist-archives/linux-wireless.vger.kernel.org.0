Return-Path: <linux-wireless+bounces-26054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8B9B15ADC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 10:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C859B18C01BE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 08:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3853C26529E;
	Wed, 30 Jul 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzFWRwQJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF41DF244
	for <linux-wireless@vger.kernel.org>; Wed, 30 Jul 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865159; cv=none; b=VVyv7bkSvHWVT7mpZUMasJuLbA2VQvu7/9XTPpxBdyF6qPS/bzS5kRiF5KQv/QYvlGgo3n74iv6zOpbU86JszCxkK2k9JpztXVE8kiLI654iRFbij4xsvISgvTPgwjY8uEks2m8uroUCOEiy7BhK8Xb674ieZo5EMefSnTmJnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865159; c=relaxed/simple;
	bh=wXb9mb3IJA/sRlDOiaVm4qMN6vs2/7p445YfZx+J7zE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=EnH0x6q/z5SGNFsktxaW9v3A1t6+xM7gNzrwUxWqcFuK6V8ca+LiSfWoB0kGmOCJvZ2CjmGPWkODQZg87gkztIIkuug6HCef6bBV57sp+EKJJcCofZZ1V+ALmm1crrRK0++AkG+75LsbmKP9yPUgUOsZg34MKrRTcubLY7bf+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bzFWRwQJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b786421e36so370660f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jul 2025 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753865156; x=1754469956; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vouVbFy9H2IeEfXvCQei0Ugeqqqv+KVoaiQc9t39ZLw=;
        b=bzFWRwQJyztthkRC7vu9NDgBYokwB4cXpagl+uXMeu7iu42iijXgFFtufbZYjx9YzQ
         L3TytIjLHNvbDDBEKXN273AOyMNFk8u85VgJR/dswrRj/oRbAgChwZwZTZmyD5GAJ9Aq
         1MDEW6S4hQ7WRqyx2eZEzuAUCxq2oVNMFzd1AHshC4dUZymIGnHIUtsWiiMnrT62bUNY
         4aL+efQaDq5n8IlsEDT2KzcekNJUzrxfoMpNBTP2IpYTJ8vBfD8+5v4Z2IaETOv3Io6H
         FJAxlE1GG6945PFFmuols9dZMCU15T9egQUqH5oe3JwSd/bng1yTCw2U7qfGTkf2eeC5
         5pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753865156; x=1754469956;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vouVbFy9H2IeEfXvCQei0Ugeqqqv+KVoaiQc9t39ZLw=;
        b=cDPDnqKym6EYBMqTAOajulcbT+KLqnHhETGDJRtV0Z/+rJxwfVxw7qLtKxZZFNaGYT
         n5aYW9w+KF0qIye9u5D2SWOp/7MoxMXwx0mYQhEbLHUwQOtG4JtWd+mbDCpWmD6sSY+N
         7yUgcDkj3Ap8pMVjjaX+7vK5NmkVU5rqp5ClZUOJlhitQYv5+s2F0XQ+BFEI3q2N/dO2
         8potasN+Zi8YIpOVPI2hWLJN/rv8nn5K0PE7G5VYUF+00ecPsfODT0kTjtqGs5kS+af7
         dtWe1eFOo5hrrWzpCwrNVB/uBw3+ES9oAQNEVNhJjkq72claHhZSdOGIqnGRQzEbs/Sw
         0YOg==
X-Forwarded-Encrypted: i=1; AJvYcCXXVIAteJra+SWFqavocJDAjavIIrTXS1yVOvLj0Avg83nfoTr4ZL2d/5dGqa7M6X4I/e0n6hxZBo3N7seMOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8/hDQJRW9HsR9buyWXFVK2kZVzjv7b/XEgsJcd7DCtikjtSh
	CV/4ua46dvge5jewy+LqLkhOJu721U0h1NLQpMptutJaS1tySkIOTEXFAlcjVjpNqNg=
X-Gm-Gg: ASbGnct4JiJ9qSDB86vTrzthXOxbYqup4/yEnw8w6lcbLlQjKOZbfhWP7WNweeXlZaS
	4ox36aJPHSQUJb8DPwYEIia6JfjMcYZzbifr4eDffE7zq5UdZAlj7q0s04GjlM3+STWdmeeX4zD
	FRGv+6epiWdo16CCtTRcwzoumQzGdc6sJUXO+1Du8Ve4+7Ejm7s+hTr9YWh1bemsKz768Q3Zz89
	6eX+6xybjFxVlAvP2n+2HtiXogr4VJQ02dKv5BF+T2oNvuuHrik+Jyf710cGd1mw+GeEpZE8lj5
	NZ5/BikfGQGZf/Dsmp3jUJrjAErFwJDE2MRWUS48SohB5eONq2GAm3B2r/E6xjSxWM5AFNfzM3t
	nDpFuCwC/NsS2+FlFURXqZ+WktA4DcfwKrq6CZA==
X-Google-Smtp-Source: AGHT+IEsUJXHb9Fu+wIAFpOOr9CxkUbkz4FbUxP1vAkQqZyqMp+yCtAvMXAxm0CSLECgSmHegl1DYQ==
X-Received: by 2002:a5d:69d0:0:b0:3b7:899c:e88b with SMTP id ffacd0b85a97d-3b794fe4da0mr1639575f8f.11.1753865155466;
        Wed, 30 Jul 2025 01:45:55 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:2e51:f80e:a7b5:16f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589aefaa44sm9422155e9.20.2025.07.30.01.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 01:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 09:45:54 +0100
Message-Id: <DBP9B4ZMXOMK.1QLITVTW393YI@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: <jjohnson@kernel.org>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <jeff.johnson@oss.qualcomm.com>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [question, bug] regularly disconnecting wifi on RB1 and RB2
 boards, ath10
X-Mailer: aerc 0.20.0
References: <Zgp0ym-MGzX2eSZdlkVYbgvjkJ0CzKItjaC5pafzQnj1AOZnVAqvCIZfYoK7nwDhUgOA0U8eNolNtaWXbExOAQ==@protonmail.internalid> <DAWJQ2NIKY28.1XOG35E4A682G@linaro.org> <5df11ee4-d645-4be2-841f-715343f1b7a4@linaro.org> <CAFEp6-0zwy2JdFOvRQ5ghMwD-J6b7F5YcVKNf-5R=8XdEpGDSw@mail.gmail.com> <CAFEp6-1wO9xwisOAtv6D__nb3Uo=8_f9rHifi-JAQ0oPD+JSVg@mail.gmail.com> <DBKDAXJ0V9U0.10YYX5H5HAJBT@linaro.org>
In-Reply-To: <DBKDAXJ0V9U0.10YYX5H5HAJBT@linaro.org>

On Thu Jul 24, 2025 at 3:50 PM BST, Alexey Klimov wrote:
> Hi Loic,
>
> On Wed Jul 23, 2025 at 11:42 AM BST, Loic Poulain wrote:
>> Hi Alexey,
>>

[..]

>> Could you check if this change helps:
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c
>> b/drivers/net/wireless/ath/ath10k/mac.c
>> index c61b95a928da..4fa7dd62aeac 100644
>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>> @@ -288,8 +288,10 @@ static int ath10k_send_key(struct ath10k_vif *arvif=
,
>>                 key->flags |=3D IEEE80211_KEY_FLAG_GENERATE_IV;
>>
>>         if (cmd =3D=3D DISABLE_KEY) {
>> -               arg.key_cipher =3D ar->wmi_key_cipher[WMI_CIPHER_NONE];
>> -               arg.key_data =3D NULL;
>> +               /*  Not all hardware supports key deletion operations. s=
o we
>> +                *  replace the key with a junk value to invalidate it.
>> +                */
>> +               memset(arg.key_data, 0, arg.key_len);
>>         }

So far looks good.

I didn't see any kind of GROUP_KEY_HANDSHAKE_TIMEOUT messages and long wifi
outages leaving the RB1, for instance, overnight.

I do observe some packet loss while pinging the board for a while --
around 0.1..0.6% packet loss but that might be because of my wifi network
and absence of external antenna and it is still much much better than
default behaviour.

Could you please add me to C/c when you're going to send it over?

Thank you for looking into this,
Alexey


