Return-Path: <linux-wireless+bounces-15998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1266A9E858A
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2024 14:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF39188482D
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2024 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446D81420DD;
	Sun,  8 Dec 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiYYhRh1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E814883C
	for <linux-wireless@vger.kernel.org>; Sun,  8 Dec 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733666010; cv=none; b=QLsJrS3Mbq/b6WuBEzGef+4ORN/y8aITu0Vdv9LOgNxV8yi9QP4SDk5SfY9xuVYibKwvnro0ZJc5iz8yg3xEnUFyXRVaTkMjQb1eG9XQf4TsTTFx6av/daMyTe4E/DFWKtLIBU4MdABGiEG9oYT/Yg9rTXU2IVSwZ6v/kGG/Ftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733666010; c=relaxed/simple;
	bh=6vmI2rNzZbPbg2XeKr3Oe5TOFkJlJ7i4jg3roFC7Oqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcU+O8RTzhxB1ERVHfUdkiKuU0TfwZXIeuR4oIlSB1foIPNBArT8pqd1TJ+dU2p3y2z28zFWjfO93Ww3Vg1ZEDKXZtpRa/QGKAGT+vmO0aErYUNrlFqDgL07lR8oUlUZ1QyFYvhSum+CTH4YbxC70yrWDQ7bvxuQ2ZD8POyOqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiYYhRh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733666007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=effItv+T4ngQBiRIY7XZjYM5/CDQslMyXd/pUoX0ZDs=;
	b=OiYYhRh1DvNgwST7PW1oW6sit2k4wTTypdTJX6R37WnFlDgrMv1NTlzVH1eRXOFw7eyNiE
	w2IepBNUsLk00GQlEIHNRAfvrDp9YO8S5/eRi+65T0iRFLDKib2FZwB61T8O4/LbZLskFf
	qLvTSDk0dIn4W8z12MDJABtLikEUGpo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-HDYBJmJ0Neiu8JG_9ENwxQ-1; Sun, 08 Dec 2024 08:53:25 -0500
X-MC-Unique: HDYBJmJ0Neiu8JG_9ENwxQ-1
X-Mimecast-MFC-AGG-ID: HDYBJmJ0Neiu8JG_9ENwxQ
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3dbddb891so1261445a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 08 Dec 2024 05:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733666004; x=1734270804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=effItv+T4ngQBiRIY7XZjYM5/CDQslMyXd/pUoX0ZDs=;
        b=t1ZxrWo17Cmld/Zq8hVBJt0tNQ2zR3/84+Wgp/A8wVNRBF2hhvpGL/O2JGBkLJCvDP
         77qo0jKeypfAunwemiw/kKofogunJa0bKKcjMTs/8a4t3J6OmgBuhaA4cQGqXZYrW5ox
         +jFXZSRyRZ0q95KRfurgWGMBCq6UlkJhxv3fCStgzFLPX4gbMderEmIGeKpiiXvg/t5P
         axQ/4/ur67VAoAYjKfikGROHUAsSmBaWa3lMhjqYqDNJA4lQHhr6KWzLJssyh0r9IdVy
         fvEDRPvRUNuU/+eCEGe+CzOVo7Td5MuTS0o1ptdvifmgN4IpxF4R+DJbJTO9Z8GHVk/E
         gJIg==
X-Gm-Message-State: AOJu0Yx2dH9Cju/AorwUVf8Ju6eoYdPtit69G0n796LPLpgPkzB3Iw3M
	P8/JKh0ej9JG7TIfSwCPzifT26d21O8F2KPpipNL92kRCmb6UqeUE1HIMBixD51lh45FPed2q/u
	NSruAto6j4OkyemlMGrdYmBDGr9j/Ugk1rbhD5SzgGt2rmlAkLIjLpxwHDK3Zp1Pe
X-Gm-Gg: ASbGncviVIGjmncU9rfu1KbuZ5IM4NwEvmwvgEEa0LZCqiMC5adN/N3LPu7WITlM97o
	A+4Ghedghuf/GbTst2wiH6AXeGKpCPVDVtKyzbbd368P5E2M5ZSR9nXeIJpiGBCWUfQzt/ACk91
	0nuM4Xf0r0aMULOsKs3TRhjxF/+jPBKFe9U8mZCv9mn4gnsVKoA1dLHnrdtyLUS/4uzLlFEK4yJ
	rXdc/b+kA+2Y4vljYVsPJGynsjBnNN92+d/0Ude7oQjLIUB0e3NrKWotT8tHeTdFw8dvcoAA2Ma
	zGcyknMZvQb2rRSn9h3kyVRab/fmYY8imJ2dFoFfgcgUaTvbtD9keBsYyd0WonH3+rA3841aPQa
	htK07RNL7uiguGEo8G/i84C8N
X-Received: by 2002:a05:6402:27ce:b0:5d0:d06b:cdc4 with SMTP id 4fb4d7f45d1cf-5d3bdccdb54mr9000818a12.15.1733666004590;
        Sun, 08 Dec 2024 05:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT6Q+gAyU4Hw06qKdr07+MmMs8jMXgZWk7VUDrfXYZHJ4HC8iwAV1xJFoNInSvuusyWJSJdw==
X-Received: by 2002:a05:6402:27ce:b0:5d0:d06b:cdc4 with SMTP id 4fb4d7f45d1cf-5d3bdccdb54mr9000794a12.15.1733666004181;
        Sun, 08 Dec 2024 05:53:24 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d20c032csm2944939a12.36.2024.12.08.05.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 05:53:23 -0800 (PST)
Message-ID: <094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
Date: Sun, 8 Dec 2024 14:53:22 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
To: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org,
 Peter Robinson <pbrobinson@gmail.com>
References: <20241107140833.274986-1-hdegoede@redhat.com>
 <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Nov-24 3:23 AM, Ping-Ke Shih wrote:
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
>> except for the following 10, add these to the untested section so they
>> can be used with the rtl8xxxu as the rtl8192cu are well supported.
>>
>> This fixes these wifi modules not working on distributions which have
>> disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
>> like Fedora.
>>
>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>> Cc: stable@vger.kernel.org
>> Cc: Peter Robinson <pbrobinson@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> 
> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
> 
> 31be3175bd7b wifi: rtl8xxxu: add more missing rtl8192cu USB IDs

Thank you for merging this, since this is a bugfix patch, see e.g. :

https://bugzilla.redhat.com/show_bug.cgi?id=2321540

I was expecting this patch to show up in 6.13-rc1 but it does
not appear to be there.

Can you please include this in a fixes-pull-request to the network
maintainer so that gets added to a 6.13-rc# release soon and then
can be backported to various stable kernels ?

Regards,

Hans



