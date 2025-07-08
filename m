Return-Path: <linux-wireless+bounces-24976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869FAFD692
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D4B484AEF
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87B2E174A;
	Tue,  8 Jul 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HxcYGyhZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEFF2E7654
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999861; cv=none; b=hAX/jcFnF4fDdt+IWnAd/UJvzWAMW/V/1UqXyuj3pNa1CGkxkCMX04l64MzGeBcvzy7q4LchwgGWzcAtrlzvx7keFzCGYKBX/0RX+9jDG8KEJXjKMDEOCQ4ic3ZJdzzdzG/DvLxy/Av+B+vzcD81GlHx/3vTpLbcyA3KdZR+Lbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999861; c=relaxed/simple;
	bh=PtWO8Kf6gARhECOW6gfEYOD3Jpj9TfpLwZ9Ug+b4Ft4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEjxrM+3YTc8/co1H1boz2wYg0BiP84TOlqOkkCEyHP2UF7n0Iq1AUgjWL+aqj8qSsZPmyJVXS4uoKc+mNo3e4ZG5bBch9vG7aYA2vhmE8M2QVJuY7KcCnIa9L4ML6Gx1/t2stii9HPlwSEfpJIzMhbF7YDCBeA4e6jon+UeVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HxcYGyhZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-236470b2dceso41304055ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751999859; x=1752604659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+psvB5g625bC4mqToYbJ3lSQ/EDO4V8Kj8hVwl32RoI=;
        b=HxcYGyhZlHtUVy/zsmj8awkc3VKdI8ymb5rwi7gYlZXC2fNCJUY/IgAucgcCYODxhB
         Bj1b8GO9r/uLjvBcKlqWNf34FBDcxaH/jEZaXn4D6uB9SVjeuQ7NI9C4cFNtkIppbPyE
         kxrDqULa8o9us+QT4alEfZYn7AJTE3OiEZavM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751999859; x=1752604659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+psvB5g625bC4mqToYbJ3lSQ/EDO4V8Kj8hVwl32RoI=;
        b=cVJdTSREhkLfHQg3ONk/t1dVAF1exth9sqaXkLHoGgyYPZ5vC45g5Wiy6YljcX1snu
         Pbg8Uyd2WYG75EBFH93JE/i0owAXigkmEFIfqWINzsZf0d+vUQH9k4L9kudB5IWp0Xo6
         IHcpqKELYqn5SWmixuAgzm1CrdaFq3quNnOsroFNxw4Q5ULuu8C4XH+i9vUhwDoQLT1X
         3EbQ0KOJWrEJ/vEg5eLS3HHONU5QjQ/3Xc/F77vAHZv7M1iro8ANkkaXhYF2llckhEeF
         LEm5FmDgJJEiqkmv9xGANejI2tnvvxfzvQ8fvCzrUIiJoqRpJ/Ea16wKqULGLIB26nlK
         ydZQ==
X-Gm-Message-State: AOJu0Yz48D3cwqxgC7sRgBaKgWU6I9vS/69Qsg2o6k2J+/JtDy6RHrMh
	3okEN13JjuMKW2K7I1kdyM26mfOCblQEJ89c9OQOSkPwSLIfQnIzyIXN2QBYuDzpKA==
X-Gm-Gg: ASbGncuhw48kOPrwOcKicBcRCxXcEKNGt9AqUsnuvWNMGE4CQcEKmjqA11dcKwLV9HJ
	7wc7g8c4K/1GBMkiuxeJ4PsWbLl+LcEMxXmR2tAUzVZ/Fvd+XkS2sNm1grC7mhm4bcnQDqhS6zz
	uFh/mPT7rrcDfX2PzA+dR9egI53s1aebKbVCN4X0rUvrMeqUwBM17iPsV0PRg73eFwWcQ19XGIc
	wBBehLBJBMStuGz74WcUtRYZvhRjzAfwuwH4U7Qh/XnmYETGD8jvJNC9S4FAbFVy6TRpkphHUYc
	RvltyBlGlODYBxg5pOg5hb442k86bjKSv1XPXupEtTFV79kIeMIAzE3iwefQ+IN1sHZh4wf0lJb
	NhIdEWOpIeAFi+VNA42ad7d87
