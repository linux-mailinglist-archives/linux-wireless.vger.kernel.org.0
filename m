Return-Path: <linux-wireless+bounces-4765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA287C243
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390F1B20FFF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A61674BE4;
	Thu, 14 Mar 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="DDQ4JToL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242C745FD
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438746; cv=none; b=niaG6MYSWLcX0sQ5P1WOYjyMtjQ0lvOFFJb9KxSS6QNEkZALywd1E/U84XE1Pb0oMuBYqkzIrLnCEKoAG+2k3RKSbQ7sevTQWzYzqYDE7iV7ABeQYEv1k8IXOP7wQEHDo/aGGp42m/YpTVSZZNM0sNfuRSoPQw9tXBIeIYdXFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438746; c=relaxed/simple;
	bh=VsxCniOj1rJue4dxpvsXa2nOXt3zHVY6JDDiyhzmCic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vk1tS50albwsShugYNo1uXT7EfLG9LSsIdKFerEd+tWJnTy/6+7v0/rQ4FzeQEnkuYWsz1Ydoi9ErUf7SmPeiqxjFPZX2XUidhukJIhhNAem8iYVesq9Tc3TzRQMDTk5mdCrGI5yg8uX/YC+Mch5AWOUVZuyVed1q0OSccRIaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=DDQ4JToL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e76d653b5so1110840f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1710438742; x=1711043542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydOw5fr/AFZUtVGxJCncGRnX7kcC+G1b69vGaI6Rc7o=;
        b=DDQ4JToLSnHcCKUF0sKPKpxklN3O5QsxPsXKFWyqVPnrd61EwFVPHWous9ap4y/2iB
         p+IUnH4sg69qzTxNRwlwHgq2HrCi1PfabOwF5hDiUd0HK4fz1gUTkGjiSHyPnLZaev1P
         ze/pR5C/7uVSDj8O6zfpaDq4G+PwlqMXUv5B8eoeXaP3rd3bRTfiJ2s1oi6Syxixhapg
         Bd9Qf+mHB1mbP2RxgxQrtMtjbY/HDwnG7455sZWDPo0uJRU78jelNCCfGeumB3QH1BUl
         9pGvyhis6bL3a7QhYO1Auh18I/tQ1r/KE0AQgLQd2eMIUMaY8pDLxhn6e4DC2zN1tjQ4
         5ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438742; x=1711043542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydOw5fr/AFZUtVGxJCncGRnX7kcC+G1b69vGaI6Rc7o=;
        b=v69Y2P/lyCG0ReY0cLs4+ICgfBi5AVxAkKBowtW/azeyWbFtzK6wk1LMwsqjyW8smW
         dv+QE1TlOZ9E3O74NXGln7i2JXjFk+DciS2qxt9ueD7nMG0KC8x1tr285QbRvCU1gDhm
         JF5bZ63jOgqVSveVIhHWcW1QQueh0IcDVVbCXM3UYoklpcFUuhc5THOXeWlORdmgJynf
         T+tglQA9c0IcWT8GbeALPGrsrL0y2AsVMbLKvlg9zoEHQmKMTyhXBRtSB8zEpweT3qpl
         MbYlAalmq23QQh8bYnnuWzTTmQdlQ3wSrhvd2YZBJAdbmsA0bzeTOwhKyFCAATsdeJVJ
         /wPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Iz9ZRa/o4UrJxy/7tAVXruxKRZH5jyctB2tfXmzlz+sQ+W2KkDcmQ/E+PpwFmaQoLOYNIWsIea+qZGbdV2stwMuIBH1Y/A0ch/xlgbw=
X-Gm-Message-State: AOJu0Yz7h4riaB0lL5j62jpwGb2nr7r16yktPuMvuE61EqTkWSQ63miK
	P87swttR/CCmt22yaphsDMyvaSIy0A2OJ1FdDBnxmti7Ikht9i637FScEY4Ojqg=
X-Google-Smtp-Source: AGHT+IEOyhXOB1aioQMfsxpLm0S1khFSThiLIjiZsbb+aHejkjcjgWgHwFtSf1gI/HfTM8GLlmW6jA==
X-Received: by 2002:adf:e3c4:0:b0:33e:7650:24c8 with SMTP id k4-20020adfe3c4000000b0033e765024c8mr2049164wrm.12.1710438742240;
        Thu, 14 Mar 2024 10:52:22 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b0033e2777f313sm1270176wrb.72.2024.03.14.10.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:52:21 -0700 (PDT)
Message-ID: <150c9705-e5ed-4d4a-b935-c0101a27795e@freebox.fr>
Date: Thu, 14 Mar 2024 18:52:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <20240229-ageless-primal-7a0544420949@spud>
 <c48ead11-0e2a-4066-b324-84f802215c9a@quicinc.com>
 <2f588948-0261-4985-91e8-d5060e673cd9@freebox.fr>
 <15db6593-c474-43a5-ad20-b0e108137713@quicinc.com>
 <cbedb60c-c849-4b7e-a00e-c75ec8429adb@quicinc.com>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <cbedb60c-c849-4b7e-a00e-c75ec8429adb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 15:33, Jeff Johnson wrote:

> On 3/7/2024 8:46 AM, Jeff Johnson wrote:
>
>> On 3/7/2024 7:29 AM, Marc Gonzalez wrote:
>>
>>> Have you heard back from the dev team?
>>>
>>> Do they confirm that an issue involving missing MSA_READY notifications
>>> was ever noticed?
>>>
>>> What devices were affected? (All msm8998? A subset of msm8998?)
>>>
>>> Was the issue eventually fixed?
>>> (Probably fixed, otherwise newer devices would be affected)
>>
>> The feedback I received was "it might be ok to change all ath10k qmi to
>> skip waiting for msa_ready", and it was pointed out that ath11k (and
>> ath12k) do not wait for it.
>>
>> However with so many deployed devices, "might be ok" isn't a strong
>> argument for changing the default behavior.
>>
>> So my preference would be to use the firmware capability in the board
>> file that Kalle has recommended.
> 
> Marc,
> I finally have an engineer who wants to research this further.
> Can you provide the kernel log that shows the firmware version being used?

Hello Jeff,

Is this the line you're after:

[   32.367011] ath10k_snoc 18800000.wifi: qmi fw_version 0x100204b2 fw_build_timestamp 2019-09-04 03:01 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.1.0-01202-QCAHLSWMTPLZ-1.221523.2

Hopefully, my Debian setup will soon be 100% functional
so I can easily tweak the kernel, and add more logs.


Bonus question:
Is it legal for my company to publish our versions of qcom firmwares on linux-firmware?
(Perhaps a generic set of FWs would work; but AFAIU, there is some kind
of signature verification at some point)


Regards


