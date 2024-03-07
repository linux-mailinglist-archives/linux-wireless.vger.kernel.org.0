Return-Path: <linux-wireless+bounces-4457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2560F875325
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B1B1F248F5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F312F36D;
	Thu,  7 Mar 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="ctgMptqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023FF1EEEA
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825372; cv=none; b=P63QiKsS7hbkLmt4pDzjO3BO/ePQl8btdKV5jhJx2h0kjmshCFWy4SJdCxaCtV2KR1DTJqGChxtYYojla9q5LbTFjv9TV3cdlI5bh4LWj2aSTdvzq85MVsR3NgHyAEmVQN9qU9OMKdWKIbGfsxsA6A9nTnNO1oggaI9d1O7m1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825372; c=relaxed/simple;
	bh=/CwM10SLvVd0qeLIDk7fSDRyhLofwyJ6hkYcbEkvGBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2bGHGBnQKZ9A8Wteicu1EF5FdwjC/4nx6mbmAUY5noiSV3LW7N9yP1I+UsEksNvdDRGw/DnslE544f1iVWrWQgGz+ndPxlzLE7hX2FkJHq+LbYiU8x7uUTpbILRNqox214gZfvxvgspLgTcAdhEPjjygtULXE+rfkQg3hrDloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=ctgMptqN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4130fefef75so5884645e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Mar 2024 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709825368; x=1710430168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4rA7glPrCrKwr981a28u15ca/pzff2LojpS0g84uXI=;
        b=ctgMptqNcuDfgmlLEsDRLPR12V3i3DxbmO/UcFyVmvKjM1HGMH9MHW2U3HOQpgCnlZ
         +5ZobBhHtfu2GbxWFq1WR5YWylV1mMNrZoAXdSzOItn4aRbK6jTO4a55xhGgWFHMuI4J
         kxjicZxKvv48aKdxxSGL2yzsDqszbQP4zOwBXhA4Y3klHEwlFpWWEXIvHUwLE29YVgyt
         tGaBTw0aqQ182m/6TU+azNIWDY+1NcU3NUdMXl1S7LswcKg5HIOu8YQtJwO8G2yfCWiJ
         Ysbi2PaAxbKMmOADchHMzzZdQDm2OrzvCYtvisiCrUYN+NwcmNK18rhp8NyWSROR//US
         uueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825368; x=1710430168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4rA7glPrCrKwr981a28u15ca/pzff2LojpS0g84uXI=;
        b=LpgWmzdmdHBY62Wuag8gHGlNU/qmDyEavM/2qKUDBvgyBuesMcsxxYELIqlMxA5NzO
         IJBNKp4DPhDHeuS9NClTgI3NJYKq2AlOmjvemoad4V6XwcAaqkAKXWVdpyVf52aUWRoq
         Oh9y4iaRm8LOVtWmR1xjFOppVKgpn/6L+KBBa9CkGQSTtaywaPhiiVkN65LdXSBb0EjP
         MjKScuAJ1tmNxgwgXJZ7k/k7ENVUQlwTmLYjM/ndPRM3PVNkCdsBIEsHlwVRy/a0DYEf
         J3Lr7gNScnNlBSzq83Y1Imd0ME3ib53ioHu0L3I0rO06V+s3QTfslhYSk4uYhTq6zT0N
         SIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCrahS1gxDzWPO/VMk83KUbsTStGM1XVmE9Aoj/Md8D79ZoiFESvteWkjI2BuDSxqqi3prMMc3ZZjTPFbZSvYvXmLJM0cTx9kMGRQPD5c=
X-Gm-Message-State: AOJu0Yze7AI9hutD+dTFN+5rsDAavYvRFGj9dmyRZcwwzli5+GigqGjV
	xdXDgUc6qwkH4KgKfkRHbnLh8dJQpAVdXtC69q96yym7vplf4nH7e9WP7B6CsAo=
X-Google-Smtp-Source: AGHT+IGEMjZrwSX4KlE3+S4Mx14JfUgPt2iuZklnN3V5j7oUm9gfxTUCLTshjWeoxPKz1UsSxB7+iA==
X-Received: by 2002:a05:600c:450e:b0:413:1013:cc7f with SMTP id t14-20020a05600c450e00b004131013cc7fmr1576665wmo.29.1709825368172;
        Thu, 07 Mar 2024 07:29:28 -0800 (PST)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id w14-20020a05600c474e00b004131310a29fsm1366528wmo.15.2024.03.07.07.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 07:29:27 -0800 (PST)
Message-ID: <2f588948-0261-4985-91e8-d5060e673cd9@freebox.fr>
Date: Thu, 7 Mar 2024 16:29:27 +0100
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
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Conor Dooley
 <conor@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <20240229-ageless-primal-7a0544420949@spud>
 <c48ead11-0e2a-4066-b324-84f802215c9a@quicinc.com>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <c48ead11-0e2a-4066-b324-84f802215c9a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 20:46, Jeff Johnson wrote:

> On 2/29/2024 10:40 AM, Conor Dooley wrote:
>
>> On Wed, Feb 28, 2024 at 06:37:08PM +0200, Kalle Valo wrote:
>>
>>> Marc Gonzalez writes:
>>
>>>> As mentioned in my other reply, there are several msm8998-based
>>>> devices affected by this issue. Is it not appropriate to consider
>>>> a kernel-based work-around?
>>>
>>> Sorry, not following you here. But I'll try to answer anyway:
>>>
>>> I have understood that Device Tree is supposed to describe hardware, not
>>> software. This is why having this property in DT does not look right
>>> place for this. For example, if the ath10k firmware is fixed then DT
>>> would have to be changed even though nothing changed in hardware. But of
>>> course DT maintainers have the final say.
>>
>> I dunno, if the firmware affects the functionality of the hardware in a
>> way that cannot be detected from the operating system at runtime how
>> else is it supposed to deal with that?
>> The devicetree is supposed to describe hardware, yes, but at a certain
>> point the line between firmware and hardware is invisible :)
>> Not describing software is mostly about not using it to determine
>> software policy in the operating system.
> 
> FWIW I've compared ath10k to the out-of-tree Android driver and there
> are discrepancies in this area. I've asked the development team that
> supports ath10k to provide a recommendation.

Hello Jeff,

Have you heard back from the dev team?

Do they confirm that an issue involving missing MSA_READY notifications
was ever noticed?

What devices were affected? (All msm8998? A subset of msm8998?)

Was the issue eventually fixed?
(Probably fixed, otherwise newer devices would be affected)

-- 
Regards.



