Return-Path: <linux-wireless+bounces-1087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD7819F45
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80D31C22F98
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A40936AFE;
	Wed, 20 Dec 2023 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir6qD7nS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9236AF0
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59067f03282so3774253eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 04:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703076154; x=1703680954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DP0zvxoQ566YYbRy4QMCmGwXsJhdmh/xrNsxiUti8ko=;
        b=Ir6qD7nSrhsL3PSojtQCv3Us4jg9kIBSqdl7WhPgmDbPuPjHluQRyjahQf9h/W8gVk
         vYajgOVpuUZEnV/a/fvRd2zlqnIqcafXJSouH2kXL0vlmD3EHl+jSsB3kUXHacmQZ/S4
         2FPhL/8uOELmAuAMYlzm5Il0fBwjLGMwH9PuaaT4Mbyn+luCDCXXXykIZsfB2I3Zk+xt
         6btXkf6a/ehnHqzvnBntWU/wWcOwITpkhlH911d8Fnk3d3BrwGoSY0bSww2Df6nIpnU6
         X0xh7NMvYq9cG47L77dDwMLQde8YndbFuPKJb/d+ASHaeR+tPhrN3GGGSYTNChx351zY
         D/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076154; x=1703680954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DP0zvxoQ566YYbRy4QMCmGwXsJhdmh/xrNsxiUti8ko=;
        b=AF4DEMhYJF3cX3YHJu09emPDdF8toHH2iwWo/Eyj2HXe9j/zFQxl8p+MmIT9fab866
         AKW5mZCA+0euPuA8RKPFaYn2uVpYliL1aOUkZnbLezYxljzKY/exQEibFdVcHZmcBcSb
         vxZ3TEkQokU0AtCxgaUz9rtzFGx6VgjtC1+yu1e4xSw/iogQTpmdgcVvGVUZgEnEgjnk
         Q2i0/UFDdxBOI2G4ozbN9I2tUtdowIEYwR530WkyyLwtV60oqhw2IrC9+saxwxp1QCxO
         zbr0U3ENEdbUXJVCLUQCAEetBg0glqlFqVwJ/sbvl8Dl2eQhadhtF/bxYscYqbRmA6TL
         KsKA==
X-Gm-Message-State: AOJu0Yy0PHmnFUBXOaM2c1XJ/DvCYYTEiEqf0V8IF0AWpICCGMZ73Ph6
	6PHANAMTBMtBmxUOJm1hg14NSC3rNZs=
X-Google-Smtp-Source: AGHT+IHzTGl5VPicMbIcW+KWYWcb9kp9FFuc5dvpUMJEUN4ACyswLyDhbRQEnmvJDbC5cudUkzkuVg==
X-Received: by 2002:a4a:98ea:0:b0:590:f5fc:df58 with SMTP id b39-20020a4a98ea000000b00590f5fcdf58mr9555540ooj.17.1703076153712;
        Wed, 20 Dec 2023 04:42:33 -0800 (PST)
Received: from [10.175.247.41] ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id j12-20020a4aab4c000000b00591994c94f6sm2173700oon.24.2023.12.20.04.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 04:42:33 -0800 (PST)
Message-ID: <6122eb4e-66f5-4772-b211-8fc69ac88ebe@gmail.com>
Date: Wed, 20 Dec 2023 04:42:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ath11k warnings, and eventual phy going away requiring reboot
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org
References: <ab00ff77-23de-43a1-9eb9-6ac036ab80e3@gmail.com>
 <87edfiqcdi.fsf@kernel.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87edfiqcdi.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kalle,

On 12/19/23 10:24 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
>
>> I noticed this after one of our devices dropped offline. The device
>> had roamed 7 minutes prior so I doubt that had anything to do with it.
>> But then we get this, and then tons of warnings. I'm happy to provide
>> full stack traces but its quite a few, not sure which ones are
>> relevant or not. After all the warnings IWD got an RTNL del link event
>> and was unable to recover from that. It seems after that ath11k tried
>> to power back on but failed.
>>
>> This is a stock 6.2 ubuntu kernel, WCN6855:
> BTW I don't know how it's nowadays, but back in the day Ubuntu heavily
> modified ath11k. And we can't support distro kernels anyway as we don't
> know what they have changed in the kernel.

Ok. I understand where your coming from, but at the same time Ubuntu is 
the largest linux distribution so it seems like these type of reports 
wouldn't be uncommon. OTOH maybe users just go directly to Ubuntu. 
Anyways, this is a list of patches isn't huge according to the changelog 
(for 6.2):

      - wifi: ath11k: fix registration of 6Ghz-only phy without the full 
channel
      - wifi: ath11k: add support default regdb while searching 
board-2.bin for
      - wifi: ath11k: fix memory leak in WMI firmware stats
      - wifi: ath11k: Add missing check for ioremap
      - wifi: ath11k: Ignore frags from uninitialized peer in dp.
      - wifi: ath11k: Fix SKB corruption in REO destination ring
      - wifi: ath11k: reduce the MHI timeout to 20s
      - wifi: ath11k: Use platform_get_irq() to get the interrupt
      - wifi: ath11k: fix SAC bug on peer addition with sta band migration
      - wifi: ath11k: fix deinitialization of firmware resources
      - wifi: ath11k: fix writing to unintended memory region
      - wifi: ath11k: Fix memory leak in ath11k_peer_rx_frag_setup
      - wifi: ath11k: fix monitor mode bringup crash
      - wifi: ath11k: debugfs: fix to work with multiple PCI devices
      - wifi: ath11k: allow system suspend to survive ath11k

I see the dilemma of not wanting to waste time debugging when there are 
unknown changes applied. I was hoping someone would recognize the 
behavior and could suggest a patch/kernel/firmware to try, I do see some 
recent patches related to firmware powering down which seems related. I 
also will try the latest firmware that was just released.

Thanks,
James


