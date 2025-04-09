Return-Path: <linux-wireless+bounces-21358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D2BA82FFD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F378A316E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095D27BF65;
	Wed,  9 Apr 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwT0vyUS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A36278140;
	Wed,  9 Apr 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225193; cv=none; b=D7ClpPcVh9STuUormj2hj/gU+5T8IWzxfzQ2TAGUzecmD8KymJACKMm/oaIelZsdcH5QqAk2+6ZjK1A5ZGqFZgBVc8cmd/+G809XmEQWhUZEy0PE1d5jupD/2qGV2S079qVY9BmS/esw666uMHSIrPKDBWeqsyjgp9UoAAR2QOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225193; c=relaxed/simple;
	bh=fHNugPqL3BXm983hBsCCRppe6yhgx8ucgV3hPzNfx+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBRknq1Z1ThyZD1IYaz/Nt2/2j/xmsSaTuzgEzCh0oTKL7ZB8LiYODNEeorvBb+Dhmb0lZ7Cblt6SS4XmGbypt/xifIWmS/amUyT2uRT4vEAX5CqKbMpH9ZAYaz73qdQAOOOZlMBy7JIARi+m7QztoOICDHjCcIqtKcMm15TJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwT0vyUS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so1029229b3a.0;
        Wed, 09 Apr 2025 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744225191; x=1744829991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1wi01EF8Z0TS5kAzJp4gC5MlmlCKp8z1jxkmp6i2uY=;
        b=AwT0vyUSeHMVxMxGaqX85h5+Ycr3cchqWcwIPZFsvl7NqVw3M6oTiQKTkKpFD3nXvv
         wJk+vP4LTW5PHzeNvGWRCbo2HuJoji7ebpq7oiVQFm/HnQW5A/DjnVgqBmkXM+V+HUou
         M/PmFwETyOZfdRvbMFLxP6bfDKFSWcd8otC7pcGmSIQo9V3/mnB4Sc96Zrh4yapBd9C/
         X8Enpts2d/ZmcpnT62AIzjPengeYJliEb2iypUFasFmtz/FHQ89AYXogmIEw+9XuYnRx
         pUvMJdBhAbO9GDOsI5iI6H3fAJtpaAYC2jSMJ2pPfUrJyGbod/eSL5GhdpwfLRaeTfuG
         wc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744225191; x=1744829991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1wi01EF8Z0TS5kAzJp4gC5MlmlCKp8z1jxkmp6i2uY=;
        b=YLN5IsLSSUMakVOEpzm1RTsPsGLCOsHaSdrYLuak0VlkP1v49UUDoMFys933sCS/A5
         WVmMl3dunwHF6sK85Pl217HfMbLOFgt+mqni8u5yu+w2nz+2nIiptGTOfW6PMI6o+8HL
         029YYzENSHwCL+uJ6vpQjAG44Wx+4uMnpps1UPycoZbJIatRhTjBrE7vbH4C1DlzPDaP
         orE4ZOPZ9Bv9EBtC+ztrgAa6ZWlHHIFmS+DtQJ1vrv+k1s4u0Oaq9EtDKfKaw6WNZdUj
         sYmXdOo88VcKeOo8AfhjnJIplcxDIawUTeC364rJb3ROjFTN7BeJkfaFoniSYkskHz81
         fgEw==
X-Forwarded-Encrypted: i=1; AJvYcCU2FelnGjbus29wJNXi67yTXwWNbYCCxmnYOUOyMC8qqXRRAwnQBfJIvZNLUzeFIPDGIHryt0cFDF+ayFya@vger.kernel.org, AJvYcCUHZBZV6aYCzvcmutUgm+nydHjmUZUreCcqfEmm4Y2vUQ3uPkJBneOXoA4QcGB7WPz8ak7UkzDV8jouHpg=@vger.kernel.org, AJvYcCUcug4n1Y58esBgOa5ao9oFsakBUhHmYSijakeW8i18+H/zs9VoSNxS/74npG0UXtOSYVmlBLLSDqrHMZE=@vger.kernel.org, AJvYcCVdzGav0lmh54HtuoBbf0GJFV9FltSolQQA9USMTqfTJRShlHEyuXgoFxNEMKpm9c/nsMLm/ws86o4JiKJ0Kc8=@vger.kernel.org, AJvYcCVwIK8kCiBi1jLW4lYbe2sH+n+1cZcMMFM5bGDeI8dg7Ly4U1BP+49x4bY/6EwgSOacFPY=@vger.kernel.org, AJvYcCX9sSeBxegsDPjU1Pjm9YcNuZKSwFu9DV2dcGKovMK7BXh0JM/wSnL6S0ZYk4df1vWTJpY5Jad8@vger.kernel.org, AJvYcCXEMJ83qpThn4HUkyM/9v/5MDFLU78ifhGg4hSRbmPPRvGTMw4pTm0nYJtbK0FlqxTpx71F0gafDNVkDGkC@vger.kernel.org, AJvYcCXG/5SOyLIDs+IXCjJ4JKD+hBxUYdpo3r3THacTvJXAeBERQZDqnOn0SxumvYyKdh9zPdyM06u0w4F+zgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+HpNf/oCVgs5BBDeLrmBA5Otcsbr1d67Cyyg/OpSEgd4igu9
	r8yzbj6A5cNGkup89dIhhc4wbzgSmD4WE3D0Bv8wtcTTyHHw7Vxg
