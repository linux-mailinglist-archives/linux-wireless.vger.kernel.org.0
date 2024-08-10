Return-Path: <linux-wireless+bounces-11259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E094DD08
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 15:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1599281FB4
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBAF1586C0;
	Sat, 10 Aug 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LKof9vwt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822915855B
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723295631; cv=none; b=h8JJywWmu6MAb3h4TqL90N9MetpJuDl0m3Xw2famqbVvv2/+JpCrEYskc8N/ALjs6C4gQZ+RwSnNY3YcVKn3el8aR9Xb5j+Tvv+LnQW3vbdeGoHGMg7GIIaPSPiGKdiVamL50TEUM+7IMu4Wy18YjCT9+N5iAQIj2OBJpAqyaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723295631; c=relaxed/simple;
	bh=kiSPUFlRHyyy7Pl9woMUpwrDdOmmRjG1IM/ANz90XlU=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RaXJjh+ikJU6AspRg/cI6sihJBY1ERRvpbu+p3DwdyxqOe6FMOxTiLMl710KpYg8/gOscOjY5hVDKqz5QrKmWMG7eF+jKB0o1evlhAXfA0mv5fPEyEhIqENiSFT8ERl+5Znwk5/TbK9VfHWbUjZRTYdAxyfsUIO9ofM550UZWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LKof9vwt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so6045961e87.0
        for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723295627; x=1723900427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1g8mWRN55v1y+2ZTRRFkIB6j/56lp7w6Y1xBZqZlMw=;
        b=LKof9vwtx3vcyfwjpsovmMqkwBlEHAtWhYO+LzvoXR4O4UY8knxTnCPHTXyAU3ItYF
         8/IWjdAjEZGAE//SKMOObu9lWjnvvnEzOibIY94OJKZbjX7q4q/byn0i7SFAdk60DR9A
         vpB+U06Qy3bGy77lxA0wvy/0ekJ79vnnoD1/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723295627; x=1723900427;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1g8mWRN55v1y+2ZTRRFkIB6j/56lp7w6Y1xBZqZlMw=;
        b=QAdeJRObQbM3Y0jPTQeAk0O+1+RzlZyjfpAw0+UW1vJ3xcTAFezoLEYulDO0VyBPf5
         ofj6Gik7cAYs1i8x3Bd/mB6Ukj3i590ERekkBXr7Vb8oAYd4xGKgecb0h/taPKHWrVvQ
         scI5/NON2cK/0hUsUYxs2S3jjrWey1FbGwUAZSw0L2Zqb/6fU1faaG2PPQmV5rz0zFkG
         oGe+9Hwi47Tyr1XyPjZp2wADOhCUDjrK1iOk8+2pTsusvEMnp0voBmJFQfIOOCFYXHFi
         OgDyYup7YO+RO6eCd9N35U/Zt+CJbi2Io1LdB2dq5ZSStfWHUrGBWFyabutNZLAGCnLR
         8NPw==
X-Forwarded-Encrypted: i=1; AJvYcCXNpG8pR4YPhDzhkmeibDVbQ32z6avS8PK5ABBPoN14tQWLlLaAKC2bLCuse4A5+880odk2HYfJMLJQWehKbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmVBxTnSFaRm9CMlCSnclbqO1dnExGe4PhPUJh9gJO9YEp54y
	g7x9ILzKkQYbdsgKR1gCpcMa9WMUueEpFvWJpUK8g6c+tzrhVe2NhWsnL7Nefg==
X-Google-Smtp-Source: AGHT+IGHgjNrhPxo+vNYkPCxAbCyDfkta6U6m41msNvVhzNCcBBGost5c6nu/63jEyHeumx3S5g8yw==
X-Received: by 2002:a05:6512:3512:b0:531:8f2f:8ae7 with SMTP id 2adb3069b0e04-5318f2f8fb4mr2280320e87.25.1723295627000;
        Sat, 10 Aug 2024 06:13:47 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb212fcdsm69069166b.170.2024.08.10.06.13.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2024 06:13:46 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Janne Grunau <j@jannau.net>, Jouni Malinen <j@w1.fi>
