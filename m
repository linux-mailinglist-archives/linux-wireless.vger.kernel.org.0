Return-Path: <linux-wireless+bounces-15836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDD79E0D54
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 21:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28407B2809C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 20:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C921DED67;
	Mon,  2 Dec 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H7aRhd3z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B71DDC24
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171277; cv=none; b=Cf0mPoqNgMlUXC5GUDsJmNhsl8M3ya00HlastXhZqN7sZLITdfGwiLmNUqjqhnaJN66ikQA7OveU5MZPJNoA4OuKkdiGpjmVC9RPbZiM7yTdGlpSZ8UlOCf1N/f6KVB0tBYZ7dxoIVa4C61ko09z+4VoKJB0dIL0GICxJYGgEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171277; c=relaxed/simple;
	bh=5UsMyenfVe2NzwTlQ934BMODe4oN9+zkJrUUqHtlfI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZt3mNgNbUssYPySfYozuQypqxhlHJFfGCg47T7Nv+YSGuF4hITVChU6di//pjwcRIMCRF4GCu/K4AlbF8zO7fPDpN9p6Enq/xwHtphVg2i8u8cB3NuYlO9jwnp4i47oOOp3NnSbAzBr1kxc0Fq+f6ONDhwbNGr76LzOJqMCIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H7aRhd3z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a044dce2so59255145e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2024 12:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733171274; x=1733776074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GRii34E74/5BieysLj2tCvjnWiSH93zrCDLfAJ9tWQ4=;
        b=H7aRhd3zjcHseqLedB/hid8qE1lnZgRWT75VMWDG226cyx/EhSOhE+XvkZeTabUwSd
         oeaZsUHQ5YYqhZa6S8Z/IF636AVo+C/TM/JIaPcEhNrtDQo3HkUfiFdxeW6B9pwwD5FA
         gdpeNenooSSA/kXwcbH/eZGZr2cZDzji4M8X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733171274; x=1733776074;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRii34E74/5BieysLj2tCvjnWiSH93zrCDLfAJ9tWQ4=;
        b=wG9v5F9q3gpVccrt6cIR3N8wcg0g10hUjLMGloS4ONWU6TT1lq02bandhAGvjEyn6g
         H3DgogpFplWDd7EoXqNJBJaGoqAsnfkRugvQkY2uvTICtGYBHFJeQ29PZu/D0suRRwvg
         Xk+GFzrEXn+cPy96aeQnIVi0/5MwGtyBX3JPIrqsrcSM7YiXEmVOl+Ict1CY9C+HVMF8
         uXJmtWXCQcLHXCpjDgXijO9g4h2rXP3X1VivLfx4czNgRKPo+8rCXZhafyqPIdYXWDUK
         zrFMGkxEnJa14DDm9aXFVksy2AYn1x5zmyLBGI/xr3fcArGELakv49/pdLEpQi3gz/yD
         4ijQ==
X-Gm-Message-State: AOJu0YyoYku3OqjbUppCCcoX3uS3+LzWalglMEmsKiPyv00N6PxpVDjw
	+m6Yx+VWM5lF/CYbpTBxC2+noalINbzrHNwABvY9660HCXoKC2oVRKAAg8pvPw==
X-Gm-Gg: ASbGncvuuM2jaepGHnUlXq7WtH5zN+7IjN44u4xIa/28vEU1iLbs5lFgFC0wSKKIusE
	imgjS/4V3qpsxMHCPkITGpc1rcPJz78EhhJr+SQG8bS/VOXK1qoFmufOZfBo9hGRRsjIvZRjDdG
	h4UgRpVVxBpCyHd5SqG81aM7d/It016cE/9TzhVjoyJe296uDZ6gGgVJQ+9Ga49d25x3uxTi01h
	gO6oQBh6Ej7SY7f1lcS7BuuR0zbRCjfoIdxUqn1VutPhpXllBYZ8cIJuVxBKphaXCnrf2YsYdvU
	BfMVjEtT9f59M2wIYw8cI80yRA==
X-Google-Smtp-Source: AGHT+IFKAFQVi4hZJOAz9rpt9WPu/wGDz/9efSCRn8dQPaY6k8MD61a7ruPcuK05vlZ4J/Bkoktj5g==
X-Received: by 2002:a05:6000:2c4:b0:385:e9de:d521 with SMTP id ffacd0b85a97d-385e9ded93amr8439556f8f.8.1733171274056;
        Mon, 02 Dec 2024 12:27:54 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e19104a0sm8966934f8f.32.2024.12.02.12.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 12:27:53 -0800 (PST)
