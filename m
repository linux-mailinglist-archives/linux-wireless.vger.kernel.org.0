Return-Path: <linux-wireless+bounces-21067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E54FDA78C6B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 12:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B797A22BD
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FFE231C9C;
	Wed,  2 Apr 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PgL+lvm9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99262AE77
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589968; cv=none; b=HDO/JJR9O/0beQm5T7n8hzFptMEisrImrqk+YuMp8NKn+irI70ekAmL6r0uCnIpNUApA2TUIPaW9zX/aXvXpwEjrJw5SvtX7OZh1E2UzRUDjfdmcPRBPqHxnBGSUfTe9z4cQgBgO4MBxwGOy2Wq75utuY6ArTACR3L2JwtQ+zqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589968; c=relaxed/simple;
	bh=DflGEPr809DcfvBjGzKFAjTDtAVQkAdsrnTtYfVENlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJ0tiveBmQDYS5howwHfrjq9tzyBBkf7whF0L3UqdU5EqvuT4p3Dm2laENVl9izV3SyCEpksBh7ZE+KTpsDlhGQtTMYdFyRYYKoNXkErXi2aoEke06PCZp9LYOxKuKoakviTfvXVIPAig8fglelUKz9jrE2orbHnmAN09Iop9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PgL+lvm9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac29af3382dso1036236566b.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743589965; x=1744194765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nYOlHkVubKmajyWk2RePk9qXc6Wg0yW0lVN0+PnWT+c=;
        b=PgL+lvm9k+i8Fg5CaweqNT43xf2GQrj++DMbQjwe5isn88ZXZnqM95OihRahEkQuPa
         3S3bbsjPhbp1MDzpAfwPDSRy1oZQ1vyMqC+xH+VwK7VlIGIx5GjRn88Q6buwcmJAs2bF
         uP5VSDQZ0wP8QUqzaScoVgmDfQkyQePscK6VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743589965; x=1744194765;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYOlHkVubKmajyWk2RePk9qXc6Wg0yW0lVN0+PnWT+c=;
        b=fhbBBzm3y8DGCQZ24xukoGnmX/PeZzcptuvhlGaTkTMFfGT3hf75TgZJzMfNE/7jtP
         H1KoAYIaFQvttCVUaXLIMjoKEScGpjZAZ9hAGGEglWT23M53idhoZ90oarjZjg+wpwOi
         R7l5CO9kymyg1zydP4TwC1yR+IqgShOdrjixIJIlZ5nhXGkzPGNQh5MR+3dffyn9cMeK
         CfZ62D5kUZ7a46K3L7UxaD5JVzOf8+Yt2Cs532ArUwbwhW1PRA+iNgvIaBovztPraQPi
         ZZpw60yzLW+10w81zl8DBdf+lj3+cacqhJahqFkA5fsFTkcCS9yVLUSPKpSNzA3Wxqxf
         X7JQ==
X-Gm-Message-State: AOJu0Yyflk3/63T227czyUiyWzW0hVSKJz0IqdECvEAtv3/XSEHPi3Cu
	fvYD4NfXPNSjtG8YATcQZeX2sE+28aZHKrM2hJgQM318YJBwcy7Qxo2vZnZQdzCaOZS0mYFJI+f
	k6QJ4
X-Gm-Gg: ASbGnctPQKEoUPWOesT7flVm96T6r8gBVQ9SXJzBxCdJNvufdLl4d2TfM0qae/S++T7
	kxJe76ymVx3OrXq4mJAy70lzQJNYZBIdF76jvAC1nIiRz2RVQjh+gai2jh11nDL1LidxG4CZrGH
	fBXJ6CmIFv/4vd5lmcNOVHSG8s90Pga7sTdsb83fQa+srsSI4Pltgnfg7+FpMENXIYrJJjv9Z6p
	4tWJz0n/4Wf9BDQbaq9ZlJQtB2yU2pmvWAV5iDeGg5o/HmlQncLQWPu0vZ17oZnH7/vBKy1mc+Q
	A67uck7DLfkTzTwkfXzeEicmjjvFMWHQNWNoSIbBzYyEEefg9HjDWWscxj+7YLq6t4aUlMZo8xz
	LGCOgr0+rYmdU08t7Li3e
X-Google-Smtp-Source: AGHT+IFpW0IH0OVPP0hG6AZ2A5rwiYPu9fXLTSAGYC9pCTSgRA4O68FhJ+pZ9v6TVJ0TMEq2caepXw==
X-Received: by 2002:a17:907:9445:b0:ac2:cf0b:b809 with SMTP id a640c23a62f3a-ac738a9c32emr1530190166b.31.1743589964962;
        Wed, 02 Apr 2025 03:32:44 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d2dd0sm8336324a12.21.2025.04.02.03.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 03:32:44 -0700 (PDT)
Message-ID: <866606d4-927f-4996-91ff-082037db147b@broadcom.com>
Date: Wed, 2 Apr 2025 12:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: bcm: rpi: Fix NULL check after devm_kasprintf()
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
References: <195f2498f70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20250402022215.42834-1-bsdhenrymartin@gmail.com>
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
In-Reply-To: <20250402022215.42834-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/2/2025 4:22 AM, Henry Martin wrote:
> Hi Arend,
> 
> Thank you for your thorough review and catching the return type mismatch. Upon
> further investigation, I’ve confirmed that this issue was flagged by static
> analysis but appears to be a false positive, as all call sites already handle
> NULL checks appropriately.
> 
> I appreciate your time and insight—please let me know if you’d like me to drop
> this patch or revise it differently.

If I look at the code I think the driver probe will eventually fail when 
the board_type is not available although USB devices seem to be the 
exception here. For PCIe and SDIO the board_type seems required so we 
could bail out in brcmf_get_module_param() when there is no board_type 
found, ie. returning NULL iso settings. I think I found another issue 
for SDIO. Upon failure it may end up with sdiodev->settings being 
ERR_PTR() so not NULL. This is not properly handled in the remove path.

So drop the patch and I will see if I can incorporate the musings above 
in some driver patches.

Regards,
Arend

