Return-Path: <linux-wireless+bounces-29108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C135EC6B078
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 18:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96FA24F5841
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34977369206;
	Tue, 18 Nov 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw1V+dj2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600E36829D
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487244; cv=none; b=sb2Lu8Mlny7pKn5xWgVnJlGNLa2Px9/VKTsIxKPcP6Wi9dqgJWnhvAv91LbDY2dLHeqC/FgEy5ljXtHzhFUDZrdz5ukAs0GCIJgSCGKW5eyhpvVJiuci9JVwq5PAKeff6IIVKaqp0+HJWNiLy33WADcaMSGuLt3gAEdxd/NWPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487244; c=relaxed/simple;
	bh=dva4IbOlaMl5pbDLQk7Y+w+y7WfATH/9MLHoKn6/f4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+ZmG650zVESWnTotyjQKkbNkghfdX4RLeeQ0x1epa2dFI/mkvz58H5UC7X4yCcZ/5Vkxh4fdQByngEeOj5IL6UZWbWXbPbi/XniUG307ipyXqKnvgaOfRS9ZdvWSnzhuJX7NBjU+A8Qu3RX9zeyJRzRrAu5LctCK42JAOJqPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kw1V+dj2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b73161849e1so1025551066b.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763487239; x=1764092039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtCJYfjO3IQbld1wykUfnF8xLcNmIVSOCesD3so5zgQ=;
        b=kw1V+dj2zgRGOxcJxfR9zfqF4RFBpIIfyoSwPZcKDYK3YiDX3TAPXZIwxJwt+LDYKT
         0aqDjMQ/H4pe/bjbOiM4l+s5gXTGklD/nj+s8IJAd2JwmDzQifyNvwzysw6fgmddlyaM
         mBwn6GuF2hbiP1lT9x98BmHIP1O7W/eXAxWDsrrE8lFWOg+w3ge8+y/YZONLD1gcIvo1
         hz/zhOCOe8gr3d3BdXAlrEm/ZQwTRbXgnMwwniVZyymiMVb5oTQLnhn7UosdLwM+/GPv
         jxKl6K6WcJ4hJEn+oSWtWp2BF3YFr7svaBOAoW0FFjNbYzZqNNUjA5CWs/779o/Nv7yF
         fO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763487239; x=1764092039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtCJYfjO3IQbld1wykUfnF8xLcNmIVSOCesD3so5zgQ=;
        b=Y/bwP0J9mkY8tlZKy/InhbY8KYigaO/Rh/o3XOWoH/CAt7PVQ3A/5BCMzmHYyBbqRB
         PqTo2MawBn+Z3F8SbjPwNUqXt3+Tu+Q/k88Yntn6qQx0yErE+8gBRWtghUuD2eIpCcCE
         I0xit3eYmOGARMrFEcH5P+Zd8qPfesb47UGBnoI+7oDQMi30Rr8RPStOIi/aGII0nUAI
         mwY+5bbXSuWW91uiL4T1g9KHU4aE+7pfSp+fWqDBlpvXXYCxNmud7TqQ1lkqJ+YZF0V1
         G+tePAcCHslnIeJkSrNaTC8mEHZ8Ghx6naQL4Dp8CTm5+QTQQKXvWD3oNzYAkw7Ox9yb
         vteA==
X-Forwarded-Encrypted: i=1; AJvYcCXJZFdz61NMs/fWkgnlyZS79vW7pG2PCdTvzu11/YYszN9lcr5AHJ88VSrMvgOxkwFHBW19hKwqoFwzL9FISg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIlNjNsU0EMogwJ1ikBOz1ydDJ3zx9875uCxGC5q74x9bpkrA
	GzoZ3lUVlIGMOQSI+f+x0v1j/pnEny8qoJs6L9eJ5ZypLU710DrjSOjh
X-Gm-Gg: ASbGncvJIqNLx5yT2eb+oLR939H8mRWlYtk6K3R54rE2sHlNBAPB+cjOK+2LZblRUrv
	ywvVz1/ytOsZIVJyq4AYjshsbxJCDY0Y+LWw9GsE7FTk4nASqhdJ482kmpvxjo+DDLI5muFZrG+
	qJheBPGSrhuhcuOo+bJRq8nlBtiAt6g4D5hCVxlBNW5Ob4Z4Fb42HMrJobEwXO+7cG0UJP5XBX4
	C98W4GHsn2i4Uj2neI0kakOA0G+P1YLs6FK2TLGC9WHP71dugP6h5XmgqQko798qbbmmEEoutb0
	+PRkycsWDyGqfihZ7U03nP8ZnsDsdquVjQaI7MwSqBVDqBFGOuok1fFU008TxrPIUHCr3B6fqQT
	XZBGyQxWLPPdtj39beIUP3HhHrtchnSvwH8lRsVmcSWV1eOq51FgP9j0cZCxW4lqlgFgmwdzqCg
	iTTaoHQfLK
X-Google-Smtp-Source: AGHT+IH2HByj5Pk+T7Os1RMjoO23yN0OIyUD4nPJPGHNfE91eoS2zfOLTrhczZF5deQHCutOd6nqGA==
X-Received: by 2002:a17:907:6d29:b0:b73:8b7f:8c48 with SMTP id a640c23a62f3a-b738b7f8f60mr1054141966b.37.1763487238895;
        Tue, 18 Nov 2025 09:33:58 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa80afbsm1376937366b.11.2025.11.18.09.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 09:33:58 -0800 (PST)
Message-ID: <6a84df25-b3b5-450c-964a-cceff9544833@gmail.com>
Date: Tue, 18 Nov 2025 19:33:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 4/5] wifi: rtl8xxxu: Fix RX channel width
 reported by RTL8192FU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
 <afd60ba6-4af8-4944-a915-4e2b814bbed3@gmail.com>
 <988bfe53bd5b42bbb411745f34114db1@realtek.com>
 <cc6f78a75c2746478191e6fe1537412d@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <cc6f78a75c2746478191e6fe1537412d@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/11/2025 05:02, Ping-Ke Shih wrote:
> Hi Bitterblue,
> 
>>> +
>>> +       if (rxmcs > DESC_RATE_11M && rxmcs < DESC_RATE_MCS0)
>>
>> Nit: would it be clear that ' if (rxmcs >= DESC_RATE_6M && rxmcs <= DESC_RATE_54M)' ?
>>
> 
> Please let me know your thought about this nit. 
> 

Yes, that's better. Now I remember this came up before.

