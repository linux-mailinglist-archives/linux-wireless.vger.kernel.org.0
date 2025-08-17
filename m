Return-Path: <linux-wireless+bounces-26415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA5B292C6
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 12:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D180E202919
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CA92877EF;
	Sun, 17 Aug 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a/UvBAMQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9672877DF
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755428188; cv=none; b=YCIAHkvDzg91/ScqqaZd2RkUx7dvtBmZMjs8vwMrMSgPyvWJj9bnq9hvMAQn1Y3tMIKc/0+udaJyaFJ0CuqYOoTZ+lst2zTzeybwfwO/oSmpIHiC+qW4U4iG012pJUGcaDBEcUzoaHdqPjxa2jtmOaZY69w4pM4Xcao3y3KEmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755428188; c=relaxed/simple;
	bh=qOuSNQcHK6ukKtHKC1lmaCUSL3Dqedq0J93il9s0RNw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LOUw5hDgUWDuICv51sh5Wwlr6dhWkQljnsEQq1TwphkdO9hTUPRQ7CIJpD1y9Ep6pzIazRU1a067zPIMlNeJ8XpnhXmRudumtxTQTfDLbMvO3G54gKrEkfoLKvJ65qHMXNyE3V5T2/P5ysur6KwT2VAgxEtW2S2WFsdpc8V4Cio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a/UvBAMQ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e870666dd4so397393985a.2
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755428186; x=1756032986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FxwHslc+aNOj4ZVlJxCfT88pdUZFU0Q7EaozNXDqlAo=;
        b=a/UvBAMQgnNigTMof2NDYeMU9GiSf5z3UTIPavQQp/77SaRCKn8pNSbKMJea8TuV7x
         eAAT+E595JyhQGqlV4zJXUKTwEsAfadEJnKXpZU4NTBLl0y5ManbnrPD0IfYccsMkF4L
         uDohGz5N7w7rlcGTzGrjhT/664GY63/P8LfJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755428186; x=1756032986;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxwHslc+aNOj4ZVlJxCfT88pdUZFU0Q7EaozNXDqlAo=;
        b=HTdUfMpTqPe9kkSxtlwpNaDqeI9l8JjWy2JxNrd5dbFqFQCly6Vm/TAqmz9VXbg+/Q
         50+y2gWhn+3Cc4hN6r1D1wonPAokKYC9mETZzzZGM+6cVgriqXJi7QCS1tJE4Z5yVIjN
         sgldpUohMOu82dzpz1Z7gJjb3d8lO0/LzsAAf9+lWUiMWvg44/QdsdNUNJv6v+VzqU6H
         21ZgNMNLNIaRimMITJvBrfnHj+skSmVnZ0FmcnmQ5g+ayBXpejOZfdTfeD8bBb3P4dqY
         21b6rwUZkZnGHF3c579Jr9HL1lcxwJ6uSPhxpHAmt4ZhV966cwLRz2SAwz5I+81sTp7I
         /iMg==
X-Gm-Message-State: AOJu0YzKRJc4mgnv1JFD6QXJVBghXKMlQbghf45/yqw7j7jUGFCQe0kN
	JJxuN3yJy7aRsrHU4sFD100DvAORYK/pluOgXtzWzn6kFG9zo8b16gABLYCWq3v5IZlGm9jrap4
	vmPNJl7jU
X-Gm-Gg: ASbGnct0xUxhnw2KkJMQm+sNTrgVoZkq6R3UCtvtluq2Afeb2kjDh2H7dEThl+ijX9B
	PXLjTW35r1nyHVjCrgjB40skVN93yLjJ6kZcJUC4lnioQCTADswpBTZ7s7N8D3ynEt67LndKB1/
	b2aR7v/k6tPBLCYe8CoHl0ArdwizbNE+WImqHhMpws3NLd4vK6mDALdy4nX5+eLpRiQ0A0Nynt9
	t8MfC92nJYY2qfpBKGp5HHD0VU7+E/TC9xXM2CR3YXbNwrvByifna24C9dbp4wIODm5AGEoUP3n
	q90rKcfdCeGCpSsa5Z1HV+V3RTQgsR3NuDbTYe3VixEZUipiVUyXNpjF/u3EDTVD+2kpxaq+jJg
	rW4MUQzGbRbobChVuyR0JJOKSkaUlSn00xGdePnjbc+uI2/zuk7ZAg2N/7eaLUy5Hp2c4zd/Qst
	fX9g==
X-Google-Smtp-Source: AGHT+IFusN4DUbUusp7Umki1FAQcmK57wdk3DtLZJPMwMbwaRtjlR4gBLpyyIYtC5UhIVkDYlHVQbg==
X-Received: by 2002:a05:620a:2809:b0:7e3:3dfa:c678 with SMTP id af79cd13be357-7e87e06f270mr1163901285a.53.1755428186033;
        Sun, 17 Aug 2025 03:56:26 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9067c23sm35801006d6.18.2025.08.17.03.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 03:56:25 -0700 (PDT)
Message-ID: <fceaae4e-a58e-4144-8c91-b62d030d28c5@broadcom.com>
Date: Sun, 17 Aug 2025 12:56:19 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wl-next 4/4] wifi: brcmfmac: support AP isolation to
 restrict reachability between stations
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Wright Feng <wright.feng@cypress.com>,
 Chi-hsien Lin <chi-hsien.lin@cypress.com>,
 Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
References: <20250817094103.941090-1-arend.vanspriel@broadcom.com>
 <20250817094103.941090-5-arend.vanspriel@broadcom.com>
 <b241fff3-b81e-45a0-ab8e-27fc0a3a75e1@broadcom.com>
Content-Language: en-US
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <b241fff3-b81e-45a0-ab8e-27fc0a3a75e1@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/17/2025 12:41 PM, Arend van Spriel wrote:
> On 8/17/2025 11:41 AM, Arend van Spriel wrote:
>> From: Wright Feng <wright.feng@cypress.com>
>>
>> hostapd & wpa_supplicant userspace daemons exposes an AP mode specific
>> config file parameter "ap_isolate" to the user, which is used to control
>> low-level bridging of frames between the stations associated in the BSS.
>>
>> In driver, handle this user setting in the newly defined cfg80211_ops
>> function brcmf_cfg80211_change_bss() by enabling "ap_isolate" IOVAR in
>> the firmware.
>>
>> In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
>>   0 = allow low-level bridging of frames between associated stations
>>   1 = restrict low-level bridging of frames to isolate associated 
>> stations
>> -1 = do not change existing setting
> 
> Hi Johannes,
> 
> See that auto-delegation in Patchwork is working, but if you don't mind 
> I bounce this one back to you as I feel being a bit too involved in this 
> one.

Nevermind. Let me first fix the checkpatch/build issues :-(

Gr. AvS

