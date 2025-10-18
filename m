Return-Path: <linux-wireless+bounces-28043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6685BED7EB
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Oct 2025 20:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1950E19C1317
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Oct 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804D6268C73;
	Sat, 18 Oct 2025 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WsGk7o34"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B17DA66
	for <linux-wireless@vger.kernel.org>; Sat, 18 Oct 2025 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760813208; cv=none; b=SxBiQCb9v5SAl8wV+XHiWFuOVCt8mRkVtfw7b6HcSbjIKD4R69ojmtwJbDq9QgAaIKBHxLqOVqmXFloEh2YhA66S769dWqdoTHBUwn38eRxOMNRG0y9ekB35hDUF+QQN94SQ3fs02pWVEJF4AyFQVvoXOUVANCw2kTYQuXA8fC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760813208; c=relaxed/simple;
	bh=so63KevQGBFjL9THsiWOunsT5D2s0Nr7Jnz3dwCnGzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=W72xV+6GANTGsTxb3Gs5/3/fAUvgzYeEsAjkN6sPQllYk28oN0wzAC0NUa103UwqAoEIM/nukdONPhXqaw5wbjAksdRx34i0gvKLDej894MRayIVVwTqGYG2YzEBfTyj1vRTuCFxNu51D0t1yDqaBaSTa9y1D+smbwYQoRRSfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WsGk7o34; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-937b40137b4so167308739f.0
        for <linux-wireless@vger.kernel.org>; Sat, 18 Oct 2025 11:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760813206; x=1761418006;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JrkmJIXKp7kFfOk4QDLOiZNg8PV8Dbo0hsP+gg8GAyM=;
        b=rG36aEHNwmHZLNRm6zN78BrzSavRKw6fgyK2Z3cNKtHVTiOsowG43Z63NPZmbm24qg
         eSKa4i/u0w71wNBcK0uV+4JJGChG5VJLXX2YGyotrUL30r14mMM/MxMWNjY7nzFvVuSK
         peOkyGQhjpgzfcFSKkG3DOkc4kJWhzp+3cTTAvl9Mc4EPqU8jYrCCv5Dc0vmXDtuuhGQ
         00JmCQQbh5O7Lg/lC86rp23tufgKtwjmGE1T5Nu9TwtMUEwZvafuu8JqwKGL8rJMFRQK
         l1a+9cCFHiXC5M2rECLpiSt1IWIWOA9LzTs2wIBi2frulkhS71TNS6Eaf4eM3M8GgSBs
         2k9w==
X-Gm-Message-State: AOJu0YzEquahiryOAdmj8GmLL8lAMP8T1XpEh8AC4kSL8wHLKFr8LQpD
	u6r+Tez+ZrD1JNUxDWKoD8+AK1j4/Sl3+RW7eEucTzG6db5p5tvwzcq9VJl2WxfuYnozok89NME
	mvJy2QP6MBm5cDKGHsVXAc7g/bSizAvR/eyd0zOeHMJbasfIEVTLpso/n9NhbzAfiAeHmS+zccy
	XI3s76teSaPAUTaMX+z300pFIweuxYORRZ0GdnF647cidAKWZa6JFdZhDc8vN4DM0pUiumQk2mc
	Ml4LDrQu9a5X5fYapTob8ju8EqekZE=
X-Gm-Gg: ASbGncvhjgTxftm6MZmqsgMiFGpYyqFIpn7Ko/BxlKA+TIAPlq69q5YCwCvrENSLIAl
	OGyssyxSHbYBpQV9RGvrvEB5hz2PABzFZzRIonOCnnYZ7j4lBq9upp7sT64OQTAg/ZDZV1OjBYK
	UCfJa6oGV9vy9dU3ewbxR9pf2Ef1Rb0zex34IB4S5oBwOM6RI1/2lLHBPAfaK+41+y2F7iUg7xE
	XEwA3CmqDgY62n3d9Ig4qaOPUp2sDD/rfWqeHrXNatfqLX8azeTbG3uc4QA1p7DgzP0fqy+j4g2
	aqkECaLdQrpNcIV0Fztp06wI15Sk4zsCAFUWtK7I25lCNXZOOOx00mxDGTWpp7OnFsFtSk3s+FA
	0vEvYxciUyIGGOuD+wMV1yeUSU4XBGCImicgHodG7rbGSPvmPsLGUqRCHEQDZ4iImjfUhhtkKJn
	nkbtE2AASIWMki7OFcYXAIViHZvvAlvN5kXq3F6g==
X-Google-Smtp-Source: AGHT+IG4DFOau67gh3tYUwW++VlkCfMO5M3Wxwdsd0oG1tYrqfUtN0Zm8pIdi29+0pfciYgqHsAdD7hB8jWN
X-Received: by 2002:a05:6e02:18c9:b0:430:c8b3:39d5 with SMTP id e9e14a558f8ab-430c8b34cd6mr103543195ab.0.1760813205726;
        Sat, 18 Oct 2025 11:46:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5a8a9778692sm361638173.35.2025.10.18.11.46.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Oct 2025 11:46:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2909daa65f2so32715155ad.0
        for <linux-wireless@vger.kernel.org>; Sat, 18 Oct 2025 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760813204; x=1761418004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JrkmJIXKp7kFfOk4QDLOiZNg8PV8Dbo0hsP+gg8GAyM=;
        b=WsGk7o34zHhpWGtC235vhk/cmcJB8lV21lQ/J2lbV1W2ucda1VDtSgKE3AEKJIy6gw
         E8vk8R6HIbcub6ziORHvHLrRXQ/s7FLzRVEkQ/5l7D4eMWJPIT/W0sdzu+5LPiHhddIJ
         EFAFSZkxjBbftKohRkV7VKd3ASB4HbSaF1FXk=
X-Received: by 2002:a17:902:f709:b0:266:3f63:3500 with SMTP id d9443c01a7336-29091af39e6mr148833335ad.12.1760813204333;
        Sat, 18 Oct 2025 11:46:44 -0700 (PDT)
X-Received: by 2002:a17:902:f709:b0:266:3f63:3500 with SMTP id d9443c01a7336-29091af39e6mr148833155ad.12.1760813203923;
        Sat, 18 Oct 2025 11:46:43 -0700 (PDT)
Received: from [10.229.40.87] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df9351fsm3201099a91.16.2025.10.18.11.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 11:46:43 -0700 (PDT)
Message-ID: <977b67ef-ef6f-4ae4-99db-eeb921a17e3f@broadcom.com>
Date: Sat, 18 Oct 2025 20:46:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New test release reload driver
To: Berkem Dincman <berkem.dincman@gmail.com>
References: <CAC3nzgJ9uX3rREGQGbLA+oJMzDh0Bc-Fs5sP1sM_4DGScgq=3w@mail.gmail.com>
Content-Language: en-US
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAC3nzgJ9uX3rREGQGbLA+oJMzDh0Bc-Fs5sP1sM_4DGScgq=3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/18/2025 5:38 PM, Berkem Dincman wrote:
> I have PostmarketOS on Pinebook Pro v25.06 it has an 6.6.34 kernel 
> originally I have custom kernels 6.16.7 6.17-rc7 also booting and wifi 
> working 6.18-rc1 sends alot error messages to the screen but works fine 
> if the driver (brcmfmac) is reloaded

Thanks for the feedback. I would be happy to look into the 6.18-rc1 
issue, but you are giving me much to work with. Any kernel logs that 
show the error messages would be a start.

Also please put the mailing lists in Cc: so other people seeing the same 
issue can chime in.

Regards,
Arend

