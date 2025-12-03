Return-Path: <linux-wireless+bounces-29474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5CAC9F1CD
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 14:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F9B3A1CB5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B91C84BB;
	Wed,  3 Dec 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChlGDno9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802A1940A1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768106; cv=none; b=kcaETHlI/JOlSCzhP21cWvrEM4f3PMjOCXMlEeRgEktCRZ4q9qu2x6KiKv8UPrelzKdUYxLQqP72QlNqaeqpc7aB3nbl9tmxgEexMgcl4GGdCslnsVnwZOZdxbIYXA1bwTpLBBFs8STR57Z0VVQ1NOeEo072NP6fNWuPJ+ZekD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768106; c=relaxed/simple;
	bh=ryETFZGOPyRfIIwBKuxD8aty17cZQ0KEBxQ6EOrfQzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RE9WyR283AO+6kGX3VOU1S0O6FaUEiAEjqssr1z+ifvQQFWlOwcUnMJF5vxFehETARaasjV7OgNzFpbWTLd6atFcH4/f1/LYyZ90G/y7eCEUGqr2sPqVXTwrCAsGZ3BjiAudsya67V6GvAbepH6cwwwVj7jFDAOgC7UVEjtnKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChlGDno9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so70633065e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 05:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764768103; x=1765372903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwWQfRICUozIvD7wuQF7aWFP8eTxZTD7tzlmqEHsBXg=;
        b=ChlGDno90m4mQ6jG7BsyERgG/yKvgMtryfXq7mU3d3xw4zAlX3DdWe/LNMvBpvHoyZ
         1tEZ1nTfg1Hb6Shv54sVkoNEr3c/1zfwRg9S/xVsqG6rCKu7zWYdrNPg6hARHgOeS8LR
         9UrfhKC8l6aNXLsYU+mr8dGV+oNqN2rP+TwKWobXu4Hk3UVT/GLi9RZKrRHjMIeXUrer
         BxaV5LF3MhSzmuaO6tNCOCrLrJQmVWY7nzmVLJeG/LxMz3d3cD2rnfdmDSKye4b60/0a
         MAJ4/5DozTqgRpwH94swT6POdtcy8TXHC5fOn/y+37oUOUGRmJXEw3q6BJ65wSIRLCiB
         hIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764768103; x=1765372903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwWQfRICUozIvD7wuQF7aWFP8eTxZTD7tzlmqEHsBXg=;
        b=WQ2wfpO6xuJrpnbCegJSmfaHeZz+5BYjp4CiZmh8UFEXmY6MYWHi2Uk+DvEJf7RVnN
         SJbAA6Et1C36Te8/dUe2zgXmFdvPUMJPsySzLni6wqY8g1zjhyPh9ClVp1raKXvBpb0g
         2XFL2DwUa5RpKA6iP2fLA0QcXYkBrw57EWu6Dhv3dkXrNrxsfER4YJ91bwD/KkmpjtQx
         BMQ6tANH5hKYfWdzLGz8hAUYXyYNaARUApaCwT0idMwigibVtZ432cfkS+uULdvduFD4
         WJKZnIFJyq5k7IhuxYjq5lOBy+wA363KROx9RZ94wXZ1cArb2x0RsHMxB3gndLDrhTGc
         euBg==
X-Forwarded-Encrypted: i=1; AJvYcCWqrzFNSschDGVtOU61UEDAy2oQQn6M0EB4p5VVKTUJOUhGc5ibYPFnrylF4W/2ekzsHlfoidjh6AULIqRdHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WUuQvJt9dvDCA0nZ1rhSKmMrDFVOXNH2dDJHc0V/xtDsBWRI
	2YUgmGx5BKm/HZYfc+vK3YWHmYQmMyzncfSfaHSoNgsAMzFs/kG5A+wm
X-Gm-Gg: ASbGnctLa3zpvZggTHFeSODkQirht0yRxNOpJPufFD50LY1YxKqIYtnd0azooCf92nB
	JIUYn/X+DNpOUUoB9FcY2QFpaThMqkSgHV3gwkdiO2BEryQh9eXPE4dSeY5pjclDosh8sBgBNhy
	jOyM6fq6R+eXWpEW4EMgClwfckP973a8ftSrzFxxpntNqA7gIQNI5zYg1cc4ouMTok0+MN4F5Hp
	hSiQznVdk4QQ/FthnXtbFCNqHZsTbuCETM59ILcPmM7M/SciCKck4ajEYZ2TbWney716dfRDy9t
	DX1MH5iiujkV84EAaObk/7q7w7gcVT5HP6QUFtERIFPTA7QL8dB8Nz7Q8l2coKcZ6dE+F+V/Umh
	6hkKwUjSSEdiURmTpYf21empHFHU6C2jNd5YAZoblJ+2vF/yph4F/CThukPUOw+yqAM5ZhnUSYL
	wqSdDFxjM82KdnvkJyZ8k=
X-Google-Smtp-Source: AGHT+IHM94AfKpigKZ72pREX11KgBRBXlQXksUnk9mm892Xk+cNjY9xIOPBCJ7RcNcciXIX6R8Kpvw==
X-Received: by 2002:a05:600c:4e8c:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-4792aee385bmr25213415e9.14.1764768102736;
        Wed, 03 Dec 2025 05:21:42 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b156604sm15422675e9.16.2025.12.03.05.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 05:21:41 -0800 (PST)
Message-ID: <0386b7d5-ec05-4b87-903e-5fb00b9048b6@gmail.com>
Date: Wed, 3 Dec 2025 15:21:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] MEDIATEK MT7902 (14c3:7902) detected but no interface
 created on ASUS laptop
To: Muhammad Firgani <muhammadfirgan50@gmail.com>,
 linux-wireless@vger.kernel.org
References: <CAFa2iMbgyA8Zgcncw2qgdrKpam5XoRzLqQ6SPq18wq58LCwi0g@mail.gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CAFa2iMbgyA8Zgcncw2qgdrKpam5XoRzLqQ6SPq18wq58LCwi0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/12/2025 14:17, Muhammad Firgani wrote:
> Hello,
> 
> I have a MEDIATEK MT7902 (PCI ID 14c3:7902) Wi-Fi adapter on an ASUS laptop.
> The device is detected by the kernel (appears in lspci), and firmware files are present,
> but no wlan0 interface is created — even with kernel 6.17.9 and mt76-dkms installed.
> 
> Driver modules (mt76, mt7921e) load without error, but there is no initialization log in dmesg.
> 
> I have disabled Secure Boot, performed cold reboots, and removed pci=nocrs.
> 
> Attached is a full diagnostic log.
> 
> Thank you for your work on Linux wireless support.
> 
> Best regards,
> Muhammad Firgan

There is no driver in the kernel for MT7902, but this works:
https://github.com/hmtheboy154/gen4-mt7902

