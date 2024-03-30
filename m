Return-Path: <linux-wireless+bounces-5642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE73892D96
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Mar 2024 23:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474741F21D22
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Mar 2024 22:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DA94AEFE;
	Sat, 30 Mar 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="buDtfqkv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705C47F47
	for <linux-wireless@vger.kernel.org>; Sat, 30 Mar 2024 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711836289; cv=none; b=cxSuHTsUBGViFoyTNjRzDp3H9Kwbj+reYllOOmJrolDaxQxVO6RpMFPBmKUF1hgNRSVBVaZ/VZxx6pv0UgdBilHTPujciCmbedQyCk24yuukfO/WKQA5603x4IoM27rCuVzyBo+TUIhSlAy1JYDVLtl6yaKj1itpYb21EPIvcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711836289; c=relaxed/simple;
	bh=PVVuSm2i/BrAi3YIHH//s+w5qN2c55N1o8exyPZvdcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXxJ8ehiIYQuPPVOoWlRmKCBNgGKmpf3LZTAVNmG5JfZGIa5jUle/+kteleEus7vNFQ+14NUcQwfE0pLSmp9Gidq+C+h0z+kbFbfUZaddK0TWZVh6YZMLog+b1af/mY7NleL9z29xg7qzt121bBfv491q8wQoES3suBLIOk9CWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=buDtfqkv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4154614b47eso14171595e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 30 Mar 2024 15:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1711836286; x=1712441086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGCYWWp9GMIyWYRiLUIkswqhBEjJW45xVVdYqohDnyQ=;
        b=buDtfqkvqBxlLnqS65zqJ/cACtrKMeM9fj5jx5lMWTOMOcuIYa0nfXs2Z+dl71xqT2
         oR1oCdo2BGufKALhmivXoJzSHgFcROcJPMM6+L0YPnNOHmlUzb9e9OENal6o2lfc1gC4
         Jm1fVicJtjJCR4SPRJZnnZH6ndOzeX8WjMWzWh+FKCZOdkFTy9awAAYUySDQWy1sGGw6
         E1Ry+70LUA/XxJropwgjZ+yoazuCAPGNRhhfBJ/XZgHdgqoedABv9ts0SkcJJ+v+dwDa
         LJrHmLFtCIhUUcP8mX1tKu4AeS+KZSNi9P9OhpIM/sBgzUYy0IdUA18MXyoCVhVEEGh/
         Mpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711836286; x=1712441086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGCYWWp9GMIyWYRiLUIkswqhBEjJW45xVVdYqohDnyQ=;
        b=j4CfW+yg5gOT01ML00GldAirFyRq+yZPOJ2S2Q9cDckHwTjj6PGxKrPx0W1zKZKvAK
         v2+2jT6QYuqauGNDi/GCE5dFsGdqTnyzVVjuaKFswrFEuYhEmJ708EbiwPsR5NA1uNGg
         AoAglFWT9Hx/a3vUjAlRyE2DT6/2GL8kWSwbYCew2m3etYo8Jc7PtD3XtHT2xKZAncu3
         6qFILGXnoqEHSAfeoSG2sddTI22eokB1oIvzmrJtxRQBXMA8HUr9aBszJkMt2FqErdEH
         kBsKsyq6soYTNthhHKaxFx77hDCI5TRJOzEPyRUwSTHZko4XqL8sPK1UVtWEqfy4r3n+
         jh3g==
X-Gm-Message-State: AOJu0YxAojMb4cx1xRrAL1eMEYS4DwajL847oeZeSPYIT+Y8Mww6UHCX
	by8+b5fNRcHMef+idnad7vsHw2rJto50ypALr89O8L1qYcJgMapi0eOrXN/AeVE=
X-Google-Smtp-Source: AGHT+IHQblUi6EhvJVc2vxBWhRa0CSocPGwpe4Y/225yNjIZknidoGHYR6Qi/0vpH2PCTsPbf1WZ4Q==
X-Received: by 2002:a05:600c:3d99:b0:415:475c:2cb7 with SMTP id bi25-20020a05600c3d9900b00415475c2cb7mr6808179wmb.3.1711836285597;
        Sat, 30 Mar 2024 15:04:45 -0700 (PDT)
Received: from ?IPV6:2a02:8428:2a4:1a01:2b43:edfc:7d3f:4878? ([2a02:8428:2a4:1a01:2b43:edfc:7d3f:4878])
        by smtp.gmail.com with ESMTPSA id bp29-20020a5d5a9d000000b00341d28586afsm7512161wrb.2.2024.03.30.15.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 15:04:45 -0700 (PDT)
Message-ID: <ea18f91a-710a-4eac-903d-90928caa3090@freebox.fr>
Date: Sat, 30 Mar 2024 23:04:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>
Cc: wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <84f20fb5-5d48-419c-8eff-d7044afb81c0@freebox.fr>
 <72c162cc-45e0-48b6-8d90-d59fac299375@linaro.org>
 <6bd3db0f-2e18-4ad1-abc2-f59c6acc8037@linaro.org>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <6bd3db0f-2e18-4ad1-abc2-f59c6acc8037@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/03/2024 19:23, Krzysztof Kozlowski wrote:

> On 30/03/2024 19:20, Krzysztof Kozlowski wrote:
> 
>> On 28/03/2024 18:36, Marc Gonzalez wrote:
>> 
>>> The ath10k driver waits for an "MSA_READY" indicator
>>> to complete initialization. If the indicator is not
>>> received, then the device remains unusable.
>>>
>>> cf. ath10k_qmi_driver_event_work()
>>>
>>> Several msm8998-based devices are affected by this issue.
>>> Oddly, it seems safe to NOT wait for the indicator, and
>>> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
>>
>> This is v2, so where is the changelog?
> 
> Expecting reviewer to dig previous discussions will not help your case.
> It helps reviewers if you provide necessary information, like resolution
> of previous discussion in the changelog.
> 
> I dig the previous discussion, since you did not mention it here, and it
> seems you entirely ignored its outcome. That's not a DT property.
> 
> NAK, sorry. Please go back to v1 and read the comments you got there.

My apologies for omitting the changelog.

And I don't blame you for missing the thread's resolution,
since I made a bit of a mess of it with my various messages.

The firmware-5.bin approach was deemed DOA since these files
are parsed too late with respect to the required work-around.
Thus, we went back to either DT or a to-be-written system used
in the vendor driver.

Jeff Johnson (one of the maintainers) concluded with:
"But I'm OK with the DT option as well. Kalle?"

Thus, I spun v2 to get Kalle's Ack, and more crucially to give
a heads-up to the msm8998 users my patch would impact.

Regards


