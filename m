Return-Path: <linux-wireless+bounces-4710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8C087B488
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 23:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0007B20F83
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F1D5A10A;
	Wed, 13 Mar 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmJ0ofj3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BB5A0EB
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369978; cv=none; b=bgK3v1FFMUuceGQr/iD+4rOTeSAWNLcPpwwpWuoOE8oJLwQL4MuUtf1Ci/T5JobibhHN97jzyd64+dItjEBmYlORO6RAZ0mGuX4WgtPQdqfhrhJY4gehnAUoJVkGGQvfhoFdW719ToJSdXnxVLN6qudqRxcSQY3MyyjtYMfLSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369978; c=relaxed/simple;
	bh=qzxki/s1wFB56wtkZ5Rrv5zgBwr/bgpmmq1YD1p2n98=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BltSDOxgwaJp6p3o3BwEzie4yZteN4DUtG72kuGcHlgAnpnHKpAUZTN1CD92VtU35x+fni/oDgF36QWVgEIlm9sJF7B+HSYa5ckIOyH02u2BJqDTqf5Xq719SGuopu40Uv/IGeenZAcNAScstWlmYCMYQKLNP75h4kDpSqGJOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmJ0ofj3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e92b3b5c9so317925f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369975; x=1710974775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B48XPBGoiDJeJMz3+wFnKIi762r+/sjAvDr0Nu4Cohg=;
        b=dmJ0ofj304mSdv41UN1rbgmm81KAP5HQivXaEvHPlZkWeWRYyupw3ByfZTTpG8txVm
         2OoOrLM8iLPnf/IdSCZMyG8Y06B74UbX9IFv9NcrUwVhDI0htl0RN7rND9jWy4v2nEWv
         xp2lPNGxOr98iVnEr5c7D4N3UVgDKxFrnr8EVDlca8AXG5/VwmdL+tvsCUTtjnYkFO76
         hLJwqB+pPZMGYLFwX4HMs/Y6RJPGkCfsRPrzD4+Ip9wU6GniNqZ6c7I/ea1oYJl8C6Am
         LQPuoa1lxv/rIyyt170XYGfiV7ejezhYRSdy3V6YKektrYt1pcLdb/dQiyVmjYUPpF6g
         Iy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369975; x=1710974775;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B48XPBGoiDJeJMz3+wFnKIi762r+/sjAvDr0Nu4Cohg=;
        b=oM2UlmmwCUi8YEWbVAOi5sgZlyVImcmAOkIoXADmbTQRbKbVmoRXOsmxLtmydqY9Pq
         HtOFA35MkY+0RVYNmJ7KiDtVZxqb1tIuRZFlbQcRk/gCU3NSGuFwlJ7iM+xMxNvOIUL0
         EARewphhssligdsaneeFYf6VxhdwfR76/hCks/9cSir8rZT0h9wtWG+BHJ09DSORS5/I
         ++8B5fx+arDuFlbrdMpHAcK7POf/LDUp7lGsctk2g+NsCkP/y6p5E51KCnYFvXu56xvr
         QeTnjjT8RqOiz/Q+JXqGAPeI6wQbQdyXXt7tqO0u6RKuwVPblsuckChbjRmjlvpPyHUn
         LQUg==
X-Gm-Message-State: AOJu0YwWU/rEHQvYN5Bqgnl0j2sxb5qB7oF8uHkgUM9zVWBF4HqLXnBa
	KgRwiViUZ1awfjofgtTWfhQgKIQPjvYCGG18vlUIBsNt6JdC/d8e
X-Google-Smtp-Source: AGHT+IGywWCBTmCY97bIEbltZBJ93Chdb9P1lvHJc+vfzgYoq2C+oIzM+4cpcKKjh0IHebnBziN2AA==
X-Received: by 2002:a05:6000:e51:b0:33b:187c:4ca0 with SMTP id dy17-20020a0560000e5100b0033b187c4ca0mr2469537wrb.62.1710369974956;
        Wed, 13 Mar 2024 15:46:14 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056000060500b0033e49aebafasm176437wrb.3.2024.03.13.15.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:46:14 -0700 (PDT)
Message-ID: <7fd2d445-9db0-4170-8d89-78d42f476255@gmail.com>
Date: Thu, 14 Mar 2024 00:46:13 +0200
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
To: Kalle Valo <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
 <87jzm64ig6.fsf@kernel.org>
Content-Language: en-US
In-Reply-To: <87jzm64ig6.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 10:58, Kalle Valo wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
> 
>> Create the new module rtl8192d-common and move some code into it from
>> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
>> (USB) can share some of the code.
>>
>> This is mostly the code that required little effort to make it
>> shareable. There are a few more functions which they could share, with
>> some changes.
>>
>> The only other changes in this patch should be adjusting whitespace and
>> renaming some functions.
>>
>> Tested only with RTL8192DU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> A cover letter is would be really good to have.
> 

I can add one. What should I write in it?

