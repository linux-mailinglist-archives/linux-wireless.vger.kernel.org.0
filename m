Return-Path: <linux-wireless+bounces-22792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02FAB16E5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 16:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802B91BC5020
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EA62918F7;
	Fri,  9 May 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOz5zLDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343872920B6
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799814; cv=none; b=aqMjj3hqYyWgw/+LGyfUyxTN5ZJzkLRy1831vPMXX0LxcHEhYoFlXnNY60vGhpOFXAE9+FyalnAxRVbDx4A7AWvapTZ8f1af7/Niafz6aYbsFSe1oApUuPFLIJ/3thj9ijmFfN0Ii8VIDz/txMYiTPY+QyvpYN3LU9sCbTzDdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799814; c=relaxed/simple;
	bh=jv2nYnyW45W2O7iOZjQIFqIOczwNPCCn+cSs4vmT9Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGeZBWpgMz0wkmkNRYzFWHz79ZfCVLNfqdPDcNxO498i6sZxEXLy+9zg/V4mtVCgxyvrjRWMByui89PFsbLyoU2Q0YCnjPxi4Sso1peyYoFZpJLSvs3RdeAe4/ZeKkQafGKV/jEfCaTtVvIS1PX+uo/fIdBgi8VMnPJbDN0p7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOz5zLDw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c55500cf80so216954285a.1
        for <linux-wireless@vger.kernel.org>; Fri, 09 May 2025 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746799811; x=1747404611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1rXhUKHNS5ZnX5jzs+VLeHWyFhaGS+q5ScHq6Ic0gQ=;
        b=fOz5zLDwuyXcVweWjMEh3sCIIZcgEvFpj70Gc+YkcW9KS9q2l8c1W3sLmFSSegO03q
         x3n1k4PcgomQjdK66l3EGNYzQILnzsIpbLiL0LSXCgdelXpWfTR3CBIMm52M6L/5B91r
         p3ffyMAcDKAWFqR3Io0pEnpGbgU9HuSsnYbVluebsl4sU225aZObt2sPksXpZF6U4jJx
         a7+XGxUXIstH+2VdhrZwK99fVPwC3WGcVAIS8v+iRZdtI91rVVEBL4lHvJP0xGUF7I8z
         Zk01rqW7MVXeT30olE46CE6+/PWDA/w1TiwvNz0MenZPSDHpjN3yoBoGfRO+BbSXvy2i
         OMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746799811; x=1747404611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1rXhUKHNS5ZnX5jzs+VLeHWyFhaGS+q5ScHq6Ic0gQ=;
        b=tcYXMJsZh9Khhcv5pSTNhA76X8bc3DfzsR8tBhFCraI8zv7EsjZen+ZoGVN/IjQLpX
         JCVXBb4A3+K229WGLGv2ljP5QXaHmgE+oWIXFkkWfAdYQvexrwzfrBLfjjlTwaus4CCU
         Br1KD/OVfrfHnd4wPMX//8dpSg3coovWc5CrSTBzQjiNl0dEQ3yCoKH5KzJnGPHYPP1C
         UW0gQtpFJEKos3BG10pNP7AxHvhN6AvaggW22w/9IwaeeZNaBS/Pt4nxjTvMsD/fgoZO
         mLyevl53PCt/mjYy0Ym/qRr8EUcfR64Pnbzv9ZumM8pzVvKc0blnzMH/WRxijNYllI4F
         objg==
X-Gm-Message-State: AOJu0YxnCqIc9sJfSibGg77tjpKUCunkBpqiGT2OcvccrQFmGYr/wLAa
	BqFY3mD9nMbb1cSTXn1sQ034Mhke4A7QcNBLMAEVIHOHwLKKwerl/gRWpw==
X-Gm-Gg: ASbGncupKrxW1enipSUHNLLs0kl/fjW4DzGDeO8gElm13zGyxv0nzYbqd/0AzBcBqSw
	UcEpxMFjNBgIXITRPsD8fqI5yPboH1atEapJtIE+E9c1H8B0tevyqMp009RooEl5Mgr2O4ki/sy
	u5/X75agnuYIzJn+FnhZYrU91Sdmn/5tHxuLueP+X51d2n0pBnQjJKoX6vY+jS41Ul7en/4eniA
	CVM1nW7BraBhEV+BILKb3HL9ByaS25ZPcJ7O+Mi3yRhQ12Zo1AWxDijhRCfe+kmGmTcoG/AffEs
	S6y5u4ic8gOgeD04NceJzAjRr8uUGsK3WdKnuid1HSqc
X-Google-Smtp-Source: AGHT+IE3h/Timp0Govs5h8jv7g5PW/qPtietaf4THLtBxhWNkr5tQO9cExgL2PWE1hAYX6b4p84VGw==
X-Received: by 2002:a05:620a:4403:b0:7c5:9a6c:b7d3 with SMTP id af79cd13be357-7cd01157590mr554349485a.37.1746799811008;
        Fri, 09 May 2025 07:10:11 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00fdc779sm143486985a.76.2025.05.09.07.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 07:10:10 -0700 (PDT)
Message-ID: <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
Date: Fri, 9 May 2025 07:10:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: linux-wireless@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com> <aB4HC8Iaa6wR5dj7@archlinux>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <aB4HC8Iaa6wR5dj7@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/9/25 6:45 AM, Jan Hendrik Farr wrote:
> On 09 06:12:23, James Prestwood wrote:
>> One thing you could try easily right off the bat would be to try forcing the
>> default SAE group in IWD's config. I've seen some APs really struggle with
>> group negotiation which is why we added the ability to set this. In your
>> network profile (/var/lib/iwd/ssid.psk) set this:
>>
>>
>> [Settings]
>> UseDefaultEccGroup=true
>>
>> And see if that helps.
> Thanks for the suggestion. It does not appear to change the behavior I'm
> seeing. Also I'm pretty convinced that the AP is not at fault here. It
> is sending the confirm, and the STA fails to ACK that and the confirm
> never shows up in iwd.
>
> Confirmed that the settings is applied using these logs from iwd:
>
> [SAE]: Using SAE H2E
> [SAE]: Using group 19
>
> I assume group 19 is the default group?

Yep that's it. At least we can take that out of the equation.

And yes, in the PCAP I do see the confirm's being sent but no ACK. We'll 
have to wait for an iwlwifi person to chime in. I suspect we'll need 
some iwlwifi debugging enabled to see if the confirm was received at 
some level in the driver and dropped, or never received at all.

Thanks,

James

>
> Best Regards
> Jan

