Return-Path: <linux-wireless+bounces-876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0DA815FAF
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Dec 2023 15:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3BC1F227B0
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Dec 2023 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2740444C69;
	Sun, 17 Dec 2023 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4/vlnQM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89944C6D
	for <linux-wireless@vger.kernel.org>; Sun, 17 Dec 2023 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6da69dd6e9fso170873a34.1
        for <linux-wireless@vger.kernel.org>; Sun, 17 Dec 2023 06:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702823111; x=1703427911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JaruYLBpxOe11f0w4ZrXFrPCNSuKLij2ih8Un7LEe3w=;
        b=f4/vlnQMMw/Xkx3kO9ufET3VCnI/sdsERDmMq+xoNtRCA4cS+7jYNGqdluPgUNI2cf
         IB0ygcVZJXANJAPElxBFuCZkfKn2ZakuPvioLpslae3z9ymSL7mAya+oZIoQmB+qcznY
         w1BsWSK0VisVoWsj1KWkqoFMciWN4GgVvZN2GeiDYX0Chk+geGrzUNdT6IixqUX8prtp
         qIXUR4VKJE631I8zHzrh0AFkCS53gp/iSN7DS0ECuXk0w7/JWn5yKNxIhP0arAGlW5cq
         iIItq7W9yIwtowm3L5g/BbkqgsLmNMUsjDlZq11VyiQQ5GpIxW24YK0XXLl13XgExg4R
         QGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702823111; x=1703427911;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaruYLBpxOe11f0w4ZrXFrPCNSuKLij2ih8Un7LEe3w=;
        b=M4DucTOxVSp86KHJen6dh9WIWSdDt7i+Feb/mtC13sXR4oYpRKlIHVRPCnp1PIU9Ah
         CqKfXHsG7kSDatH7vXJYLQQShLTfwDFfYVDhD4LEDB424X/JGEl6LKgxbE0fpcggAEbw
         fw6LVPG1ul3EchwZtP6p7Mq7SbdtK1bj+2bBbcOEZq5mD4uebXpAHdB3tn6M9zCq9vED
         r+hMoWIqw0JRO15iRiIj+n8W/Mju7gXiMG8/Q1LuUlqW1p+H2UDNGI6eUkTpWdzzIY/h
         DmF0ZjKkNn3AaGzcgr/xsQq7zRVwxAhYpa9NHch+aHtq2J9D+YS9DjfLyPmV0JvCO4g+
         RFlQ==
X-Gm-Message-State: AOJu0YyV2tKsU6cqlIB+yAeH/QY85DbpWw+zQjKg97y/jOveM/FYWktw
	j/slUyXNDzHghT7KJS/5X+hk2TZBQFIARw==
X-Google-Smtp-Source: AGHT+IHodXVO2yDRyoXy8lFZbaPpHlX8OGHmJkQLEVhaXD++8qts1QfB2wqPYhWwy0Ue8+JU+x2oKA==
X-Received: by 2002:a9d:799a:0:b0:6d9:e4e3:9680 with SMTP id h26-20020a9d799a000000b006d9e4e39680mr12683272otm.3.1702823111233;
        Sun, 17 Dec 2023 06:25:11 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id h16-20020a9d7990000000b006d9d8abcdeesm4447728otm.40.2023.12.17.06.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:25:10 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <47021a54-f4b7-43ca-acd3-d4dbe1e1a4d5@lwfinger.net>
Date: Sun, 17 Dec 2023 08:25:07 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Realtek rtl8723de load krn 6.5 but dont work
Content-Language: en-US
To: Leonam Uerba <ghostdog0777@gmail.com>
References: <CA+f0+YH_yAAvqz5_hPVwPHvWvK52cD10XjWye2=S5+OhLS-hwQ@mail.gmail.com>
 <dc58789d-0d60-407e-8fdf-ba56f139877f@lwfinger.net>
 <CA+f0+YHsfYVPkG11kdd5F1Lf_EigHnNCPdvofv+KADmpm7D3EQ@mail.gmail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CA+f0+YHsfYVPkG11kdd5F1Lf_EigHnNCPdvofv+KADmpm7D3EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/23 00:53, Leonam Uerba wrote:
> Thanks for help Larry, but, unfortunately none of these options
> changed the failure status. I did it this way, is there something I'm
> doing wrong?
> 
> 1) i create a file on /etc/modprobe.d called: "rtw_8723de.conf: who
> contains these tips that your give me:
> 
> cat /etc/modprobe.d/rtw_8723de.conf
> 
> options rtw88_pci disable_msi=y
> options rtw88_pci disable_aspm=y
> options rtw_pci disable_msi=y
> options rtw_pci disable_aspm=y
> options rtw_core disable_lps_deep=y
> options rtw88_core disable_lps_deep=y
> 
> obs.: I added all the modules even though some didn't appear os "lsmod
> | grep rtw"
> 
> 2) lsmod | grep -i rtw
> rtw_8723de             12288  0
> rtw_8723d              61440  1 rtw_8723de
> rtw_pci                32768  1 rtw_8723de
> rtw_core              303104  2 rtw_8723d,rtw_pci
> mac80211             1396736  3 rtw_core,mt7601u,rtw_pci
> cfg80211             1339392  4 rndis_wlan,rtw_core,mt7601u,mac80211
> 
> then: modprobe -r rtw_8723de && modprobe -a rtw_8723de
> 
> and still same error on syslog/dmesg.... :/
> 
> do you have any more tips to solve this case ?

On this list, do not top post. Also, always do a "Reply All", or whatever your 
mailer wants. I have added linux-wireless back in.

Please do the following:

sudo modprobe -rv rtw_8723de
sudo modprobe -rv rtw_core
sudo modprobe -v rtw_8723de

Do the options show on the rtw_pci and rtw_core lines of the last command?

If so, they are correct, and I have no more suggestions.

Larry



