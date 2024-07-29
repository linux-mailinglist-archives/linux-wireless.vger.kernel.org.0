Return-Path: <linux-wireless+bounces-10605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920793EF62
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9311C2190E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE688136E21;
	Mon, 29 Jul 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AvYMWIzE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EDB13213C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240361; cv=none; b=uBgHlYtZoCh8SIphTcdu+8uymGSqr+hyV2QxUiEKhReb68U9o9bPPadiWquxngWHx5G10nt36cY48TZxtHRy5KzkqOFMCJ45E2zhDQO4OslZ2sD2R/ksIAJYNWUgvF2tW9SuWj2zcpa+G0sFaIHDMdAMlNSxpxKZlQQx4yCEuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240361; c=relaxed/simple;
	bh=n8Rx/zdmS57QY4dB3glmMrAOg1vw7OYCpVhNhDCu8BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/kkLYG9pH+7Eg65AWywSfNQVnwFPUoRsL8F49JJ/y7RxeWIb4N7aWT7uWhNbTjKo+rpjh0+J/3Vfp2Yoyh6qg1HI6LmrepPmYV64aTY0rC38dvrll8TYywRgbdYLHk6snoOXstntbZ9XfRaRn2ysChJaMDL6Q88QaGsldbXfug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AvYMWIzE; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b7a3b75133so22061096d6.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722240359; x=1722845159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OLxQ+oltHXvWTm73jCnAzYaGS2Qwqp5wgJznleOQdko=;
        b=AvYMWIzEi5Ek17AaQEgMmflFCJfGOgEazhzAbihf3+BXJXBWnX5Pm9qI8G4EMRcztE
         audTFOX6Qjj+7fbsSk8pKwWdqA9nFbmimjppC5jJxtqrnqakOjT5m28LRTUB7qDkA6Ba
         YSYY1y7EBYHFDg3fkij0g4HmTBiPo4vDgAw2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240359; x=1722845159;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLxQ+oltHXvWTm73jCnAzYaGS2Qwqp5wgJznleOQdko=;
        b=MyrfDGfEhNRiuIdA47GRdhVollomRpEkep0/LWUSwardz4iWjVnvcAJr+FfjghdO0c
         pugynFWp9K3RIZy8T4wB7ZWuh2NgfrfYKGnwjiKKAUW/YvZsPAlI/AaD7b818+w9qma1
         rxtEywSneCq/qG/n8oYgc3/qWqJ9k9E3gwrFql6DlDN3D+FMQ3yPxDItHYIpkySu5n0i
         zAinJZd+wIeBqLyEzd3Z5oiRdvLtFPQt9ASnmZQz6zISG0b7x7+Nmu2byvrIhOY5pagy
         p6jsWFm+lWVZojCX/UWAttOhAYZsX/uXMDrsMTwAZEz+Ok46hufE0FB//hiUGZxf+Qpp
         QJ0w==
X-Gm-Message-State: AOJu0YxEa0iH6o30A2DlbujUqRnkIvpcFMNuKHKZDly8Xr2VwctH5kb5
	yPb8cYcyu8w5B6uJI9D/Vx9g2yjuOLMg9zLE+KAZw/kGxotpDjuGHqRFAM0o7w==
X-Google-Smtp-Source: AGHT+IHDxRS/Qj/GgqaFGs7FuOIX0yBdKNkaZhJs4PVEqzZvCi316pZ+Yn2S8PHH0tjxLiWg/3zRpw==
X-Received: by 2002:ad4:5ae1:0:b0:6b5:23eb:3a4d with SMTP id 6a1803df08f44-6bb55a0cd98mr109431496d6.27.1722240359085;
        Mon, 29 Jul 2024 01:05:59 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f922b63sm48741156d6.67.2024.07.29.01.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 01:05:58 -0700 (PDT)
Message-ID: <d14bcb85-2b43-4961-863f-42eb14227051@broadcom.com>
Date: Mon, 29 Jul 2024 10:05:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT v2] wifi: brcmfmac: add flag for random seed during firmware
 download
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>
References: <20240728193904.35820-1-arend.vanspriel@broadcom.com>
 <TYZPR03MB700147CA6C80F34B8E3D5CC280B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <TYZPR03MB70019A591F0717F365A3392280B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <TYZPR03MB70019A591F0717F365A3392280B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/2024 8:25 AM, Jacobe Zang wrote:
>> I found that in drivers/net/wirless/broadcom/brcm80211/brcmfmac/bus.h has already prepared an > enumeration like these.
>> enum brcmf_fwvendor {
>>          BRCMF_FWVENDOR_WCC,
>>          BRCMF_FWVENDOR_CYW,
>>          BRCMF_FWVENDOR_BCA,
>>          /* keep last */
>>          BRCMF_FWVENDOR_NUM,
>>          BRCMF_FWVENDOR_INVALID
>> };
>> So should we delete them? Because you also changed BRCMF_FWVENDOR_ to BRCMF_DRVDATA_
> 
> Sorry, please ignore this comment, I didn't notice these were two enums with different purposes

Ignored ;-)

