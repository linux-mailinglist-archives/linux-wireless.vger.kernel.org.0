Return-Path: <linux-wireless+bounces-25740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B174B0BD38
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 09:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB06B189C3BB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE227F16A;
	Mon, 21 Jul 2025 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgdddAVb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176463BB48
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081796; cv=none; b=dfsdndfOH/QgU09FP5Q5lnaOhQrOmz+DD/cyCYQhy/jhNvMjrg2LPz52Q9lHTWhRgXXxGukYWoabHi6ASiOyH5uPsQFnNOyNZcU2lVuNsc2/kzC+TcOMeM1iAl9l918Lbgc/xG7nTv7TzOkWBGYLtSUwpS0be4yyX+tbSWxxFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081796; c=relaxed/simple;
	bh=iNSFbDJO4HWU9fsV3Vmg/YNOnANu/9eXVJravn1YODc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieUk+f9r8kp8rUqn3CgokhWfy46Jb/Ny3yFSr83w1H8iGqQ5qeusaxlAY44ouAJllUqI9tqv6iCE2UF8P6KkN19IfSHq1ukh1VeGPtydQQuVXTEY9FLOUT2gTWhGPdfrUtwEdn+kYfQO5tokfLqk3mdzMOeJ5NeC4j+2l+A2gJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgdddAVb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so7020839a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 00:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753081793; x=1753686593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6s6dcQOea9P2mGPOLnJH7f85LLjlXCjo7J0Zv92TD8=;
        b=MgdddAVbC5iuLZYrB96zU1ms8/T6YUzp5tHYmKVR/f+CCduEB5fUJIpYTLuUI+opSP
         maZJnheKeQ0/yKp1klFpEllZhJAL9VEsxqHW8Ng9l3DEleF53ykjpA9jbp0Kkwl4SwHd
         i1Q3sSWo685lyzkKyVZv0+mLEQWfYKpdMYIkUJ4Ei5GGqaTAfLJWinfZWrlg3Uvjwbp1
         nlwjNmX+MRrEuSX9z0UxLizTNXUFRqUy1Z7KoKKAc3YMEIWvz9MT5pmcoxtRIIZ4agfV
         D9yCc/1X2wgX6I3nMXhZL//MBieTLn4mgQCuosqcwgArywzKZPE1ENrgSa6CqZJYxPbw
         PBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753081793; x=1753686593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6s6dcQOea9P2mGPOLnJH7f85LLjlXCjo7J0Zv92TD8=;
        b=O1SvtFH8izmLnd/HIExbdBtSUQ9S1CfHS3nSzrRxcK+X1ffXpt341D0/ZMzAoEF3r7
         l3Itbq0nB8p3jtoDpmvF6aC/sxiGVzA6w1CjLJpYBf/yW97LOar0gihqtmpEFf/D82Wy
         wnYx4Evdq+k8U5eLkyINZ3HZBc22NrYpNQ0O4eO7CxOqp4ckEf2PTGSLF6+LVVJsFvju
         O3KHADceRKUjm7nEKuv6Skxv+e5MjePIayxT2tUU4HAUy30FixJZ4mIffXHOHn1D3Wnx
         08yRdKOdMdyR1p+ROPmtT3S/fblKdiWhj+mQfloeUFu03fGrrOU6H/ejvSjIgnyRt9iL
         2ZjA==
X-Forwarded-Encrypted: i=1; AJvYcCVqi+/o2yOa7TA/Vz0GnYTUd6KQvFF940pLaREOGX5q4aE+Ntqp85rtjkwrQh3dSNxxt9aBs+qg0g6hnWLRMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyek9FBNspyw3ol99pOWLNYWUczcZ5MUiK6zqsH+knkr6DToj7K
	ViYKYRg6+g53lLWLoQRMwwkaTil3ljw+RymegNm1knhF2hZv4t8V3SHJ
X-Gm-Gg: ASbGncvkyNP6PIy8MaeKRBDYn0GaDxx7pKinCQjdQq4AV8mPIpCGM9mdUaoM+ppaAat
	rlazzuaoskFgY6Csub2nVnX1gTyBjyU/jNtPFy+TIg9Lu2y4PA17p6BWIS56tJpK4Exr4cG28In
	zrt67PrvUFESAIrZzqvjfenLrT0dAd6whY3nQEB+N7Dgnhzg1MWosJvVKPo5Wzn9Sr7czKOrrIw
	1w4BcONeGcpwkBbEnek264Ovn14YV/7HEwOBgGC/QjqdAOL7Lbwl9K/NYtlDr8Hcp5v31ptgxkq
	AWkimnbkzjfAy/zOnM4ZxRgoKBqY7l6L/UfcQy6pHCx7PsrDzE+cpyubksye4adBBBX0H0pOWCS
	CNgg4otEZICx9WeD6hu84D+dyx9nKeBzmnBGUQXgL