X-Gm-Gg: ASbGncuMsp+EiD0LXxAV6VZ6Bex1YMDVTI1w7c9vMbCbA9VW/RF4llJ2nOSLXI0VYG+
	5FU0P5bBLtx3qlRatWIYOUnjRZc58Abrxda/Fcky773X6kTSDbU3Q2wyGf46JHdiYQuJq9WU3X3
	JIqxsSRqNfDM6QqyYfulIRvwS13bhMk1MUsDAdzWxO/8BdP4Eg0JCe3N1bEu2RAH0NtJxZogwg6
	XP+dDtYLzd65LW+SBrqbc5OcHz1ryI98jGogKbWcX1n2F6plSsJVe3u1FVCvZ4sD7OwyMFqToga
	z+Q4h+qNeorPqo2GavWFMAqKsdLSZJmm/YsV7gtLGCx9ra8cfkTTwVZwEyFmemLBnnjkN0B2Y/k
	EU+A=
X-Google-Smtp-Source: AGHT+IECCxkkYx11FRXflSmygxg09UKvf+V06wtQrEcsVk2bA1aQzXREqWD22vkpXtX6pPvgieHcAA==
X-Received: by 2002:a05:6a00:22d4:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-73bbcc568a5mr921360b3a.4.1744225191359;
        Wed, 09 Apr 2025 11:59:51 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e53e92sm1699061b3a.156.2025.04.09.11.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:59:50 -0700 (PDT)
Date: Thu, 10 Apr 2025 02:59:40 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, johannes@sipsolutions.net,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	yury.norov@gmail.com, akpm@linux-foundation.org, jdelvare@suse.com,
	linux@roeck-us.net, alexandre.belloni@bootlin.com, pgaj@cadence.com,
	hpa@zytor.com, alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, Frank.Li@nxp.com,
	linux-hwmon@vger.kernel.org, linux-i3c@lists.infradead.org,
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v4 03/13] media: pci: cx18-av-vbi: Replace open-coded
 parity calculation with parity_odd()
Message-ID: <Z/bDnLzcajzIxey3@visitorckw-System-Product-Name>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-4-visitorckw@gmail.com>
 <25b7888d-f704-493b-a2d7-c5e8fff9cfb4@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b7888d-f704-493b-a2d7-c5e8fff9cfb4@broadcom.com>

On Wed, Apr 09, 2025 at 08:43:09PM +0200, Arend van Spriel wrote:
> On 4/9/2025 5:43 PM, Kuan-Wei Chiu wrote:
> > Refactor parity calculations to use the standard parity_odd() helper.
> > This change eliminates redundant implementations.
> > 
> > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >   drivers/media/pci/cx18/cx18-av-vbi.c | 12 ++----------
> >   1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/media/pci/cx18/cx18-av-vbi.c b/drivers/media/pci/cx18/cx18-av-vbi.c
> > index 65281d40c681..15b515b95956 100644
> > --- a/drivers/media/pci/cx18/cx18-av-vbi.c
> > +++ b/drivers/media/pci/cx18/cx18-av-vbi.c
> 
> [...]
> 
> > @@ -278,7 +270,7 @@ int cx18_av_decode_vbi_line(struct v4l2_subdev *sd,
> >   		break;
> >   	case 6:
> >   		sdid = V4L2_SLICED_CAPTION_525;
> > -		err = !odd_parity(p[0]) || !odd_parity(p[1]);
> > +		err = !parity_odd(p[0]) || !parity_odd(p[1]);
> 
> No need to call parity_odd() twice here. Instead you could do:
> 
> 		err = !parity_odd(p[0] ^ p[1]);
> 
> This is orthogonal to the change to parity_odd() though. More specific to
> the new parity_odd() you can now do following as parity_odd() argument is
> u64:
> 
> 		err = !parity_odd(*(u16 *)p);
> 
> 
Thanks for the feedback!
Would you prefer this change to be part of the parity() conversion
patch, or in a separate one?

Regards,
Kuan-Wei

