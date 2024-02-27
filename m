Return-Path: <linux-wireless+bounces-4105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58102869A0B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C5B28F11C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1745A7BB;
	Tue, 27 Feb 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVq7gIRA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729731A66;
	Tue, 27 Feb 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046846; cv=none; b=hTRuTEmwhcJQbvxBzpEHpw3fkVAhXqet8ZaypCnKFwdUXAP9NHVznjBODkMAodzPnEhIaJK26rQUGya8tfcIfTkbnDVhHw+6+z1fpwjQgleWx+2fEgty1kSpNXWIGUtY28oMpWE7mlNdFuzShBOmFT7rPF5jYa0OQjAQiNJCxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046846; c=relaxed/simple;
	bh=iTQQO8tqmbTNpVUWbVS75eknSf+49aGAXniVQXxoOfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdtar1y6NwpTfQY54YaWldFK5aCaTafVDa8US7d9G+xMY8hCbeffT1uHNGEilYHq9h6qryp5HobSIKFKnb/TgcMZbzWn90asDM1wv2bXcx8U3dEdDaY6uE1fl3IvwQ5/UMJAdru/p3YcQNnfZiQ4N6zV15GzAmIO5MZ37SXjubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVq7gIRA; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1a3384741so1417565b6e.0;
        Tue, 27 Feb 2024 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046843; x=1709651643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WVNGSy7giUkojaHCvX9mWCH3TabrUKX3n7apLQkiKPc=;
        b=EVq7gIRA6fVFUhlJzq1jvDNSO2ByvrhtwKWWbux/jmc7CQpcbS1yi3NvqIQnus9NKy
         J8JGVPkxxkOI1EjdEqVgmPVhnpM9OYaOgg+PDa4TGMDl43p+LQIABPA+lH/meJtaUH7p
         m3pjb4F+BfVbxsawguql5BUt1ZDwl7qCEpK8DpSiOSgCw5a6FMnGaYH5e6FLsSOcYxyW
         uhwk2c88leknu5UHiD6e5IWqjbV7cNSXP+SN1ARVg2IrGSVdWNjCZmrAAtXtCKzAwRj5
         /qMqu+MMovE+KKwDvWVFfieUEyuQrfC4QZkCc8PJMxgnChxuuwokBq4sr+P62mnzS8J6
         qpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046843; x=1709651643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVNGSy7giUkojaHCvX9mWCH3TabrUKX3n7apLQkiKPc=;
        b=eWUapkIOreqm4XMxfl9mAHjNuxJzEUJYP3uMsKCBr68rkjOgRWTgzSpkmzd+eAvSB6
         c3xOm0rVpHdImy1FI43RNRDpgIYt20pqbjSU7ZYLdOVWHNBpm9O3imFAq7JB4GRXf4G0
         kvAhIdHe+Z45mAM8I0dE0h2Z3tL6Ro2PILEs0+BxiCLbniJl8ulL+IiVd230fK34Ozo+
         YjJQ5utK14s1yQ6uIWvW5/jlssAHF5x83smPIETcPGeEtu/HJ28phMSlkFPUkzxY3OTR
         PJi7vbfhw3j4UbNvIPfmJgd9UjjEX7BX40GoTEKhP7qKqoZmyR9JAM5q11GZV+PkovhE
         Cegw==
X-Forwarded-Encrypted: i=1; AJvYcCVjjlzOdLMDqnRjQjpzFYk634iHK9pCVML1CLi/QNWujxydCO38plUXf2cv2SsrF27+/T2TYfqKpJjUAYiq7bJNN55aIEw528OyjV2/K8bcHMXI0TDsCGxiUjzTyu2ROEIfDGZSBL4=
X-Gm-Message-State: AOJu0YzOkFejjeMLSxifkkq/wnbLWkpJWdp1CroVrKh/DMGP0xgJK3UU
	GMBlevU6KOunDz1oQ+uMfpSGnzb0/NKeKO4HvGwipUK7+Wziu00wF5Q1Brbk
X-Google-Smtp-Source: AGHT+IHsvtX/7ig1HTlh3M8HSFy9C/Dk8wBxHG4a9n+ueNebt/eho2tnqIbyDs1CBwLVVwze6+czww==
X-Received: by 2002:a05:6808:2110:b0:3c1:7c2c:a1c1 with SMTP id r16-20020a056808211000b003c17c2ca1c1mr2830554oiw.0.1709046843145;
        Tue, 27 Feb 2024 07:14:03 -0800 (PST)
Received: from [192.168.0.188] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l21-20020a056808021500b003c167e590fasm1465792oie.11.2024.02.27.07.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:14:02 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b310bbb2-5a8a-4a6a-86ed-79185f6372d5@lwfinger.net>
Date: Tue, 27 Feb 2024 09:13:59 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHi V2] wifi: rtw88: Add missing VID/PIDs doe 8811CU and
 8821CU
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
Cc: Larry Finger <Larry.Finger@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Nick Morrow <morrownr@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <4ume7mjw63u7.XlMUvUuacW2ErhOCdqlLkw2@1EHFQ.trk.elasticemail.com>
 <aab5bb779e1f470daeb0a4258e4bb764@realtek.com> <87h6hu9zt3.fsf@kernel.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87h6hu9zt3.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 00:38, Kalle Valo wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
>> Hi Larry,
>>
>>> -----Original Message-----
>>> From: Larry Finger <Larry.Finger@gmail.com>
>>> Sent: Tuesday, February 27, 2024 10:35 AM
>>> To: Kalle Valo <kvalo@kernel.org>
>>> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org; Nick Morrow
>>> <morrownr@gmail.com>; Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih <pkshih@realtek.com>;
>>> stable@vger.kernel.org
>>> Subject: [PATCHi V2] wifi: rtw88: Add missing VID/PIDs doe 8811CU and 8821CU
>>
>> Not sure if "doe" is typo?
> 
> I think it means "for" but Larry's finger was one key off to the left :) I can fix that.
> 
>>> From: Nick Morrow <morrownr@gmail.com>
>>>
>>> Purpose: Add VID/PIDs that are known to be missing for this driver.
>>> - removed  /* 8811CU */ and /* 8821CU */ as they are redundant
>>> since the file is specific to those chips.
>>> - removed /* TOTOLINK A650UA v3 */ as the manufacturer. It has a REALTEK
>>> VID so it may not be specific to this adapter.
>>>
>>> Source is
>>> https://1EHFQ.trk.elasticemail.com/tracking/click?d=I82H0YR_W_h175Lb3Nkb0D8i6IqvuhESe0WLnY6P7IVwR1UKvB
>>> 0SPxd1Olp3PNJEJTqsu4kyqBXayE0BVd_k7uLFvlTe65Syx2uqLUB-UQSfsKKLkuyE-frMZXSCL7q824UG3Oer614GGEeEz-DNEWHh
>>> 43p_e8oz7OouS6gRBEng0
>>> Verified and tested.
>>>
>>> Signed-off-by: Nick Morrow <morrownr@gmail.com>
>>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>>>
>>
>> Did you keep a blank line intentionally?
> 
> I can fix this as well. I'll also move 'cc: stable' to the beginning of
> tags.
> 
Kalle,

Thanks for correcting my mistakes.

Larry