Message-ID: <28fe9c8c-1013-4f21-a994-23a404c40d46@broadcom.com>
Date: Mon, 2 Dec 2024 21:27:52 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: KeithG <ys3al35l@gmail.com>,
 Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Cc: linux-wireless@vger.kernel.org
References: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
 <20241202042100.6384-1-renjaya.zenta@formulatrix.com>
 <CAG17S_O03v6YAK2aUa9kN7ZGgCk2=Lb5B6KeX9qihfFTJPZikA@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 xsFNBGP96SABEACfErEjSRi7TA1ttHYaUM3GuirbgqrNvQ41UJs1ag1T0TeyINqG+s6aFuO8
 evRHRnyAqTjMQoo4tkfy21XQX/OsBlgvMeNzfs6jnVwlCVrhqPkX5g5GaXJnO3c4AvXHyWik
 SOd8nOIwt9MNfGn99tkRAmmsLaMiVLzYfg+n3kNDsqgylcSahbd+gVMq+32q8QA+L1B9tAkM
 UccmSXuhilER70gFMJeM9ZQwD/WPOQ2jHpd0hDVoQsTbBxZZnr2GSjSNr7r5ilGV7a3uaRUU
 HLWPOuGUngSktUTpjwgGYZ87Edp+BpxO62h0aKMyjzWNTkt6UVnMPOwvb70hNA2v58Pt4kHh
 8ApHky6IepI6SOCcMpUEHQuoKxTMw/pzmlb4A8PY//Xu/SJF8xpkpWPVcQxNTqkjbpazOUw3
 12u4EK1lzwH7wjnhM3Fs5aNBgyg+STS1VWIwoXJ7Q2Z51odh0XecsjL8EkHbp9qHdRvZQmMu
 Ns8lBPBkzpS7y2Q6Sp7DcRvDfQQxPrE2sKxKLZVGcRYAD90r7NANryRA/i+785MSPUNSTWK3
 MGZ3Xv3fY7phISvYAklVn/tYRh88Zthf6iDuq86m5mr+qOO8s1JnCz6uxd/SSWLVOWov9Gx3
 uClOYpVsUSu3utTta3XVcKVMWG/M+dWkbdt2KES2cv4P5twxyQARAQABzS9BcmVuZCB2YW4g
 U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPsLBhwQTAQgAMRYhBLX1Z69w
 T4l/vfdb0pZ6NOIYA/1RBQJj/ek9AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQlno04hgD/VGw
 8A//VEoGTamfCks+a12yFtT1d/GjDdf3i9agKMk3esn08JwjJ96x9OFFl2vFaQCSiefeXITR
 K4T/yT+n/IXntVWT3pOBfb343cAPjpaZvBMh8p32z3CuV1H0Y+753HX7gdWTEojGWaWmKkZh
 w3nGoRZQEeAcwcF3gMNwsM5Gemj7aInIhRLUeoKh/0yV85lNE1D7JkyNheQ+v91DWVj5/a9X
 7kiL18fH1iC9kvP3lq5VE54okpGqUj5KE5pmHNFBp7HZO3EXFAd3Zxm9ol5ic9tggY0oET28
 ucARi1wXLD/oCf1R9sAoWfSTnvOcJjG+kUwK7T+ZHTF8YZ4GAT3k5EwZ2Mk3+Rt62R81gzRF
 A6+zsewqdymbpwgyPDKcJ8YUHbqvspMQnPTmXNk+7p7fXReVPOYFtzzfBGSCByIkh1bB45jO
 +TM5ZbMmhsUbqA0dFT5JMHjJIaGmcw21ocgBcLsJ730fbLP/L08udgWHywPoq7Ja7lj5W0io
 ZDLz5uQ6CEER6wzD07vZwSl/NokljVexnOrwbR3wIhdr6B0Hc/0Bh7T8gpeM+QcK6EwJBG7A
 xCHLEacOuKo4jinf94YQrOEMnOmvucuQRm9CIwZrQ69Mg6rLn32pA4cK4XWQN1N3wQXnRUnb
 MTymLAoxE4MInhDVsZCtIDFxMVvBUgZiZZszN33OwU0EY/3pIgEQAN35Ii1Hn90ghm/qlvz/
 L+wFi3PTQ90V6UKPv5Q5hq+1BtLA6aj2qmdFBO9lgO9AbzHo8Eizrgtxp41GkKTgHuYChijI
 kdhTVPm+Pv44N/3uHUeFhN3wQ3sTs1ZT/0HhwXt8JvjqbhvtNmoGosZvpUCTwiyM1VBF/ICT
 ltzFmXd5z7sEuDyZcz9Q1t1Bb2cmbhp3eIgLmVA4Lc9ZS3sK1UMgSDwaR4KYBhF0OKMC1OH8
 M5jfcPHR8OLTLIM/Thw0YIUiYfj6lWwWkb82qa4IQvIEmz0LwvHkaLU1TCXbehO0pLWB9HnK
 r3nofx5oMfhu+cMa5C6g3fBB8Z43mDi2m/xM6p5c3q/EybOxBzhujeKN7smBTlkvAdwQfvuD
 jKr9lvrC2oKIjcsO+MxSGY4zRU0WKr4KD720PV2DCn54ZcOxOkOGR624d5bhDbjw1l2r+89V
 WLRLirBZn7VmWHSdfq5Xl9CyHT1uY6X9FRr3sWde9kA/C7Z2tqy0MevXAz+MtavOJb9XDUlI
 7Bm0OPe5BTIuhtLvVZiW4ivT2LJOpkokLy2K852u32Z1QlOYjsbimf77avcrLBplvms0D7j6
 OaKOq503UKfcSZo3lF70J5UtJfXy64noI4oyVNl1b+egkV2iSXifTGGzOjt50/efgm1bKNkX
 iCVOYt9sGTrVhiX1ABEBAAHCwXYEGAEIACAWIQS19WevcE+Jf733W9KWejTiGAP9UQUCY/3p
 PgIbDAAKCRCWejTiGAP9UaC/EACZvViKrMkFooyACGaukqIo/s94sGuqxj308NbZ4g5jgy/T
 +lYBzlurnFmIbJESFOEq0MBZorozDGk+/p8pfAh4S868i1HFeLivVIujkcL6unG1UYEnnJI9
 uSwUbEqgA8vwdUPEGewYkPH6AaQoh1DdYGOleQqDq1Mo62xu+bKstYHpArzT2islvLdrBtjD
 MEzYThskDgDUk/aGPgtPlU9mB7IiBnQcqbS/V5f01ZicI1esy9ywnlWdZCHy36uTUfacshpz
 LsTCSKICXRotA0p6ZiCQloW7uRH28JFDBEbIOgAcuXGojqYx5vSM6o+03W9UjKkBGYFCqjIy
 Ku843p86Ky4JBs5dAXN7msLGLhAhtiVx8ymeoLGMoYoxqIoqVNaovvH9y1ZHGqS/IYXWf+jE
 H4MX7ucv4N8RcsoMGzXyi4UbBjxgljAhTYs+c5YOkbXfkRqXQeECOuQ4prsc6/zxGJf7MlPy
 NKowQLrlMBGXT4NnRNV0+yHmusXPOPIqQCKEtbWSx9s2slQxmXukPYvLnuRJqkPkvrTgjn5d
 eSE0Dkhni4292/Nn/TnZf5mxCNWH1p3dz/vrT6EIYk2GSJgCLoTkCcqaM6+5E4IwgYOq3UYu
 AAgeEbPV1QeTVAPrntrLb0t0U5vdwG7Xl40baV9OydTv7ghjYZU349w1d5mdxg==
In-Reply-To: <CAG17S_O03v6YAK2aUa9kN7ZGgCk2=Lb5B6KeX9qihfFTJPZikA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/2/2024 3:23 PM, KeithG wrote:
> Renjaya,
> 
> Thanks! I am assuming this is done by setting a flag in the driver?
> Can you detail what that is, exactly?

You can pass module parameter 'feature_disable=0x200000' provided 
DUMP_OBSS feature id is 21.

Regards,
Arend

> Keith
> 
> On Sun, Dec 1, 2024 at 10:21 PM Renjaya Raga Zenta
> <renjaya.zenta@formulatrix.com> wrote:
>>
>> I believe those errors are not fatal but I still hope this can be fixed
>> in the kernel (or firmware? (or wpa_supplicant?)).
>>
>> Fortunately, you can disable DUMP_OBSS feature to disable dump_survey
>> which triggers those error messages.
>>
>> See: https://github.com/raspberrypi/linux/issues/6049#issuecomment-2485431104
>>
>> Regards,
>> Renjaya


