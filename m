Return-Path: <linux-wireless+bounces-4707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDDC87B480
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 23:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC38B20E22
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 22:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267E95C603;
	Wed, 13 Mar 2024 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTjpk9m8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6365B697
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369718; cv=none; b=JjGGL/JPIozyHaclas7kdItBOjDeEW6P2GhogYCgK7F54YRYyzag3AG+JC8PcjOCG2pC0KtIOa5Eiyvo4zJ8lQplLqdhOUyGDKQ7hj/jE1wJgTvwEs2QhIPtzcy0lL5p4R02XxN0xfBFUrF8wAImFuRGxhaknBbK5W2uWW5dZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369718; c=relaxed/simple;
	bh=t7988LZ1SIArJCYXSc5CV2jh8v7GFBtTbaiex05kKj8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C/xOW3/vnN2YIyQlQCPYQVJC9uNjoU/ZhP9dkDkd27JYfummwjz0iJCQ/vzZuxDSzr6HtJv9h+9pNdy6jV+l71hoHgR1zNeMYzpcqmo6RM45PnTaSBjLRsI90OJfM51kaSRjoRZLoKD+8skoJJnuLdLWVnZYh7EQt4npM92CZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTjpk9m8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-413ef6985bfso2210575e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369715; x=1710974515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ejIjePZ6YmOgQoXptoL1v7LBjt5xjVQhKv7XkuvU5UQ=;
        b=TTjpk9m8jwCZwOMp3DY6aY9aDlDtxGVBJpzyNvhfdowuumhTG8Pcr93kU8bsDPGor8
         4PvffrnnO11/qTke25apppDKMGQ+5dcb2eFGwhzayFDlZ9O/XrPhLuh+7r3WkIsT91Ax
         ipSheaif7aLXDqxYYzdteZ1NpA2expomUtPP1BDGrOo+Xi5mpMPYmOSaRwBS11rZnV9E
         +gC4H4keyBlitR3Bn8uWn8eHTuSlDxAsXda5iVXXIC3pNpmuYGj3xjHgYAwFNL03HCv4
         /6mbtR78T77Pxlq6W0nWI0FAHB8XWfXDKd4MGJEd+H8Xocn0D8ArVPLMjMhK/R4qmPoR
         FpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369715; x=1710974515;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejIjePZ6YmOgQoXptoL1v7LBjt5xjVQhKv7XkuvU5UQ=;
        b=hcutEIpcorhWysv7ZrD1atNctVetYxz+PfRdZKnHDQecmWrDVE6I1JP3Vjb915R6My
         TEFbgcH6ZU2vez22k/JW+vuiRtddaRAfilazi/7W/8iAr/anlHD8Lgie1fOrMYDDFUOG
         5zZaiCeQQPiS8Jf0tneCFE0eS0COUdRnjqPPbg9hB/1wZw2rprXCNE716BTsKu9+Jf8s
         kDIwkGJy05Q9k60DPZkAkqKZomeUYMEqPFBmHDC2Ob1E9PKpIXNPOKjlDJLQM0LDth3m
         GnMPOIZqPXqH7zqqPtXAiEfmrk01t8gUg05rxSqoHWKs6Z66rKh3FwR2BdCkKIZdhxUn
         fFhA==
X-Gm-Message-State: AOJu0YxrmVLG9Mutlxgiw2z8ph/MR5/PGr8EVAv2iu0HKJsVcvbwbDIU
	FzpIozXeyE4Sg/84keDS6/GoXxBDkntEdSGAHTjw82tb2NEhKvYAzef8BLBY
X-Google-Smtp-Source: AGHT+IHEA3LPMPSDYT9OP596Gh/9BQDyDQ2Dud7YyEuxMiVzq9yXDXuJsSH4DQtgFlxLYstX3h2Ljw==
X-Received: by 2002:a05:600c:46c7:b0:413:1f8d:f97f with SMTP id q7-20020a05600c46c700b004131f8df97fmr96137wmo.29.1710369714641;
        Wed, 13 Mar 2024 15:41:54 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bu29-20020a056000079d00b0033e456f6e7csm167144wrb.1.2024.03.13.15.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:41:54 -0700 (PDT)
Message-ID: <5fa1ee44-fd9f-47ef-abb3-7d578dc7af0b@gmail.com>
Date: Thu, 14 Mar 2024 00:41:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>, "s.l-h@gmx.de" <s.l-h@gmx.de>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
 <20240313064917.527110c4@mir>
 <4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
Content-Language: en-US
In-Reply-To: <4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 07:55, Ping-Ke Shih wrote:
> On Wed, 2024-03-13 at 06:49 +0100, Stefan Lippers-Hollmann wrote:
>>
>> On 2024-03-13, Bitterblue Smith wrote:
>>> Create the new module rtl8192d-common and move some code into it from
>>> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
>>> (USB) can share some of the code.
>> [...]
>>> Tested only with RTL8192DU.
>>>
>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>
>> Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> 
> Thanks for the report. Could I know the throughput performance in your side?
> Just for a record. 
> 
>>
>> Using the firmware from https://github.com/lwfinger/rtl8192du/,
>> it would be great if someone could publish the necessary firmware
>> to linux-firmware.
> 
> I can do that after this patchset get merged. 
> 
> Ping-Ke 
> 

Should I send you the firmware like usual?

