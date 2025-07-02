Return-Path: <linux-wireless+bounces-24755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB7AF0AAB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 07:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA293487925
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 05:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9A91F1301;
	Wed,  2 Jul 2025 05:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct2Zi9jD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0E14F90
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433483; cv=none; b=YZXyWBcyDYxjaknNCcGUmRX/M5T/DWxPhdRMHdhTy57dJVJcen2cIs03dsHXb4egnrjeN2tWfwI8k5yB9PQqi66hjFNAMCf9J9n64U0QfQxN8Yb95r4sPNTvthV8hcMRFsP+Zjjx6ViCiP/2byuFqG+ors3iwtl4zoX+mojxVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433483; c=relaxed/simple;
	bh=um54tsybIQGov1so14z99eeBcqw/L/Ty7QQVOkcxLcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taLWP1GETZ0jcSxjZ4ZGxy11Nnc1ehlMsirvT53hf1mA6jQ5btWHeWaQGMjDAHHZi5zqPDFJlEAs2dudJCb7RwQGXGu4lPrFAMaPgRXeZmam/vSBAMe4wNHMn6Xs345m4jdGgBghM29z1/fyWoYxpPp5o3VOwFJyiq41H4Hxzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct2Zi9jD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so5871179a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 22:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751433480; x=1752038280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=um54tsybIQGov1so14z99eeBcqw/L/Ty7QQVOkcxLcU=;
        b=ct2Zi9jDBMdUoG5KSeY4vPQJHT8PNILBrZL8ozqRTzzFeGSyh4Mg3NcHxnBEFZZW3d
         QhX2MMirn875oGiox2N9QJlz+Fe7+0N/Cs0LHPixA2vBOmw8smLaUsjh3L41t8NcjpBF
         hdPEOdeALJWKmxp9utxP3Zwh/OB1wHsk6aGNd+K6IiPI1irWoCx2DBbAJ1JFDNka7/1R
         kkPHrXnrh3cJamLKc+/BJSYbLD9t4ZV8U6f3mwPSFw8itP76xCPlP8jVcF/qfC4PW82f
         SBhKh7AMLXUMuZxaRxh/K5Quf06JoCNBIKGyaNFTCkDo2Y3h+JROkS0zobIuanGYojYP
         8rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433480; x=1752038280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um54tsybIQGov1so14z99eeBcqw/L/Ty7QQVOkcxLcU=;
        b=ZIotVhY3vJkhng3H/apFTvGMY8KjzxrJKTgjlXU7I7Up1l/onSafPr17KKSPemJ1m1
         7aB5/8KbHybCYlh5aKFo5RjdZGjMZcx65kTxR7Ui1nmCdg4L3Q7/HpyYrk3ZIVbgYqeb
         YYw8SG64Sxm6rCRyGTBzmfvGDyAom+Raw4JXXAMMh1UXIj+v4eVU5QV6OMvVj0dLH7WB
         zW+rXT8diHwepSizW7DNekmv0YL8xbdNqWOjZE/pEt56UTbrqbOGi0ULYP69AIinb5l2
         WobpVbVOiD8fsSOrBIF+pXaegZh75chNRwhE4IhRvBYoWiEbapmuYffDEitRM43VhznU
         S9ug==
X-Forwarded-Encrypted: i=1; AJvYcCUxCfCvc3c5SQQreN+wfDgY5pdDfhFTnItbrfWHHZJKip4Vv7/TQ8Y4f7F2YRICVXpriHJhd8jNKmtQKTl50w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xkLae4aGb/LwqZjMN/XDrKmpMkVf6JlOfBDK9fc/Lmu6toHL
	P+CT+qA0zogMZQgX8bq3EJdb2w/0NMrpV4m/70u24NXgDpVsYfyVT02F6ST8Lp/LHywtQnobmXb
	dWIOCMXLhmtGgZa3/1iCECQIp5YbaVYK59NQmGQE=
X-Gm-Gg: ASbGncvTlW0vRBC+qtXvNc3gMH6nojA8TuMeJSPwV7HJmWIzLrP8420194amRsb8y+q
	I0gTBotxbm7lZ87sSkbkACXtHq8W4PFkdFUxZTQmbxIQQyg8HsLbqPWFVW4cGhrzj29XY/ShPLA
	NGvv/8tsggfZNffkzbNitYJld5YeFIbg8cXAzTNvtkGurI158CtTC0euDCEekuTjLE19FalzTbk
	Q==
X-Google-Smtp-Source: AGHT+IEMkmdwzlSGJeAQ8PPaXllLIAjtkJJZeH3b5OICmbQtX7VsVL5Q9yjPcEMmQTvGVa8fRMj8QxumFogFy9cFkSg=
X-Received: by 2002:a17:907:1ca3:b0:ad8:8529:4f8f with SMTP id
 a640c23a62f3a-ae3c2da9cdfmr117080666b.45.1751433479523; Tue, 01 Jul 2025
 22:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com> <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com>
In-Reply-To: <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com>
From: Matt Mower <mowerm@gmail.com>
Date: Tue, 1 Jul 2025 22:17:48 -0700
X-Gm-Features: Ac12FXwNkOaqmG2BtbfIHH58QXlArNNvzinDBRJOE7pKkFaCFWQUgB-Rk0U9dvU
Message-ID: <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	1107521@bugs.debian.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> A couple more things I'd try on the ath12k side: firstly, boot with
> "iommu.strict=1" and see if that makes the faults any more
> frequent/reproducible;

The issue is easy enough to reproduce in 6.12.27 onward and I may be
mistaken about the rarity in 6.12.22; I reproduced it relatively
quickly in .22 today, so if this was the primary purpose for setting
iommu.strict=1, then testing with or without strict works. FWIW, I did
test iommu.strict=1 with 6.15.3 and still have not reproduced this
issue there.

> if a fault is fairly easily reproducible, then
> use the DMA API and/or IOMMU API tracepoints to compare the fault
> address to prior DMA mapping activity - that can usually reveal the
> nature of the bug enough to then know what to go looking for.

This is unfamiliar territory for me, so I hope the following is at
least close to what you requested. If not, happy to provide more test
results based on a set of instructions. Here's what I did:

1. Set CONFIG_DMA_API_DEBUG=y
2. Set kernel command line to: iommu.strict=1 log_buf_len=100M
dma_debug_driver=ath12k_pci trace_event=dma:*,iommu:*
3. Booted and waited for page fault, then cat'd
/sys/kernel/tracing/trace to a file.

Additionally, though I'm pretty sure this is irrelevant now, I added
logging after each dma_map_single() in the ath12k driver to print the
function name and resultant address to the kernel log.

Comparing the addresses of several io_page_fault lines in the trace
and in the kernel log, they line up. So, I'm hopeful this is on the
right track.

DMA/IOMMU trace: https://cmphys.com/ath12k/iommu_dma_trace-20250701.log
Kernel log with additional logging:
https://cmphys.com/ath12k/dmesg-6.12.35-20250701.log
Diff showing extra logging added to v6.12.35:
https://cmphys.com/ath12k/ath12k-extra-logging-6.12.35-20250701.diff

Thanks,
Matt

