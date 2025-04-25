Return-Path: <linux-wireless+bounces-22075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C6A9CDC9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 18:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C0F4A141A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2EE18C91F;
	Fri, 25 Apr 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yx33lm1a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF612C544
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597256; cv=none; b=YDChWdtyRQYE6rnDM3voSi3+9y2gWFEhY2k+HqZiqexVwMwhwfYa5sea98ZBSjkNXWo5lC94/c5YIoLjMP2+FnCqdjS5prkS17Kvw4aH1ukrmNCKiBlntZ+8tX5/ZX3xUzgxvSGajr6naEm325EvFFy+Ks/GtBcRwuUkq8D39BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597256; c=relaxed/simple;
	bh=WZaOdc1wZPK/4EneNSUdAaK7q9TWH49BP3VyKo6ZwAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRnCEtUsBLqIxpANQb63UD0eYskvFEtx1HRv22MJO1Jxa2jT0Y5SK39khsridwk+C1dE940c0SIwY0dR8l9SMblRinAT+5JD4du6sj8edFH77KIxw3KUkNCzI5vA29ajuvYddNWFG1vz5ahZdqcuv8c3P3idsGGSfsxfv8alvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yx33lm1a; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fd89d036so32126285ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745597253; x=1746202053; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ma+iGpUn/AKMVwLZapT0W95tZe34aNE+r6szCxKHl2g=;
        b=Yx33lm1aI5IbDKpBUpJeIh+x2DnQoN7pah6x4C+Hfr/k4pS9xBgOl8MknKaVbziTVU
         qgXKSRMUijIeiGxw53ncGtJqZgox53RYArm1SATtoygYroRhcP2ZA3AyJ9JZBL1yw9w9
         TLIZvausDBtEDhro8l44ZXqSSH21mq0dG/0ojz/uUPpeo8q+MYCy37HPQz97afBZOvXs
         MtqQUju7JIlctQbrOqVw9pf7RzWBjw4LSLxD2JoILT8AOFcsmSgefMq4HanQeoE47gqb
         YRDVT7FktzR4k/ViinwQJKK4YZ+EHF/G/Hd8RKz6b3NQDLp623QFJzyRL8Tu1RDsAVu+
         3Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745597253; x=1746202053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ma+iGpUn/AKMVwLZapT0W95tZe34aNE+r6szCxKHl2g=;
        b=dTTCycmiskc8ev/zo/nz0yhoOm9BjB5YAEkTZftujtE0OPOH4Y1R1mSRSXvUk5f82Q
         /7vhDhdnj2SKnlYCX2/EpWrvIyAz/YamboJPgxr9PIxW3ktn3PYcy1JKdxUt2MJrWwe2
         qV3TP69iX975fq0IBVdc9pv3Ac8Ltv88I4syVlIhOChM3XOaJtVRtou2nC8kTnTCM4dR
         R/4FO8nRul6w9Hs5efRuTxHjmYnBgVHxGTNpJ6ZYBnNWYqCOgY8+24MEIvEdrMCX+K3s
         ockJf1unzIkz0PtvgNSuC8ulURlJUb0/xvOaw8bKOUyD7fZHraWbnMOY1O/cLyepg3VG
         UX+g==
X-Forwarded-Encrypted: i=1; AJvYcCVZRuTIn6FCabdlWb1U5/ooBzxRKetfZ5DJkQqkq4HvQOpWfarIQwyY+2ttyxKEwfUpGoRBScPY5fhbFR0/hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNt3uJC/KJq/K0PdhdPmIA5MhvszHlrZ47GJRWlGRRyCAUNRp
	pU6u7jWSe2Fr4w973xgoTa/8WLCQtf9RVNEuc4wSRdb8jKzyV6y1sFEdIyy/Ag==
X-Gm-Gg: ASbGncuH+G0FLHPUfSYsnYBCvWfiQt/u9RP241aIkEDmOjnSz+HWgCEbadxaxCCtifY
	zxonShYBxqB4FVWh3Xd9R2Kw7sjzCebJGCn5rz1ps89/Nk4pwDZGgtapXimv2m3epBIsLnz4pUV
	zhINd44H3Er3CJQety4ZrOH9dc39VYV2b11xOSAQIQB8jHBAYd8MWGfMTljbTa/JH6i6b1cO0RM
	E0xp9cEFoWjsubI/JdCiqU5Y7rhpELE94YD1zI0/FagpjnML8My3+H8pvZZSpcHKoajJqId8lvk
	igRXGdWJ3yI+71Dws78/dKug8A9zEcpvmkI+vCk9CZBjBviC8vxV
X-Google-Smtp-Source: AGHT+IGHuaRxdPoXNwRTHc78Guuv44yqP3/H83BEy2uFRv1C3A22TKg1MCU7FGgOqFZzBgCQSRzorg==
X-Received: by 2002:a17:902:d2ce:b0:229:1717:882a with SMTP id d9443c01a7336-22dc69efaeemr2288965ad.4.1745597253205;
        Fri, 25 Apr 2025 09:07:33 -0700 (PDT)
Received: from thinkpad ([120.56.201.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15faee2091sm3098381a12.75.2025.04.25.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:07:32 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:37:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v2 05/10] PCI: qcom: Add support for PCIe bus bw scaling
Message-ID: <ammo5uyd65xyr2gexp6kgkyout2hezrlqqb7l77dix52wbtehl@ezw2ntaabjug>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
 <20250313-mhi_bw_up-v2-5-869ca32170bf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-mhi_bw_up-v2-5-869ca32170bf@oss.qualcomm.com>

On Thu, Mar 13, 2025 at 05:10:12PM +0530, Krishna Chaitanya Chundru wrote:
> QCOM PCIe controllers need to disable ASPM before initiating link
> re-train. So as part of pre_bw_scale() disable ASPM and as part of
> post_scale_bus_bw() enable ASPM back.
> 
> Update ICC & OPP votes based on the requested speed so that RPMh votes
> get updated based on the speed.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b66c413f1e2b..a68e62422ff7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1328,10 +1328,59 @@ static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
>  	return ret;
>  }
>  
> +static int qcom_pcie_scale_bw(struct dw_pcie_rp *pp, int speed)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u32 offset, status, width;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	return qcom_pcie_set_icc_opp(pcie, speed, width);
> +}
> +
> +static int qcom_pcie_enable_disable_aspm(struct pci_dev *pdev, void *userdata)

qcom_pcie_enable_aspm() since the opaque argument is serving as a boolean.

> +{
> +	bool *enable = userdata;
> +
> +	/*
> +	 * QCOM controllers doesn't support link re-train with ASPM enabled.
> +	 * Disable ASPM as part of pre_bus_bw() and enable them back as
> +	 * part of post_bus_bw().
> +	 */
> +	if (*enable)
> +		pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> +	else
> +		pci_disable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_host_post_scale_bus_bw(struct dw_pcie_rp *pp, int current_speed)
> +{
> +	bool enable = true;
> +
> +	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_disable_aspm, &enable);

We do not enable ASPM on all platforms. So this is going to affect all platforms
whose client drivers initiate link retrain.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

