Return-Path: <linux-wireless+bounces-27811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F72BB8F86
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Oct 2025 17:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40DDF4E3F4C
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Oct 2025 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181C192B7D;
	Sat,  4 Oct 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVIvqmOT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7093207
	for <linux-wireless@vger.kernel.org>; Sat,  4 Oct 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759593441; cv=none; b=rvlieurTqTCatPHVKo09vOUrLVO4cIL2DmMHWSWAa+DjO456/JYGDapqIPGlGcHjLXTG4B6irOKd5oDyNmlOVJf5rqvaj/TUXO8e0FYiVuamnAz8MQeF9F/jD4o7hmTifFE6n+6U3Re4t5gWuj5bx6kTOZmEBgVbXioPwjG/KRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759593441; c=relaxed/simple;
	bh=ZBxTzhWQ/WePbTENKlW1HRgCW5Wi2yc8XQyJg3tXJfA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lrN2PFdlmzRZpdkmQ82ktWCPACZ2RyPmlezD7ez+bvwilMsSd9YO4ABdkKeC7hCMxI6huMfLjQXAQILk/yaXjdPomwHKoHlpaLyRo2MC005sVHOdDh62LDM4F4bAeioe5GgvwTvCRDN3cexVgKVeKQNisL7/XnZ9Q7MvDFE/su0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVIvqmOT; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso5886716e87.1
        for <linux-wireless@vger.kernel.org>; Sat, 04 Oct 2025 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759593437; x=1760198237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UkC3AELOpWV0/BiWqfTHXOtItCby386HiwylDrzY5Xw=;
        b=BVIvqmOTkh+kt8D7379WHsjQLx7bBdAmQnmiLcduJfOzoSOOsu1yjW38ZspsIxir3p
         p7Ei+s8WzHwQcU+S/o77Ej/USzA6zifrZusWm3VxpdBfne37J2lR9VnATnVZ0b3K5jo/
         i2UiZUrBwNKqPkq+az70vIaGkvCtAQxkHt802fAasSF8MywVA+yKUCchzo/6BrY+aSAe
         tmqMAl23vPDRn/paaS4ldsjC0lt4pu0r+oNciwtU+iBMWNR58Up1i/2jDv03Wbxir45f
         kwoVq7QckNL1mY9WC782yo61LXK2PegP1IaqYo2t/3LacYnKJE2MHYj/i9wLKQnsvPRn
         9hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759593437; x=1760198237;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkC3AELOpWV0/BiWqfTHXOtItCby386HiwylDrzY5Xw=;
        b=ArY8cV+lWMdnm3sMTVNjwlu+Bm0/tVZDpWmzwGy+lJoDVlXPX6gKcATqBECTbcRnFr
         iC8hH4LCvv0Q7Mot10VjV2E76B1xECp4vYs/igAnV26BmINt5jwDT3RUQhTGibuMVC6a
         UNygW5p+h/gQgx73lCTPCDWS2fq0BrFjEGqBRVNm8XuPLecUqyKL9S7PEBdo0q0sC+t5
         7t04u0RLbzaTuGPm8Y1dVHsI5sI3HX5G7tHN8hn9VdsE4UBZKw94ANmMVoufNInnvcPX
         MHPdCx5vAgijjNJUMVhKWrZn0TOmU5+6fzSw0CTKQ8a7RWWNPId1Q0JAc6HOUcJybVjk
         Xp+A==
X-Gm-Message-State: AOJu0YxdKKmCFsVGqFW/o7VvIYXvtpEaeF2MjPRBfi3P1sFqhWe/Xpit
	8iaGbYVwV4AG7xbnOGt7Z0YmhWVY5a+nnmBUMcAhFHykjKhaWbEmOQDm
