Return-Path: <linux-wireless+bounces-27486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C1B85AF2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 17:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A877B864B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6230E0FF;
	Thu, 18 Sep 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em/0lnuO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D830F946
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209851; cv=none; b=dv3SWG+mC1BO1CHbdAxwzNiesncfVkDc+vsarYYLK8nQMhdgEslfIKMt0r8Tf95Owuideht+LFarsMEnaOihP6ZqwabsjKVlSPhuCaEoDn1v/uX1eEeWOE8+OU3QLplpj0zelHl3p7OG/1R+P0FUC5K34reF6evHI9KBNKVRgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209851; c=relaxed/simple;
	bh=5a4VIoh+3AjSOqCSX6kuvG/N5MXZZ8MKVAtmohvSMrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PmA/nz55qSSoaRzhOawy+ZVhZsNVSS6eXyz7EkYe16xTuN+F3r/u5P3T97XikMLtfVPwVfcARt6RhFitGBRn+zbDGzYD6sHWchtcUOj6yoIjqE6Vyzm/Fdn5hPmwg7oSxxmzHEi8JpTTGfRSjrqPxCqfnEvKDLtJ8oY4FDKRvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em/0lnuO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2570bf6058aso14521145ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758209849; x=1758814649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spxv57HJ9BfakePJ29btbG/jyvASrkJd61yqCTLxSCI=;
        b=Em/0lnuOevpN2jq/Ny5PDiLIy4Zj7svgPhBEjtOr8xsekhZmL7fQWBxkZrgCaUYb//
         TUjBbhLi31HO26PcUeB3Lus+uB4ofURAz+W+8QYIc69GFfJ8QNJSkxXdSfICmH08M9RL
         lVqvLagniwRZHY2wk5HA3sABHBP+UL10/jVw6vn90qkFGs96PkwL/BETfw6/TqoKZFjP
         mIUzZbstPSAUxTYZGLMTwzHnN3OmHZe+8zX/clRerLYDFDXRWpHlFI84BCRLbjtjzT5Z
         LJeKLNyh0heonNNHkxFi7ipeyOgEV3aLn5JlBbl6UK7nbp/sIENzcKQrz7AA+oOn2j94
         YhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209849; x=1758814649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spxv57HJ9BfakePJ29btbG/jyvASrkJd61yqCTLxSCI=;
        b=Ck1Qiqv8guAmMr9R5VUepKRJcuqmZ4A8wekWYkObR0Djf3WbG1z3D3FmIfijlCWyJw
         Hz1MPTQaHm3jmBV6fJYE7x9Leeq98p907igtVfB/h1tpqaHPMYhWS/JIQJs3VDxONcxV
         Z15o0rsbqKbF9X2jyvDAl8z9jDAjIY/J8uLlepgGduhUz9Ls3pGEaEO+t69XMvDV/yFD
         qT0vlDn4EhjmQlkKW8iPQn7uB0+PiyzziiMLn1LOfiAnrfh3yeKOUc5llBk+lTnMzgVV
         aQDJnAnTTSsX4WlTaVGWBABQZagZxZ8SaadQCP/lB+vy895VIhwODGy5Ur2h91TowJ/L
         sX4w==
X-Forwarded-Encrypted: i=1; AJvYcCWzOO0yE8TaJbAHPSURlQuNciSmuiNSDN4A5F8W9QPA4dfBYBVJk0a6uPBHXAhT0b4mu6zLNmfLqLJFb0qihQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYWqVUQr3v5PXyCjaHuyc3nVn9uOg0empQrS29qZzdYJxir5N
	j+XFTc2AWy9NU8MSr3iOTB1P+fvxFzZ4IZQP9Pv1N4dy+ILPQQcRjlvyBMAPyw==
