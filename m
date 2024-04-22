Return-Path: <linux-wireless+bounces-6679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3ED8AD33A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CA51F214BD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC53152197;
	Mon, 22 Apr 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJUQIlYk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D40153BCF
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806339; cv=none; b=kCJxf0hB4zivaLjd4liRY7wqb5vKYiJcCDePAM9gUl/mPzzRCtuDD2XBjUerZ0+siesX50K++0U7cPgens3Fc6VDCgllhzjA/p0cO4I0hV5SVO5b1bS7V3ormNe/fjPfv2jxoswig7vW6epz1gEYTeH8uONG7ECbwTy6Q/HDyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806339; c=relaxed/simple;
	bh=c4RDLg3RLGx1DkHdTocgO/US5Q9ax1HYNPomvw9BAbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzjkCd2dIQwoGY7aJBlxLUOyjZBMMyiXgnDkWk98D0T1uKRUeTP2Aq/iskqfQiPTeT6ujfZoilecd8vwpx0TWFtkKj/Qo5d9R8ukiyhYPWnM3wWJ9kF+sJTLc+4vKuIQl8TZfMHy9ajqkBHxixcnqTfn4m/TFc2eZGo0E+9528Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJUQIlYk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso6697124a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713806336; x=1714411136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWh8VFIA82+3wyxGQXCPJwH5SG+1ncl/F6NU2Oef1k4=;
        b=YJUQIlYkG9wOliBEeZtNBkfJCjK8AHL4CqOHHHy/cN7R7N0su1tp3IX/1H18ipxkOc
         QgbxAb4953pGhSxj9xbeL0JG1dM2F7gPB/Vd81nhDHJ1+8uLVacGkHrZvBmdurVJrWkg
         zzqcUgFD5r7QXIKwNC9Lfc70wkzOcKiTdOumaSfNxZIzgm9GhSOeUHYm11VzN8kIRv96
         bYzXH0LmycZl91J4nhGe6UWcTl7War5D+6v3B/KWnAZOp4hVo1gaH8CnGOxBzpAvCm+8
         IB5fqb/Apvtr1lIZEnG6HKOl7LifaojcUCHsnJx8EE1ngKurnG+3aSP/XOA1oVnGTBJv
         6T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713806336; x=1714411136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWh8VFIA82+3wyxGQXCPJwH5SG+1ncl/F6NU2Oef1k4=;
        b=aVa6FH3Hfr+AKf04/oVQC1JGSemyUnELdZPCs5G3umrANZ45OTIGpqKpVXcnDhWMtG
         6rG4jMz/J/u6U8DfaSg3Yn/17DBkXf7sBa5Z3NYwS9W3Xj1eJEz8KqzZF6va2XlM1INL
         /3X9mdWq+whNSNau0BteQN2dtsww0KESBK3fIaFuceCgNF9jsyXd72u/XwkHQoFln6gw
         ljB1btwlg+ZCYSZozRDmPn8zMiupDtSD9Smnm0Fhkeszm9e/YuGe/oTftQfBk0loaP6V
         6kUorssMZQ78GuYdXtY5o6IQMpI11ohFePXbUACXK4w95n8XSjbKvf5dTEuqVkc01Yc9
         PJLw==
X-Forwarded-Encrypted: i=1; AJvYcCVyipHZOZF0ZqFR6qLajP3PSl10B29RTcRjYolcIwUjjtGjTeo2u+hLVIvsHQvD8TVoDnvFSw/VG0CiogTGNNTRsJvnp1fbWGHD/T1SFNk=
X-Gm-Message-State: AOJu0Yzk7xK0JB28jRZ+yZbuYjBOHNKJoPMDGRJTOZAdiS+1cSrvifVZ
	EXJUFgIqUHIdpzldg3JbwiEP25P2hREKJzX2Le5UfRnoPU4IMX9v
X-Google-Smtp-Source: AGHT+IGbl+fxI3N34UAJ10X07d7dVQLT3BIOM+LI5lqi9qYJRloBXp1V+lu2EqBrgsoKJuEU/qwYVw==
X-Received: by 2002:a50:c30d:0:b0:56e:6d9:7bd6 with SMTP id a13-20020a50c30d000000b0056e06d97bd6mr7235467edb.34.1713806336206;
        Mon, 22 Apr 2024 10:18:56 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id fk6-20020a056402398600b00571ba529bbasm5725971edb.44.2024.04.22.10.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 10:18:55 -0700 (PDT)
Message-ID: <409f1f1f-9b1a-4b09-bf34-fba0b3ccccb4@gmail.com>
Date: Mon, 22 Apr 2024 20:18:54 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
 <fe031948-9602-4f6b-9c13-7797047c03b6@gmail.com>
 <13ed709559ee4a48993519c88223a8d3@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <13ed709559ee4a48993519c88223a8d3@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 06:13, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Improve readability:
>>  * add empty lines
>>  * use abs_diff in rtl92d_dm_txpower_tracking_callback_thermalmeter
>>  * roll up repeated statements into a for loop in
>>    rtl92d_dm_txpower_tracking_callback_thermalmeter
>>  * shorten lines by replacing many instances of "rtlpriv->dm" with "dm"
>>    pointer in rtl92d_dm_txpower_tracking_callback_thermalmeter
>>  * sort some declarations by length
>>  * refactor _rtl92d_get_txpower_writeval_by_regulatory a little
>>  * refactor _rtl92de_readpowervalue_fromprom a little
>>
>> Delete unused structs tag_dynamic_init_gain_operation_type_definition
>> and swat.
>>
>> Simplify rtl92d_fill_h2c_cmd a little and delete a pointless wrapper
>> function.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Thanks for the cleanup and test. Please also provide tested devices
> to me.
> 
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> 

I tested with something called "CC&C WL-6210-V3" -- single MAC
single PHY, sold on Aliexpress without a case. I will put this
in the commit message in v7.

