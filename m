Return-Path: <linux-wireless+bounces-5670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F3B893270
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 18:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D9FB21FED
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7E6146A65;
	Sun, 31 Mar 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="buDtfqkv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4141914534D;
	Sun, 31 Mar 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901004; cv=fail; b=UfZfq1Z/2bnBs25EMQUzHqe2nIxgXG/tjixss14r9nX541NBzxlKKgctw/aoPm5l/LTx48Dg4tbi6uKjzGNWtBuqNGv6GFIvRIYPB16BSKAwKM+3SzD5M3R3+0TbnDau7SQpK+ecqSAYVwzfT5M+wRZP2V0ltBYjZhhJHHWxXSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901004; c=relaxed/simple;
	bh=PVVuSm2i/BrAi3YIHH//s+w5qN2c55N1o8exyPZvdcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQzYuPxkQd8JfXLSKCih+9A3v+Ue2LhXDsn64oef2ZRtTnQb1oRYFl8G92M8+YO+UIijOYlmSualbuu5kjVVNRYxZrQBuf+sdsh1SVyQ/1R5820opWrrNAEmlfC3LZ9RV5gCQdX/rE6vR/xhe3s3xJLWxPL+uL4hXWIWMOUGwPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=fail smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=buDtfqkv; arc=none smtp.client-ip=209.85.128.48; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=freebox.fr
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D0A18208CB;
	Sun, 31 Mar 2024 18:03:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pCFUnSqk4TQe; Sun, 31 Mar 2024 18:03:18 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 305A2207B2;
	Sun, 31 Mar 2024 18:03:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 305A2207B2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 22DB5800057;
	Sun, 31 Mar 2024 18:03:18 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:03:17 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:45 +0000
X-sender: <linux-wireless+bounces-5642-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoA+FxrGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgAMAAAA5IoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 16156
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5642-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com C963C2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="buDtfqkv"
X-Original-To: linux-wireless@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711836289; cv=none; b=cxSuHTsUBGViFoyTNjRzDp3H9Kwbj+reYllOOmJrolDaxQxVO6RpMFPBmKUF1hgNRSVBVaZ/VZxx6pv0UgdBilHTPujciCmbedQyCk24yuukfO/WKQA5603x4IoM27rCuVzyBo+TUIhSlAy1JYDVLtl6yaKj1itpYb21EPIvcq8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711836289; c=relaxed/simple;
	bh=PVVuSm2i/BrAi3YIHH//s+w5qN2c55N1o8exyPZvdcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXxJ8ehiIYQuPPVOoWlRmKCBNgGKmpf3LZTAVNmG5JfZGIa5jUle/+kteleEus7vNFQ+14NUcQwfE0pLSmp9Gidq+C+h0z+kbFbfUZaddK0TWZVh6YZMLog+b1af/mY7NleL9z29xg7qzt121bBfv491q8wQoES3suBLIOk9CWQ=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=buDtfqkv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
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
Message-ID: <ea18f91a-710a-4eac-903d-90928caa3090@freebox.fr>
Date: Sat, 30 Mar 2024 23:04:44 +0100
Precedence: bulk
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

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



