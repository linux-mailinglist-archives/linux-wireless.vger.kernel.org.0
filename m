Return-Path: <linux-wireless+bounces-14857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C619BB094
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C58F1C21A35
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D1B1AF0D9;
	Mon,  4 Nov 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BWYyDMaR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5B1AF0A8
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714827; cv=none; b=pNWG1onFxMV86KwPM+0PzKzOxWJFrN4KoxaKQQjqx3trede6y5YFTs8OHVdI0XACRnBgfbRVgObqneZN5Sklm+Vx+UpEO/1O9JSjI+VcevsEu5UKIKGtnU2jnUUe3P+f72gEf+H1v6UOkRik3asMhPmeQetkc8jRJaXQo1jTji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714827; c=relaxed/simple;
	bh=1f4HDTr7zjyAleJSQ9D0qYziygXYurzjF9zC7TSJMdA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VDUaiy+DREjBJrtQ1lDiOfBAqgh2XH7ad09LZbGLomBcxBvIp6xG1xuxbtW5KzMKFEFrWTI4pxG0BybB+EcAz2OF7LKfzMkmv/oBb8Cva+Xg+lFQeftGuAWdldQ381rWuN24fAcVsGbi6l4u+QKSUz6Y8E2nmMqUMMYJlmBhQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BWYyDMaR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so3478549b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2024 02:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730714825; x=1731319625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rle5SKLETfESdrXUPBzgj8C4czQZN1OmDrIQFZUAujQ=;
        b=BWYyDMaRT7D/qjztFdKwOCa4ghRgO4An/iOrgZ6VRYoD4a3mDJd5dPM4kFrawC+b9v
         PLvXjg5r7QcEAkvV5BkKy7+o2GM+48RH76Zx+LrC1HQ9lXYlFjOhqVAqcdsPSkn8/VTR
         X+BUqQg0E42HFcZjpQ9+wuHbHry674zfCcUec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714825; x=1731319625;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rle5SKLETfESdrXUPBzgj8C4czQZN1OmDrIQFZUAujQ=;
        b=RPUh14PNjWp0kXHpTnT+gFTrxj9olC/mFWVrRRRwldqfufWjFkEdU/o7173OG0gFe6
         c41lcyGZiGMTPW0+MN9+DlI8FRMXj+oxXJSYM+fLSGqoHdLDEXeUIclJMj/C+nV2T+Gs
         fXwAscWavEpIMAeA3yY+9T+10i+keC1N2JOMYSmTMfoLWIL+L19fIKvS5bbQyM8PA6K8
         M+O8rcXYFUGMo/T7oTXg4aPw7R6KynvtElHWNTvL9P+R1sb+fpNbh3iHlnmP5r7OdVOz
         t7vHSnoVkd9XFNjONSHripEzIUQqs/gA1ODmOJPhdv/wjJX8Z0wP/zVq0AdzX8LPWSWC
         BVAQ==
X-Gm-Message-State: AOJu0YzyitakOpJc6eqvOy/Y/Nbzwv0qN8v02AIfIZ6pjP5SVRCJkAOW
	GcYGnva/vlqMzn8rr+3UVpARteJ2ERgAB9xeEe/4ZoXs1nQfXwanMAr1N8KjS8e9ygaKACH0jBJ
	Rob0W
X-Google-Smtp-Source: AGHT+IGm6Dywu4SWPI1SYam0DOTcyvfVOO3244TddVk2u6YFOHnq3Om43kwBeRfyfgrmbiCxRcZ2Rg==
X-Received: by 2002:a05:6a00:a0a:b0:71e:581f:7d7e with SMTP id d2e1a72fcca58-720b9c29c4cmr20476123b3a.15.1730714825464;
        Mon, 04 Nov 2024 02:07:05 -0800 (PST)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb5adsm7003912b3a.163.2024.11.04.02.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 02:07:04 -0800 (PST)
