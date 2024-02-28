Return-Path: <linux-wireless+bounces-4207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A6186B3F3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B030283A07
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56515D5AE;
	Wed, 28 Feb 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="idppjIXM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941171487DC
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136062; cv=none; b=Y+E8WUVDn60VQZU04qwqJqkEJfybsjwWApFfWSMAeWgV+9wKIcef1hbYrZQuoaVV/xvBoh/3+BIokmm/dXcW6lAiWweD+7Cu64PacKvHIUEY2kjvx1BLqRikxf2w85vNB3jS4zbigNKoh7hOCDa7USf+dV/rzKaiGXtSYFG/ebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136062; c=relaxed/simple;
	bh=mjroxPW2eHBhaXXEBNaLZsRTmzRxKrpIIQVrF8G1Zpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9AsKWOmfz+uV8/SCdlWqKPJm1N2t0T74hmNbe406LG/vqKdK3gFiCNLqxeg9la+b3F1kMDgmr5d3MszltSGVFIIcl3r5xzsh+oL//31T756065N68HIETGKrSk0NERKa8VRgH4mJqpGUEZbWN55pSziefB+mr4PEmGr4Vats2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=idppjIXM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412b83cfb20so1429365e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709136058; x=1709740858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qOgqKolcgCMqkLQDBYRiEWccklZZF6TtDAuL0z45LU=;
        b=idppjIXM0ER1DMayERYLmhj0Bnh9kj7T7eLvD3E+KtnVN7YZXOMY3qPk1J4j1+FI5q
         F4wIZj2c4XjNzVHlFg6GBtdkeAlP7//LGVB713g1T9vb6iQlU42Dv/vYDa3p3Q7VsN70
         y+yD3gwMmw57wmUxnNdUW/gvGw11l+oARSqGGB1DbSWrPnyjrSl/jyzs6nHkehbaDfHG
         5OpfYBcSTMVxchnax20a6loyoziLUZ/0XmfeOu3kMn5XW/08gQpsVnh05G/fApcmA3np
         o+vvnp0DCrIWdWbIZRrbUP+7V2s5zsrQHbJPd9ajJElQmSznkgBIaL4TnVjGLiJ+QAN6
         AWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136058; x=1709740858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qOgqKolcgCMqkLQDBYRiEWccklZZF6TtDAuL0z45LU=;
        b=XHpQTZb9FcfQBjllYZopeOcHdStQfiZUeDM+IfD1xAgdX3vIMz0y1q/q0L/zWBt10z
         EM0J7IZOiXGxvW9y/lv5putSeAGFNIqMAsqhxHlEKEPbjmn1aZdWv0RrCIX3V0LUA5O0
         vk0/OZuBT6yX63lLuOphnQK3AqkQW793jeMZgM6+41WsjQfyK7WfpsR4jFzoF1RRQwn+
         8EiWTZdEooFDksNpYulHyZFRkMNAXc3siI9XYtqE5U3tyBgBq1OcewaDhseqg8DSL0r2
         PI+B89ySxbLAx+oq84J824h4nohzk29uuuOjtve8dhdZhO+65ncoI5gcK/bvVHSUd8aE
         kpVA==
X-Gm-Message-State: AOJu0YwcshKfsY3Uh/92f3vgy8xIJmuIvKQiwZSnSrKSg5JdzFqIi8TW
	I/WJr6FkGAfFOAslH0WVEgmhTn0PakWhUN19koat7yQ76pp01Gh+7e5+2BC5ZTrgJGAXQRVLoKC
	ymsM=
X-Google-Smtp-Source: AGHT+IFN2sCE6PE1xyjuz871GiSbf8TCRVzfrTClfeivGcowaSF9sD8L32UjuIrf1ROZJrtBJdB69Q==
X-Received: by 2002:a05:600c:4ece:b0:412:a344:ea95 with SMTP id g14-20020a05600c4ece00b00412a344ea95mr6394878wmq.14.1709136057810;
        Wed, 28 Feb 2024 08:00:57 -0800 (PST)
Received: from ?IPV6:2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456? ([2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c161500b004128f41a13fsm2450042wmn.38.2024.02.28.08.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:00:57 -0800 (PST)
Message-ID: <73d85158-6286-45c3-986e-22850fa20c38@freebox.fr>
Date: Wed, 28 Feb 2024 17:00:56 +0100
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
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
 ath10k <ath10k@lists.infradead.org>, Jami Kettunen
 <jamipkettunen@gmail.com>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
 <d8c90f33-d0ab-4d73-9580-2547446671a0@quicinc.com>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <d8c90f33-d0ab-4d73-9580-2547446671a0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[ Adding Jami Kettunen who documented the same issue 3 years ago ]
[ Adding Jeffrey Hugo for his past work on msm8998 ]

On 28/02/2024 15:59, Jeff Johnson wrote:

> On 2/28/2024 5:24 AM, Marc Gonzalez wrote:
> 
>> The driver waits for this indicator before proceeding,
>> yet some WCNSS firmwares apparently do not send it.
>> On those devices, it seems safe to ignore the indicator,
>> and continue loading the firmware.
> 
> Can you list the product/hardware/firmware where this is observed?
> Would prefer to fix the firmware if the issue is there

This issue is observed on an apq8098 (msm8998) SoC using
QC_IMAGE_VERSION_STRING = WLAN.HL.1.0-01202-QCAHLSWMTPLZ-1.221523.2
according to /sys/kernel/debug/qcom_soc_info/cnss/name

We are not the first to run into the issue:

https://wiki.postmarketos.org/wiki/Qualcomm_Snapdragon_835_(MSM8998)#WLAN

"Currently if you get FW details printed in dmesg from ath10k
with nothing else seemingly happening, you'll most likely have
to fake an MSA ready indication"

https://github.com/JamiKettunen/linux-mainline-oneplus5/commit/088eaa9153803e2b028e092f88539036442da4a3


The issue is also observed on an F(x)tec Pro1 phone (msm8998-based)
with unknown firmware.

The issue was apparently also observed on the OnePlus 5,
also msm8998/sdm835-based, also unknown firmware.


If the firmwares are signed, and the signature is verified by some remote proc,
then working around the issue in the kernel seems a more pragmatic solution?

Regards


