Return-Path: <linux-wireless+bounces-20435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52750A650C4
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 14:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454E13B398E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657E823C8CE;
	Mon, 17 Mar 2025 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMr2oVKS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE08238D22
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217881; cv=none; b=J+PebBRV501zg+o7Fb/6eHn2nKzJrr4kRzlJ58fW7y7B+Pu/KPp75lCeiGjVfFqgc9cCB5rgIMY7UfJn1LSwNKs08Mmy8GMe90KpNtyV+1xUg3zpOf6YtpoIR2n7gIbzo7kTFFzFokDtdVjGhmwcpDLnaXl/kQgw8Abvk3ZvXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217881; c=relaxed/simple;
	bh=JGmlDzFV34tiBzDy/DCO/WvcI0zjlhRgk2V7g48vyt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yx2MnfTNRIpkY2iSiwFo4fL0ahlDWwKNB+PVpUD9HwHDWLZDBk1j+n/A/K8C2t4JFbSggffEtZVKZyM8BEJdNp33FYWNmCJGBv+hKM8bJ0J8Y5gMMewJULcdmhqYJ3uEr7aJsNR33cSR3nEUEEjquGucPcz+RfzI4tb0o36uVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMr2oVKS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac25d2b2354so761225766b.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742217878; x=1742822678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75DGUwaZUMh5xew+755shQtUXwKQffCzN7Pf1xrpFN8=;
        b=aMr2oVKS8CPm4EmqB19SIV3NVFiWsLkET7LdHqTc01iOgVk2CzI9m/JGmdC86b8PS9
         xeb1OYZUfTH7JmeVwRKxtgO3FWQlTsUbcNCLrYhG/79kCe8l1AYfe5x575bXto3K4gYe
         49ypdjv57/6FFV+ca3CUHmtqAjv/uaBGVY7wYz2Dap3t6aX6Uzy8dVudj5+TIGU1jjXf
         segyHpzb8rKSNgPWYK2E0FF8+39Q2VzDj09wo9ZKbK1/H6EK4Jl8hdkhHB1En9dEsubI
         XwDSY4CRf10B6lmU2R8HogzmzMohNhEP/A8XbJCnFUZaE4SW29YAzjFUabZvPiq328Kz
         NiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742217878; x=1742822678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75DGUwaZUMh5xew+755shQtUXwKQffCzN7Pf1xrpFN8=;
        b=Br4LaVMnmZIPTiXf9Cc/AuhRwCGK+j3I5dTEeq1yMfuDfcVpc2BwUZlKzOl7cKgTYz
         BKQfh/rJMJvCGKMoTmd1eMTm2D0RyL5JklRWo+6cBsuPDSldk99CVNOgRoUrJowfBRms
         gQ/f8BkmYrClU/6hu9VP3xyykxYL5ODwLq44jEwgruM+FA51cmHLlbYYtckc3dgwEm4R
         S2QuRO3YNKlCr1lmLLQuOBE49rhk/rFewhtDvv744RI9OTZ23kAdLRvKY76kEqS1t5ZW
         x3tLefI9yEfjACWHQzuKMLADN/sNFw9vZR8k41b42RFBowhgU994TaZidZJDFPIqw9OW
         E8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCU3DvtZoy9j6Wc49Nt8W6EqzeRLp4sKyydkB0KCNxQbrsGffd+3CrmNIM2n7LkDFJ2jeVFiu4HdzFP8L7O+jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL2D4hBDC1jzzXF+3h3zGlDTP4cSqerCI6nRzuZKgl4GpvnLzb
	evA9ju7WIowtWY7O+njFbdLx28Vz9fYRL72+EM1qB1ZzVi45ShDG
X-Gm-Gg: ASbGnctgLHNvwwRXKLOCF8jzFQdKhQfNpx/LPQNv4LZUnoKDOw23SeYyzR+Hc5IGcts
	RVXAenEMcx/+Ok2vXqacGsAB1Ned7Ji8zf/04/RPPQakt8jTplBizF0N9RslLFd1c45bxJ+DpgL
	dW+GqDB0h0Fdtm2HKkw4lqMCnUpHd1eWGlL5zJBWoUPLZEyLXfn/tT6u8WfjMKxI2r+z6zE0J2I
	6mWfMfhbBGegEQygClx2xhYzh0BDe5Zi1eT+m+5ePZLwddPg92ecbc4UKnYvYg5HLwBXE1rKeDZ
	vCXQa9wjKTGK5NrGth4E2XcKTGLCdSGd3ZnIDOksU3/wZQAXHAPWn8OvZbwLfAC+
X-Google-Smtp-Source: AGHT+IEu7qxB2eNYsmguYei+fgIbvu0dZtaX8QxebLXw0QteBAZCcX2l94iX1qhxdziSOTeIOqW27A==
X-Received: by 2002:a17:907:6ea9:b0:ac1:e881:8997 with SMTP id a640c23a62f3a-ac3301e020cmr1433595666b.3.1742217877444;
        Mon, 17 Mar 2025 06:24:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm655171466b.49.2025.03.17.06.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 06:24:37 -0700 (PDT)
Message-ID: <0ac48cfe-dc7a-442f-b893-41416cd3017d@gmail.com>
Date: Mon, 17 Mar 2025 15:24:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
 <b972a60bb0b04b5f817047027970d896@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <b972a60bb0b04b5f817047027970d896@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 05:01, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> Tell the chip the maximum AMPDU size supported by the AP. This greatly
>> improves the TX speed of RTL8814AU in the 2.4 GHz band. Before: ~90
>> Mbps. After: ~300 Mbps.
>>
>> Add this configuration for all the chips, even if it only has an effect
>> on RTL8814AU in my tests. Surely they all need this.
> 
> The hardware default value of REG_AMPDU_MAX_LENGTH is 0xffff (unlimited)
> for most chips. It seems like RTL8812A/RTL8821A are also exceptions, so
> at power on function they do
>     rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, 0xffffffff);
> 
> I feel RTL8814A has similar setting, so maybe you can just add similar 
> stuff. 
> 
> By the way, the AMPDU is controlled by TX descriptor basically: 
> 	pkt_info->ampdu_factor = ampdu_factor;
> 	pkt_info->ampdu_density = ampdu_density;
> 	pkt_info->ampdu_en = ampdu_en;
> 
> Since you didn't change this part at all, I still feel setting 
> REG_AMPDU_MAX_LENGTH to 0xffffffff can fix low throughput problem.
> 

I tried 0xffffffff just now and it doesn't work. It's the same with
both of my routers. They advertise a maximum AMPDU size of 64 K.
I can't just set it to 0xffff either, because then the upload speed
in the 5 GHz band suffers a lot. The dual band router advertises a
maximum AMPDU size of 256 K in the 5 GHz band so it gets a value of
0x3ffff.