Message-ID: <16169285-d838-46f3-8be1-3639f573062e@broadcom.com>
Date: Mon, 4 Nov 2024 11:06:59 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: brcmfmac: error messages while entering suspend
To: Stefan Wahren <wahrenst@gmx.net>, Arend van Spriel <aspriel@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, Kalle Valo <kvalo@kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>
References: <a825587c-e6f6-45f8-8ac0-a1a5642a5333@gmx.net>
Content-Language: en-US
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <a825587c-e6f6-45f8-8ac0-a1a5642a5333@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On November 3, 2024 12:01:55 PM Stefan Wahren <wahrenst@gmx.net> wrote:

> Hi,
> I'm currently working on s2idle support for Raspberry Pi 3B+ (BCM43455
> SDIO). During the tests with I noticed harmless, but annoying error
> messages from brcmfmac like this:
>
> [  383.186640] PM: suspend entry (s2idle)
> [  383.190107] Filesystems sync: 0.003 seconds
> [  383.247470] Freezing user space processes
> [  383.250291] Freezing user space processes completed (elapsed 0.002
> seconds)
> [  383.250379] OOM killer disabled.
> [  383.250385] Freezing remaining freezable tasks
> [  383.251677] Freezing remaining freezable tasks completed (elapsed
> 0.001 seconds)
> [  384.292071] ieee80211 phy0: brcmf_fil_cmd_data: bus is down. we have
> nothing to do.
> [  384.292079] ieee80211 phy0: brcmf_cfg80211_get_tx_power: error (-5)
>
> These errors are not new and I assume they have always been there. I'm
> not an expert here, so I want to know is the problem here that the SDIO
> interface is shutdown before brcmfmac is suspended or lies the issue
> within brcmfmac suspend itself?

Hi Stefan,

Upon suspend we execute the remove path and cleaning the interfaces. We 
notify cfg80211 about the removal, which in turn will notify userspace, 
but is tries to obtain the tx power from brcmfmac. However, at this 
stage the communication with the dongle is already gone. These messages 
are also seen in the module unload scenario. It seems a bit redundant to 
query a device that is going to be removed. So it could be fixed by 
chiming down those message or avoid it completely by changing the 
behavior in cfg80211.

Regards,
Arend

> Here is a calltrace for the error above:
>
> [  384.291308]  brcmf_fil_cmd_data+0xe0/0x114 [brcmfmac] (P)
> [  384.291347]  brcmf_fil_iovar_data_get+0xcc/0x134 [brcmfmac] (L)
> [  384.291384]  brcmf_fil_iovar_data_get+0xcc/0x134 [brcmfmac]
> [  384.291420]  brcmf_cfg80211_get_tx_power+0x58/0xd4 [brcmfmac]
> [  384.291458]  nl80211_send_iface+0x1e8/0x584 [cfg80211]
> [  384.291549]  nl80211_notify_iface+0x58/0xd4 [cfg80211]
> [  384.291615]  _cfg80211_unregister_wdev+0x40/0x27c [cfg80211]
> [  384.291682]  cfg80211_unregister_wdev+0x14/0x20 [cfg80211]
> [  384.291748]  brcmf_p2p_ifp_removed+0x6c/0x98 [brcmfmac]
> [  384.291785]  brcmf_remove_interface+0x170/0x1ec [brcmfmac]
> [  384.291822]  brcmf_detach+0x60/0xfc [brcmfmac]
> [  384.291859]  brcmf_sdio_remove+0x4c/0x188 [brcmfmac]
> [  384.291896]  brcmf_sdiod_remove+0x24/0xa4 [brcmfmac]
> [  384.291933]  brcmf_ops_sdio_suspend+0x100/0x1c8 [brcmfmac]
> [  384.291971]  pm_generic_suspend+0x2c/0x44
> [  384.291982]  dpm_run_callback.constprop.0+0x74/0x134
> [  384.291993]  device_suspend+0x110/0x3d0
> [  384.292002]  async_suspend+0x24/0x3c
> [  384.292012]  async_run_entry_fn+0x34/0xe0
> [  384.292022]  process_one_work+0x150/0x294
> [  384.292032]  worker_thread+0x2dc/0x3dc
> [  384.292041]  kthread+0x118/0x11c
> [  384.292049]  ret_from_fork+0x10/0x20
>
> Best regards