X-Gm-Gg: ASbGncs6g15PUgRdanjaAc86yJx5UPHxWovlAlo9ZaK9KvTeFAiVegP+27MxTDaSWyu
	zIMiW/U2n1kSY3iDyNfBLspd257MEyG6kBzxRcE2r4V5IPOoGKKdwQUlenf8ZrS3h2nxNDJN9GU
	Jlv4J6i5EsHVnGeyfVfg+4kszLz6eOlz7QLWi7g7qE6MUqMsShezKO+2KC1JT/y5luwiCH+jCyI
	19kly09jIrs2OLXAZIUjDxAz4QiJjCjm/ETFkg7M8V37yX+wTZ732aprROPslCqOgMEqf9cONBR
	tN6x8EjbcRLQXUhXGlGb1iZDwIe/Nzae2ytbB9p54F17UwlVz0nAg8j4FvEn3wftsvkm0/m0QD2
	l8RotAz7cv0pe1fgu28aY1HQDs+gC+2lGTkyN1ktNa137Ez03JvSNcH8GS2tOhYnupBlZ+CylkV
	AoBf/H8j79
X-Google-Smtp-Source: AGHT+IEW6ue7arntffLYPBvQdvDm4i/Rx9L7t7Ilj4bMr+VVLstc58I1e4MQn6+ygtjps1rUSjp9sA==
X-Received: by 2002:a05:6512:138d:b0:58b:75:8fc6 with SMTP id 2adb3069b0e04-58b00b9fcb4mr3307530e87.19.1759593436920;
        Sat, 04 Oct 2025 08:57:16 -0700 (PDT)
Received: from troynas (host-176-37-53-238.b025.la.net.ua. [176.37.53.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118dd2esm2963313e87.80.2025.10.04.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 08:57:16 -0700 (PDT)
From: Dmitry Geurkov <d.geurkov@gmail.com>
X-Google-Original-From: Dmitry Geurkov <d.geurkov@gmai.com>
Received: from [192.168.1.116] ([192.168.1.1])
	by troynas with ESMTPSA
	id wuF0AtxD4WieDQAAVAQQrQ
	(envelope-from <d.geurkov@gmai.com>); Sat, 04 Oct 2025 15:57:16 +0000
Message-ID: <252f428e-8903-4d3f-8337-d42e6a2ad4a4@gmai.com>
Date: Sat, 4 Oct 2025 18:57:15 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wireless-regdb: Update regulatory rules for Ukraine (UA) on 6GHz
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
References: <d2e09391-d2fd-4456-ae45-103239dbac74@gmai.com>
 <CAGb2v66VXhx0ymHGOdS33W2QxUMxew1xW--+hrs+jy48u6MfoA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGb2v66VXhx0ymHGOdS33W2QxUMxew1xW--+hrs+jy48u6MfoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi ChenYu,

Here is official website with text of amendment that was approved and 
became a law as of 13 August 2025

https://zakon.rada.gov.ua/laws/show/976-2025-%D0%BF#Text

The text is in Ukrainian language but you can use google translate and 
translation is pretty much accurate

If you have any questions feel free to ask, thanks in advance


On 10/4/2025 5:38 PM, Chen-Yu Tsai wrote:
> Hi,
>
> On Sat, Oct 4, 2025 at 10:36 PM Dmitry Geurkov <d.geurkov@gmail.com> wrote:
>> Hi,
>>
>> 6GHz wireless band was recently allowed by Ukraine government for WiFi
>> 6e standard indoor use.
>>
>> Could you please add the appropriate setting to wireless-regdb
>>
>> I'm not familiar with wireless-regdb format nor an expert on wireless
>> technology to create PR myself
>>
>> You can find all needed information here
>>
>> https://eba.com.ua/en/v-ukrayini-dozvoleno-vykorystannya-novitnoyi-radiotehnologiyi-wi-fi-6e/
>> <https://eba.com.ua/en/v-ukrayini-dozvoleno-vykorystannya-novitnoyi-radiotehnologiyi-wi-fi-6e/>
>>
>>
>> https://mrt-cert.com/en/gjxw/4323.html
>> <https://mrt-cert.com/en/gjxw/4323.html>
>>
>>
>> Best regards from Ukraine
> Thank you for the notice.
>
> Would it be possible to provide a link to an official document or web page
> that describes the change? Something from a government ministry or office.
> We prefer those as reference over second hand sources.
>
>
> Thanks
> ChenYu