X-Gm-Gg: ASbGncuAi1KpRLUDv2qpCeYzyIfB3OG2viclDgrblyvWa+rJnOmUDd8kvH/LLxkQwJP
	4mCZmDblQT/WlXTAUPqbF0VohmzPxy3rSR8p8+y3sR6K61JOVfdbs8nk64Ne13FTyu9dzGbmU/T
	3To9FbjASX558+WJywtBTO81KJXtGM6mNBlhz0zSiebWbS/TMspeQGjZknFMVAMpNJ2rVtihJiX
	Qu1SZNr7WvxTKaZGnpcW31AmPpBO6z93XYqUgDL29GP9SB1PfFobvgVBTZjKas5q39+2RRhVQRI
	8LioINhB9zf/N47q3d7YruPni3EivBSctDhGcCxxoJBCK8nAOh/dyGb3/eLsJnJ4MJmfyOozN6U
	koMI2Rn0xhrA4zO9ZCcRK7hIx2Pyw7WcXqJMgiuOTT1AK
X-Google-Smtp-Source: AGHT+IGwYI6E00yl0prQNe30Cf1y0xX1phFCc3rJEFdmCWA3tTwcqCG8zEPxZqyL5UFyjnz531VGkg==
X-Received: by 2002:a17:902:f54a:b0:267:f131:d657 with SMTP id d9443c01a7336-268137f2a34mr81354955ad.33.1758209849043;
        Thu, 18 Sep 2025 08:37:29 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800531e8sm29641405ad.29.2025.09.18.08.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:37:28 -0700 (PDT)
Message-ID: <c2c30d01-0969-4d0f-9b11-2a4b125b4bf1@gmail.com>
Date: Thu, 18 Sep 2025 08:37:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Inquiry: WPA3-FT Roaming Support in iwd ver3.9
To: amit kumar <amit60700@gmail.com>, linux-wireless@vger.kernel.org
References: <CAJNKUtcMh9+i2AiXGxKDqa41QRrkfHbU1rR-HJEKx9aJj2tJSg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAJNKUtcMh9+i2AiXGxKDqa41QRrkfHbU1rR-HJEKx9aJj2tJSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/17/25 11:34 PM, amit kumar wrote:
> Dear iwd maintainers and community,
>
> I’m currently working with iwd version 3.9 and have been evaluating
> Fast Transition (FT) behavior across different security
> configurations.
>
> In my testing:
>
> 1>WPA2-FT works flawlessly — the device connects and roams as expected.
> 2>WPA3-SAE also connects without issue.
> 3>However, when the AP is configured with WPA3-FT only (AKM suite
> 00-0F-AC:9), iwd fails to connect, logging:
> 3.a>iwd[440]: autoconnect: No suitable BSSes found
>
> Upon reviewing the source code, I noticed that the AKM suite for FT
> over SAE (IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256) is not included in the
> logic that identifies WPA3-Personal networks. After adding the
> following patch to ie.c, iwd successfully connects to the WPA3-FT AP:
>
> ----
>
> diff --git a/src/ie.c b/src/ie.c
> --- a/src/ie.c
> +++ b/src/ie.c
> @@ -1338,7 +1338,8 @@ bool ie_rsne_is_wpa3_personal(const struct
> ie_rsn_info *info)
>           * 3. an AP should enable AKM suite selector: 00-0F-AC:6
>           * 5. an AP shall set MFPC to 1, MFPR to 0
>           */
> -       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256))
> +       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) &&
> +           !(info->akm_suites & IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256))
>                  return false;
>
>          if (!info->mfpc)
>
> ----
>
> My query:
> Does iwd officially support WPA3-FT roaming? If not, is there a
> specific reason this AKM suite is excluded — such as spec maturity,
> roaming logic limitations, or security concerns?
>
> I’d appreciate any insights into the roadmap or design considerations
> around WPA3-FT support. Happy to share logs or test results if
> helpful.
>
> Best regards,
> [Amit Kumar]

As Johannes said, IWD has its own mailing list [1] and we can continue 
the discussion there. But it looks like this was done to adhere to the 
WPA3 spec as mentioned in the comment above:

2.2 WPA3-Personal only mode When operating in WPA3-Personal only mode: 
1. An AP shall enable at least AKM suite selector 00-0F-AC:8 in the BSS

So this looks like an out of spec AP configuration if its not including 
the SAE_SHA256 AKM.

[1] iwd@lists.linux.dev


