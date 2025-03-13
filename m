Return-Path: <linux-wireless+bounces-20304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427A9A5F052
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E07172D25
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0500E264FB8;
	Thu, 13 Mar 2025 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="MlHaLa0k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD49264A7B
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860637; cv=none; b=SIx6up6Y6f3PTogh6r3Mjxr6h5TP8Jcw8Y5MhxqcpQpjU8swUDTNsE4OQTcMkay9Xm/jJpL2wm2LeWrB/fWdERDirQ8Pd15FUm+phuGiu3NYyUO/uuwBBMZFLYAraxcDi9GqToh3I4X5OBCMTrZeilTWQ1v+KYH+e8IwkJpwaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860637; c=relaxed/simple;
	bh=hcFCnx3uS3TpvHJPQgKv8tXwbefp9V9rPmL9l2TgJdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBwFt9KsVo/BCg5SWvl8DBXewN9lOHa/f0GQ2X+f9Luo+smmwUs8eGPfFSRdD2HZ/ov2GvxG4Orx0kkj34Rm8G4xmjyhWMwdSigGpq11PHZneOfUtxGywY4V2509gowYP6jhgbuj0zGICG2Jgzz4fW9HCKOOih3ghJdIvrxbG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=MlHaLa0k; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54298ec925bso1203154e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1741860633; x=1742465433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cB67YH6YfdXrNYVTUHeNhr27VpzrcXfl9PICsA70xKI=;
        b=MlHaLa0kHzNRp0VPBw815ow93TkQzmIzwD4BFiA8BFye+9Aj8D1jzzR2bBBgJtYkBx
         gyGpiwDuJEOB5WNOVKaK/iYbzJydtMrNWhKUkV8wExd5Nz5iDWhZMKNKVWDpTgMpkNUM
         5nIS9YKqxqLW21CLHOCkPnJ+pFNVpt+hev1m2LgWCJHZPIAzwMJRMksv5FEDjKSnUq8L
         ylqE5A71OVaxAhNkM1Dl9+MVzCntyOfCKV7mLlLeZg+OH0usAsnD8rG5Js2HyYCvFyZ1
         PE8t9gjnxzHJ6RwycjPFbbJ9PGmrgRCEHhlhxv9qTsrLu5h8JxE0wNcAw/gTNGQ/pzED
         9K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860633; x=1742465433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cB67YH6YfdXrNYVTUHeNhr27VpzrcXfl9PICsA70xKI=;
        b=uZrs2KMiZ5p6s3Uip/t6pgeSU/H1RsB2IdFULEVFMiteb+UbXg7TI64kfHQgrhSccJ
         s0DNGS8fUzqIiC27pplZFhcZQaRGE1DfMaQv4Z52MJyOdB3piFYFjPUFvi0PAXKk26Oq
         fzSHYv+xVhZm1/sw5NQq6jQrFQvRa8h9tx/rlH8N6D6iTQHYjz11TdGfaJ2Z8P0cNwNR
         9CMsDdkwgC+HDqqZIvZKLf0Lo60ToM9BkQjGUAoI0t4h256M84mm1hFhGz6BN3kzP+2H
         i288nVvQHeeklrr9Ky2bUZYvjRz26ZTMRcRyfENDwoEGCp7ICUJggkqoUlY35EeSBAge
         kwDw==
X-Forwarded-Encrypted: i=1; AJvYcCUFq33+GKaso+hozMqwIAtKKIbsGRcxvCHhHp0I8PUtA3OgETwlid6L7iTjefKTUCrEkoWh9c/6C06R1fUiNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4tHc93OxQx7Ptvi7V8RQ8HZapWKb1g3D2M7f6BJ+VGeYbgxMw
	RDQ0F4Hkptj32+ewSW05/ZzB8FKFK6t5s0h/af2pVpmNCbIIWpeohrM++blgVuI=
X-Gm-Gg: ASbGnctsS49+c0oTLIIEktUI9r+6dnxidj/O1P+RcDIHBtjHpm6JmorzG6azSDcIEvT
	ySRyYfOEAtJJZhFQ9t6XjMMyOoYtd9W9AdmOJVNYxhoaX+Gkg6MDSuEofK/DpiOSvcKrE/hK4j5
	mxJAEdn11piDipNuWK1G+S9JG5m94hmxFNXexQCAxqEGmaCCXrBUDtDcIww4qj1xRlJzhw1ppt3
	wREd4wCW1u9NcOGk1Sf+xlHipK9uraWe3qgnpvNFDpQYnaXql1ZdxTtxx0LetG9ebfeVzusG+OI
	Zk0e9Dxh/S4e3gBde359ujuwRhAN/0haTis5NizFMlOSToIChZcDTmRnAsc=
X-Google-Smtp-Source: AGHT+IFG51K1w0HPoy9OtijujySdcKdTqN4yBf/VMBFgBwfH8an14pHCg9O3uX4RyxkS50AvoG6zCw==
X-Received: by 2002:a05:6512:3988:b0:545:2e76:495c with SMTP id 2adb3069b0e04-54990e6729dmr6810635e87.25.1741860632590;
        Thu, 13 Mar 2025 03:10:32 -0700 (PDT)
Received: from [192.168.2.202] ([78.62.132.154])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c0723sm163463e87.70.2025.03.13.03.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:10:31 -0700 (PDT)
Message-ID: <187c8be7-23ef-4bcb-9ac1-cf1882fe3e62@8devices.com>
Date: Thu, 13 Mar 2025 12:10:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: limit WMI_SCAN_CHAN_LIST_CMDID
 argument size
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310-limit-wmi-chanlist-v1-1-8f0fb45459a7@8devices.com>
 <a44f064f-19fd-16ea-222f-058486698951@quicinc.com>
Content-Language: en-US
From: Mantas <mantas@8devices.com>
In-Reply-To: <a44f064f-19fd-16ea-222f-058486698951@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-13 11:45, Vasanthakumar Thiagarajan wrote:
>
>
> On 3/10/2025 6:58 PM, Mantas Pucka wrote:
>> When using BDF with both 5GHz and 6GHz bands enabled on QCN9274, 
>> interface
>> fails to start. It happens because FW fails to process
>> WMI_SCAN_CHAN_LIST_CMDID with argument size >2048, resulting in a 
>> command
>> timeout. The current code allows splitting channel list across 
>> multiple WMI
>> commands but uses WMI max_msg_len (4096) as chunk size, which is 
>> still too
>
> Did you have any private changes to increase the message_len from current
> 2048 ot 4096 bytes? As mentioned in a reply for your other patch, 
> multi-band
> in qcn9274 requires additional changes in driver, only scan mode is 
> supported
> even with those changes.
>
No private changes, using unmodified FW from:

https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/tree/main/QCN9274/hw2.0/1.4.1/WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

max_msg_len comes from FW initialization message:

ath12k_htc_connect_service max_msg_len=0 flags_len=0x0 assigned_eid=0
boot htc service 'Control' ul pipe 0 dl pipe 1 eid 0 ready
ath12k_htc_connect_service max_msg_len=2040 flags_len=0x7f80100 
assigned_eid=1
boot htc service 'HTT Data' ul pipe 4 dl pipe 1 eid 1 ready
ath12k_htc_connect_service max_msg_len=4088 flags_len=0xff80200 
assigned_eid=2
boot htc service 'WMI' ul pipe 3 dl pipe 2 eid 2 ready


Is support for multi-band AP/STA limited by FW? AFAIK it works with 
proprietary driver.


Mantas


