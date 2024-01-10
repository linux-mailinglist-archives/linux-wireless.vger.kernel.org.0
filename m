Return-Path: <linux-wireless+bounces-1672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF7829CE9
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 15:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F602B21107
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C7495C5;
	Wed, 10 Jan 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzX6nVph"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB834A9B5
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbeff495c16so2791000276.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898526; x=1705503326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6s/DjyGGlYA04VcYhLlf5rs2XIHUh5tvTkRQGkhtStw=;
        b=JzX6nVphXrnU1oLB4PeQfzkHxAD0tvJEKiTQywIluMDcvQ6aMOnoPsLALkeQ5Vxe8x
         WaN4cbduO8FVJ/g0EZVZkdHUm06p1XceO2fp0fohJQY7zjos55kXFvW5nRZvBLn+/pHt
         6gIEe5HKtB4BvLu6L+un1z6URim9mGSKAJxq1W83qFYFGMyjpAVne9pDzL+sWCcY+llV
         ToN1B6H60fxcko4TXw/n9tfNGr+cGYmPANFdYUiL6fPVRQu17PB5j/aUocQBsCpLZCwe
         RUbkxAOANng57eAqsYTZWSv6O2/w+0DUHVl7fCkNXW0xBJUuWUm6gmr8Vdk3FU7nyQj7
         lU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898526; x=1705503326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s/DjyGGlYA04VcYhLlf5rs2XIHUh5tvTkRQGkhtStw=;
        b=LaLQpvajiB2O3+0HYV2NoCAcGY+4Mi8+wxNwvkQvYE96M9X4AmOAXmSM8HJ5ow+czo
         5lzKZW5k/MNE0rE11ArWDUbOVphezRAanVJafkEmHEDuPjw8aFKoawpYFWNwVCQZnzAM
         yEpu0u3w3iMbHhadE/GGicz5BmnXtDoq3tuAZ092NRLWcZBX0w2D90kciDtvCRa8jDns
         qHndn8l3LWOr9Hdn8Akyno6rOsj6iF6YFir1AEHfwzwvZO1HwYI8ntttGQrNXfJu4gnW
         b1LKeNxepzdjJwIeUZdNgQUKnuJ6YZw+iWFg7krlMXiJ5TNtnKi6XH7gf+uhtOQbs37E
         bc/w==
X-Gm-Message-State: AOJu0Yz5ldIFNQZQ3KqsyGA9se5cKm7F1eUjZrKrC55vWigYtb/ECmm5
	YKFcWHzauQlz+D8FyEuMRhA=
X-Google-Smtp-Source: AGHT+IFSA6hpG4OYNoXISy+6NXPM9czRtads/xSkt7aYl95uddlxeYmpUxwoyzIzFIz2F8OAqVGjcQ==
X-Received: by 2002:a05:6902:1023:b0:dbd:bf0d:d97f with SMTP id x3-20020a056902102300b00dbdbf0dd97fmr845117ybt.126.1704898526128;
        Wed, 10 Jan 2024 06:55:26 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id ge8-20020a05622a5c8800b00429bd898838sm53212qtb.47.2024.01.10.06.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 06:55:25 -0800 (PST)
Message-ID: <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
Date: Wed, 10 Jan 2024 06:55:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87r0ipcn7j.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kalle,

On 1/10/24 5:49 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
>
>>> But I have also no idea what is causing this, I guess we are doing
>>> something wrong with the PCI communication? That reminds me, you could
>>> try this in case that helps:
>>>
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>> Heh, I saw this pop up a day after I sent this and was wondering. Is
>> this something I'd need on the host kernel, guest, or both?
> On the guest where ath11k is running. I'm not optimistic that this would
> solve your issue, I suspect there can be also other bugs, but good to
> know if the patch changes anything.

Looks the same here, didn't seem to change anything based on the kernel 
logs.

Thanks,

James


