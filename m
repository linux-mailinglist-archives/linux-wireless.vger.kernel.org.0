Return-Path: <linux-wireless+bounces-870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ECE815C89
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Dec 2023 00:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C1EB228D9
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E343237D01;
	Sat, 16 Dec 2023 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKUYxaez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CE37D00
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1534121a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 15:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702768500; x=1703373300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P0owA1NYh7prLjnJ8vwBejfsmew9vNh7zYTFMzggcss=;
        b=aKUYxaez/sAG8lcqxq4XdiWZsmGfghDdWlbqqTM1xaQ8tPIsN522KK1a8CQ13516na
         NAcjJFn7gUCd/AydonOEsoUtP6y0P4V/L/QuZNpbWagapdorpSvYvl8twx+CzYkMgO8E
         mOXVG0Iu+cf+/sHiYsbeq7qynsIaV2KeExk96kLNwyjsLMKHYJQxz4JPlwR5M4su8noD
         DhLS1+HWvwcs5S4M3Myepl2jFhPaRN8yJXEjvTaqRe6U/YvGHLDUW9UgvWivRigjEp8Y
         8f8QTfuVDXBAv/Wvke10oHwnlheaWIM6Jg6eGOXgYO0ixBMbC0ISrgpKeoX4zQe3P24s
         A0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702768500; x=1703373300;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0owA1NYh7prLjnJ8vwBejfsmew9vNh7zYTFMzggcss=;
        b=oYBiN1xz6e6NQvmx//RiLUeQvom9+KZYgtmzU25oaVGSHbwvIm9lsJASJwLjHLTW6e
         Qrnd5hyRJQCoFOyjM19ynGR5wRfuOkEMrcscH1LHo8iCwvxM2Qq5z1MJvsq2tXYjlIcD
         6hDxHbxJfISPBzepwHk+P+54dT/x1z1wktCfXXopNAHcMHE5e12/9vYWgjVUpFxp9lem
         lEBjgyen8DqzQsfJkq4u6Uoj8vPbKyWA2024fYb7/ohlU5SWFypU3h8nZ9JB6O9dzU9V
         juAJ978g8EE53ccyneiuRvhAZFiJEnkUYebgA+VtXL+mkLhFKDIBawgmgtzXhrzv3xwK
         ME9g==
X-Gm-Message-State: AOJu0YwJvkA3xWibhMoxKTDgT2Yi99k1w5ZoG4SLsPkAoDD9NV1llXXf
	Pqvl17S7xP/2YaqbgJFDA+MICVTOfua5UQ==
X-Google-Smtp-Source: AGHT+IFzuLhXYnEv6yrziZpSEUfMAaOCotTsh8djdwsupmamEB40fa04Fn19aPSIA3Wbz0DkubF3rw==
X-Received: by 2002:a05:6a20:5657:b0:193:fda5:8278 with SMTP id is23-20020a056a20565700b00193fda58278mr3048590pzc.16.1702768500211;
        Sat, 16 Dec 2023 15:15:00 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id pb11-20020a0568701e8b00b001fad96b0264sm5836435oab.10.2023.12.16.15.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 15:14:59 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <dc58789d-0d60-407e-8fdf-ba56f139877f@lwfinger.net>
Date: Sat, 16 Dec 2023 17:14:55 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Realtek rtl8723de load krn 6.5 but dont work
Content-Language: en-US
To: Leonam Uerba <ghostdog0777@gmail.com>, linux-wireless@vger.kernel.org
References: <CA+f0+YH_yAAvqz5_hPVwPHvWvK52cD10XjWye2=S5+OhLS-hwQ@mail.gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CA+f0+YH_yAAvqz5_hPVwPHvWvK52cD10XjWye2=S5+OhLS-hwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/23 02:16, Leonam Uerba wrote:
> Hi Realtek Engineers,
> 
> In the hope that they can help me understand and correct why the
> driver installs and (apparently) loads correctly after compiling the
> driver (using the project: https://github.com/lwfinger/rtw88) but it
> doesn't work in NetworkManager and dmesg gives me this error when
> loading it via modprobe:
> 
> [  166.218608] rtw_8723de 0000:02:00.0: firmware: direct-loading
> firmware rtw88/rtw8723d_fw.bin
> [  166.219439] rtw_8723de 0000:02:00.0: Firmware version 48.0.0, H2C version 0
> [  172.152525] rtw_8723de 0000:02:00.0: failed to poll offset=0x5
> mask=0x3 value=0x0
> [  172.152531] rtw_8723de 0000:02:00.0: mac power on failed
> [  172.152533] rtw_8723de 0000:02:00.0: failed to power on mac
> [  172.152535] rtw_8723de 0000:02:00.0: failed to setup chip efuse info
> [  172.152537] rtw_8723de 0000:02:00.0: failed to setup chip information
> [  172.167493] rtw_8723de: probe of 0000:02:00.0 failed with error -16
> 
> Kernel: 6.5.0-kali3-amd64
> Hardware: built-in chipset: on Notebook HP 15-DA0012DX
> 
> I've done a lot of research and haven't found anything that can get
> around this error, can you help me?

I am not a Realtek engineer, but you might try setting some options for 
rtw88_pci or rtw_pci (depends on whether you are using the built-in kernel 
drivers or the GitHub repo) such as disable_msi=y and disable_aspm=y.

Similarly, add the option disable_lps_deep=y for rtw88_core or rtw_core.

Late-model HP and Lenovo laptops have BIOS coding that seems to need these options.

Larry

