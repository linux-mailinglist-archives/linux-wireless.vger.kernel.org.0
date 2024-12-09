Return-Path: <linux-wireless+bounces-16032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22679E91A2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A11282445
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E75219E89;
	Mon,  9 Dec 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTAhDzd8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC5218EAE
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742326; cv=none; b=ouxIRdxTTunwou05nnKCFuBRFIrc7Ze3gbOeY/MD36Nytz+X/mr0NtsTPVG1tEt1f329nuPqtkI/J9yp7Tk5B8Cm8dnVEwlLZUlw79WSoyapqKhhCxd4LBMczKcVk1SMS8uhqya6rJbQvIfxiUXCJTVP8S794CeiB2gnBD8ycW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742326; c=relaxed/simple;
	bh=epidLB7NhL5xTx6DaDSzyC9NSZa6RPmcFUHWHcegxtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLSM8GcxeXWulIwBB2JEQP5DE1ykZrpy7RCHKpR4HDHBTUCjZ1aCnjM8JMJuqaeUw5VOT+vRQ1AbLJBX2A+gQ43E0T5QCCh5ug38N/nh3Qda0KV97LFcBNPcQucrSvPvPAtNbIF9yAsZUb5nXeWPn/lmiX7FMP/CqEY7g7BrsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTAhDzd8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733742323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcqFqgXjnmt6G7/7k/hur7z0RAKrnBg+DMT5WyZ4S4w=;
	b=NTAhDzd8G04kNGguoAdJMPWUQnV/3Hx4v1UvjmDChCW7xOqOG7q59gHZaTOcFuUv3GmWKs
	NYe0MDOK5JQ/EAx6HJUDgiWvENPSQTf3Hfw1T3JVOsOG2SRzx2/cGxr/PLzT52zaqmjgJc
	pMLLIw58u3maTgW6RcThuLEVuaeyTao=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-Sur-mTc3MJO5d3VVy_9lfQ-1; Mon, 09 Dec 2024 06:05:22 -0500
X-MC-Unique: Sur-mTc3MJO5d3VVy_9lfQ-1
X-Mimecast-MFC-AGG-ID: Sur-mTc3MJO5d3VVy_9lfQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa6481dcc0eso258019066b.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 03:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742320; x=1734347120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcqFqgXjnmt6G7/7k/hur7z0RAKrnBg+DMT5WyZ4S4w=;
        b=DdvAUojXTK/zwBGn2msLtmvc23pma4Jwjm/xn5/kkUUYN6CYcBBxw3C/g85Mh+897d
         Z6a0YdBGl5+e4msqu6g3LAOt4wSK3Qyv6ws5vhQAVIY3xdqo1mlTgA42LLg/SJLKjswN
         +8HEZ+0VC5ESxmJGJKWY+p4IkmSt9DxRTxcLwnmtDnbR3siBR53IEN8rcPJ5E6r00koD
         WCL3OYMeCyMio9iM6Ba2htaWHXKKcL/JtRo3L7rBvzmxTJdBOVExOziZ73A1ufKZvUsE
         uK59hzVVnUQXT3+orEuqHVZ8uEYQD93yEVcEcav+ahDa+Sc5lCIdRVqZ6TRet2LG2yfy
         1ozw==
X-Forwarded-Encrypted: i=1; AJvYcCVWTNyxs87QlbT2lF5Jkuyq5nKAMI2EcfbcSId1ZBsvQC0OC9qBDGZ7BgyI/h+suLPJvN7SeSl+cx1gKYPg9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbERQCisLYI/ahYjPC3pVPKlDueQ/kN24viKR82RQ1fmhWuX9
	cFdtHcx8WFIudXaRpCSNfUFI117cO3aPDQ2DViy5mWHdQ4AwUBG89yHfkePOfwFvSkfGz2hWkeG
	gSly+wq5yh7Krw3h0xQOVVgJK8B0zBqBY2SyMRNvxa+7/QBBL6JX0+zmSs4T5NcKCQcOzWrio
