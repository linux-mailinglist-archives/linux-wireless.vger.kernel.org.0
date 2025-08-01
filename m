Return-Path: <linux-wireless+bounces-26092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8637B18847
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C668627C6E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF620E011;
	Fri,  1 Aug 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqGMUzkH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A941F9F70
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081102; cv=none; b=GU1OV4LbYs8AAqT4+NyuBQ9wi7w/Myuvq1Li8EnWfzrw+h++MI/a4j7hJlwAoNHyZi2X2p3JBx5NM+sY0prq7XF42LA/BS8ZLjWNDT1AguGcyXitjAsGs4yfdKu43lnANt8JRu/MDTujW7kvYRoC7xCT+/iyNtOLEzMCVu07d4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081102; c=relaxed/simple;
	bh=Ly7yz/OVWa9XDL5MWj3B4Wib+PRV0JVly0stwypylAg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PkcX+RgqUaj5yFBWWyGBkmGX+7BTscwVMNK6qY/wKgplQMYiYPtIcyc7Rp6GImLa/IutYy8jcGoyfAmFZ6BD4fev4BAidmPGZyCAm5nvFozDCx4vyfBMU/GwzkmJel/NNXHGD8zYAa7+rn+L/MvXy9fHSYSYOGtddsj6Uqspk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqGMUzkH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-615c8ca53efso3246463a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081099; x=1754685899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=klE8+JhKXoAvG9bZiMPVG92ftAHAXmJSUfvihkGUxGQ=;
        b=PqGMUzkHAa5aJZp8PhizidWYgEVc/CqByzjNeoj7byDPF1ATpwSS0+cZQcjhnF+wAP
         QfQnKeTHojvS8TlupaQ16rra/PRpwjzyBkFjiiMs11CByn7H0F+H0mq8m9BU5WZ7KxR9
         8P3QZ3KDnwhfIPskXK+u5lJ/rHvEZ6XHMRUVvuG1PaU1CKT6Y5eWCaw/3cRb/9jvVeby
         zxdv0u1lOmYroemYCODCQ3NcNXBlbfp6vSOSEVhudoec1Khy0kExQNQtnlYRlApZl8D2
         13boFB4eSD07htv2YOgHOmJfjBJp90d9gbDnSnOJUmjfF22l9wc6+Tc+p0GH9DDOrXOa
         Gd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081099; x=1754685899;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klE8+JhKXoAvG9bZiMPVG92ftAHAXmJSUfvihkGUxGQ=;
        b=uw6VHwxX8pcjWK9q4DLa7vOjagyjxhXb9qJwijIn2O8/V21BB0k4yEoFkXQp0tkNJY
         zC76aZHVqE9iOQO7VlsjMxYipVwMxmSpMfDy+ZxlcM29+hGXZmDFQ1d73nYOucFgNchN
         EQ1dJtiiYFbUtyKSq0l5V41qpskEAO56hVz8Vq5w7OB+bwgTUswXU8CoZl5esMN1TGn4
         amc3iXkHWUVLf78GOYNGt46pajU0Quxt0zvU8mnO7D9Ik3uf4fl7nrQc4t+8Q4jDHg1X
         89EM1E4+4nuLIXYzk9Fre3JQ/9lbW+X3L0/gHuXfpG5plZpu+iHw6miztUoxyzpDOPjO
         oQWA==
X-Gm-Message-State: AOJu0Ywzp0ShQjI3ltyHignM5c7R/Dy7ATCLFleaOqIcPj375zBxIvZ+
	X5kqi5fPOmOXdiPna2TXMmjKq1ItxvqdxGPPIhGjxq9KWMgp2c3IYXNzDyBUyQ==
X-Gm-Gg: ASbGnctXF5on3om2GSGUA7yX3qmVxcLDG2Yx/7XOJkBlV3Q7tHHXv/p2m37exXJ2YSW
	iC5EsnTpROINoSQXdU/IkKqfFSk5obEJc4r2d3ouVi90dO7Dbq4V96DMT+nE0ICQtMZPyVyuYhH
	69zoEJ3LN6Pi8HFuyfGVDrH0q+EsAQAelANLBxBL9pnxLqfzQ4OofiKmUKn6GH4LI2CTnth5nkI
	KsGpGflG6g1WQKMtqVPrXhUnYnwwKh0inbQltR3rZn4nYDJ/xJe3UREGxh6VIMdN5Vc235dSR+Z
	XeMcMsnYFPlyrzQNlkI13qfniN+2e1NMmU2fhyUETdM65QrFoRQUMCi9NVoSaR96sBCJ8cBx4o0
	3gLOF0BkzZS7xiWcGIJurB63tXardLA==
X-Google-Smtp-Source: AGHT+IGOOGDCJiM6oIMy428hdtn75LfeOKYq1/2Lu2RJKFaNH2Cg9cFB3YVAfSEnKO+0ESg5hhoWog==
X-Received: by 2002:aa7:dd11:0:b0:615:a84e:c596 with SMTP id 4fb4d7f45d1cf-615e6ed1c3dmr526017a12.10.1754081098764;
        Fri, 01 Aug 2025 13:44:58 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm3148552a12.62.2025.08.01.13.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:44:58 -0700 (PDT)
Message-ID: <2c032947-fe07-425a-a423-0d071c929e7d@gmail.com>
Date: Fri, 1 Aug 2025 23:44:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 00/11] wifi: rtw89: Add support for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Language: en-US
In-Reply-To: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/08/2025 23:35, Bitterblue Smith wrote:
> Add support for RTL8852CU. It works well but sometimes it loses the
> connection:
> 
> Jul 04 16:05:56 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
> Jul 14 13:45:26 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
> Jul 15 17:51:28 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
> Jul 18 14:43:30 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
> Jul 24 14:58:07 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
> 
> When that happens it reconnects immediately.
> 
> Bitterblue Smith (11):
>   wifi: rtw89: Fix rtw89_core_get_ch_dma() for RTL8852CU
>   wifi: rtw89: usb: Fix rtw89_usb_get_bulkout_id() for RTL8852CU
>   wifi: rtw89: usb: Fix rtw89_usb_ops_mac_pre_init() for RTL8852CU
>   wifi: rtw89: usb: Fix rtw89_usb_ops_mac_post_init() for RTL8852CU
>   wifi: rtw89: Fix rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
>   wifi: rtw89: 8852c: Fix rtw8852c_pwr_{on,off}_func() for USB
>   wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
>   wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
>   wifi: rtw89: 8852c: Accept USB devices and load their MAC address
>   wifi: rtw89: Add rtw8852cu.c
>   wifi: rtw89: Enable the new rtw89_8852cu module.
> 
>  drivers/net/wireless/realtek/rtw89/Kconfig    |  11 ++
>  drivers/net/wireless/realtek/rtw89/Makefile   |   3 +
>  drivers/net/wireless/realtek/rtw89/mac.c      |  31 ++++-
>  drivers/net/wireless/realtek/rtw89/mac.h      |  10 ++
>  drivers/net/wireless/realtek/rtw89/rtw8852c.c | 124 +++++++++++++++---
>  drivers/net/wireless/realtek/rtw89/rtw8852c.h |   2 +-
>  .../net/wireless/realtek/rtw89/rtw8852cu.c    |  45 +++++++
>  drivers/net/wireless/realtek/rtw89/txrx.h     |  19 +++
>  drivers/net/wireless/realtek/rtw89/usb.c      | 118 +++++++++++++----
>  9 files changed, 316 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> 

Please disregard this version. I messed up sending the emails. I will
send v2.

