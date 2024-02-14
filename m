Return-Path: <linux-wireless+bounces-3586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63185854B30
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 15:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58BDB27AF6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F1F5810D;
	Wed, 14 Feb 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj3l4Btt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3258105
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920025; cv=none; b=NUE0MP2PP/ip7MR1dK0NJrrAbX3xn+HO15IVxseL0e6WatTX0ewJVcsK8yuKDIRjj+gFfLI+y6Qy9Ud0ISl+VWLWzFEjKDkPH7cxsWmySTS/rhTXLQmHfrIQjNVY+wEeFOnB88v2LO8zHzawwHEYNkv3mqe77YMV/Vv0s7SMX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920025; c=relaxed/simple;
	bh=LcH2sze3jID3d7nzNpoB0bcFD4BLDnB9nMn+kAJ/ogE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b2emOfStwPj54cNRgvotG0oSKRA3lpR+E2K3zthegymIZIJKmqbtwBaVxgUkYPxozR6Z/md60iG2P+wtAIHinAW/u29Ny4JuM2ywxN+3j5PiJvlAh9DMwWJuXTaHRXW6IsIR/BU6ngnuAd5ecy+5I2mwj1G+5nTPKCC4RV0vIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj3l4Btt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e0cc8d740cso2634570b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 06:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707920023; x=1708524823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMCtCE62iOVfljVN+OsaY/ahYfF26KNLjMaqRimwwEM=;
        b=Uj3l4BttLWkARW5qU+EBjV7+SNFrght2cHLhpUH+QT0wrqN56Z8yC5+xxQSqxEByEd
         Pr/c40gOZeKVYsMKeknIKm+/YHRp00MffZQkHIlpe8J9u5uzsKJVVTwZxNYGTNhpFsjt
         UVOm6dSTXK1S7GJalKzSB/uvYX1+RhaT5ICbIzqmqCvE0XGrRulVGceV/YtrVTdpng2p
         JeGHZRYF9w8zvC5JBxFUq/nY28pgCGOxSyw+CNzLBFOiuXN8e6w2zWq5JDjEI/PMgJI9
         UJFvsaAW4ibzK6cRAkWlJEeKDriYINwVMGU/PSD3g34EZfDKfEeWP88VrTV5Pe/xPzib
         QQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920023; x=1708524823;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMCtCE62iOVfljVN+OsaY/ahYfF26KNLjMaqRimwwEM=;
        b=jBdSJuMkO1uZJbfh6WbzFSRzFnko1KWV/MrKYtjEuZOjYroG9XCTKZRVI74A09hmOA
         8ZH8KRjKrhWJ5DV4VYo+BSf1qZjNsN8tPAWRjV7vd0vgtBo0+hWPSijd2ByDJRIgP15K
         cUIrmVlopaPQzvw+aP9rFZTlsBkhMvFHb1psxPeMVcEeKiCff0s3srq/9JNY7SnVU2n2
         Gg5R7do1DPLla2Q3EVlK0XZXGFXg8ha9qMh65VeMjOobCUXNl+T0pqriEijzADYzjwAS
         TtVCOYslxTQ3E7o7kSQJHdJQnj3GuIPwuhY+zqPp4w9zNvZVVDaq5tgByLpT10xCEpuN
         Mqjw==
X-Forwarded-Encrypted: i=1; AJvYcCV/cfpvFD8w9C3EcF2u5d+Jim7wwptGJlcd6eB6KrGUVTXL3w4y9M8a8vt73WIoRSw1wq19Tp8+xqYOMFlvbbnkN6Ne/zfSLqZjMqZ2bVo=
X-Gm-Message-State: AOJu0YzgKKAscP7tMKH2zti1kU3G7uRTpy+h7VnAK17eM6dE8kKM+zzC
	AqbCsL5ljJ2v5zL5pyGH5qN13feQv8Pcdj7AksbKGkVx9d4lKBL9
