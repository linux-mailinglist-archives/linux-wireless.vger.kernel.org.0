Return-Path: <linux-wireless+bounces-24718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFFDAEF5C6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 12:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC87E3AD92D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1070810;
	Tue,  1 Jul 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfQx2WL9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020A3242D8C
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367495; cv=none; b=ITIitx4+G+b7ngPTQ385O2BKfDM65iEIeEzpnlk3xtpFDgp2nCYlDBwfne326D9zx5DxGjhlu05auKsCo2w2kEGxUU5FjrW+Ae6x2cQgoRb+/l5Ez4aOxZ1liGLI+WI7Btf3TjWV6iZfbA+y8nyTwvsqd9nUtC4B4bPGEr10zjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367495; c=relaxed/simple;
	bh=5w3wjWL2igy8oNIeXfoVCLbNII5Wr2U6RJ04Jhj4jso=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D3EG7/8tYOJIWw9Q+XOnB+5cslJxNA6iU26OZQtKTEQd7tV4KMudFjWQY8xaAIa4zztcl5y1O+DWZxOA2BNRqBmQ7jwqLM4ehw6c2rA2K0tXx85kiNh8MHbVzWDoVrUHwvUD8mPts8f7U8alAGAKktSLLdua0Us8MzaP1EJAy00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfQx2WL9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ce671a08so20425225e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751367492; x=1751972292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wndAU6cNC46Ojoag94Mugj81oC9yixodAQsS2P9C6jg=;
        b=VfQx2WL9/xUl03rDG32c2z1pMKLVHPK2ZWaoHJz27REwQp14AYCV40RM2Re3HVKOQ3
         8pAClJaJpiggQmvP5L0Uy+XDis2F5gMqW2kJVxqNDNhFE1wu3Xzxgv8vrFIkO9Ypem3N
         st9JHdvERtQNIof5Udlwp4gtOx9GVDI04045mj1nTwO2uo9YtghlfANWy7mS5R4eDk0n
         Vtmty+SpDHOCPbtvZFnpGhbJDZzt9OUvHYpcZr8lc//8OhPwQQS9cBLI8xdIqiXPO7k1
         Sgfj10sSpQdo+5sWrYvZrxZSlfQnxM43JuG9gsJLdoFaVc1wb64vGE2mkkXSTPmEvNux
         7exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751367492; x=1751972292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wndAU6cNC46Ojoag94Mugj81oC9yixodAQsS2P9C6jg=;
        b=RbU9VHOn0APfvPWBy9jGB8I09SdgIJEhgA8u7soSpufZ046u2ZWpJb6fdX1UepGlvt
         ohQ6Yl6kEWQt23ysrRwNpW8lgbzISeWJsb716ayTCkARxMk4NgBczlavrXaVIo/YylaJ
         jxFTXGD8BrnXUSJJq1s/Q7aKXvT4Rsnpl1mUTHt8fOxb0TjutjZ3FQqP2d40Q0PyHnHH
         +ot2JD762MPiTKLqH1ZF235cgF6B2owGgG3p8pu+dAgYIzSZ2+I064bEnHKZd5ugMcNP
         wsjJwkiTiiAKtVVjzug4xEVCsMH3K5rK1r4YgYfhZlXjhGCYBXIELWi2EmwCmk1v9SMu
         ha8g==
X-Forwarded-Encrypted: i=1; AJvYcCUKyqCXg8F/MNh8cuPY3XTb9RT4nulh2ENKUj5Vae4k3SAVXb1BKH1gPVa4+SeQRGMidNAr2u3aRbuBZV1eMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypBf16492Z2/yPVw4lOqhp3jdRqZxyykIYLXwK9ZHsO4lUIRd7
	esQGUHJ5LJbLlLvTlVdUHi93cGh4amFQggW0oM4k30q39G/oWlKFQtwP2p4FRw==
