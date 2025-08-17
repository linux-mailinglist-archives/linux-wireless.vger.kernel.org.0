Return-Path: <linux-wireless+bounces-26414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D59B292B3
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 12:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F9320023F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023F284B26;
	Sun, 17 Aug 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ORJvbRy8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B5283FC3
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755427308; cv=none; b=D6JoakPVOh3AS7Xr9ZgwO2+eCSmzuyWhF7x0arWb84t1onuF50ZMoic1C+9tz45wQfyQCjcHdVI58E1EoTTNrMkrD4X6boatIfOuJlELJFpvhI1SAZ5HviBw+Ag1/yAX9XxeIWa8mi1H4gJJCMl2LjhnhzLHNJGM7ePkdIBjExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755427308; c=relaxed/simple;
	bh=gXY1o7C80AmmuKzfAoUQXvPMTu79pu0D7fBj2TZb3Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P00qaPRRwavaAA//rniIh/wYWRzZKV7wXCkSmJ+mZbIxY4fQdwTAIxZTDMZtPGSbTqgrt1fwTKvii9Pf41uOXrgOQoTn4gbVNpjFtoM+RVfflyqtjtvZfDodcv0lKp36PNMzxCzSjAxD2y9Wj9aD2QI8TMZkK4rftHlYbRylTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ORJvbRy8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e87063d4a9so380171485a.2
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755427306; x=1756032106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HDtdFDWTKTc6YAaWVY19bIzEz5anBGZPAnrOJv9XMOs=;
        b=ORJvbRy8ynvL4uLylD7dQyRAyVpNnobqap7/+IMOLrss+opzMkOb0pnoeqQTJPrVXy
         PUWc5hereKevHnS/XeyIWbJkT1d1HKpNVg2kzOcCeB6Cbon3hj+IhuVjQJuYHQskul3g
         NmJhOO4I7Oh+4aOlvvB3YNvb/fMsQdYfj4D/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755427306; x=1756032106;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDtdFDWTKTc6YAaWVY19bIzEz5anBGZPAnrOJv9XMOs=;
        b=ghgD+QPmJMud6tfb37VJqngPh9DaUxT6LDOY1qS5PR+mAB6JwbJ3YGugzauH96tc6S
         wMNb2k5dFk1Img9yCiM+oWwXPDlJpgYbaBU0aiFWY3071y1hch4J3GCFtDSo6X+GIKQz
         DqZkwE7ild3nz4hmaCE43L2FS9IG8wfxs/aY3I+hFffGi9DEXwPdEBos7bXPoRbDM++L
         QyOKBNni6Xqgh3LknRbeT8BBn0cgriTcoALkbU8SZHVmsS6GEwf2EiUi62CCZLSShiiO
         WG0SvIOfetUsBZQL9jwKm1cMxnpg9spdIXCD7/B0XnCCNk7K93TMcgbd++g43vL++L3E
         gFnw==
X-Gm-Message-State: AOJu0YyJFxjOaCH1wYj7mYss8fqc+/8D6Qc93NSavY4pqHeZljqJJRAt
	Dz/jP/s9MqZKnz8qNLrVlysIpymlkqLUFnxKqkHTN8d2jGI8mvObTDrKXBwcHCNBUg==
X-Gm-Gg: ASbGncuTZUIDiyo8Xtn7BL2PCfhnai18S3xBy2h+HNUvEmwIf6WOfVORJsIqoxu152l
	TvwuRHAZz2OFqHrA6sVhw25saD/mHDobBdYEAniReJ7k3Hb0wi/te+VfUKxLjWg+FcYP6DrGtAl
	PAscj1aKtbQtvRtTHwMCPtI+FN8HCdMYWT4s9OzC83892AVGn3dlKgixrdd3IXm1qBmqDXyD8Mp
	5YTAwe9mmMEijH7e5/2ZX1aWjZZK5Pqw1QXz9p3mP7GVyQ6ChHzVDBNHblgSgFofkhcR+GFI4Rp
	Wzi/n95JMfdMoeYw/rvQ2x/aRJeeTE/kcgTutp6y+EcOQRgHe1cD8vXqTaiPiQ0vGPU0sAYH71B
	dQfVvlPMN4OS0VmbleRVGeSq1+k7ftjQxB3zrQJ7rxGJJYKbK5iOWXDHXMQ40xI0Maw9vQbAzBT
	Ls3FdsMw==
X-Google-Smtp-Source: AGHT+IFjaH7gnxh/cDgpQPF9lgpUavTad2BQOGDJRMXM1uVZVp7OkEvEYwL5k7pXeGSCaty9P2BILg==
X-Received: by 2002:a05:620a:4142:b0:7e8:589e:1722 with SMTP id af79cd13be357-7e87e1296e3mr1128169385a.61.1755427305982;
        Sun, 17 Aug 2025 03:41:45 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c14aesm403307885a.69.2025.08.17.03.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 03:41:45 -0700 (PDT)
Message-ID: <b241fff3-b81e-45a0-ab8e-27fc0a3a75e1@broadcom.com>
Date: Sun, 17 Aug 2025 12:41:39 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wl-next 4/4] wifi: brcmfmac: support AP isolation to
 restrict reachability between stations
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Wright Feng <wright.feng@cypress.com>,
 Chi-hsien Lin <chi-hsien.lin@cypress.com>,
 Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
References: <20250817094103.941090-1-arend.vanspriel@broadcom.com>
 <20250817094103.941090-5-arend.vanspriel@broadcom.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250817094103.941090-5-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/2025 11:41 AM, Arend van Spriel wrote:
> From: Wright Feng <wright.feng@cypress.com>
> 
> hostapd & wpa_supplicant userspace daemons exposes an AP mode specific
> config file parameter "ap_isolate" to the user, which is used to control
> low-level bridging of frames between the stations associated in the BSS.
> 
> In driver, handle this user setting in the newly defined cfg80211_ops
> function brcmf_cfg80211_change_bss() by enabling "ap_isolate" IOVAR in
> the firmware.
> 
> In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
>   0 = allow low-level bridging of frames between associated stations
>   1 = restrict low-level bridging of frames to isolate associated stations
> -1 = do not change existing setting

Hi Johannes,

See that auto-delegation in Patchwork is working, but if you don't mind 
I bounce this one back to you as I feel being a bit too involved in this 
one.

Regards,
Arend

> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> [arend: indicate ap_isolate support in struct wiphy::bss_param_support]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 24 +++++++++++++++++++
>   1 file changed, 24 insertions(+)