X-Google-Smtp-Source: AGHT+IF/h3pATTKmhdlIaxZHgKCInLL/NLsk1hkyt4mkL2VxWPz9trFSVK+KMoJ/KO1a3/DQZMsMHw==
X-Received: by 2002:a05:6a21:31c7:b0:1a0:5841:673c with SMTP id zb7-20020a056a2131c700b001a05841673cmr3495511pzb.21.1707920022959;
        Wed, 14 Feb 2024 06:13:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV53BN01L7UdrtI+7ZglmHsUpv3tSfbG2jopX/F6GN7PO7JlxPrgGwx7uGOhY39uUssLpknZvjWiz79DNkvjp4sNslxbGOmipeY5VI5tfI=
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id l190-20020a6325c7000000b005dc120fa3b2sm4198285pgl.18.2024.02.14.06.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 06:13:42 -0800 (PST)
Message-ID: <e0825627-4652-4c5a-ae29-33c270a38bc0@gmail.com>
Date: Wed, 14 Feb 2024 06:13:40 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac AP mode
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>, linux-wireless@vger.kernel.org
References: <CAG17S_MOiC43F2wXMG-Y6nQgitZQJs18jESQJrX+aC6=MQb6ew@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_MOiC43F2wXMG-Y6nQgitZQJs18jESQJrX+aC6=MQb6ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

All,

On 2/12/24 5:36 PM, KeithG wrote:
> I have been trying to use teh brcmfmac device on my RPi to run in AP
> mode to allow device configuration of wifi and such when ethernet is
> not available. I am using connman and iwd to manage my internet
> connections and have noticed that when the AP is running, the AP will
> reset when iwd scans.
>
> I set it up to be an AP so I can configure the network on the RPi via
> a web interface. I first set up a as a separate device as an AP for
> wlan0:
>
> iw dev wlan0 interface add ap0 type __ap
>
> I then give it a MAC different from the wlan0 so iwd can keep track of
> which is which and the ssids will show up on wlan0 when I run 'iwctl
> station wlan0 scan'
>
> ip link set dev ap0 address b8:27:eb:00:00:00
>
> I then start an AP with either iwd or hostapd/dnsmasq.
>
> iwctl device ap0 set-property Mode ap
> iwctl ap ap0 start-profile testAP
>
> It will start the AP and then I can connect to the Pi from my laptop.
> I am using iwd on wlan0 to scan for available SSIDs. Whenever iwd
> scans, either manually from cli or automatically, it will reset the AP
> and kick everyone off. It does this even when I use hostapd/dnsmasq to
> control the AP. When I disable iwd and use wpa_supplicant for
> scanning, though, I can set up the AP with hostapd and scan many times
> via connmanctl and it will not disconnect.
>
> Why does it kick everyone off when iwd scans? Why is iot more stable
> with wpa_supplicant? Is there something I could/should do to make this
> more stable? When I try this on an intel card, it is rock steady and I
> have not seen a disconnect. I have tried the latest brcmfmac
> (cycmfmac) firmware and see the same result.
>
> https://github.com/Infineon/ifx-linux-firmware/tree/master/firmware
>
> I am running RPiOS Bookworm and am fully up to date though it uses an
> older firmware
> [   11.513277] brcmfmac: F1 signature read @0x18000000=0x1542a9a6
> [   11.533628] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43430b0-sdio for chip BCM43430/2
> [   11.740252] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/2
> wl0: Mar 31 2022 17:24:51 version 9.88.4.77 (g58bc5cc) FWID
> 01-3b307371
>
> Is there any hope of stability when used like this?
>
> Keith
>
I was helping Keith out here and wanted to provide a bit more 
information. I found there were a few differences between IWD and 
wpa_supplicant related to scanning which may aid in figuring out why 
brcmfmac is behaving this way:

  - IWD scans using the wdev ID where wpa_supplicant uses ifindex. Not 
sure if this has anything to do with the difference behavior.

  - Passive scans (which IWD prefers) seem to exacerbate the behavior. 
Simple testing using "wpa_cli scan" showed wpa_supplicant was only using 
active scans. I also tested with iw and saw repeatable disconnects when 
passive scanning. Disconnects while using active scans (using iw) were 
much less frequent.

  - Scanning with IWD, wpa_supplicant, or iw, passive or active, always 
resulted in beacon loss for clients connected to the AP. This was 100% 
guaranteed. The clients just could recover when active scans were used 
over passive. But either way this does not seem like normal behavior, 
the AP interface should still be beaconing on its active channel during 
a scan right? If this isn't possible or can't be done reliably then 
should the interface combinations be changed to disallow concurrent sta 
+ AP mode interfaces?

Thanks,

James