X-Gm-Gg: ASbGncsT/K1UW7qGAmuLW3CetJNfjiQ8dx/I8p0Tnpp99RV3fVegKpnM5dP6XizUz12
	RIMhbAF8pUgRmqEd2cMs1iWv01aHxAHjGA3wCJN1vgcnsfFVNFvQCzf7IP1FdxFXU6Od8aCo9q5
	8OuR0tItOcsFSqEzywEr/FK5KaO0oV9AlFX22WEpCy/jEnyYnCKNgiH1wJu2Vjc0tXcI3Aw938W
	9DyT26e+ntm8mekcBM7Qa70IbZYJ3Q3iG53rNK1F+RKZwSWp+7RYoN6fUZ2lfK5xqwuWXlMutYe
	9XAMkl3D/qEBv6FtmIDpKnp0ILR5kLT7QbeiH1ncGWBz4aNsRq1AZ01q6P9748qYl4c5YQ==
X-Google-Smtp-Source: AGHT+IEdEXCa2Imq+6s/s72OSakjo9r+MYproq0Cwsw6VbMSr2hey6Jt4Gfx4NOIJwENTKHMF+vBng==
X-Received: by 2002:a05:600c:c09b:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-4538ee3344amr147473015e9.2.1751367491932;
        Tue, 01 Jul 2025 03:58:11 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6e9esm195952495e9.28.2025.07.01.03.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 03:58:11 -0700 (PDT)
Message-ID: <38541b56-f02d-4b1b-9198-f98696871da8@gmail.com>
Date: Tue, 1 Jul 2025 13:58:09 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v4 12/14] wifi: rtw89: Add usb.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
 <f9ad1664-2d63-4a8f-88bf-c7b7bececbfe@gmail.com>
 <bebb3b4c59ae45ee8e30e92c95680b86@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <bebb3b4c59ae45ee8e30e92c95680b86@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2025 05:21, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Add basic USB support. No TX/RX aggregation, no switching to USB 3 mode.
>>
>> RTL8851BU and RTL8832BU work.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Since v3 is good to me, I just checked the difference between v3 and v4, and
> it looks good as well. So
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
>> ---
>> v2:
>>  - Don't do vendor requests when unplugged.
>>  - Rename rtw89_get_usb_priv() to rtw89_usb_priv().
>>  - Move rtw89_usb_read_port_complete() forward declaration to the top
>>    of usb.c.
>>  - Remove unnecessary empty lines.
>>  - Rename "error" variable to "ret".
>>  - Don't call usb_kill_urb() in rtw89_usb_free_rx_bufs().
>>  - Use u32_get_bits() in rtw89_usb_vendorreq().
>>  - Initialise rtwdev->hci.dle_type.
>>  - Delete vendor_req_mutex.
>>
>> v3:
>>  - Avoid skb_over_panic in rtw89_usb_fwcmd_submit() when the size is
>>    a multiple of 512. We can't just extend the skb by 4 bytes, it has
>>    to be copied. This was triggered by the hardware scan offload feature
>>    in the "00" regulatory domain.
>>  - Convert the warning in rtw89_usb_fwcmd_submit() into a debug message.
>>  - Delete empty line in rtw89_usb_fwcmd_submit().
>>  - Reschedule rx_work when rtw89_usb_rx_handler() finds more than 200
>>    frames in the queue.
>>  - Use sizeof(*rtwusb->vendor_req_buf) instead of sizeof(u32) in
>>    rtw89_usb_intf_init().
>>
>> v4:
>>  - Implement TX queues because other parts of rtw89 expect
>>    rtw89_usb_ops_tx_write() to just put a frame in a queue and
>>    rtw89_usb_ops_tx_kick_off() to actually transmit.
>>  - Merge rtw89_usb_write_port_complete_fwcmd() into
>>    rtw89_usb_write_port_complete() because they were very similar. Add
>>    txch member to struct rtw89_usb_tx_ctrl_block for this purpose.
>>  - Really convert that "avoiding multiple of 512" warning into a debug
>>    message. It was supposed to be done in v3 but it didn't happen.
> 
> If current version is workable for users, I'd take this version, and
> then we can improve it in separated patches. Adding more and more stuffs
> into this (quite big) patch is not a good idea to review and maintain.
> 

I completely agree, this is big enough.

> (I knew changes of v4 is necessary.)
> 


