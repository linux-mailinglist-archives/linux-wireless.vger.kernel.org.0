Return-Path: <linux-wireless+bounces-1178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA5B81BF42
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 20:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A4C1F23DCE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A3651AC;
	Thu, 21 Dec 2023 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlP/440V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8420317
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso1521254a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 11:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703188430; x=1703793230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUQSXC447Peh52qUfhb6YAE5bwPvxHNsArXk5Pyx+vw=;
        b=RlP/440VjKe41grIKGVZjtwCH/1pi9fS8O6SAus6X7ORzZwSOmtS2/uYcKHKl4v08l
         yw2qdMVj+GIE8+i8YfoHWjr5kvuLoKiAmq7/TJ4aE52uwkblAiuYykCeXml8Lry7W7u0
         frvyY4hYUyVnCkmV6XF+oRb6GERq9bz1mtli+ihUt1c9MncxSqN5hy75ZZj1iyiTrCm8
         yIRg0RJ9G9FklYyfuarxaFtlRfgmb8lxFfrm1kivcxzTqLUcYTkyg3IOs3j1v3GZP+LU
         NZjSlXhxKKaZsGD+xhscMFg7tDL0sZNXklM1CgO5MqFT4XxhvWrtkTc74mGoQEsoZjXP
         yajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703188430; x=1703793230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUQSXC447Peh52qUfhb6YAE5bwPvxHNsArXk5Pyx+vw=;
        b=QQJAK7hnFGQJ1Zypc7K7qLAoDg6FDPE+7UChfqspsQWJGABHyd207OL7OvpYxFRIvU
         iz7K8nKPJ+AjJXq3e4kvtcOK0Xtui5jy/jpw2mMekqw7s68YWoBOmNr08R2uzY+HHq/f
         PJ++blCqyNpt+i913nc0xNF+hsrlUPd0lXf3Xsovh0iATevLwwkSeaVXgWllgvLkqg3M
         u89+LHLD9kL6jaSCb6EtA3cMgVanDIDebtK4Ej30VrjK06NHcuoXcD/64UQpud2ypOjZ
         dTmb8OvTTr2CjnCSeAd1HEkPnI+p+j5y+EtsTvRLC1Jz4b0vMCJyOgiRRtCQ5gff4bD4
         l0qg==
X-Gm-Message-State: AOJu0YxAYMmdJxEmTo7Y1hwEbgWMfs0mE9jd8FXNQVVEKvdqjHfJ9c2Y
	owp6qIbW6WI9ZqsCq1oV1HA=
X-Google-Smtp-Source: AGHT+IEcmi2PLtRq+OfQsyOVHWs17WWVmd5Qqg/EDha9jqJHygK7xp59ZFSBm5y24QldK6FVc9ClTg==
X-Received: by 2002:a50:9b16:0:b0:552:9862:42d3 with SMTP id o22-20020a509b16000000b00552986242d3mr50871edi.80.1703188430279;
        Thu, 21 Dec 2023 11:53:50 -0800 (PST)
Received: from shift.daheim (p200300d5ff3fe100aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff3f:e100:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b0054c7dfc63b4sm1588759edr.43.2023.12.21.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:53:50 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.97)
	(envelope-from <chunkeey@gmail.com>)
	id 1rGP77-00000001EHD-2gH3;
	Thu, 21 Dec 2023 20:53:49 +0100
Message-ID: <cf644ed2-6d75-4fc5-9a56-34541ef8eaff@gmail.com>
Date: Thu, 21 Dec 2023 20:53:49 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: p54: fix GCC format truncation warning with
 wiphy->fw_version
To: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc: chunkeey@googlemail.com
References: <20231219162516.898205-1-kvalo@kernel.org>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20231219162516.898205-1-kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/23 17:25, Kalle Valo wrote:
> GCC 13.2 warns:
> 
> drivers/net/wireless/intersil/p54/fwio.c:128:34: warning: '%s' directive output may be truncated writing up to 39 bytes into a region of size 32 [-Wformat-truncation=]
> drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 16777215]
> drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 255]
> drivers/net/wireless/intersil/p54/fwio.c:127:17: note: 'snprintf' output between 7 and 52 bytes into a destination of size 32
> 
> The issue here is that wiphy->fw_version is 32 bytes and in theory the string
> we try to place there can be 39 bytes.
Puh, I've been looking into /lib/vsprintf.c. Looking at the code, it seems
that it goes like this:

snprintf() -> vsnprintf() -> case FORMAT_TYPE_STR: -> string() -> string_nocheck():
| [...]
|                if (buf < end)
|                      *buf = c;
| [...]

which dutifully checks for overruns (i.e. before writing into the buffer=wiphy->fw_version).
So, thankfully no blind memcpy/strcpy is taking place here.
Though, I don't know if this could be used for speculation attacks.

> wiphy->fw_version is used for providing
> the firmware version to user space via ethtool, so not really important.
> fw_version in theory can be 24 bytes but in practise it's shorter, so even if
> print only 19 bytes via ethtool there should not be any practical difference.
> 
> I did consider removing fw_var from the string altogether or making the maximum
> length for fw_version 19 bytes, but chose this approach as it was the least
> intrusive.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

|ethtool -i wlx0014a535e989
|driver: p54usb
|version: 6.7.0-rc6-wt+
|firmware-version: 2.13.25.0 - 5.9
|expansion-rom-version:
|bus-info: 5-2:1.0
|supports-statistics: yes
|supports-test: no
|supports-eeprom-access: no
|supports-register-dump: no
|supports-priv-flags: no

(yes, this doesn't change the output of ethtool. The firmware version is indeed
much much shorter than 24 bytes for the firmwares I know of.)


To be honest, I would write something like: "This patch silences gcc" in the commit
message. Rather than trying to come up with a well-intended justification. But I get
why this happens. That said, I would like to see gcc envolve... And maybe then it
will add warnings that go in the other direction (i.e. it will complain that
this %.19s was unnecessary here) :D.

Acked-by: Christian Lamparter <chunkeey@gmail.com> (Tested with Dell 1450 USB)

Regards,
Christian

> ---
>   drivers/net/wireless/intersil/p54/fwio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
> index b52cce38115d..c4fe70e05b9b 100644
> --- a/drivers/net/wireless/intersil/p54/fwio.c
> +++ b/drivers/net/wireless/intersil/p54/fwio.c
> @@ -125,7 +125,7 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
>   			   "FW rev %s - Softmac protocol %x.%x\n",
>   			   fw_version, priv->fw_var >> 8, priv->fw_var & 0xff);
>   		snprintf(dev->wiphy->fw_version, sizeof(dev->wiphy->fw_version),
> -				"%s - %x.%x", fw_version,
> +				"%.19s - %x.%x", fw_version,
>   				priv->fw_var >> 8, priv->fw_var & 0xff);
>   	}
>   
> 
> base-commit: 4e87ca403e2008b9e182239e1abbf6876a55eb33


