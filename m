Return-Path: <linux-wireless+bounces-12300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9B96755F
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 08:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE17B21295
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519E728389;
	Sun,  1 Sep 2024 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tinm286/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB2A94B
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725173734; cv=none; b=Px1qY6J//MREb+YsqfRXfuMubSkDJqG5YbGOrgSMAH5Or+/9UThLzPR2xPO59mJoXNjQE9iX9zYfJEtPD+liIV9YTULP3vfmBcGRmxml2EkBOQxoxjU2XBkOzWW8mspPVIykJ8zvWHrSFgdjc9zMiTs7HIru9XoE1shXcuVdoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725173734; c=relaxed/simple;
	bh=5VUJ1tUMYYQC5/ug3pAY1zSqR654bVKbDaxKoarkPVM=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nTYs5To3UBDGiDb7FnGBE5lgLTZpdBvRNWQfG+Ox4CG4344XqbmMkfM3T2TSIcAj7O0oWEp/a84c61K2sLUWOg1uoq1IK3k7BZnMXEc/iIG0WSlor61uOUYZZnD+isrmNNA05C8jdvJBwQFVBX7hsVHDQY3R2EcpjB8uEIJFyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Tinm286/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39e6a1e0079so12771965ab.0
        for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2024 23:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725173731; x=1725778531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcbFIa62Fe7gQ4kKe6DN2JC8H5qmWTMruzqxDQuo6/A=;
        b=Tinm286/R+HmUQbSgBMV8eXUbdu1rCzgcKtXMoDpwNGasbV3aMYA3ope15gCL3Br0Q
         iajuiX1QHi81LHTQ17o2Dl4EcFLy1S0ZRrwcfKw/olQm99R04xPno4OH/1Z8AayRlyFO
         2Z4uQFywJk9FvFkVhFAIi1vuPChLvPTLE7G7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725173731; x=1725778531;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcbFIa62Fe7gQ4kKe6DN2JC8H5qmWTMruzqxDQuo6/A=;
        b=OEOlBrpBVMZjQ4jgRgJZ64PVyrdjtj0Z9RREWu3Y+3iJF7i33irQ5EZ860sz6VFWXB
         n5vtF6oj8Q9h1ZrXcprkqv3rhdb2BEOXeU68jQ8LcNbJ1yFNiKsRCY2hjZiv4+NF91b/
         0+bBP58LzTbco+KhSdD1dBSXdjjXQ0Xn+qBv9aTfUY5xZH42E23dYwRe0Z/rLwC1iFFA
         oE6WEHuA7unfS/9f1othTOcnM1TS01tOiI9+Pv0hv3MCWuCTT2Xp1NH/Ag+Yr+JzxiSu
         7WpFD9rbkUztP+i4u2NpXaPiV4rwyqcXa6vSdvISRWzoovvv3yPAw3pltJlu/uz1YGdS
         BDTQ==
X-Gm-Message-State: AOJu0Yz0OGXFIPlyc0FxJ1nhpwUFwlAXIrC7TpSC6TulDDAMJgsgYdZl
	T3LgPMYyCEdGD6GShHDBrcF3vZvJLhfixlNVvhWMIcF/wx+kX07UfDmoExvGrw==
X-Google-Smtp-Source: AGHT+IE739jURfeNez7kUNisOAPZJ37CfR56AIw0IemswIr2OKC3bQbsrcZBEiIWxQg8q+Ud7qwvTw==
X-Received: by 2002:a05:6e02:508:b0:39f:51b8:5e08 with SMTP id e9e14a558f8ab-39f51b860a3mr25392965ab.27.1725173731443;
        Sat, 31 Aug 2024 23:55:31 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5200sm5024871b3a.73.2024.08.31.23.55.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2024 23:55:30 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Marek Vasut <marex@denx.de>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, "Chung-Hsien Hsu" <stanley.hsu@cypress.com>, "Chung-Hsien Hsu" <chung-hsien.hsu@infineon.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Carter Chen <carter.chen@infineon.com>, Duoming Zhou <duoming@zju.edu.cn>, Erick Archer <erick.archer@outlook.com>, Kees Cook <kees@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Mathias Krause <minipli@grsecurity.net>, Matthias Brugger <mbrugger@suse.com>, Owen Huang <Owen.Huang@infineon.com>, Ulf Hansson <ulf.hansson@linaro.org>, <brcm80211-dev-list.pdl@broadcom.com>, Double Lo <Double.Lo@infineon.com>
Date: Sun, 01 Sep 2024 08:55:24 +0200
Message-ID: <191ac5df360.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <6129cf7b-59bb-440f-a277-69af63168e87@denx.de>
References: <20240818201533.89669-1-marex@denx.de>
 <172431581868.2154344.15348672155352447310.kvalo@kernel.org>
 <6129cf7b-59bb-440f-a277-69af63168e87@denx.de>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

+ Double Lo

On August 22, 2024 5:24:09 PM Marek Vasut <marex@denx.de> wrote:

> On 8/22/24 10:37 AM, Kalle Valo wrote:
>> Marek Vasut <marex@denx.de> wrote:
>>
>>> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>>>
>>> Add support to download TRX firmware for PCIe and SDIO.
>>>
>>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>>> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current linux-next
>>
>> Please fix the review comments, also Ping's comment that from and s-o-b
>> needs to match.
>
> I have most of the changes addressed locally already.
>
> Regarding the SoB line, do I update the commit Author email (because
> that would make more sense, cypress got assimilated into infineon) or
> the SoB line email to the "old" cypress email address ?

I would say the SoB line is leading as developer's certificate and that has 
the Infineon address so that seems more appropriate.

> I am still hoping to get a bit more input on the TRX firmware handling
> from Arend ... or maybe there is no further feedback ?

Took me a while before I looked into this. Can not offer much info though. 
Within Broadcom code bases we only have a v1 and v2 defined for the TRX 
format. This patch specifies v4. The only difference seem to be the number 
of offsets and their meaning. Looking at the index definitions I suspect 
this version accommodates signed firmware images which is verified by the 
bootloader on the device.

Hopefully Infineon can/will confirm my suspicion and explain what SE in 
.TRXSE stands for (security extension?). Anyways, this seem pretty specific 
to (some) Infineon devices. Despite its history I would keep this separate 
and specifically use trxse instead of trx.

Regards,
Arend