X-Google-Smtp-Source: AGHT+IG20ULsYtz6QLvi2+lHa5g3xn2is++0hyrWSM/yyQ95yipiz5r0NsXbRYJaDRS3gsDc9Gwpsw==
X-Received: by 2002:a17:903:2349:b0:234:8a4a:adac with SMTP id d9443c01a7336-23c8747de05mr235010015ad.20.1751999858816;
        Tue, 08 Jul 2025 11:37:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9b88:4872:11ac:8ccb])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8431a3d8sm117327455ad.45.2025.07.08.11.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 11:37:38 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:37:37 -0700
From: Brian Norris <briannorris@chromium.org>
To: Miguel =?iso-8859-1?Q?Garc=EDa?= <miguelgarciaroman8@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	francesco@dolcini.it, thomas.weissschuh@linutronix.de,
	tglx@linutronix.de, johannes.berg@intel.com, mingo@kernel.org,
	christophe.jaillet@wanadoo.fr, skhan@linuxfoundation.org
Subject: Re: [PATCH] mwifiex: replace deprecated strcpy() with strscpy()
Message-ID: <aG1lcWYjk9GARp1P@google.com>
References: <20250705133600.186441-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705133600.186441-1-miguelgarciaroman8@gmail.com>

Hi Miguel,

On Sat, Jul 05, 2025 at 03:36:00PM +0200, Miguel García wrote:
> strcpy() is deprecated for NUL-terminated strings because it may overflow
> the destination buffer and does not guarantee termination.  strscpy()
> avoids these issues.
> 
> adapter->fw_name is a fixed-size char array (64 bytes).  All source

It's actually 32 bytes. Not sure where 64 came from.

> strings copied here are bounded literals or validated inputs, so no
> return-value handling is required.
> 
> Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/pcie.c | 40 ++++++++++++++-------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
> index a760de191fce..2aad9ab210e0 100644
> --- a/drivers/net/wireless/marvell/mwifiex/pcie.c
> +++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
> @@ -3098,9 +3098,8 @@ static int mwifiex_pcie_request_irq(struct mwifiex_adapter *adapter)
>  }
>  
>  /*
> - * This function gets the firmware name for downloading by revision id
> - *
> - * Read revision id register to get revision id
> + * Get firmware name for download by revision id
> + * Uses strscpy() to ensure NUL-termination and avoid overflow.

The original comments are strange here (as are many of the comments in
this driver), so you probably have a good idea to tweak them. But IMO,
their main problem is that they repeat themselves, and don't really add
much value over simply having well-named functions. And particularly, we
don't need to write out full sentences to describe every step that we
do.

So, please drop the "Use strscpy() [...]" sentence. It doesn't need to
be here. If it's not obvious what str*() APIs are doing, then we have
bigger problems.

This seems fine:

/*
 * Get firmware name for download by revision ID
 */

>   */
>  static void mwifiex_pcie_get_fw_name(struct mwifiex_adapter *adapter)
>  {
> @@ -3110,39 +3109,56 @@ static void mwifiex_pcie_get_fw_name(struct mwifiex_adapter *adapter)
...
>  	case PCIE_DEVICE_ID_MARVELL_88W8997:
>  		mwifiex_read_reg(adapter, 0x8, &revision_id);
>  		mwifiex_read_reg(adapter, 0x0cd0, &version);
>  		mwifiex_read_reg(adapter, 0x0cd4, &magic);
> +
>  		revision_id &= 0xff;
> -		version &= 0x7;
> -		magic &= 0xff;
> +		version     &= 0x7;
> +		magic       &= 0xff;

Don't make arbitrary whitespace changes. The whitespace was fine as-is.

Thanks,
Brian

> +
>  		if (revision_id == PCIE8997_A1 &&
>  		    magic == CHIP_MAGIC_VALUE &&
>  		    version == CHIP_VER_PCIEUART)
> -			strcpy(adapter->fw_name, PCIEUART8997_FW_NAME_V4);
> +			strscpy(adapter->fw_name,
> +				PCIEUART8997_FW_NAME_V4,
> +				sizeof(adapter->fw_name));
>  		else
> -			strcpy(adapter->fw_name, PCIEUSB8997_FW_NAME_V4);
> +			strscpy(adapter->fw_name,
> +				PCIEUSB8997_FW_NAME_V4,
> +				sizeof(adapter->fw_name));
>  		break;
> +
>  	default:
>  		break;
>  	}
> -- 
> 2.34.1
> 

