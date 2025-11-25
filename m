Return-Path: <linux-wireless+bounces-29335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD337C84B71
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 12:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A15A34FC76
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5962626CE3B;
	Tue, 25 Nov 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Weoi4Zu5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1126FD97
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069806; cv=none; b=u3xbKVDxgGk27zBjl3CqsmXP7kluzeNUWIvEaX4SJb0L2sAkQ3J0KiAEwqcWN9Kn9Ab3GHC/HOO1F8Kx/CjQhOShHNM9/flQ5TkHq1Xi+wv5iR0W51DI3FNHImU0KIJEiG2kAl9PLMRmTlIFH4mcDhJgeUiXB3gkSkDx5CseaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069806; c=relaxed/simple;
	bh=DT7lXuvM/tHIm6I/hY1terVdKvvBN38TFu2ftSg6MDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0dPMqb9UcLHSql519eSngWkiP07l2Fn7QrKFT9dlI70klk9YZDZ3EiydEi2GsspXM6HnusUnwV20e3gs1bg98/R70pu9om7ETyFnSBvV9sq95Y0KIkbOV8MN1N9Wrdjn/dWG76Uoql9TYeef8SZ8zFwwL0Ceqgr3HOw7coGMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Weoi4Zu5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5945510fd7aso4526080e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 03:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764069803; x=1764674603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kx9dKn71Ej/+B6+GF1aR+chW2BjyhmbbsfrUzvecUQM=;
        b=Weoi4Zu54w6mVeo0jsUhlNuc7Y4E5TaPownQYiHjA24nI6UjVP9beaRTsLrHTUt+QW
         TIOZ2uOVLjM3WJrMfC3sxND656G+5afHPFC9nRCcOgYlT+uQgw5MXkxtSPdkfPUoiG4K
         Pa/hOFyJv1r5rEpqW0c2w9ADHTBOOIgD7b4S+NEZ8fnUdZ/FERzon0nSmPMgO00BU945
         gLylotIrXbTZw5EgUoCjX4OudqcaOLiagLvHMWv3CSHVNjB2p4C6+5ZiD/9MzqGepSVo
         539ebwOHI8OrTmLHAR1dQONbqcb1woidnETRMeBIdR8yNhqd4L2zXiJicLN/VX4Id9AO
         c9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764069803; x=1764674603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx9dKn71Ej/+B6+GF1aR+chW2BjyhmbbsfrUzvecUQM=;
        b=uTuVMypvArQqLESlXQbrJehHpKF/3sEUf+oNrjaNqtkHVpqzPA3bMILf6RTPaBUjhV
         9na8Y5298bsWq+MiTk/uFJh7uQS5Y2X99mZV7WZPNjqGCcZifsFIY2BuLozUTXm1uLq4
         pEkM6F33d0T210oxtCBKuC9ceracTtnqgnY5FRfnr17h7xrwFKnqkgsMJfcscYvHKWeV
         dLvhqgczY8gjwdjFy/tE92IVSvWX0BKeNHq7sqfC7PTVyaSrT0LN+yKFNXMbRgW5ejfF
         slReneZZt4k3hlu/2hxXxGSbd7E3E4/v2Yv3eXDT7VmU8aw4YTN3uWo6FLr+qJ1xo60g
         NLhw==
X-Gm-Message-State: AOJu0YzH53RYrG/eZSzaCnMIfwBgX4JcoKxO1ULv7+iXsDojF58OL0Yu
	YMHBEsrdS6C0GMCfeDEJEzlP2/9/zqGWVpeDO4WSOz12EogySvHsMTGequH8FQ==
X-Gm-Gg: ASbGncuYDhGvTZ53Br1HF69E74nhomCc+Vp8gsdG0jkxNv3Eq3dqSoR3v0m9sn3bcoU
	AS7DO/yxlLrsia2XN24LQCIEnZS32vRkYOkTSpyzeqi9phQi3wJoOP3VMJmFC7tevm7iWRVUx+v
	LB9TkgLEChESAF9h6Lu4B+4XQMPz3fe7CCwIHKMxlOtJqchG3zaM57kFiJm/ldjWg3Uw3FVJ1OU
	ED3TThDnu8NnBSMP4uWV6VJXERq/9xM3ZUFZgTJqAlhMO+QCnEQ4AvLC/V1oModG3muUClkb3dU
	DT7hWktwrliMSJb57M+cLej1cm8OzXy5bbYGaFeaHIbzaomhFFr3V0fZkE/DYjaD02zzalZGy8o
	hoBYAx7YF+6316I4Peht5cD16qxCh5cI9K1DfEb8XAsLVafg8kt10Hk3qykQRd2RtTzBBJzTSym
	2CHZTV8ZzsDRbsPP4=
X-Google-Smtp-Source: AGHT+IEdLbOxSvFw4h+c+EndXSTVz2lnFVAIfRR6az/rhiDUvwnoN4lBC6UW8KjmScw7HvtiIyNHNA==
X-Received: by 2002:a05:6512:3f0c:b0:594:2654:5e39 with SMTP id 2adb3069b0e04-596b5275450mr1050562e87.34.1764069802050;
        Tue, 25 Nov 2025 03:23:22 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-596a0d14946sm4582785e87.72.2025.11.25.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:23:21 -0800 (PST)
Date: Tue, 25 Nov 2025 14:23:21 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw] wifi: rtw88: limit indirect IO under powered off for
 RTL8822CS
Message-ID: <aSWRqcryxMCKwF4N@skv.local>
References: <1764034729-1251-1-git-send-email-pkshih@realtek.com>
 <799749958ece4b8e9a6f460c1b5aacac@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <799749958ece4b8e9a6f460c1b5aacac@realtek.com>

On 25-11-25 01:40, Ping-Ke Shih wrote:
> Hi Andrey,
> 
> Ping-Ke Shih <pkshih@realtek.com> wrote:
> 
> (for record for patchwork)
> The subject missed to point out "sdio: " which I will add during getting merged.
> 
> > 
> > The indirect IO is necessary for RTL8822CS, but not necessary for other
> > chips. Otherwiese, it throws errors and becomes unusable.
> > 
> >  rtw88_8723cs mmc1:0001:1: WOW Firmware version 11.0.0, H2C version 0
> >  rtw88_8723cs mmc1:0001:1: Firmware version 11.0.0, H2C version 0
> >  rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
> >  rtw88_8723cs mmc1:0001:1: sdio write8 failed (0x1c): -110
> >  rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
> > 
> > By vendor driver, only RTL8822CS and RTL8822ES need indirect IO, but
> > RTL8822ES isn't supported yet. Therefore, limit it to RTL8822CS only.
> > 
> > Reported-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > Closes:
> > https://lore.kernel.org/linux-wireless/07a32e2d6c764eb1bd9415b5a921a652@realtek.com/T/#m997b4522f7209b
> > a629561c776bfd1d13ab24c1d4
> > Fixes: 58de1f91e033 ("wifi: rtw88: sdio: use indirect IO for device registers before power-on")
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> Could you please test this patch and give a Tested-by tag if it can fix issue
> you encountered?
> 

Thanks for the quick fix. I've tested the change on 6.18-rc7 on
RTL8723CS (PinePhone) and WLAN is working.

Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

-- 
Best regards,
Andrey Skvortsov

