Return-Path: <linux-wireless+bounces-3779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313F85A7A6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7300B23C2D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3B38DEA;
	Mon, 19 Feb 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMdPK3gK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AA38DCA
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357250; cv=none; b=qXLvbS16tT77uWULpSqbxdWozGKtga8uh+zznVvHjhu/DRnPyuUDtg0YHwSPLk7Hpr1RCwRlOzG4xz2T7a+aVaz3vtrKcGW2gSbW0per48Cn72JWOSn84t41JPfcOH3LeRH8PH3pZ4GjM7EWuVulLqPfP0YHyNlMTBSKP/E2n9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357250; c=relaxed/simple;
	bh=K3E8jf+mQ+43IdnCYQ5EIalB8sNPtggge0ma7pnbbQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVgQdudBUyHnJ90gOyS7f4pB5b2LhATwI5BDTDPpYoXhwiJU916MsmjrMFqKvepspeTKJ0CPka/+dB/UnYKXYsJDechWhcr7q+aTfmAqT2razaghviKAprWhhYBPZcjg2wX6EaSfK2171DHtZ1ZGlc34nwfGo50yyrXbWFbmN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMdPK3gK; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59a8ee08c23so1609563eaf.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708357247; x=1708962047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JMuWaS40IHpZcZ3n6nIc3LEn/ZkF/V302y+1lkvHg+0=;
        b=NMdPK3gKVW6mK8IYCS0XWYJX0qHzCX9qY3QYQ5MMWM4Ym3FVlSp5UeQt/+yCNgpkyN
         RW0H3r2ceO/HMe9MSubVj96b7hGqfUaK76whu3eHamLlg8+7XlDo8uBzO23vx+U8+bs6
         NQw427UpuUAgoMeG5wi3yC+4psUuRH3dfC6AOg54ud7Wa8yydoV9ZZRd/3F93aJkk2H6
         urVD4UkfFNDE7AwKV/ARmXsgoeKcbqrdwe/pF93vFsjf2GUZoM7mdWLRNTUCyCst+Lyv
         ipCBplHunNMjo+siHccQU0R+McpQ6QVvt5807dCPMzC04mHpL8CL3dVwDoyGeo1h69u8
         dzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708357247; x=1708962047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMuWaS40IHpZcZ3n6nIc3LEn/ZkF/V302y+1lkvHg+0=;
        b=ogywIHHMXndP/jxngW8Jy7gfJSo5o7ehvTG4q+UQMRLUhfxxPALUFI5yjzKcgoLZkk
         RiN0EfEIxwHDQfGINivNFGOADZ0y3ObIu7k3hrh7l+I/8PGm2EnfOb/YyR8M443HOqW7
         L6WsYWe+XFB71LO6Czw8MWzSYVmADtZuLJFNCaEsXuRKrbvZx8b9npMILn7A0mtyD0NX
         24MOQQo7oAa0z74ZHU18gOTBjuCQ/GcL7oxUnsJ5nniEc81j42Rk/DzHV6qKlO5Bf86e
         1VdpFJjqTgbnpIgnAP/pJbeM4koHFKSYqW5aMYaduntPmaNkZBgu6JUmV68C49O2ByVu
         zY8w==
X-Gm-Message-State: AOJu0YxY/LNoZu2Q0Py9rH2oUJK7+h9ODtNOUYF+3F8IPmdewLQJ6B5/
	Ua7H2saRumDzS03+U4LC9gqH221tfiltPu3BJ2GEw6Uhu9JU/BkU
X-Google-Smtp-Source: AGHT+IE1MrT0ji4ZIQdFX6NWzOd1Y2Om7KR0mRxWE5b6fYX1l731FziKc6PNLlCSNAA1cJpinl1zSQ==
X-Received: by 2002:a05:6820:e07:b0:59f:af25:aed8 with SMTP id el7-20020a0568200e0700b0059faf25aed8mr5818112oob.8.1708357247175;
        Mon, 19 Feb 2024 07:40:47 -0800 (PST)
Received: from [192.168.0.188] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id k7-20020a4a3107000000b0059cc37c8cdcsm1070839ooa.46.2024.02.19.07.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 07:40:46 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <99fc641f-f73a-4fa6-b3c1-1c19ac697602@lwfinger.net>
Date: Mon, 19 Feb 2024 09:40:43 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88 driver support for rtl8723ds does not work on Radxa
 RockPi-S
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Brent Roman <brent@mbari.org>
Cc: linux-wireless@vger.kernel.org, martin.blumenstingl@googlemail.com
References: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
 <9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
 <f8d31d74-fdfe-8706-6748-273b8c3674ca@mbari.org>
 <b9a4df4e-4b1f-436f-ae4b-90fc0c68ae81@lwfinger.net>
 <878r3hc6hy.fsf@kernel.org> <42772df2-32b3-2b37-045d-b528a752bef7@mbari.org>
 <874je4dfoy.fsf@kernel.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <874je4dfoy.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/24 02:24, Kalle Valo wrote:
> Brent Roman <brent@mbari.org> writes:
> 
>> Yes, that's all true.  However... Random MAC address assignment tends
>> to cause devices to be assigned a different IP address on each reboot.
>> This often doesn't play nicely with port forwarding.
> 
> Sure, I wasn't claiming that using random addresses is the perfect
> solution. But you could also set a fixed random address from user space
> (hopefully that works with rtw88).

That will require a new module parameter, which the community does not want.
> 
>> It's difficult to "prove" the RK3308 cpu serial numbers are unique,
>> but they should be and the few I've tested have been.
> 
> Please take into account that rtw88 driver can be used with all sort of
> different CPUs, not just RK3308. This is why I pointed this out.

We should be able to modify the code to handle a number of CPUs. They all should 
have a unique identifier. On my 2 Intel-based systems, there is no CPU serial 
number, but there is a serial number attached to the system, In addition, this 
code will only be invoked if the MAC address in the EUSE is invalid.

Larry


