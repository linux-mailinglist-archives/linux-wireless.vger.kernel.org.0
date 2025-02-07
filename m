Return-Path: <linux-wireless+bounces-18642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5DDA2CA24
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 18:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C583A97A2
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D78199E84;
	Fri,  7 Feb 2025 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byR1w/oE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AA1991B2
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949206; cv=none; b=iEwTy8xeI8zpyKQ+RVgtE0yWZGEywo0w3mjFc5tA2VycpHVNR1iIJM0alHM3tE48W8436lgdZZI69AeC6+C8osj/WfC1dmTfgnpavUvUZKYAA/1zJFchiCu6obCev75vW9Gu4G2MEwYdm2eowwsEmqLcXLQ9znT1jUUwq7z756M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949206; c=relaxed/simple;
	bh=avwKJTHwZhEICbpkM2GsB25ND3png6YyHfACluZr+Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWG4K4K9nQkNrQ4OmblXW9LeHACNs+Kcle/rnDBD6ElyC4A5U1J2mJcbxgMI2tqbhopllOgPr4iKT1xsSFevIFjrqVS9SqfD9ePhkGA6/9XHFoV6Mrmn2Rt0no7Qnj5Zp7kwrpXupaNJC2mtKSI/zmoqAgvmlPzzsg99Qy52/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=byR1w/oE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f5268cf50so15128065ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738949204; x=1739554004; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8kQ7aPeifT1xdGGMZlwPvaAdEmOG9nj84TNIl4A91gs=;
        b=byR1w/oED7Q6rEzBU+7qJGjHYCyqfUxqGMIPOhQPeJhbLZTPqWwuZJMQYkRBVswMdv
         YXDLKHyYpJ06soD/0Da0AvBeMkp56CilUOqSfNepxe8STCJQ3PGkP6p8pAOybL9go6YO
         mb/fYc24iwlrJBAgD6sWTFdozKC0Fd03IUJDJrOMYmbI1UIdr0SS6KyjjQYqmHw7mA/h
         n3L4ufRqsFvRyITX2tfLnSqXMntHKgVXaL40e57jD1dhsQ0jfbd2oKkj3e9xnvxJjh3K
         nkIgA2aHhHp6JCBTSz8DX90Ef6EeABtip6ByMI1tQSsf0mHXWzqTDSsU9HH/r9MgWHZM
         wSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949204; x=1739554004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kQ7aPeifT1xdGGMZlwPvaAdEmOG9nj84TNIl4A91gs=;
        b=RIix1eLmR5uVuCUeOd7jAr+MeSfr7ZLpcIxIW01kzJ092DC+dqDFMVntOrfPzy0bhr
         1HcuxrKgMX4e3B68h7EA4Z5rHlyLVuxc0SGZyHcO7z9701NxdWrv1rB/oXXPbHkKXtU+
         MwO96cYn2m6Ko0bmINFIcBO6sVdyDFPQxQBRrJmn9QVvwRa2Z/t8hTTNQAXzVD1wq+WB
         4WSi2av0Lqwcyh53xQ3kC4vTVVl5NISbX7Ub2Zxw7iVOvIu9PHKtqSPd7pPH/fjlPEP2
         g7qCRWzWMJGs6BIsSLaoaYOvwXo3Tg35vfjTipOyIxFzHTtCmsDrgqoSOIX89/To+/1k
         j1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUj2dgM2/eDPVD2PhPEEx3LYgLG+AuseROzSndeNaZ5NVvMZxsDhIgxeJLIWI8ZDDUnoOBrqvFNsQeXDaRi7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHbPpvfvwt1/lwXDWKT2vmT0i12wbuModpk7srwSRqzPQxOAs
	71jQZAJkogQDw7Cm/SBpgarCUeG1lyHKHUfXY5VqxtAUOgy6VGFzf94WIi3f9A==
X-Gm-Gg: ASbGncujc2z0Jx7Lx/XeBE0UHHby+WUBmRfzbay0C+kRbXAoawheGTzsZTHs16quDru
	qDeVFyNN5TQVdbaSNB/SIN4fuqyxOLAozg2M5efi4/5E9NiMTvmPO04vjzvnbvnW1vv93yeGbmc
	oeAVt/Q2mwgSDGSsuhekmk+P+FDHHKyJJ8w3/4FZvM68kdiNgPHM9s7Drf5DLkJyddlo3L8fAbe
	z2Z6u96MaHv+OuHnQOL/FF+AicRY+AXQ2P54ApSxJkwIOHmnAnChfwh86Rv8cQRUfX8vYgXXSRk
	ptqe+BrCa14gJZVFThR1kzmqbw==
X-Google-Smtp-Source: AGHT+IGwlMJjAWRYza5p7WJGxEFFQpo89Mjy7QrfQNgroEojUj8PNO092Q8xdIFkP1o8AKidffm+WQ==
X-Received: by 2002:a05:6a20:d705:b0:1e6:509c:1664 with SMTP id adf61e73a8af0-1ee03b6f0ffmr6990656637.39.1738949204454;
        Fri, 07 Feb 2025 09:26:44 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c16222sm3332034b3a.135.2025.02.07.09.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:26:43 -0800 (PST)
Date: Fri, 7 Feb 2025 22:56:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: kvalo@kernel.org, jjohnson@kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] wifi: ath11k/ath12k: Set IRQ affinity hint after
 requesting all shared IRQs
Message-ID: <20250207172640.npoa3ojrdhxg765a@thinkpad>
References: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
 <a8f4f4e7-1c13-44d8-b19e-4ac85b48ee04@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8f4f4e7-1c13-44d8-b19e-4ac85b48ee04@oss.qualcomm.com>

On Fri, Jan 31, 2025 at 02:21:45PM -0800, Jeff Johnson wrote:
> On 8/23/2024 8:54 AM, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > This series fixes a warning from kernel IRQ core that gets triggered in the
> > error path of QCA6390 probe. While fixing that I also noticed the same issue in
> > the ath12k driver, so added an untested patch for the same.
> > 
> > Finally, I updated the irq_set_affinity_hint() API in both drivers as it was
> > depercated.
> > 
> > - Mani
> > 
> > Manivannan Sadhasivam (3):
> >   wifi: ath11k: Set IRQ affinity hint after requesting all shared IRQs
> >   wifi: ath12k: Set IRQ affinity hint after requesting all shared IRQs
> >   wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with
> >     irq_set_affinity_and_hint()
> > 
> >  drivers/net/wireless/ath/ath11k/pci.c | 26 +++++++++++++-------------
> >  drivers/net/wireless/ath/ath12k/pci.c | 26 +++++++++++++-------------
> >  2 files changed, 26 insertions(+), 26 deletions(-)
> > 
> 
> What is the status of this series. I inherited it in Patchwork from Kalle.
> 
> It looks like there was a question if the 1/3 patch was actually applicable.
> 
> If we think this series is needed, can you rebase & repost?
> 

Yeah, this series slipped through the cracks. I will respin.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

