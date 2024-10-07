Return-Path: <linux-wireless+bounces-13651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE449939C7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 00:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5C7B20A65
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 22:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04018A6DC;
	Mon,  7 Oct 2024 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cehFEhLn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88B184549
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338595; cv=none; b=bkuPpow19AsGFrOt7eF8bbW3pTt6BWcAjXZxFKQ6G1HJHbKRBbVvNQc/b6wkcorJV+EvEhTUlYg212xQNUvsgIJM9A+fAJirmeEKr+mtpoXN08AJ0JqsoGMREBNEKrMw3CgUDUsfOzD/h9MvRt8G5eoIxy92Q04k3Vune3v/BGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338595; c=relaxed/simple;
	bh=G5irQUwlfQc4dnR16J4zN42O15wf9ke6hkjoG9x2flk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KRl0pMhmLqFz6RgHqHY+7R+AAzoVoHiT7pYq4SNPY42zvcPiiC8xMAgNLuZ1mEmwmeX6l/AowD/pvPaSQlf10WtWW2MhWx+251AgPDoSu5K6SlWNc3psGtTDaSuHcS0myEqND7SwGDxbaH03sMZTbRcqy7444v7v5GC9c783NRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cehFEhLn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so66709575e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2024 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728338592; x=1728943392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a0Vdevx6K2jJipKcQbe18Enpyou2NSleEhs1/GJHS7A=;
        b=cehFEhLntDlNqSb9EeQEBeRAXy+wPI7BxTKddQC9ELBBx4Syy8XisUYzOjoeE9iW9c
         RAJFLIPo55Lhf5SicdCtGyD0+4dPgfIvwfOO4lTCMOorHhauQEmTHuhgu4h8E9fR46Lo
         UAf+rZCd07VHXAXZaJGdA6al+aQ9b03Dh4lsu/jv3Caal6gcci5LQn1PT5jd4eW1wbi0
         rwqOGvcNDW5f8haazqWa3uiMGAORzeALpvrWcKcxNEsP2RoA73iZ08x4oUIGFBKVGQ5f
         A9v7Jr9Sy3qqdrPyvleNcmVzxB0ywzrjGQkyVbelPwd2q5V7Jdnh1iYYoexgIkDx4nwl
         Q3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728338592; x=1728943392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0Vdevx6K2jJipKcQbe18Enpyou2NSleEhs1/GJHS7A=;
        b=MlroIKE/50OHVc0HJ946Ap6kWH9h0dg8R+8jykkb9W4TpH/pmK1Y0EkkfhdSfZaUUq
         EIVuN6e0oe7ZsYUMEMDg26sChmzpYuRelIs0yGllP0ZdIFIx+4b3F29uYruDLmJmMNgL
         1yXtFTkj5Q/2Q/xawBzrNfK3KZgVhmoiE8qch8E1CeZf3WDU93q7Kwul9P8NvXOLr957
         N4wjsbl6jH+4dpIXspd7DGopZqapEq9nqIB5aEJLbFDorm/kvZz5s+ooDhVsjDy3heef
         ODJIrC5Nks4bopxTQzXemEX1PfIUorNT5yPAc9VQxb3d8zrR1HOTvUFJxMk1BKQO7qKQ
         h7VA==
X-Forwarded-Encrypted: i=1; AJvYcCWSmF7fwbw6cTllP7ilf3lZzB33O4Dbs7zGRfaU/gvxaE6ZgoUP47kRURrB26qZQVPkZ0Y56eybgvUhcpMyLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyhVb8GJBk5tK5fmEZfEvrvNKfMmz5Vy3QsrJXUUxrKGKVyzT8
	YeDh/WcXfSSL4knbBuXkb1CILBcWvAyrc5CKJ5EsDghCsL30jZZS4ZO6dw==
X-Google-Smtp-Source: AGHT+IFVgOlfjCrMizkrsla+g1vpCqRRsCW+PaUpzvwoDiUXjINkIRNTRybI7x4C7QaNgpoaNj+v3A==
X-Received: by 2002:adf:cd06:0:b0:37c:d270:e5cf with SMTP id ffacd0b85a97d-37d0e779b4emr10704649f8f.33.1728338591680;
        Mon, 07 Oct 2024 15:03:11 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f265sm6544123f8f.19.2024.10.07.15.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 15:03:11 -0700 (PDT)
Message-ID: <4d710785-4733-4f04-878c-53d2684d744e@gmail.com>
Date: Tue, 8 Oct 2024 01:03:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: rtw88: alloc_skb(32768, GFP_ATOMIC) fails, driver gets stuck
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
 <baca0d5d-072e-4003-ab4a-ecc524d6b89b@gmail.com>
 <ff98c33e797c4df3aee29a46229ee7ee@realtek.com>
Content-Language: en-US
In-Reply-To: <ff98c33e797c4df3aee29a46229ee7ee@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2024 04:25, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> alloc_skb fails (silently) therefore the RX URB is not submitted
>> ever again. There are only 4 RX URBs.
> 
> Though only 4 RX URB, it might be possible more than 4 RX skb. 
> In rtw_usb_read_port_complete(), queue RX skb into rtwusb->rx_queue, and kick
> off rx_work. It means some RX skb are inflight, but not sure how many.
> 
>>
>> static void rtw_usb_rx_resubmit(struct rtw_usb *rtwusb, struct rx_usb_ctrl_block *rxcb)
>> {
>>         struct rtw_dev *rtwdev = rtwusb->rtwdev;
>>         int error;
>>
>>         rxcb->rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, GFP_ATOMIC);
>>         if (!rxcb->rx_skb)
>>                 return;
>>
>>         usb_fill_bulk_urb(rxcb->rx_urb, rtwusb->udev,
>>                           usb_rcvbulkpipe(rtwusb->udev, rtwusb->pipe_in),
>>                           rxcb->rx_skb->data, RTW_USB_MAX_RECVBUF_SZ,
>>                           rtw_usb_read_port_complete, rxcb);
>>
>>         error = usb_submit_urb(rxcb->rx_urb, GFP_ATOMIC);
>>
>> I added an error message there:
>>
>>         rxcb->rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, GFP_ATOMIC);
>>         if (!rxcb->rx_skb) {
>>                 rtw_err(rtwdev, "failed to allocate rx_skb\n");
>>                 return;
>>         }
> 
> My first thought is to change GFP_ATOMIC to GFP_KERNEL, but kernel documentation
> notes that 
> "NEVER SLEEP IN A COMPLETION HANDLER. These are often called in atomic context."
> However, I feel it is possible to do rtw_usb_rx_resubmit() in a work.
> 

Yes, maybe even in the existing rx_work.

> Another thought is to allocate a new skb with size urb->actual_length, and
> copy received data to the new skb, and queue to rtwusb->rx_queue. Then reuse
> the original rx_skb. This thought is based on what urb->actual_length would
> be smaller than RTW_USB_MAX_RECVBUF_SZ, but not very sure if this is fact. 
> 
> 

I think actual_length is often close to RTW_USB_MAX_RECVBUF_SZ (32768).
Only with RTL8723DU it's small, probably around 1600 bytes, because it
doesn't use aggregation.