CC: <hostap@lists.infradead.org>, Vinayak Yadawad <vinayak.yadawad@broadcom.com>, Aditya Garg <gargaditya08@live.com>, Hector Martin <marcan@marcan.st>, <linux-wireless@vger.kernel.org>, <asahi@lists.linux.dev>
Date: Sat, 10 Aug 2024 15:13:46 +0200
Message-ID: <1913c6c7310.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <81485c0a-dbf0-4e07-abb9-22fb8d671839@app.fastmail.com>
References: <92fe4dd4-21a4-4559-8441-32ef86672de6@app.fastmail.com>
 <ZrclLHJ63RxnG/B3@w1.fi>
 <d82c88a2-77f7-4308-97fa-c5b4446e2cf5@app.fastmail.com>
 <1913be30f30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <81485c0a-dbf0-4e07-abb9-22fb8d671839@app.fastmail.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: wpa_supplicant 2.11 breaks WPA2-PSK / WPA3-SAE authentication on Linux' brcmfmac
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 10, 2024 2:02:43 PM "Janne Grunau" <j@jannau.net> wrote:

> Hej,
>
> On Sat, Aug 10, 2024, at 12:43, Arend Van Spriel wrote:
>> On August 10, 2024 11:17:56 AM "Janne Grunau" <j@jannau.net> wrote:
>>> On Sat, Aug 10, 2024, at 10:30, Jouni Malinen wrote:
>>>> On Sun, Aug 04, 2024 at 02:23:56PM +0200, Janne Grunau wrote:
>>>
>>>>> A revert looks to me like a possible/proper fix. I can send that
>>>>> later if no alternative materializes.
>>>>
>>>> I'm inclined to revert this if it is indeed the case that
>>>> NL80211_CMD_PORT_AUTHORIZED is not delivered reliably by the
>>>> upstream driver and this commit was tested only with some non-
>>>> upstream versions.
>>>
>>> I intend extend the upstream kernel driver to post
>>> NL80211_CMD_PORT_AUTHORIZED after successful connection with
>>> authentication offload. I expect that the change will be accepted for
>>> the stable kernel. Infineon/Cypress have non-upstream patches for the
>>> brcmfmac driver which implement it already.
>>
>> Do you have a reference to see what they have done?
>
> I was misremembering their implementation. They removed
> NL80211_CMD_PORT_AUTHORIZED and instead added "authorized" fields to
> struct cfg80211_connect_resp_params and struct cfg80211_roam_info. Those
> fields are then used to set NL80211_ATTR_PORT_AUTHORIZED. This is
> annotated as reserved and as far as I can see unused in upstream Linux
> and hostap. That means the patched Infineon/Cypress driver is broken as
> well. Probably not relevant since they patch hostap as well.
>
> Looking at the RTM/v6.1.19-hedorah branch of
> https://github.com/Infineon/ifx-wireless-drivers (214 mostly brcmfmac
> commits on top of Linux v6.1.19).
> 1. "nl80211: add authorized flag to CONNECT event"
>   https://github.com/Infineon/ifx-wireless-drivers/commit/f7fb21f980b743e319cee406719e18ca0fd6784e
> 2. "brcmfmac: set authorized flag in CONNECT event for PMK caching"
>   https://github.com/Infineon/ifx-wireless-drivers/commit/a665defa7e67b1d5f5735a55643014374e5f53d0
>
> For roaming they do same and revert the NL80211_CMD_PORT_AUTHORIZED
> 1. "nl80211: add authorized flag back to ROAM event"
>   https://github.com/Infineon/ifx-wireless-drivers/commit/d2262fb0a08124153c9549d2cd0e6f9c04d946e9
> 2. "brcmfmac: set authorized flag in ROAM event for offload FT roaming"
>   https://github.com/Infineon/ifx-wireless-drivers/commit/3099d355af9914753927f913b14f62318a33ab55
>
>>> A revert in wpa_supplicant might be still appropriate until exteded
>>> kernel drivers are deployed. The wpa_supplicant Fedora package
>>> carries the revert as patch:
>>> https://src.fedoraproject.org/rpms/wpa_supplicant/c/c2eac195adadd2c48b04f8752cc46b12a351e69
>>
>> Agree that revert makes most sense here. So what upstream drivers use
>> WPA offload. Only brcmsmac and QCA drivers?
>
> It might be only brcmfmac, at least that's the only driver match for
> NL80211_EXT_FEATURE_SAE_OFFLOAD / NL80211_EXT_FEATURE_SAE_OFFLOAD_AP

But the issue was not just with SAE or was it. I thought I saw someone 
mentioning WPA2-PSK was not working with wpa_sup 2.11 and assumed for the 
same reason. So for the NL80211_EXT_FEATURE_4WAY_HANDSHAKE_* flavors.

Regards,
Arend



