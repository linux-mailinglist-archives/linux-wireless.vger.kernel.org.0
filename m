Return-Path: <linux-wireless+bounces-29568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E77CAB29C
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Dec 2025 09:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8EF330052A6
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Dec 2025 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA15271469;
	Sun,  7 Dec 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5osyJex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994CE1EDA03
	for <linux-wireless@vger.kernel.org>; Sun,  7 Dec 2025 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765094709; cv=none; b=mI9gn6NTKC5xiD0q9f9WwcBnBngUzwtpLTOlmTp1BcNF+BXic2gYAIMzUx1oLK7EeDMWxEKd9noedBkUfdomC4bnqYkT02PTlCEAFguDZJ5m6egBpnFR4WjclYHwvndFA0NjAQ0b2YVw4hQV6Pze5mWYCxcRTg7poBSK5hy4k9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765094709; c=relaxed/simple;
	bh=u3VBf7nZ7V6oWtVB4N88DTum6HAok9ZrSwVvYxFRdys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQMjQjeCgpUGWnXQMvfP38D/Kc33lkD0MpHlhuL5C5l7cKr8jUOln/mYoqxI2/5a6fwP/9yvd/xSSp84LnazUVyKnBfEw9TqJOy1aAR2GBiweoaUxSfVdNtNojF5a9Dc/ryZmINQyVS9wa6lvVJyuwkrLwB+mZfqK5rD9whF0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5osyJex; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b735e278fa1so590803666b.0
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 00:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765094706; x=1765699506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5q5Xq0sGlEaLAo2BW6b3E5rJGoYi1LAD4X7rgAhzhM=;
        b=G5osyJexw7WwXiGvu0sfCaSe5yndcLGVFG8gjNy7xMoRVyJEa1VQ6JlLTBATW49SVX
         VldfplwuzCb+yRSSE+huJ20l0EMLg1FGBoGr3PdBP42U+uu+Zfqq0vjTQukFmIvuIXAN
         cA8mhRAD8S4IU33q00G+AgSy96LGKpF7G4bVxHwHiWxh7djyPVefDEbUuPrmPH0sFAyf
         GDlTY6yJzset+iTHbh83w5K3qA/SWEfNbBXO6CLcS3j6JyUGs5v6l7TOHI3rhW2Xxz15
         +iulWeNbpRi5bHOzORc/87XbIpLi08iRuGUnDJ8qtfde6MMI0A1hE2eWlkh6/DMD1Aqx
         lv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765094706; x=1765699506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5q5Xq0sGlEaLAo2BW6b3E5rJGoYi1LAD4X7rgAhzhM=;
        b=RZeGdh2uDv7nDxRK/O5Vq4LwDOcsH8Bys4LoSNf7iZqaPeE/WU7akdbkHREEoqdDD0
         Rwu7bpTrqOxOcOFVb+vnaQSKxB1IQ/+X68dtRJkKVo75iPfEjAF1EMbspbb3dGUMUTdJ
         dpukGKySgWUqyc2UpJJ3mhC/2uV7ov1GK77dw4BdcmqleLuhDoZbAMc1DNSJrhUC0WKd
         W6cjGW/qXb4oO1PutROeaVNnn9cIjIysyjSJTrKeu139ZPi7ofMbS7jVX6hzuYJfBc4F
         yfLLH5F0M5BX0xZL3qOmBvVHEHwSwGXbFkVzo2euMb7CaRFQfKGBBz2UtNtEPydGhIgp
         4XcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbIcLThkdteHtsYYu7bolF+zjPqZL85PrXCm5Q8OD3GmeHSCKnLO6egV0Krg1GOYjncSQTvOGpjZpkT6WPug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEBkv212iFigScpy2jq5jqcs1sjUx94z+B41tO23CO0ptqJkPj
	3oQ5bqaCM97wtN2SysVoLYs2erUwtAnlo8stQbgTlTzJ6g+nR34HumPpPaN7Uw==
