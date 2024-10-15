Return-Path: <linux-wireless+bounces-14021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C799FAE6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 00:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148751F22941
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959F11B0F36;
	Tue, 15 Oct 2024 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YpWxMC5j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869F1B0F25
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030017; cv=none; b=PHFTYUDZ+ovfkmaiOvVRAtrqQCVy/0DAEZ03rMs2BJGyMI1dlRxdtnztX872IO5a64GA0rn8I54lT+Q8D81lpTYGceOAvbd0owhboxkyA/5jSfG7HeksbfyTT0OgdHy1aVHp+ieX+rT5ziRTPhqddStwRJZzPjxpKrXmvUA5OBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030017; c=relaxed/simple;
	bh=4vRt+hJq2BeLpXAtOJSNUjTXAzJvtSSt2c04j5cz7M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb+HmE6W4HeNGvdK7BuUwnwlGlMplDPAMjenOWUHrMo7GEXiECcLFUDGJLHDWXKTzHcG6Q52T5CMJ0XWUSqB6+uiZ1OQValiRbamJfQuew90FWWfzF6BKyjHiMCK9o21FoIdl3P//gjYyopmss9SpSU18krNY11tqx8QYqkYKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YpWxMC5j; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea784aea63so1404066a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729030015; x=1729634815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hT0R9bqoxmercTe8FcIYej1AYkgMYBqJ5UzV5PqtWaI=;
        b=YpWxMC5jG9VSSz6q7gKC8/h24hnHK9W3Mm5+t0Rp28PTjI9UAkUX/PNTMpCGDNBdmR
         EU8c5vd9Ic1g7jYT4ySXqt/k1UrHnmpXYGMazhLJyQrV7d1qXkBmrlMexoXH/dngKq4N
         ccd/JRgIRCn5fEJs1yXUUgNVKCsWXI8aj9hP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729030015; x=1729634815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT0R9bqoxmercTe8FcIYej1AYkgMYBqJ5UzV5PqtWaI=;
        b=rxHLZJ1GXFrWJDnBTo+gg0fsFeF177Z7q/j4gdm4db+LKT7uaMKnHxrhh+BdyISo/S
         Pvk2UaQCMQblLMiuhuwDl5vZYxlnhLIP/bmIwIz/QtAUiqUdB26KhVtGAN1Z/iFMwcYp
         wQaTfeXrZAz7w4V5N/5dB9JFxLe/NGnfG0sc6BM570b0hVyQxXlIVag+sBBr6skysJrf
         VQiWh/f9g+6rL7tkPnKsh3eMdr0roeWrsMhBobqUZHalKL5lod/rjo90q6NDPbpe6lY+
         kNPmkycEIfwFssAbgFLWqOP9sy7TkMnW47LZb2IXMUBsUCow5oowQ2v+H+u1k1Xsh2pb
         TqpQ==
X-Gm-Message-State: AOJu0Yw6bLtBfNUzbDu0Sw80phlyAOd2Pb5jxvjNISSkFFWIjwC7/g8Y
	0FrGmOc+29u6yi+aQRL8qcmm2wnlDTQqG+e4dMXy6qKxH4izR7NF7wvT0ENrxQ==
X-Google-Smtp-Source: AGHT+IEpVH6CVZlPWktmJt6DhI48M5bSXpnUMj7IEXnfgo2g4woJPHJ3BpNKBkT2LODRTvv8UgeTew==
X-Received: by 2002:a05:6a21:4d8c:b0:1d2:eaca:4fa8 with SMTP id adf61e73a8af0-1d905f58e25mr2593674637.35.1729030015272;
        Tue, 15 Oct 2024 15:06:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:eef3:dbf8:fbe3:ab12])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71e773716bbsm1882961b3a.13.2024.10.15.15.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:06:55 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:06:53 -0700
From: Brian Norris <briannorris@chromium.org>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <kees@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	David Lin <yu-hao.lin@nxp.com>, linux-hardening@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] wifi: mwifiex: Annotate
 mwifiex_ie_types_wildcard_ssid_params with __counted_by()
Message-ID: <Zw7nfaYZHP-HIqWQ@google.com>
References: <20241007222301.24154-1-alpernebiyasak@gmail.com>
 <20241007222301.24154-2-alpernebiyasak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007222301.24154-2-alpernebiyasak@gmail.com>

Hi Alper,

On Tue, Oct 08, 2024 at 01:20:55AM +0300, Alper Nebi Yasak wrote:
> Add the __counted_by compiler attribute to the flexible array member
> `ssid` to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> I've mimicked the commit messages from `git log -S"__counted_by("`.
> Since they refer to UBSAN I tried testing with CONFIG_KASAN (w/
> kasan_multi_shot), CONFIG_UBSAN and CONFIG_FORTIFY_SOURCE. I do not
> get any errors relating to this module with those options, but have
> others -- I even had to test on another board altogether.

It's possible you don't have a new enough compiler to enable the
improved array bounds checks? Supposedly, that's new in GCC 15 and Clang
18. But I'm not too familiar.

> This attribute was suggested in reviews, I don't fully understand it,
> but I am not sure it is correct in the context of this comment from
> scan.c (with irrelelvant parts omitted):
> 
>     ssid_len = user_scan_in->ssid_list[i].ssid_len;
> 
>     wildcard_ssid_tlv =
>             (struct mwifiex_ie_types_wildcard_ssid_params *)
>             tlv_pos;
> 
>     /*
>      * max_ssid_length = 0 tells firmware to perform
>      * specific scan for the SSID filled, whereas
>      * max_ssid_length = IEEE80211_MAX_SSID_LEN is for
>      * wildcard scan.
>      */
>     if (ssid_len)
>             wildcard_ssid_tlv->max_ssid_length = 0;
>     else
>             wildcard_ssid_tlv->max_ssid_length =
>                                     IEEE80211_MAX_SSID_LEN;
> 
>     memcpy(wildcard_ssid_tlv->ssid,
>            user_scan_in->ssid_list[i].ssid, ssid_len);
> 
> I expect we want to use __counted_by(ssid_len) instead, but do not have
> it in the struct. And max_ssid_length = 0 when ssid[] is non-empty, so
> is it really appropriate as the __counted_by()? But then again, I
> couldn't get this to produce a warning.

The correct length would be derived from header.len. But IIUC,
__counted_by neither supports nested structs, nor derived values.

But anyway, like you suspect, __counted_by(max_ssid_length) is actually
wrong.

I'd be happy to be enlighted by other experts on CC, but otherwise,
that's a "NACK" for patch 2. Thanks for looking into this though!

Regards,
Brian

> Changes in v2:
> - Add patch to annotate ssid field with __counted_by(max_ssid_length)
> 
>  drivers/net/wireless/marvell/mwifiex/fw.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index 4a96281792cc..e4e35ba35454 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -875,7 +875,7 @@ struct mwifiex_ietypes_chanstats {
>  struct mwifiex_ie_types_wildcard_ssid_params {
>  	struct mwifiex_ie_types_header header;
>  	u8 max_ssid_length;
> -	u8 ssid[];
> +	u8 ssid[] __counted_by(max_ssid_length);
>  } __packed;
>  
>  #define TSF_DATA_SIZE            8
> -- 
> 2.45.2
> 

