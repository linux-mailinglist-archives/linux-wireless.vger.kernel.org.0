Return-Path: <linux-wireless+bounces-18710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F900A2EDEF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 14:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B1F3A1D53
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724722FF5F;
	Mon, 10 Feb 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLakUSMF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5122F16A
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194242; cv=none; b=p585bl+wngxe3whXiVpy2q0c1jihaPKKKGg0LKO73xPDxBeKVICf82gESbltyrrErPjlSYrQ6Lrv3NPBgM4wN9lHu2lL/pUg+gqeAulp4JXFvork7t7Ue/rX9B78cE3f6mKwNOVX281UEVVoppSIbYKm7HAY1WtCMXbf5osZ3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194242; c=relaxed/simple;
	bh=xzR95+vrkDBDeB9j0wCiT1Bu/67XaaV7S4ZZbWRygnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nSCVXZXUN2Q7bzDO8G7/MNeihZcN0vsErzkHQCEEfjCEvtX9uVBh+mZTl7v1+mpinAy36mkfBMwVv4Uccgsi3E3Brtuc70lv8D8b0y/jKiFuX1gFQdgOJmwsfDzRICKUNVLuHg5+VDEpOPjiLOATbjnIueGwn9C5oKQSw1unYkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLakUSMF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de861dcb04so1034545a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194239; x=1739799039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q24vHHQ1SnBMHxcwto72Dh3csPAbQwG8zVQfdc192pg=;
        b=fLakUSMF4O4zzpsBGYyZnEWuOZw9zbsCJjaODWjveLulGVC3whwQ+GU1GtMeG2T22N
         FX50gVS8inq0QSXlH0kcqBPq009X0074fHvmbNoFpWkZ3Vgs0xjfWHnW/9xQDhGztjtU
         9nnTHTgWsWjE8a5Gt6Ttkcbu7tqANv18jyPYqjGsVNwmw2pFsn4KRBXi/oA4UgJfdLMx
         8T1yIUgt7cD+34wWPqRZoOqRs+EBXtU+O7h6Y/h9UXV16CKTUy0Kl3esIFIWz8mChK+u
         NdJ9z5v/c/AaquTrntoH8Lld5VNfjG0YypmRl6EJiRXYdA22oG5nXpM7o49G6GxLHWnl
         jfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194239; x=1739799039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q24vHHQ1SnBMHxcwto72Dh3csPAbQwG8zVQfdc192pg=;
        b=SXhXdeqxEsDtld5ls70zyZGJVfSI49P6XQ2uCX5/nHxsFYLo1O74DmY9htYKcGO+AS
         upqwRRnXP8i/xWVxMxDckxDqDf1opAUM4lScBPjXnAc/2yCuBbur3LlJ0MSyKF2+te4/
         SG+TWIjfR9Uf3jgLbrkv9wuaL7OBxlddUlsmqwwe/mCQ9/Kz0cli7VH6fyCDgsjwPgfN
         ajISKqhuR3TyAwgFkhmHEIt9jS/WdWJ36kjBQ2WXDzrNrJon3l++iopULzq1THZp8z78
         h9lsykVDVUa4AJFkxgYf1zY/vgnGAmRyxeZGTE+wQ7a5GtAe0fo+4fhPeVo3UHCwL/hl
         T6JA==
X-Forwarded-Encrypted: i=1; AJvYcCXYbiEeHvoMOlfbJ4PqwkI4Uw5IsRLutshSnyWlKaIC30ViSJvTqeGNvlfEA4Ln1O/wXJ1oOASSHeMd3jUY0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWs36F4V/76YbeaIIFlq/wpnSHQkCeZ/bHHmBSEJu+kO57CmJP
	Qgw+MMjHhY7LhF5cNrwbSP6q8vaB3ZHnO2kGQO+1IxDndVaSUoA+nsA2mg==
X-Gm-Gg: ASbGncsBN7j2I98Z+nlHSMuyliygESe0WnLySzGgACPRcF2NCB4H/qYYR1szLfzwNwf
	MndwhFMflv10eyzhAYqqpDiLoGFL/cYToR0c4scFiNHBF7oZek9SCXHeu4uDy65V4X3kLRkbthn
	6GXDegRz+81zB+eZ4agQdWWOd8XH45Pr18cWN+T23+BAAM4xnt44zc/5LgDEPDiAyb+qGZXLvwm
	gZEExjU89C36/s8GBgaSK4o7j0eymBUdvKuYotNR2cNVzPQ6b4g87AQCIyhTyMMVVYu9qpF5QSs
	BYUBwdw1qqCrhWMc0ibywYig
X-Google-Smtp-Source: AGHT+IFx3k55PTq8kpgwKcb5RBhQUyp1OMTX5cXkssctzaZV79A7RJPBwJuog5CyrXFMu62ocVpQYA==
X-Received: by 2002:a05:6402:440f:b0:5d9:fbb5:9ee with SMTP id 4fb4d7f45d1cf-5de45005adbmr17226356a12.13.1739194238397;
        Mon, 10 Feb 2025 05:30:38 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de63a89b6asm4042296a12.46.2025.02.10.05.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 05:30:38 -0800 (PST)
Message-ID: <53fc4a4c-dff8-4d30-9c79-c91fa36b55b9@gmail.com>
Date: Mon, 10 Feb 2025 15:30:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] wifi: rtw88: Fix __rtw_download_firmware() for
 RTL8814AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <55b5641f-094e-4f94-9f79-ac053733f2cf@gmail.com>
 <3a8771c4587e4ac5b4bd59d95f6d5162@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <3a8771c4587e4ac5b4bd59d95f6d5162@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2025 03:23, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Don't call ltecoex_read_reg() and ltecoex_reg_write() when the
>> ltecoex_addr member of struct rtw_chip_info is NULL. The RTL8814AU
>> doesn't have this feature.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
>> ---
>> v2:
>>  - No change.
> 
> Next time please take my Acked-by in v1. That will help me to save time in v2.
> 

Okay, I will do that.

