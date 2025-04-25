Return-Path: <linux-wireless+bounces-22048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8C0A9C1F5
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E45A170573
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1F1F3FEC;
	Fri, 25 Apr 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e2YHaZE0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4B1EB182
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571000; cv=none; b=S0lmFyuiKKH+2lWAB+jYDl6nm/yUwoR9KWm3sNFm96yTum2NXo0EYvl+ie31jwejpt67oOg/eTdtpkCfrGEHOONRQupH1c1LCEyvJO0Tw/LomJkEt9RwxHxrQXCNNT5AY4RIPtX2sihOa/ilKRY4m7bNOcMPBVAFapBM+/Rdu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571000; c=relaxed/simple;
	bh=Zi9rEal6MmrgdyI7YRWQR7y0WuoH9LbL32cp2+ReMbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjbkX4h3Hg0aecjtUMZxI72Nd8KnQASENA3IBXvr6fy7vF4vrbHp2TGipoZNWTqqk+xIQNiARJpIbG9bXax18g52HREPEvtIIllG9903W/lnf0NFIy5Ohtx7GKj57Kku6HAaBVKUezlo7IE6pZIubbStKWuGXcow1lQEt3b9A0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e2YHaZE0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2241053582dso30986035ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745570998; x=1746175798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni2loAD/cI1i/mHG1bkeUTWj7t1Q4ciH3PocEuXSdOE=;
        b=e2YHaZE0CdsG7vW3zFSR7incqwBxu7XWl4l8eVDqwJaNiulE4uFfPT9rRxPJH17oBg
         ZaSYvMpV3oxlDO+s+yY4SvP2qcZ6f8bzLzxMWuQ0s3gHr5spfP7mPD/Ay06rMajwrh2O
         84Wd+5S6gGTCIVcwJE3ovAf1xf2Jf2DPt8e3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745570998; x=1746175798;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ni2loAD/cI1i/mHG1bkeUTWj7t1Q4ciH3PocEuXSdOE=;
        b=CLy8FVBuwe3CCZlyp6sY4/KV0muHLlVisWTqqHayMkanSZlLdjr3T9ZavYNp3zEkET
         w0FfQRNedGjZBxg+VLOac7IrlViJ9NXMBlw70i5W0L8RW/VHQPQe93e4jzux60MkS4Bx
         U3Lhc8N0MsaEDkiyvro1yu0FlIAY9D0RjrnARSKedKjMU6k/QJOjaq2u5ejFTb+FsNk5
         0d9cM5WW5SWcPgUU1nnCrQ5JXqWJXDABaazlB7NkgXB/f0iM+Cr+85j19AWSF2HRVckX
         GHvrdVdSxr4r2UeMZLua2XBaR8t8OOrr4VH3eesDzocJDNGn8RxZIlRMcY62YyM15nLj
         N2TA==
X-Gm-Message-State: AOJu0YzpMz0ZGEnePP47dGRUTZxnFBWMvpmwOzIUUSJyKlEcEqhu8KwA
	95XkpyzC6kPamtwUnEXTNy1tOxnra6/16djd4lCn7Lb/A9anlR0CrU2iVP+xkw==
X-Gm-Gg: ASbGncuLLnE2Q935fycaxApQigvKikzp40JssbwuisU6Ed6zw2hMaXXLZcNlwdZ3hrG
	yOEFQviJucZKzoE+QbvUP0sTqBMrSJ/I1FZtqiCIBHhhub1za/LnQRk/BogeaQAMR3RsjbwoOP4
	MnAl0HwAcCtPs5Aa5VoqRTQSWjQ7tVBoBecZTyDoyklNWHSvSC2Pa8E8tfMHtR0j1T5NsQz2qlm
	Ya+sKssmUdfA+hh+dN1ILSXZR31v0NtqVkX8arSSPgmko+E3gia+Kc6phdQ+JlIChFxBI//AbK7
	gLqofuqbv+E4JyfAgc5RKCqpy0WUsmA4/IJg0pI1z6EwP81IEUWlRipTJwLUgnnK+ZDskaScEKs
	gwoaOJY4J0cvZRmM6
X-Google-Smtp-Source: AGHT+IGikx37FNrAPUxxSSRY3fGWmYut7KcfiQ8EQClHIR8TSqbmzgDABB0bnjPaNTa5yPaWQnhDBg==
X-Received: by 2002:a17:902:cf0a:b0:224:1001:677c with SMTP id d9443c01a7336-22dbf4deec8mr21903005ad.9.1745570998507;
        Fri, 25 Apr 2025 01:49:58 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f85972d7sm2416017a12.38.2025.04.25.01.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:49:58 -0700 (PDT)
Message-ID: <95cbaef6-761b-4ecb-a722-a546bb034939@broadcom.com>
Date: Fri, 25 Apr 2025 10:49:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 4/4] wifi: brcmfmac: Fix structure size for
 WPA3 external SAE
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Ting-Ying Li <tingying.li@cypress.com>,
 Ting-Ying Li <tingying.li@infineon.com>, James Prestwood <prestwoj@gmail.com>
References: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
 <20250424194239.2825830-5-arend.vanspriel@broadcom.com>
 <850b42ab-a637-4dd9-af18-e12523983ded@broadcom.com>
 <44916ff608ee53238d79e57ee31fcbf86dfb672d.camel@sipsolutions.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <44916ff608ee53238d79e57ee31fcbf86dfb672d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/2025 10:40 AM, Johannes Berg wrote:
> On Fri, 2025-04-25 at 09:57 +0200, Arend van Spriel wrote:
>> On 4/24/2025 9:42 PM, Arend van Spriel wrote:
>>> From: Ting-Ying Li <tingying.li@cypress.com>
>>>
>>> Add pmkid parameter in "brcmf_auth_req_status_le" structure to
>>> align the buffer size defined in firmware "wl_auth_req_status"
>>> structure.
>>>
>>> Signed-off-by: Ting-Ying Li <tingying.li@infineon.com>
>>
>> Hi Johannes,
>>
>> checkpatch issued a warning about From: and SoB: difference, but how to
>> resolve it. Both emails are stale so it does not matter, but I lean
>> towards using the infineon email address as that is likely the most
>> recent identity used given the company history. Please advice.
> 
> I think you should probably keep whatever they used when they posted it.

Crap. Just sent v2 executing my plan as stated above. v3 or is the 
mai..eh..custodian willing to fix it up?

Gr. AvS

