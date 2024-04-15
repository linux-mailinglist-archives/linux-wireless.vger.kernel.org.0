Return-Path: <linux-wireless+bounces-6295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A368A468B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 03:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2C81F21D5B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 01:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D700BE6C;
	Mon, 15 Apr 2024 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHTzfahm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559BBE58
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713144209; cv=none; b=XlvcOmz5Kfzfz27MzqmdtWm1TRLZDVE1s/LFLg97AOu+h0Da1C6pC0l9eLD0SY7OCVCmZZfrmzhQ/GhcedYxufp79rq5T/bF2LrqS54MuLdle7gWPuFBMs9lS9JdL5ZET+7MlvkpHqXct5hIzDin+At9bpp67ZjVW/sI5k/wMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713144209; c=relaxed/simple;
	bh=gzTr0viS67fiwCArwpZDAU6hJ96BXLt45Z5bvRVyaow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2t4xx4XS/FGPvRh/leecRJo7eiKeAna97YxA5Q3mhEEF16sB7mEPFSOcqUcIaYX9cdm3AOCSg+iXIFrfNiIJf3xwTa5EOTQY2JQkVbQk7rBR3nYNqEZuhoXpaTVjNDfCrkOslfyQ/oyGl8Oa7hyONF+RspYU84qIUTrZ2G6JzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHTzfahm; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5aa2dcd4454so1945769eaf.2
        for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 18:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713144206; x=1713749006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yUYjY+H+ebNB4HkEUdMBYlZN9uRDGs8w/DqirPju+wA=;
        b=KHTzfahmf1KHddWM+Utcwi4DiZ+hfFSmIlB7wvFdXBTtggu1Cqxh7R4XDG3KzT7fEg
         KLfl8LqGEk9ZtHnCvnumZDTbAWtHw04BqnvtHBPu6TUNPx7x+AMtnl137GweCrr/Js+g
         f1rwg8ChZD/8EVMhy9iKyXSt8fS/NAreAn6zKE0gh+ZFI9bWG5xvmVbqaLUEFygkbrms
         6Loq68cw+WBSja21ZJrex2xeMjTTGdmdi5gkG58VCHNNj72DspjGpfVxb/k1Qk846jDI
         IGBjtURraIqRIfybMow3CQl9p+xryGD7QS05x32OH4FU1xFY+ce2abKF/MAXL/vsQBwZ
         JoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713144206; x=1713749006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUYjY+H+ebNB4HkEUdMBYlZN9uRDGs8w/DqirPju+wA=;
        b=W+KMY17oNBJ8bhhW6jwbe5pv6wjIFwU6zePVXDHJ3NqHv2+ooqZ/tr85WZnQGqskkz
         pzcF9Q+IRpGrtvOuqRF5gJnE0l+fDCZOLIYqovOXnPv/b+5OFYmEhhG44HIaaIxgww5p
         Ed1wdrGk4nzMwKUZF9NUIFZisUloX6DGQHFvIISDVDVkf4yJ5PZ84m+/QSJTu2wwoBM/
         3+cHFOTvFNRpIhPBvxBVdPWyYpxu+JKXZP4Pyep4M6p/mlkkzpynL2WpNlG61j2EEJ4L
         q4IOXvkyxhTdiPoySxW9miB927vtqAGsGGbSWfWF2blxtCcWod5ZnlMa6oYgS3VmJRKi
         FWSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv/tvMA+lp3kki1sQCAh4JR49Ku5lOW/yTxgAc34PetQwCSKV+Yi3mCCiQ870UOmSsslUxOMGG4NcTl1UXAls+hku/huyeOtkA7O8cnvw=
X-Gm-Message-State: AOJu0YyranC2tbPzozxKGpQloaJ8hbMNSORdGU+Zdpr6x+kgSgIz4IxU
	Bpv10Bnnhb1UeGFKFmQ2gosNf/B0wRdZIETFhgfE/VhgYE8Qhgb4
X-Google-Smtp-Source: AGHT+IFnJ+oGcpbw0lqtVOKUJe9pEPJw6OwFJ/56jHigG1ax5Q6kVZHXS6YWeHe8s9IWcQ7yWwun2A==
X-Received: by 2002:a4a:4e81:0:b0:5ac:9f86:cc0d with SMTP id r123-20020a4a4e81000000b005ac9f86cc0dmr1988052ooa.6.1713144206621;
        Sun, 14 Apr 2024 18:23:26 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id v26-20020a9d5a1a000000b006eb80dd6c97sm169423oth.68.2024.04.14.18.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 18:23:26 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4d36d201-bb39-469c-9861-5e08c9003c73@lwfinger.net>
Date: Sun, 14 Apr 2024 20:23:22 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART
 Bluetooth
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc: Larry Finger <Larry.Finger@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <4umro86wvv84.MjDfYvt4P5uZryt8boBK8Q2@1EHFQ.trk.elasticemail.com>
 <5af71338f3904aac9d2c237637c851e7@realtek.com>
 <287e9d4e-316a-4579-961e-58e75abea534@lwfinger.net>
 <87o7agjs00.fsf@kernel.org>
 <46745fe7-a43d-4f7c-b247-f0fde01ee63e@lwfinger.net>
 <d3141ad7a7a9455f8a6dbcdd3f46eecf@realtek.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <d3141ad7a7a9455f8a6dbcdd3f46eecf@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/24 7:45 PM, Ping-Ke Shih wrote:
> Larry Finger <larry.finger@gmail.com> wrote:
>>
>> I originally wondered if there was a power problem when both were simultaneously
>> started, but I see that is not the case. To reiterate, the BT must start first
>> and complete UART initialization before the wifi starts initializing. It seems
>> to me that a suitable msleep() at the start of the SDIO probe routine seems to
>> be a viable workaround even though it is not aesthetically pleasing. A sleep of
>> 150 ms is too short, but 500 seems to work reliably.
> 
> Suggest to apply this workaround but only if UART-BT + SDIO-WiFi, because SDIO
> experts didn't remember they have met this problem. They need real hardware to
> measure signals to know what it is wrong, but unfortunately they don't have
> bandwidth to process this because of limitation of human resources. Sorry
> for that.

The OP at GitHub reported today that there was a DTB error for that chip [1]. I 
am going to drop the patch for the stable kernel, but I will still apply it to 
my rtw88 repo at GitHub.com. That way, users with older kernels will get the 
benefit of the msleep() even though their DTB may not be fixed.

Thanks to you and the SDIO team for your efforts toward a problem that turned 
out to be in the kernel. Sorry for some noise.

Larry


[1] 
https://github.com/ROCKNIX/distribution/pull/63/files#diff-e2de6222b1794f89311bdc1597c1597c76f34503c575ea3f7e7ec9c5376218d6