X-Gm-Gg: ASbGncuaKAyIkqpJ2T3ocQEfiZhrwqh3yKEkSYrvB/4R3BJK0q2twKh/UXwXqQYSaD8
	gCFUfbw4PdB87JCuK9c2n3wvm/h9PIvmV31J0JhP7kPSCkB7JWLHIQ5unxf5QOtRpxi4jPueb6C
	CGJ02trR3SMyociD+ohJq5sPf7jHSeyy/0ODy0nCUh1Yp01N9GAZM4lH0q3DH6GZvSGLhj4p/wm
	OipYx37ii2QEhibEiWVXNfAIfo4V3EXgRj70USzBLG0hXIBZXtazw==
X-Received: by 2002:a17:907:7846:b0:aa6:6ca2:b772 with SMTP id a640c23a62f3a-aa66ca2b8e9mr559076066b.10.1733742320178;
        Mon, 09 Dec 2024 03:05:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEinNFXzpmUfvbOzVGpdNy+v/42bFycLFBNOD3IwdWR5Q+hqMHMYElk8YhkflG1uTj/MaQTQA==
X-Received: by 2002:a17:907:7846:b0:aa6:6ca2:b772 with SMTP id a640c23a62f3a-aa66ca2b8e9mr559063866b.10.1733742318172;
        Mon, 09 Dec 2024 03:05:18 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683de38fesm165450266b.108.2024.12.09.03.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 03:05:17 -0800 (PST)
Message-ID: <5f0bb4c4-57f0-4976-a6c2-2419500ffe4d@redhat.com>
Date: Mon, 9 Dec 2024 12:05:17 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
To: Kalle Valo <kvalo@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20241107140833.274986-1-hdegoede@redhat.com>
 <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
 <094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
 <8e0a643ecdc2469f936c607dbd555b4c@realtek.com>
 <1d59a602-053a-47f1-9dac-5c95483d07b6@redhat.com> <87ldwpt90g.fsf@kernel.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87ldwpt90g.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9-Dec-24 12:01 PM, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
> 
>> Hi,
>>
>> On 9-Dec-24 1:26 AM, Ping-Ke Shih wrote:
>>> Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> On 18-Nov-24 3:23 AM, Ping-Ke Shih wrote:
>>>>> Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>>> The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
>>>>>> except for the following 10, add these to the untested section so they
>>>>>> can be used with the rtl8xxxu as the rtl8192cu are well supported.
>>>>>>
>>>>>> This fixes these wifi modules not working on distributions which have
>>>>>> disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
>>>>>> like Fedora.
>>>>>>
>>>>>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Cc: Peter Robinson <pbrobinson@gmail.com>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>>>>>
>>>>> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>>>>>
>>>>> 31be3175bd7b wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
>>>>
>>>> Thank you for merging this, since this is a bugfix patch, see e.g. :
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>>>
>>>> I was expecting this patch to show up in 6.13-rc1 but it does
>>>> not appear to be there.
>>>>
>>>> Can you please include this in a fixes-pull-request to the network
>>>> maintainer so that gets added to a 6.13-rc# release soon and then
>>>> can be backported to various stable kernels ?
>>>>
>>>
>>> This patch stays in rtw.git and 6.14 will have it, and then drain to stable
>>> trees. For the redhat users, could you ask the distro maintainer to take this
>>> patch ahead?
>>
>> That is not how things are supposed to work. You are supposed to have a fixes
>> tree/branch and a next tree/branch and fixes should be send out ASAP.
> 
> Please understand that we are more or less volunteers and working with
> limited time.
> 
>> Ideally you would have already send this out as a fixes pull-request for
>> 6.12 but waiting till 6.14 really is not acceptable IMHO.
> 
> If you have an important fix please document that somehow, for example
> "[PATCH wireless]" or "[PATCH v6.13]". If there's nothing like that most
> likely the patch goes to -next, we (in wireless) don't take every fix to

Ok, so how do we move forward with this patch now ?

Regards,

Hans




