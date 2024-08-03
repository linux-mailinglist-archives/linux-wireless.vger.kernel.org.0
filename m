Return-Path: <linux-wireless+bounces-10880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9619469E4
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 15:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C012816BC
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453249659;
	Sat,  3 Aug 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LNQ45uOr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A44136E09
	for <linux-wireless@vger.kernel.org>; Sat,  3 Aug 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722692839; cv=none; b=LxOVIlwu0Q1kk1HctYS7wvtKMn1nlNQYKHSUTGHKDkehM7rCS6lzuiZ2oTqrPCbm1jj25kEhr9yvnPK+p+b7pZ/q42hlo/g0C9ABdOwv1OCf3P0PYZMytYAjDDCITmhooBd/CVgYW/sqOgqv0P1iBVmubPkGczRRpkga954YJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722692839; c=relaxed/simple;
	bh=NYA6sYQwjyHrZaAyGTauiIPxEqDC/y2kBfxFAb1PwZY=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZgSnPknyIagYx/lpo3t7PdpCAYbUF8ztxHWDFSTGWplf9FttbY4KDiTHF7qhZ/dDwl0ITIV9e7uwXyv7hdu7cLPc7poS2t0/Hs8fl3l3O7teFNgrMN0sp7B/xJTSVOt6zOVh0WI+SC3FVh4lVSFbY5MUnWoMbNoStZYVOQBuEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LNQ45uOr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so11456520a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 03 Aug 2024 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722692836; x=1723297636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5RT1Qu2F1uakgzsI7iEt4bY0NeXn3F9JOiq2sORjJM=;
        b=LNQ45uOriaKzL9ebRq3WAJ2prO13UtFhrPH7bG6UtUoRVPYaCDX5naQV0+e5ocbfzN
         25i6ysw0kNEw9HqQJQs5Dx4MCdc+PMjoUapdk9fYuQvRHJY/ve2e+J4cVzEsqhMBMvvA
         k6mC2KmVXV6UkVjxD2GIa4HwousF3Mw4gPCKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722692836; x=1723297636;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5RT1Qu2F1uakgzsI7iEt4bY0NeXn3F9JOiq2sORjJM=;
        b=Jh3gKN/bg2666s1O6xbFxTwon1y4aR++rjLSucfjcgjabTX5l1kltaO3ftb5qqTO5d
         DS8NytSORkXd1MmsX1ZdV5wAzpQBEad5hhaYFyxZUvUm8H9063wEZNi3vIo73nVSoau+
         5PHmchnjOusiZ5+B7kM1lmgE21tByxh6ER0fmvO6AUUGixGwejLQharxXDQSQW4l+vi7
         64/YBjmorjDvtwr3rMToGYGSh2abjS5EO4u8hzefcS+Lg4Y95my0np5A/jJAWQGYXs1F
         dB1bJSEoToGLmPh6h6qVWsqPFhTQ2l1ab4TMDW7k2XRVDi0GhYNj4g5eTPiZNbT1LsAI
         icGA==
X-Gm-Message-State: AOJu0YwkvWSzUzzp0MqHwKkxVN+Mh71TWpPPKuaCVvJ2GvAm08c8S0iF
	Q3vaa83r4OByZ5ZnQD8fO5ZmuIbwFIk9pjHpqnIIVCAmXWqzJuISMBFAK1z6X5jq7He3JYG/KX9
	AQBWw
X-Google-Smtp-Source: AGHT+IH5sxguhxTGPtrzWoIPbbAkQ7FJ4XYNcIEzg1Fzyecpd8e+DAtDtrRTDth4ddyzyAeWlhJzrw==
X-Received: by 2002:aa7:d5c1:0:b0:5a2:189:6306 with SMTP id 4fb4d7f45d1cf-5b7f40a71c3mr4958811a12.18.1722692835699;
        Sat, 03 Aug 2024 06:47:15 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839c2dbe8sm2389737a12.37.2024.08.03.06.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2024 06:47:15 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, Jacobe Zang <jacobe.zang@wesion.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, Ondrej Jirman <megi@xff.cz>
Date: Sat, 03 Aug 2024 15:47:15 +0200
Message-ID: <191187e96b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <f2cc346e-63b0-4fb7-b954-5dc3e597b7e1@broadcom.com>
References: <20240802083400.166753-1-arend.vanspriel@broadcom.com>
 <f2cc346e-63b0-4fb7-b954-5dc3e597b7e1@broadcom.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [RFT] wifi: brcmfmac: Add optional lpo clock enable support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 2, 2024 7:28:51 PM Florian Fainelli 
<florian.fainelli@broadcom.com> wrote:

> On 8/2/24 01:34, Arend van Spriel wrote:
>> From: Jacobe Zang <jacobe.zang@wesion.com>
>>
>> WiFi modules often require 32kHz clock to function. Add support to
>> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
>> to the top of brcmf_of_probe
>>
>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> [arend: handle -EPROBE_DEFER scenario]
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>
> This looks fine for a cold boot case, how about handling suspend/resume
> where the clock might have been disabled, do we need to deal with an
> "always-on" Device Tree property as well as whether the device is
> enabled for wake-up or not?

Thanks, Florian

When the external LPO is disabled the chip will fallback on the internal (I 
think). So it is not an issue for wakeup scenario, but if the clock is not 
enabled upon resume we should deal with it. Could go in separate patch.

I can inquire about my assumption above.

Regards,
Arend




