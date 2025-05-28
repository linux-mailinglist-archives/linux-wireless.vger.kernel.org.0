Return-Path: <linux-wireless+bounces-23475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60813AC6EB9
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFE24E5163
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37F028C2A9;
	Wed, 28 May 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f34N6Uxn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70B28DF4F
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451908; cv=none; b=Q2PXWlC5BQcackrB83Mt18avOfrEg/7B2uY4COM31QKrp3x2b53uLD41EeCaL+dPq6QoYJW1MtGmL5lZrcln89AfJvILuiTSRiIumoPXzV/lUhGBYM0Qp1QYNQBGU0f7oAYjJzRnGMDnoLL9hcxIXrHBhbbZlvylmme99Xw0uhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451908; c=relaxed/simple;
	bh=0DgzNtii2XWXPt+m9Xmjccp5sFgv9qhxyoaDSRtPwK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix7XqdGMOEOg7Q4pcWDq7djthuqGqzjSu6+dk7n/Vo/K/CqdBkKLxXDbemJuti1p0VPxTvuOfWbpczCPmWLVgxdab1V45nK3V2gta11ht/mxvbHiJQD6MyUVeO0RU9CpGozTHobwy5GdXDzWtbzQoyjdpNhuW83PzyIbpkau57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f34N6Uxn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-231c86bffc1so1463095ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748451906; x=1749056706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VspX5rS9W9nV20VrA8EY7nkU4h0oSZ1JdThY0x0OkJY=;
        b=f34N6UxnLsD614rWptT3JqFZpcYHDQNow1sWY7r2g7QlVZlpQ78ROrF/CQoPak+ht+
         qoF2T9s4xoI4i2742f+ntk9MtLt8w3ga/qA39nST7AIUTSaZPz84GD5YmK1z5ESFMlar
         yxvP0m24ZwRxS2QgZmT4wJ5F3OmajG0lCBdwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748451906; x=1749056706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VspX5rS9W9nV20VrA8EY7nkU4h0oSZ1JdThY0x0OkJY=;
        b=Odj5J31GuqWHVlZuWNWlGHGCQ+G29kRiMnTg/lHwKweAiHQhBXs/C+tQwTwhX+kW0d
         ZIwwr9a5Fxp8R4nBazLuCgjh3+EYVVsIBW2WNXJVzrCnkflE20SZCphyMrdQeoEBWPcf
         2cIN0VyxEznbaYDOoBq0s/Lvq+n3Iv7FMDG3Fx9HW61B62g91Pwaf1rSbtvudtwFH5ia
         1wJJuW5fOiv4Zr0KzKQUwUZOySKFBk0tlHQKAIA4QmrUKOKNAmrHCGRU6zaRop7LobsS
         2HrCp7jVsTSB1HROB6M5c/0fmmm5kpbo2B78v25rbWsirJIe8Wfl96gIfRzhuBMOOQ02
         jXpA==
X-Forwarded-Encrypted: i=1; AJvYcCXrulFHJvm6mnhBkyuuMeQGbmWt5yoCzu7AeDql+Vjc+0sYcPmDqaVLajxoGeOiML2oNYAgPm935EUMiy11LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2h6XPn+O9ON2jKfK83v6bDyCGst7qTQsuI7OaHGyYCRjlQwi0
	Kw41H5Pd5e0d0FC7mIWxE5z5jVXvrgAPy1+QoL0jk0St3BUmlXfysUgjySxckj0/LkXwMD5mC2W
	tfG4=
X-Gm-Gg: ASbGncuWKarDYDdX0u8DvwUr1u50NAcwbiqp1Gm4OTfBxQV9TsFI5K+Vzq3QtGzkGDg
	S5yPhWyMSjC30oZZR7J52V8TfAagoepjZ6+gZ3g9vgpmuFbvFKte0MPz/cSbPAlR+g0OBPmqTaq
	e3Tsebfq5W5lObBHVFwCSIrq42QVmMCb/jKAIgR8X77YyFnMdDsjLIfnSAtlM4V4ulaGKiCqO3E
	Dw+H6FRS3EqCIH0u7w6O3fttVD+vImVkUtfFumvMSNsy6zo5sCppbKlcYWZAQ/5wI0iGgaHptn6
	OvYGAKy2QYqlT7IEV1+LM54vNzER3D16kk8p0P2EYV+P2SydN/B8xB82AXKFm653spLZczDHR9H
	7gEKi4lrhKlI1Dw==
X-Google-Smtp-Source: AGHT+IFU5AHAAdBQ71v43Zug0Rlg+HfRRu/4sHj4AchmDH70sYT6JNthrG2CjwlrMpKf7NwFDUvrDw==
X-Received: by 2002:a17:903:1a67:b0:234:d7b2:2ac2 with SMTP id d9443c01a7336-234d7b22c20mr48025905ad.22.1748451906196;
        Wed, 28 May 2025 10:05:06 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:1fd6:4e0c:b80e:960a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-234d2ff7ebdsm14268255ad.106.2025.05.28.10.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 10:05:05 -0700 (PDT)
Date: Wed, 28 May 2025 10:05:03 -0700
From: Brian Norris <briannorris@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: rafael@beims.me, Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: enable host mlme on sdio W8997 chipsets
Message-ID: <aDdCP_lvlyvk9J3n@google.com>
References: <20250521101950.1220793-1-rafael@beims.me>
 <aC9dvv6Ki1T5RsHF@google.com>
 <20250523072604.GA14001@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523072604.GA14001@francesco-nb>

Hi Francesco,

On Fri, May 23, 2025 at 09:26:04AM +0200, Francesco Dolcini wrote:
> On Thu, May 22, 2025 at 10:24:14AM -0700, Brian Norris wrote:
> > On Wed, May 21, 2025 at 07:19:34AM -0300, rafael@beims.me wrote:
> > > From: Rafael Beims <rafael.beims@toradex.com>
> > > 
> > > Enable the host mlme flag for W8997 chipsets so WPA3 can be used.
> > > This feature depends on firmware support (V2 API key), which may not be
> > > available in all available firmwares.
> > 
> > Is it available in *any* W8997 firmware? Or particularly, is it
> > available in the firmware in linux-firmware.git? Judging by its git
> > history, the answer is "no", in which case this is definitely NAK'd.
> 
> mrvl/sdsd8997_combo_v4.bin, from linux-firmware GIT, 16.92.21.p137
> version. From an off-list chat with Rafael he confirmed me that this is
> what he used for testing.

linux-firmware.git claims to hold W16.68.1.p197.1. Either WHENCE is
wrong, or that sounds like a completely different branch. Are you sure
about that?

> > users on the old FW version. So, we'd need to teach the driver to know
> > the difference between v1 and v2 API here, and choose accordingly.
> 
> This is already implemented. From mwifiex_ret_get_hw_spec()
> 
> ```
>         if (adapter->key_api_major_ver != KEY_API_VER_MAJOR_V2)
>                 adapter->host_mlme_enabled = false;
> ```


Huh, I forgot about that. I also assumed "v2 API" wasn't something
available on most older chips, but I guess I might have been wrong.

> To me the patch is ok.

The firmware versions above don't match up to me. But if we confirm
that:
(a) this API is available in a linux-firmware.git firmware for this chip
    and
(b) someone includes a valid linux-firmware.git version that they tested
    in the changelog

then maybe this is OK. As it stands now though, no.

Brian