X-Google-Smtp-Source: AGHT+IG50tjltUCDuFMKQRNiLz+VEMp0BzDNLrpkyP8tRUrFbTikhbzsWUpp63ypaDEwweIeiCv/Hg==
X-Received: by 2002:a50:d61c:0:b0:609:d491:8d7c with SMTP id 4fb4d7f45d1cf-612a4f7d7d6mr11041627a12.33.1753081792952;
        Mon, 21 Jul 2025 00:09:52 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90b4387sm4820432a12.66.2025.07.21.00.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 00:09:51 -0700 (PDT)
Message-ID: <d34875f0-d098-4035-b0c0-b0d1fce997bd@gmail.com>
Date: Mon, 21 Jul 2025 10:09:49 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] mt76: add initial support for MT7902 based on
 MT7921 driver
To: tnguy3333 <tnguy3333@gmail.com>, linux-wireless@vger.kernel.org,
 nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com
References: <20250721001905.11614-1-tnguy3333@gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20250721001905.11614-1-tnguy3333@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2025 03:19, tnguy3333 wrote:
> Hi all,
> 
> Linux support for the MediaTek MT7902 is still very highly desired, because it is a card found in many Acer, ASUS, and HP laptops. This patch series adds support for the card to successfully download the firmware and scan nearby networks, and has been tested on a laptop that comes with the MT7902 PCI card. However, I need more information about the card and its firmware to continue development.
> 
> Right now, the problem is with the UNI commands timing out. I was actually able to get the card to connect to the internet briefly by changing all the UNI commands to EXT, disabling all offload tasks, and enabling fallback to software decryption of packets. However, I believe this is not the ideal solution because EXT commands are not used in the newer cards. So, I need some advice on how to implement the MCU commands correctly (dev_info_update, bss_info_update, sta_rec_update, and offload).
> 
> Hopefully, with a revised version of this patch, we can work up to a fully functional Linux driver.
> 
> Best regards,
> Thomas Nguyen
> 

Hi Thomas,

Have a look at this repository, specifically the "besra" folder:

https://github.com/cerg2010cerg2010/mt76

Could be enlightening. 

> tnguy3333 (5):
>   copy mt7921 to use as mt7902 baseline
>   add to build and add firmware paths
>   fix dma register and add firmware ready check
>   set fw download mode like mt7921
>   replace UNI add dev with EXT cmd
> 
>  drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
>  drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
>  .../net/wireless/mediatek/mt76/mt76_connac.h  |    5 +
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  |    3 +-
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |    2 +-
>  .../net/wireless/mediatek/mt76/mt7902/Kconfig |   37 +
>  .../wireless/mediatek/mt76/mt7902/Makefile    |   12 +
>  .../wireless/mediatek/mt76/mt7902/debugfs.c   |  296 +++
>  .../net/wireless/mediatek/mt76/mt7902/init.c  |  348 ++++
>  .../net/wireless/mediatek/mt76/mt7902/mac.c   |  865 +++++++++
>  .../net/wireless/mediatek/mt76/mt7902/main.c  | 1588 ++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7902/mcu.c   | 1593 +++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7902/mcu.h   |  120 ++
>  .../wireless/mediatek/mt76/mt7902/mt7902.h    |  343 ++++
>  .../net/wireless/mediatek/mt76/mt7902/pci.c   |  571 ++++++
>  .../wireless/mediatek/mt76/mt7902/pci_mac.c   |  129 ++
>  .../wireless/mediatek/mt76/mt7902/pci_mcu.c   |   63 +
>  .../net/wireless/mediatek/mt76/mt7902/regs.h  |   81 +
>  .../net/wireless/mediatek/mt76/mt7902/sdio.c  |  331 ++++
>  .../wireless/mediatek/mt76/mt7902/sdio_mac.c  |  141 ++
>  .../wireless/mediatek/mt76/mt7902/sdio_mcu.c  |  175 ++
>  .../wireless/mediatek/mt76/mt7902/testmode.c  |  196 ++
>  .../net/wireless/mediatek/mt76/mt7902/usb.c   |  345 ++++
>  drivers/net/wireless/mediatek/mt76/mt792x.h   |    6 +
>  24 files changed, 7250 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/Kconfig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/Makefile
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/debugfs.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/init.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mac.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/main.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mcu.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mcu.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/mt7902.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/pci.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/pci_mac.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/pci_mcu.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/regs.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/sdio.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/sdio_mac.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/sdio_mcu.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/testmode.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7902/usb.c
> 


