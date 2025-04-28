Return-Path: <linux-wireless+bounces-22125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120AAA9EB14
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 10:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5681A188F8DB
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30925D1EC;
	Mon, 28 Apr 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="alXNXs2e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAB18C937
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829969; cv=none; b=AgaCLH1j0ronlXQEp/XDmafQvDW7bE5v3knF8QN86Qf8jvnilNXMeLaK1W63d1wlLcxxnIlHG9kX4dcSJhBl9vSwHQt021IzD6VGR8M/sPJRdZ149V3GxyscaT20LTzudK2PggB64VEJQU572/C72QXq1Z42klWB9avHx9Sscyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829969; c=relaxed/simple;
	bh=GDNlrGSMfRwR/Pa6AgyFzByMPl2JLXERdBWkLM14RLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbyDlnQq9DRc/58wM8xdd90+lkXhXSt0WA3Y1P9RprACk5TMWEVJIxE1WB6oJjOLS0AHDvuSudzL8PYvkrlyIJe4hmSkrPsC483QRoisiePoX6+M72aT6CDTPuogqd5cdB9LUJXuJEcCuETh6x+4cLIjVagiMHnO7YxRqghodbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=alXNXs2e; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736c062b1f5so3688619b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745829967; x=1746434767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GWEGEENv/8I5RyLa5MjLNFG/IqS1JTCh/sY5K8DeZ9g=;
        b=alXNXs2eNKn4FJR7eTBlSFGRG29tbGh/fgamJiR2c9Eq3ff1YoG8G60i2Ke4rq/qAY
         NDOHLnB4zbq3ZO2rc9jw5B9A4q+QznB9vvPfJR+XL2CwJut5Nm4dRPgWDQkNXm0WvAVO
         sDQP0FB9v6UfbM+V1Qdyf+04vyXe1m/pGIaes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745829967; x=1746434767;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWEGEENv/8I5RyLa5MjLNFG/IqS1JTCh/sY5K8DeZ9g=;
        b=M5zyI0Nul28RUb1LdBHYlMdP+JRnyZOV7cxbjVA6U5b/7CVdYr/dd+j7gaVWqOA3EQ
         mLAJfg+GEaDGY17fLMsuv97gjksVG77Upy2abJqDbxqnfqIZHr1xpDmo4a5HE7YL7xfa
         QbRxDrPc/amjxjdN0kHXP3hLkT/hX618/zqWk/Pyb3l2CgQzZcqgt8Pi+fJgA7Oexr+X
         f8TChKEzA/sA4TI4lE9PhVREGNBp6J3IJSUSB6rU7G4KubT64AJf2EHFMRE763UBHFN8
         Oss30c1nRrK9Rkt4zn5O8n/X5JfQxSupZj6R3QyyMHcwhHTk/cHqXtwJD+4o/NndgZ3f
         5jYw==
X-Gm-Message-State: AOJu0Yx0BUxxXCoM2Obrq+bneTotgCTeW5gh/X53PD1as0zGF3nSyP+k
	ynFjMvjYVBlBn2VlRdN5tkdhHfhHZdsmnfTZbxx7gvLMuvQcnK8QGd7wzRyN2A==
X-Gm-Gg: ASbGncvTaS8NJE1qldoSchMCkQjCCaPZIekyO2msZ2HhPTMSi5EbrZxF7qydFsWAV2T
	q2SDRSms0dr9NZWyFchvjDcsK46WbMPrfE2TpQFTXrrNoaG7mQqSLJsW0LOnHNlh5kb5ejPBXN0
	YiZoxAAek0ORvIdU6SbUhIGTbRXfwGAmNDC/tew83JX/pdUIGQfXFbzB7Bgj9+c1Z25sgFNfZPp
	pyl7hG8Vay8+08wqqa1ei7tzDga9tF/axpL9978oqfh80V6tzeTcTygXHzX7ZqBXWUKGGmFmExY
	UsQ8G1rEIgIQpLakchVubcJaBukHuZErKWQNxQYbYjP9jD2g00uUY38NjWDR+MQFmN6QU6TP+n7
	DHw==
X-Google-Smtp-Source: AGHT+IFN2oRW/y7113X1pKUfuLjvwMBoJvDuLDloG5A+8Dyb0us6vO2iiQIrDcrAQBFxYGUOYIfgsg==
X-Received: by 2002:a05:6a00:1412:b0:736:4110:5579 with SMTP id d2e1a72fcca58-73fd6712e49mr14568443b3a.2.1745829966850;
        Mon, 28 Apr 2025 01:46:06 -0700 (PDT)
Received: from [10.176.3.251] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25acc944sm7730319b3a.170.2025.04.28.01.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 01:46:06 -0700 (PDT)
Message-ID: <9a657c02-b688-4f2f-bb0b-fd25d19a54be@broadcom.com>
Date: Mon, 28 Apr 2025 10:45:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] wifi: Nordic nRF70 series
To: Johannes Berg <johannes@sipsolutions.net>,
 Artur Rojek <artur@conclusive.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Klama <jakub@conclusive.pl>,
 Wojciech Kloska <wojciech@conclusive.pl>,
 Ulf Axelsson <ulf.axelsson@nordicsemi.no>, Josh Boyer <jwboyer@kernel.org>
References: <20250422175918.585022-1-artur@conclusive.pl>
 <4854f6a248fdc501d4157339fdb21f9a3ca3097d.camel@sipsolutions.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <4854f6a248fdc501d4157339fdb21f9a3ca3097d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+ Josh

On 4/25/2025 8:11 PM, Johannes Berg wrote:
> On Tue, 2025-04-22 at 19:59 +0200, Artur Rojek wrote:
>> 1) Nordic gave us permission to upstream the firmware blob [1] required
>>     to use this driver. As that needs to go through separate
>>     linux-firmware repository and is subject to different licensing,
>>     should I try to upstream it in parallel with this series, or does it
>>     need to wait until the kernel driver gets in?
> 
> I have no idea. Chicken and egg, I guess.

It used to be a check by the linux-firmware maintainer if the firmware 
blob is referenced in kernel module info. I assume the main linux tree 
is checked and not linux-next.

Regards,
Arend

