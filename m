Return-Path: <linux-wireless+bounces-22755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E85AB0099
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 18:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FFC7BB2A9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B494283158;
	Thu,  8 May 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqcKjg1C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E078F32
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722524; cv=none; b=Fiaoapx4UId/G8mIWTzCu3NbD5TqYPcw0bWQmNSCQsUr1Tqqyz35klBdyVqQpY+k6nMkFEYJQ9voeHObamtD4lXkxyU2gvn+n38g3dcKbxI54kRecGjNsJLRPHztlEbi6KHasOAoAjRq/PCJRUuXkOKYvL2xouYxB/8J64CwcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722524; c=relaxed/simple;
	bh=2fqWELrKnO9wUsarln3Vi8eIH9FoHsiNE3ni6kE2Pz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H6r8WA+Lwn9QFaqnjPr7UJJepvFKplmHuJMQWIIqvi4aLfQXreHq/Tgx8BgP3aH65hzvZ/n7l2ENtpfLBcD7J+spI4YTG0lMWT7eJxM/aiK6V9+u0O5n04oPku6eZmePttMSJmT9tlsDIU76/6/vgl0dqzUFal57TF9H+yz2UJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqcKjg1C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbda5a8561so1727781a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 08 May 2025 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746722521; x=1747327321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jh77nJfgwNd3D6u2Cs2dpzkroPTZqg9JTBBPpH1sArg=;
        b=eqcKjg1CgzVkpaKASReSCzC+bjZs4mCHvuy+ihGXnOMkbFF27w4UTcIXqfyXoaLtPD
         Tz/6V2vEkWc2d9+OANyEq+uUJbJti0Hl3bDKBNVbo6e1tqTusqCMNM/f1QlAZiRd1X7k
         iTPy1Qu+I/8tfBqoPYBvni/BFUf1G30dH7i2Q244DKsE4Eyh4bxKRI2wpSW0Lm4jg64N
         JTXFjeNWSz/fIpVZDqJxLZhSzQDGn2vZ1V9VlR7uiFr6TMjk52QCYN9er9/3n+feTMkR
         5Qlg6I/xYCeUIsQTQjveXvf5LOJMUXw4c29dnsP/hg4XgaXeqloi9Np+OJ3ZRHOam69T
         43RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746722521; x=1747327321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh77nJfgwNd3D6u2Cs2dpzkroPTZqg9JTBBPpH1sArg=;
        b=uujHhWV7wr3hR2tSiyhzfFhWiST6pXEVWWMNm+qSOZ8cxDUU74YkThQG20G5rP5dny
         dSsyHPCkiWnKfGbOQhUpk9y/4eDHwu3+gUHlvDFkbaFBVDOcMhSjCT43SzR3rpcxvP99
         hCC7xkxhxM0R13gbILF2gCx3XLNZVT/RCxRlBPfiOxxVWgM24nBJWrZyAIq0tJmvOouR
         OXBV7ALLsnSZuYQQATtIhRepdsfJ0cAIr5bMgaPqacuNmmSjNVm6o9ApHICllGQo1s4Q
         2qWIRBcBnaQntbWwD4LzHiDavHsLNibzHqzotGJXCN63SUAW8RMpJgvH+a7It+ai04+e
         vbzw==
X-Forwarded-Encrypted: i=1; AJvYcCW1pgsE7QKzwjL7OjgxcwGaD++j9wnAv78eLkNK7xZTyYEpRBt9UBxJRcQ6RiTf1Dn5twdTY9mjXIlGh3vqVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBcj3Dro8iNR7HHhuuFTOzSEp4zKutHHuMf7idoCQfQ7SLytt
	zab+Ce/LEAclnxIFo1euhvkueRfNTTLlVxypg4lFE8HAnXMRXOa74f2ZZQ==
X-Gm-Gg: ASbGncujCs9tLljJ8r4Ir0stpiwVY+Kt404ii52iwCwPXOoMYdZo9ueGCLqJnbPZe+Z
	HkL9y7QNUnUU6O+ZclZxMFsfx2oN0dtGpNyakZAy+UairvO8VKorDNQUmyQdON/ZJk8uy3ySV4+
	TsiOKq2PpqjXGhSt6mHw+kYB15tvn4Mvm6EkNnGmv0MDxMLbZ5NYS4joOlap5XU7XhYi8oPMAam
	s1tODJ4BFZ+JgPtXokfq9yHnA4INYe+UGvLaL9oftj7QqIXR2jNhqEJDfH1AoiqB8mTlNv8raoj
	2/L+6n6+7bfBTDacUuGX7lkjRmRO0I4YFuIU52uWuFJ7cuzsVO0FLZZ43lUO
X-Google-Smtp-Source: AGHT+IFQQXsCFSpa4sl7Ii8dWI/5XXsPRdo2GRhusF39tMO0rVEjvV662WCDqXCMDAXj/WxSZbyp6Q==
X-Received: by 2002:a05:6402:520e:b0:5fc:4045:7d74 with SMTP id 4fb4d7f45d1cf-5fc4045890dmr3326142a12.9.1746722520513;
        Thu, 08 May 2025 09:42:00 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70ec1esm93941a12.78.2025.05.08.09.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 09:42:00 -0700 (PDT)
Message-ID: <2298a71e-2a52-4912-96b6-2c331dec8179@gmail.com>
Date: Thu, 8 May 2025 19:41:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw88: usb: Reduce control message
 timeout to 500 ms
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <af4d2d58-f567-4bdf-841b-8345d21f7035@gmail.com>
 <d661841634644d089c3250fda7ae43be@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <d661841634644d089c3250fda7ae43be@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2025 06:11, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> RTL8811AU stops responding during the firmware download on some systems:
>>
>> [  809.256440] rtw_8821au 5-2.1:1.0: Firmware version 42.4.0, H2C version 0
>> [  812.759142] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: renamed from wlan0
>> [  837.315388] rtw_8821au 1-4:1.0: write register 0x1ef4 failed with -110
>> [  867.524259] rtw_8821au 1-4:1.0: write register 0x1ef8 failed with -110
>> [  868.930976] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: entered promiscuous mode
>> [  897.730952] rtw_8821au 1-4:1.0: write register 0x1efc failed with -110
>>
>> Each write takes 30 seconds to fail because that's the timeout currently
>> used for control messages in rtw_usb_write().
>>
>> In this scenario the firmware download takes at least 2000 seconds.
>> Because this is done from the USB probe function, the long delay makes
>> other things in the system hang.
>>
>> Reduce the timeout to 500 ms. This is the value used by the official USB
>> wifi drivers from Realtek.
> 
> A question about timeout time. Is this enough for USB 2 or older?
> 

Yes, it's fine.

>>
>> Of course this only makes things hang for ~30 seconds instead of ~30
>> minutes. It doesn't fix the firmware download.
>>
>> Tested with RTL8822CU, RTL8812BU, RTL8811CU, RTL8814AU, RTL8811AU,
>> RTL8812AU, RTL8821AU, RTL8723DU.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
>> Link: https://github.com/lwfinger/rtw88/issues/344
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> 