X-Gm-Gg: ASbGnctCzmy1xKF3T1FC9GgxUTVYqvy6gsXszcrp0d/5p/sf5ToNYQp4G4vecbroksS
	HX7uWkHl4bBowr9kizIKW+NYU7VyIUI7lKRSw7Aa2qgvWKzZP+DSatWsUyMYXgw8UlV7+KxaKm/
	C09NkGD6vhRVjCo4N13lWbb45kYjtd04vZ2ECn2WZr355O4wPrMsgPmLuyqmwxs+EUAZ/0Rnuqc
	lE28wu9vQ+ZKXYW2WMW5gowGSZkF5FNQ128s9050KlOqkB4rxbHpYJy7E34CDF/MfdS91bgBzMi
	9bQxYfLyYeTLqkuxhp6lxRZ61iNjRkT9rVABczdz0hEb3s4kTAac8sh+2OlRqdM3SGZBNCFSzdc
	T6ZKwBCRFZ696CwvCob45CmoQZY9cXKvrNoI/uNMP1qrkm1EY65hxTgrHti1hkdIR4UYMrOvicu
	zKuppgd67OLCSQLJVeTJGH12U=
X-Google-Smtp-Source: AGHT+IG3Fb6sFELWMDgiQ9Jhbis9xCT1Vxpk4srIFV8hPtA69hlwDRkseJRO10ljQ/uXJfKJ+qudEA==
X-Received: by 2002:a17:907:3e11:b0:b73:6e0d:4f6b with SMTP id a640c23a62f3a-b7a2476f945mr396070366b.36.1765094705602;
        Sun, 07 Dec 2025 00:05:05 -0800 (PST)
Received: from foxbook (bfg212.neoplus.adsl.tpnet.pl. [83.28.44.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4976c43sm813393666b.42.2025.12.07.00.05.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 Dec 2025 00:05:05 -0800 (PST)
Date: Sun, 7 Dec 2025 09:05:01 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Ping-Ke Shih
 <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>, "Jes.Sorensen@gmail.com"
 <Jes.Sorensen@gmail.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20251207090501.41980a50.michal.pecio@gmail.com>
In-Reply-To: <2025120716-sway-hypnotic-8cb6@gregkh>
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
	<20251121111132.4435-1-zenmchen@gmail.com>
	<475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
	<c0d187d6fead4e5387db2a14129be96c@realtek.com>
	<44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
	<20251207001608.1f6940bf.michal.pecio@gmail.com>
	<2025120716-sway-hypnotic-8cb6@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Dec 2025 08:55:59 +0900, Greg KH wrote:
> On Sun, Dec 07, 2025 at 12:16:08AM +0100, Michal Pecio wrote:
> > Hi,
> >   
> > > >> I got something. In my case everything seemed fine until I
> > > >> unplugged the wifi adapter. And then the system still worked
> > > >> for a few minutes before it froze.  
> > 
> > Sounds like memory corruption.
> >   
> > > > Zenm and I tested below changes which can also reproduce the
> > > > symptom, so I wonder driver might assume urb is the first
> > > > member of struct, but unfortunately I can't find that.  
> > 
> > That's what it seems to be doing, because it uses usb_init_urb()
> > on urbs embedded in some struct and then usb_free_urb().
> > 
> > If you look what usb_free_urb() does, it decrements refcount and
> > attempts to free urb. But here urb is a member of a larger struct,
> > so I guess the whole struct is freed (and this was either
> > intentional or a bug that didn't happen to blow up yet).  
> 
> That's not ok at all, it's amazing this is working today.  urbs need
> to be "stand alone" structures and never embedded into anything else.

Is it though?

usb_init_urb() is exported and documented as below. Neither of which
suggests that the function must not be used by drivers.

/**
 * usb_init_urb - initializes a urb so that it can be used by a USB driver
 * @urb: pointer to the urb to initialize
 *
 * Initializes a urb so that the USB subsystem can use it properly.
 *
 * If a urb is created with a call to usb_alloc_urb() it is not
 * necessary to call this function.  Only use this if you allocate the
 * space for a struct urb on your own.  If you call this function, be
 * careful when freeing the memory for your urb that it is no longer in
 * use by the USB core.
 *
 * Only use this function if you _really_ understand what you are doing.
 */

I see that there are some sound drivers which embed URBs in larger
structures too, so if this is some tree-wide campaign there is a risk
of breaking them too.

Regards,
Michal

