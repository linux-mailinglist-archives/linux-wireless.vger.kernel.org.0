Return-Path: <linux-wireless+bounces-1380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC378213D1
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jan 2024 14:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84688283016
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jan 2024 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3B73C39;
	Mon,  1 Jan 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVLHRYYy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3343C32
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jan 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so14831398a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jan 2024 05:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704114771; x=1704719571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTG3f17CihfvfbIDINbqihad4dcL7yuRT3oxt0n+sHM=;
        b=jVLHRYYyry7M5oayjiiUY0rH3/wg+VahRKV3DMIo7qZBKHgyyuwbWNEm6lwlUHwzSc
         ggdEbDb/naxbpFyQbLcqS4eVgLHrxk1epIij3N/61SU8k4OauJqFw8+r6HBJB66iFrkw
         jXJYLCiaEuy5PhMlm1ASDdsbOj+UtvJq6EkTvIldfAielu2YlG0Of1jb1QeYSQpaw0Ze
         bS8IfYbw/oGD3IfRNS730k7ymIJv7TnsCM4GcfjFtDkVOFYTh7nk+YlU9YaabdOapRbu
         dU/6PLcFl/3vZ7vml51V9jY0529WD+4d6ZTUl/fue4Dw0TBmN3+8Gw4/JzqFe6BjnkEo
         0j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704114771; x=1704719571;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTG3f17CihfvfbIDINbqihad4dcL7yuRT3oxt0n+sHM=;
        b=DHV76xL0fniHQkgg1iqWZ+BOcDtElofh0r2dkZDgtTP6VZx+kLWfDxYRttmN/TcMXw
         /3uvdsFLks/5CpLFAUIBMosm32kC6mfmSCfE/hoGYBzAK8aOKlsbC0LTOQ8S/zsCRcfe
         +IGjkpw2Z1wdB0G2txQjZ0Q2eAdv+Xp2+bQXdL+nCD10AZrdqo7eX3Ckf/TBv5OMfzeq
         yNBtlpjhevNEsyfP4F4jpgcpUHNThtO7pur3snYxKrNZK54MKFlaA2rHDuJZXJ99dWS6
         xQX4rmVfUdr8FMo/MwqnAM2eSciqJHDUeGxzlmgmFMeCXSARqYX1ptl2AGknTqIXOEh9
         7M1Q==
X-Gm-Message-State: AOJu0YywJenF+fLB8lB7z30Tb6aF3utiaX0DnELUeEHte6R+MJbSE1Tl
	4+0S9+MnpPdY4+pQKmNlOe0=
X-Google-Smtp-Source: AGHT+IFyAon3XKBsvXBry2Rvp1XqRrnA4OlmxxMD6tE1FD64w0kxdTDsNeoECd/5TJhXXa2zVt5OMA==
X-Received: by 2002:a17:906:5303:b0:a27:4714:2c6f with SMTP id h3-20020a170906530300b00a2747142c6fmr5802818ejo.66.1704114771163;
        Mon, 01 Jan 2024 05:12:51 -0800 (PST)
Received: from [192.168.4.109] (85.184.187.58.dynamic.dhcp.aura-net.dk. [85.184.187.58])
        by smtp.gmail.com with ESMTPSA id p13-20020a170907910d00b00a26a63346ddsm10461583ejq.87.2024.01.01.05.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 05:12:50 -0800 (PST)
From: Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <16be98c1-3b64-f8e3-9350-e61dadb7f008@gmail.com>
Date: Mon, 1 Jan 2024 08:12:50 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: rtl8xxxu: Fix off by one initial RTS rate
Content-Language: en-US
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <be0427a7-f85f-449e-a6c8-b1c8371c39b0@gmail.com>
In-Reply-To: <be0427a7-f85f-449e-a6c8-b1c8371c39b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/23 17:19, Bitterblue Smith wrote:
> rtl8xxxu_set_basic_rates() sets the wrong initial RTS rate. It sets the
> next higher rate than the one it should set, e.g. 36M instead of 24M.
> 
> The while loop is supposed to find the index of the most significant
> bit which is 1.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>



