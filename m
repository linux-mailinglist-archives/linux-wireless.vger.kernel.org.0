Return-Path: <linux-wireless+bounces-8147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3458D0A19
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 20:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18F11F21216
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602815F33A;
	Mon, 27 May 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghlq7X46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E6155C81
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835408; cv=none; b=qQKLSr8SRk5Xf9O41MzJYRSGXNj1lZP+k8u22fWuBLGVM3ktA3nFRgM1Ht6A9dBwesoq21UrkUePfd2Zgd2dYnDOp8Q5qxkQnm7mkiGJzqMVekIIJxfZnGej2HDbnWntP+YzyvLcJ7plkWF/21zPrd/YFDUXGXjJS5uCMnaBknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835408; c=relaxed/simple;
	bh=ObozJ/fX/wMKC8ihVB1t30sp4uhbT9BgFarEI3msBUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d48FWVLPtP8Bf8jfuQzjbIQbx7S8evArRDn8OzkAlbuI7lOpe65OgxgRJ0sTY1BVSeSb7HzEVeazazE2+WsPxgZSWZLQSZ/x/0YFU3cdlxZiF6glCpsixEE57wuSys+zpNpfMZqjm/CFVlg7WPxTOzYE/tcyfuoyWB0Uw667I2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghlq7X46; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354f51ac110so47936f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835405; x=1717440205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0pM93VFwd6SZRSiQasN4poAANKyhUlLcdnlWqPHasQ=;
        b=Ghlq7X46KXIN1j5E1vU7lh+plEj06+aZq3NTQC37wm7vvuORM/wMcwU7YvFuAUjoBd
         0eT5/Tfv2EM0YYe+CQyWgOv4KWuoAzusw4sfaDSe0/Vy1hx6nl5+o7JpsiBdUB0HAWYb
         lK8bBEuKzHEjb3uVAbOVkLEmNFMF8xCJdnrinDEZNs0YJ1pLkz2jYUzW5JjCVjYpn4cl
         KAOFIlCMoPBH7YeJ2gyd0M0eSu/MYV0nsPmPf6WV/4vHr1YeNwmplBwaesS8j/oExup7
         yyJ0TeLxGKMXlBQutdXnu9CZfM72rHq9BUh4gFzCt7BgQ8oV0mgikTRySJQd0eyR9O/3
         wqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835405; x=1717440205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0pM93VFwd6SZRSiQasN4poAANKyhUlLcdnlWqPHasQ=;
        b=oYJWbuqL3bmMgP4ffiVAnRKHy4/Sd6nuGChRB2daXpz1lIFOZUhhXvku7247P5MeaN
         6P5Rm0hseEW2aXjCBO2IEa70uFfvvaHYXb5re0enKmQUluGF9Vh3Sxbmue5se2R2HFZ6
         GcuyPjo1j0rdVtJu0A0sxpSz3a7s6HHe/lpEIP23MuQlbACCNOf2jgdarUY+wdPaWkSD
         DK4I03kg15jOR+VkSSEmYsokjg4PyrIb9MTr4qO6Y4H7S2/eiID1fbbPwMWvaGoEIORD
         q6O0tqVf8ly9q0BMTbm1ciS8iTnxweWfykIvxN9pTf1IUuHkdjBlPbFH6PCZ2CszFw34
         Vl5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSGk9y3P4kar82WOTJ5rvYZ4w4JglUN9+T0+E5UgzoWzWgRubby42P//Wlxf1oNQqOGmAY7ffP45buUC02i4DzEcoVh1FhSy7yHO8fNdg=
X-Gm-Message-State: AOJu0Yxcx2IqYkZW1za7r2ercBS1ehOHA14B1BdRfukw47RvsIpygbRW
	1+jMcNPWo4xwJJLQCNmOxjf6H+LeJAk1eF4JAWJJxd/65toidDjL3kVcHg==
X-Google-Smtp-Source: AGHT+IGNu25FY2jd81Ca4bihn+VJYYBa2DFRLXeYifIuoj+B/C0igZz+T6Doz8Hlb7cI3JXe+aczyw==
X-Received: by 2002:a05:6000:181c:b0:354:eb62:365a with SMTP id ffacd0b85a97d-3552f4feda5mr7850353f8f.25.1716835404981;
        Mon, 27 May 2024 11:43:24 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93707csm520248966b.57.2024.05.27.11.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 11:43:24 -0700 (PDT)
Message-ID: <0f1aef25-2b91-408d-aca9-9943dc9367b3@gmail.com>
Date: Mon, 27 May 2024 21:43:23 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: rtw88: 8821CU hangs after some number of power-off/on
 cycles
To: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20240527173454.459264-1-marcin.slusarz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/05/2024 20:34, Marcin Ślusarz wrote:
> From: Marcin Ślusarz <mslusarz@renau.com>
> 
> If I don't connect to any Wifi network, after around 10 minutes, the device
> hangs with endless spamming of:
> rtw_8821cu 1-1:1.2: rtw_usb_reg_sec: reg 0x4e0, usb write 1 fail, status: -71
> killing both Wifi and Bluetooth part of the device.
> 
> On arm, just leaving the wifi device unconnected kills it in up to 20 minutes.
> If I keep restarting wpa_supplicant I can trigger it within a minute.
> Looping "ifconfig wlan0 down; ifconfig wlan0 up" also triggers it within a minute.
> 
> On x86_64 system the only way I could trigger this was via ifconfig loop,
> but it took 3 hours and 20 minutes to do it.
> 
> The only thing that can "fix" the device is replugging it.
> 
> I found out that the reason for those hangs is a power-off+on sequence that's
> triggered by the above steps.
> 
> Disabling power-off for that chip "fixes" the issue. The patches below
> implement that, but I'm not seriously proposing them for merging.
> 
> Marcin Ślusarz (2):
>   wifi: rtw88: use RTW_FLAG_RUNNING for deciding whether to enter/leave
>     IPS
>   wifi: rtw88: disable power offs for 8821C
> 
>  drivers/net/wireless/realtek/rtw88/main.c | 14 ++++++++------
>  drivers/net/wireless/realtek/rtw88/ps.c   |  4 ++--
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 

The first patch alone doesn't fix it?

