Return-Path: <linux-wireless+bounces-15057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E43F9C0359
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 12:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3F71C216F7
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352911EF0A4;
	Thu,  7 Nov 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBn0vZ0t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A771D9A59
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977616; cv=none; b=be6C2quLnW2srx7KnPPIKUfZXXaPbZerQQUGM9Nl2kOiDE8MzFtFdsrdYr+BizOmOP0b71Vy3fnlrGst19Iow6tWHldj2++PNMQCoH3FBi/Tfs0ESpYwTwkrDtCZDgIJ/ajnxA2IDjQx4vXWcnSfnI5ldr8Rw6Ca1ABShOF7bCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977616; c=relaxed/simple;
	bh=ZYTtNkkENvqqW42AEa0uNHQB1QDLf4BhU5B9EYFA0BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5fO/MDjD+BmmW8lW98WzV0yoCn38uzBoOsev6nVR+6+Q86PQvzS4njnqyZdwlhOloXFqo2SvvwVrRp8696ORgvC87wQEYTA+NKQLjgoJI0eRsnitd5HPVNq0ARkNGwm/nLvKtNLrjtr76Q6EsY+0I4v8yZlStYMaR5RFf4SPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBn0vZ0t; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53a007743e7so780093e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 03:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730977613; x=1731582413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASyBcKrBKY8NGzfSOTvWexlrMtjkKivNcNfUlPPO4jo=;
        b=rBn0vZ0tiE07FzRohW9Qej9FFbols66/m7cACHyCQlNu4L5qh6L5Jf+65efEp0uTqF
         cmRxMsgbZiFqzdDuITbilz+vtZ6pw49ukTEVFSzIhG+Ft0Vd8/EZKuBDNq7jHAwFUXK0
         IQOee3s3dvpdfAfGKufLZ8R4da2NjWfqc67etqLhZoEfLAx1/x905fFaiC6wKtYjLylF
         XpcbvMW8zLxqPRPCl6BPfYPmqGlOWaSbt0ZRKNTeGtfWAwcOdsbCYnOBFY3gbjYEzBc0
         ZiRNWtWpdWILOx1zT92DObGnbwHYoOABFP/LbhdP8ibSOYeX6fePG+YBslfD1AjSRwL8
         1Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730977613; x=1731582413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASyBcKrBKY8NGzfSOTvWexlrMtjkKivNcNfUlPPO4jo=;
        b=S91p6aS5eC2nNIUIMEWTO2eUKkqco76S2Qr04qrSrVmLd8eQlJYjKnVzb58XGs0KU4
         Z28zH9vTsjjFJn8MXPqw59zgTzmlaCZX/bIkfk724b0kB4WarEODX3C+ohCiNJYGbd7R
         nVd9oWnCgl2bg0GSgi8GErcUr53t9zwXTnjaYf/vje2bteI7G0Bf0i1vppooSaryUdlJ
         SwGkmvggnITc1DwsLmYRk3S6YEyjtjYU5ytWTYKmOMyDrLWE3/M4J3LaNjGtxN913ONf
         7pmbuiDE4bHFxJSnVWDu2bkVlJD4QoPWnHWP1e6YeZnCNnkeQr6b1CLzlmpwNC9AwSNx
         z6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTKFGUXllLZhr9g+8HIystJyPY4epsyp3MVm//MOLvczy/AKLKSOAGd8BcbGUw9GZE2X1B2iaSC/dVfQgLZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ghPDT4kVEBnv8hcx4OaLrYgpNZIkFTECQY5p/+xklQ3VTuEW
	8ifhXJTrIJw9fER87Pqejwk4EKd8uwow9UvB4UHpArMbCfzVpkT+ESfQoROqjls=
X-Google-Smtp-Source: AGHT+IFi3LY+Kr3VywWVQAVjcm+xWKmNQhu5wIXejKiarWn4kE6mkOvT2Gb7mmwc2E0pIjCs2m7I8g==
X-Received: by 2002:a05:6512:33c9:b0:539:f1ce:5fa8 with SMTP id 2adb3069b0e04-53d840ac0femr353800e87.49.1730977612627;
        Thu, 07 Nov 2024 03:06:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d82678449sm168905e87.12.2024.11.07.03.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:06:52 -0800 (PST)
Date: Thu, 7 Nov 2024 13:06:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] wifi: ath12k: Add wifi device node with WSI
 for QCN9274 in RDP433
Message-ID: <cmvfpctliqggra33u6ituguoxh3jxcuxiyjpbtcjbcgpu6lhoi@4zdthfkc2ed3>
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
 <49a6ec0d-8a0b-49aa-a9eb-1174cff930f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a6ec0d-8a0b-49aa-a9eb-1174cff930f6@kernel.org>

On Thu, Nov 07, 2024 at 11:23:20AM +0100, Krzysztof Kozlowski wrote:
> On 05/11/2024 19:04, Raj Kumar Bhagat wrote:
> > The RDP433 is a Qualcomm Reference Design Platform based on the
> > IPQ9574. It features three QCN9274 WiFi devices connected to PCIe1,
> > PCIe2, and PCIe3. These devices are also interconnected via a WLAN
> > Serial Interface (WSI) connection. This WSI connection is essential
> > for exchanging control information among these devices.
> > 
> > This patch series describes the WSI interface found in QCN9274 in
> > device tree and uses this device tree node in the Ath12k driver to get the
> > details of WSI connection for Multi Link Operation (MLO) among multiple
> > QCN9274 devices.
> > 
> > NOTES:
> > 1. As ath12k MLO patches are not ready yet, this patchset does not apply
> >    to the ath.git ath-next branch and that's why the patchset is marked
> >    as RFC. These are the work-in-progress patches we have at the moment.
> >    The full set of MLO patches is available at:
> >    https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=ath12k-mlo-qcn9274
> > 
> > 2. The dependency marked below applies only to the DTS patch. The
> >    dt-bindings patches do not have this dependency.
> > 
> > Depends-On: [PATCH V7 0/4] Add PCIe support for IPQ9574
> > Link: https://lore.kernel.org/linux-pci/20240801054803.3015572-1-quic_srichara@quicinc.com/
> > 
> > v3:
> > - Created a separate binding "qcom,ath12k-wsi.yaml" to describe ath12k PCI
> >   devices with WSI interface.
> 
> Thanks for the changes. When you finish with testing/RFC, please send
> proper version for review (just remember to keep numbering, next one is
> v4 regardless whether this is RFC or not).

Isn't the 'RFC' being an invitation for review per the nature of the tag
itself?

-- 
With best wishes
Dmitry

