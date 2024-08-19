Return-Path: <linux-wireless+bounces-11632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 459689573FD
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 20:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8249E1C211CC
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945DB1EB3D;
	Mon, 19 Aug 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOm1m6YT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED31411E0
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093590; cv=none; b=lpXpcEgaFx2VHpdp7Jss8XuSINoKP81rjcFbtd/ewYr49gj6APi63H60roOpFDy5HaL+PDSqSAV+NlaT3xmNr3sOtDRoJ2bbowggDbil7twmSL2aVStZ32kAXoJSHftWfZdsoIpZmalyNDOEgsm4hgWYTpb6QggfAobMHK2aLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093590; c=relaxed/simple;
	bh=VIMszekDzVsR76htwsRvYout4zwuWbX1hWBRUDF4/mc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Xe6NKQkXyZiad/l24S/H2v9Ff0GySfhPYG8+oY0X8Uo6LuEWALILtGlkNtZEjMNY/1znSTXz4S9vY7B5a2TorMS31sF5JN8cfbLDll9eVVQMmD8NR5IzIr+ODTBcSW1cRvTfclt7Gsj3PmQVKpva73eh1MMpJTfeTVrtSe6kggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOm1m6YT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so646964166b.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724093587; x=1724698387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+fZr1SS1jJaIvcaDHg6OiGoHYo8COk8rAIOWUohyl8=;
        b=LOm1m6YTojjJC1L5r/YBU0E29Vr3A+fqQeRnXyeLL2t+mJZZKY08XSdliMuVYyyl8k
         tEMk0FeJBDsHQtJ40g4AooiPQG8B7QKqzhxZ95xVNIMISpwQHqoYJqDOwKVQgPXNcR4t
         6SH3ePNPDO5qTLasjkroqHLA2//xlRG64YGW4heSsZl2jCVUidwH2yscMct/7++Vuok1
         WvmPalGhntFnx/0QZhgFN9XE51oC5ht1EoP8zxR3KxGtpjWwZvxdzzb1ExkMGPyqANAs
         DB6OkyAu4TZ1CmzxNDN5bkfW84vn5YBTv77htvh2J6LtJHDoHM+sZ49r4+v47bAGcgCE
         glbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724093587; x=1724698387;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+fZr1SS1jJaIvcaDHg6OiGoHYo8COk8rAIOWUohyl8=;
        b=ZpqgXe8TMkU1ok8izQMU6tivh/xExShYsluojcUa4vmVFJV5w8pTV22Bti6wFK7/8h
         GxUwqY3aRzobNFe+P0FWMZgoWxE8T0dcWKF7LHMpCTnZqYh5kPqDz4AGZ76ic789JhjK
         zH5qbopHTeRciHJYHvZK34TOCqlWPPvhQZB9m69XwwIDcjw+Xr6ybWXTg16KJt86p6SX
         eVEzUS6/JL+fkr6EtyJogKwR/Zgl36e0ZHem86Ux0shjj9RVEjWgqVWqSd6xhozjIOW4
         FGBbEZ7JjGXdN853BiwEefyWoJzdsx2RYbccJjXbuobADCONttmZIUA/q/tMnIcShPob
         9ygQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi1JnUOGdKVfA5fHZjZeZoyxhvzAtBieibpTwvquMmf01PA6j3vO/z5k/hq9mXT6JGd5zNIJJrCBHpkdzFsKSVt42xTuX9IX2fprTGfC8=
X-Gm-Message-State: AOJu0Yy8b723tXsl7t97uIWfT3cLDluwtnGFkG87wBtuCSW6zFSRQSur
	GSqokX/cboUspJUYWnulleURQ4GnWHSUWIUVmE6Rt3kJnxM1AL+0
X-Google-Smtp-Source: AGHT+IGzUjISUStFLLkh6no+MnmzvsWCNSq2qS5YagZmLYqm4B75Z6fPylDFDKbOx//Ts55ycFj6Eg==
X-Received: by 2002:a17:907:f796:b0:a72:5470:1d6a with SMTP id a640c23a62f3a-a839295601emr902443766b.35.1724093586520;
        Mon, 19 Aug 2024 11:53:06 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfd69sm663192266b.61.2024.08.19.11.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 11:53:06 -0700 (PDT)
Message-ID: <4602091e-7093-4f35-b465-7753be8ff02d@gmail.com>
Date: Mon, 19 Aug 2024 21:53:05 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: assign mac_id for vif/sta and update to TX
 desc
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <20240819025248.17939-1-pkshih@realtek.com>
Content-Language: en-US
In-Reply-To: <20240819025248.17939-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 05:52, Ping-Ke Shih wrote:
> A mac_id as an instance in firmware has to be assigned for each station
> including AP and connected stations. Firmware will use the mac_id to
> control TX rate and do statistics.
> 
> Assignment rule is to assign mac_id to each vif when adding vif.
> For station mode, sta->mac_id will reuse vif->mac_id. For AP mode,
> dynamically allocate an sta->mac_id to a station, and vif->mac_id is
> used to send broadcast/multicast packets which are not belong to
> a station. For example,
> 
>                   vif->mac_id      sta->mac_id
> vif0 (STA mode)        0               0
> vif1 (AP mode)         1               2...
> 
> By the way, remove unused RTW_BC_MC_MACID, which was planed to send
> broadcast/multicast packets on fixed mac_id.
> 

I tested this with RTL8822CE in AP mode with a single vif. It says:

Aug 19 21:32:47 ideapad2 kernel: rtw_8822ce 0000:02:00.0: change vif 00:45:e2:a1:65:ab (2)->(3), p2p (0)->(0)
Aug 19 21:32:47 ideapad2 kernel: rtw_8822ce 0000:02:00.0: stop vif 00:45:e2:a1:65:ab mac_id 0 on port 0
Aug 19 21:32:47 ideapad2 kernel: rtw_8822ce 0000:02:00.0: start vif 00:45:e2:a1:65:ab mac_id 0 on port 0
Aug 19 21:33:54 ideapad2 kernel: rtw_8822ce 0000:02:00.0: sta b6:bd:3c:c0:39:87 joined with macid 1

Then I added another vif:

# iw dev wlp2s0 interface add my_interface type managed

Aug 19 21:36:45 ideapad2 kernel: rtw_8822ce 0000:02:00.0: start vif 3e:60:cc:0b:fa:17 mac_id 2 on port 1

So in this case the AP vif's rtwvif->mac_id is 0, and the first
station gets 1. The managed vif's rtwvif->mac_id is 2. Is it okay
if the numbers are not assigned like in your example?

