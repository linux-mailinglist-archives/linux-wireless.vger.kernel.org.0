Return-Path: <linux-wireless+bounces-28976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8622C5CC4C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 12:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1C0F4EFE83
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F5A2C1786;
	Fri, 14 Nov 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XjjCXc00";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LpzsxiIY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324742ED151
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118151; cv=none; b=laR8tlfFws2Cbavhk1dPmiECiN5QchwebjEwx92msGwiFG9Ly1rA8dtHq0hJ3i9YHPABWUa9MY+hRXjudMIN6pQcWOcEwQKlWkJJj42aGiCxtGdyGFYntKBvRo7mOkAmbpKxtuyduSCCAVaAH1T3L+NRUdUFnFOq7F4JvI7pYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118151; c=relaxed/simple;
	bh=+4X2EEILwzML/D3ZobGcwRk9lL7wORlBEox14AKg7y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh3vylcvuIe5vD0TvS2/8ZJmtVLoyWvYdE7jQOVfQeTDoSnzis8AXVfHf7udGnJXqHTtijEtSbwlg+OjV3Q/4jD+Lrz5dcY/qKIkGQZA/bPFQm1SDK4X4IGsqpMVaeohe/u8Vy1feyYkLLdq22LJdDjcySqWnnPtvKgh4u0M940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XjjCXc00; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LpzsxiIY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8K2411629395
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 11:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2RR1QJ03Mswmjs+cujBHJS7vnuUVaPQ+K3SVtWWyBPQ=; b=XjjCXc00U1MwFPzf
	8bPPHsWCyQ5uSogsh0zSw2ThKZS76fCn40FGGtJeALNAAYSSKj76lMBJC8u0q952
	5lL3OLSXFGOL6PacJrFI/3RhHasEqtwf6BwHOxPZzcQwyQp6XdTayZ80M0SOwKQU
	vCnLXlZDysKwxYP/xXcuRc3dH6/cjt0Vg15aZyjNEdy0XH4tzDN9Mr+Ftr1FoYnU
	28onChHHLXvVZtjto2OITSKMb74IIeW/8vvtrbKh0xNHC/ehu9c8PUM3yCkUDZTR
	fY1tINRlIjG3VF7IcK4jLY9t6IciF5bqyyxorzMqqt734aFRE35i583bJgpOSGG2
	S4e/Zw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9d9wr3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 11:02:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b991765fb5so2410776b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 03:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763118148; x=1763722948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2RR1QJ03Mswmjs+cujBHJS7vnuUVaPQ+K3SVtWWyBPQ=;
        b=LpzsxiIYiSLS0WLRt2xPaoegMC5lR8LXCagnD4imAHmlWkmEsqpCxh1z991cwfxtfl
         D51M+7KEXgUfHBjjxNS79MrMic+lo2TV0Shq4sutK6yQPyhaU9eF1NeBIlek+cNiwvoD
         VlJxQg5dj/yyqptiiXCV15AeWO62c0GnwyhOTqbzgdKFu3Uyp2hjexLnk6LJYjeh/FiA
         rIi0MJ6YHovjR1Ag0fI3fG5p7JLQlGP+BsfMOIiPQPfEXi5e5SERiElznG9AI2n0l0jm
         4OMivZ7xGWz65TNpLqM+0nuo0+PUOq8Y1bFLkfs1o5gIeTuQGznDarLzMa2fcMOgG4CK
         qrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763118148; x=1763722948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RR1QJ03Mswmjs+cujBHJS7vnuUVaPQ+K3SVtWWyBPQ=;
        b=mFDvvjvo5x83uFWFgCJkO4R8BP/GaYwmbYmvtchrWxDAnXSYXns8spx2pXIJjjmh/s
         b1ExTk0RizKtiiqLrvtDXWNUJd4po8qLXwWhsy7nDE1QNXvJXrdmIPwQTKrIeUtIbj2Q
         DoJ/2qsSJDYzFyzTSyn7LcYXjim+UW1SzJd2z/bzQmj4Ce75IZ+iQx4TctsBUBkg+4ch
         ZKgbfOZBVDe5jhqC2CzPoUybO57uxD9u69gN8PYWX3wEdp2D0EhLyOI3oEKfBf0WfSG+
         IwSwihma50w5gGRqvoaLwRw6pyFNxX+m1wfploswm9yJVLbXAdD/gbh/LHIDE9hvERmj
         hwPA==
X-Forwarded-Encrypted: i=1; AJvYcCV3qJnIZMikiMl0QUUMB8BvrFDTTYtlD7DcdwgFkugEnWMh1Z0NoXFpWKcF9Df1edYSMjcnWqZaKIfBouUarg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMPCny22zTXimNyw5hVymKO/Tc9a1IoPGreKX6g0nGbohWsP6
	KB1W3JWy3sVBDorn7HZScCbtSfyWYj3dMlPdCutUEyzihvN6fO8va4Mpdui6Pfkb4MMAqWsB8Lq
	qYsGujGlMPK/msCRuwt8G+PH2YhSFt32HG6Vu8Bitbj7R7hHPzIDzgc6J82wEaCIgP6VK7ZNBR/
	qMYg==
X-Gm-Gg: ASbGnctu1vDaoffSHvAA2EB7i2DQJPEiR1PgjtdzRoD2POz4U589INEJnvGfiwRz/bH
	+7XmbS9qk7yuWV26GJisCqCdOjZAx3YVsJswlDdg6CeenZCwjv7xLaETKpBevkiftqVQsOPlQhB
	fiehj/2Z78HGCz1XOZlv6akF1LWVVegxoSeG4nQUEEGefkGaG4ndRoOqq3jRmhRDZGTIvubZrKf
	8PODims7L0gLEscKL/JYF9cX6yUeWtyNsso5+Q22eECzTlaPFA/m1Ia+PkLYR6hEmLC33pqb5MB
	3auiBzsyWP26HJ6K5HrK/tCdX6H3aTkdTuS5giMWabIjTH7So185awehiUYJLthynxUOS/Ju8jN
	W6KtVC/sRBf9bv5w=
X-Received: by 2002:a05:6a00:198d:b0:7b8:9d86:6d44 with SMTP id d2e1a72fcca58-7ba3a0be249mr3281994b3a.9.1763118148335;
        Fri, 14 Nov 2025 03:02:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExFNYt2MskO3W88XzfwFL4ANOFXf0FsrBkggPFobNWhKgZWFcTDPQBJLVYzM5f0k3sKC8ZFQ==
X-Received: by 2002:a05:6a00:198d:b0:7b8:9d86:6d44 with SMTP id d2e1a72fcca58-7ba3a0be249mr3281959b3a.9.1763118147841;
        Fri, 14 Nov 2025 03:02:27 -0800 (PST)
Received: from work ([117.213.102.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9256b8824sm4884070b3a.31.2025.11.14.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 03:02:27 -0800 (PST)
Date: Fri, 14 Nov 2025 16:32:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] dt-bindings: wireless: ath: Deprecate
 'qcom,calibration-variant' property
Message-ID: <fmumja63j3xvbvfxlmtnkfubgw4jwo5f43srrpfgqrxyqknrj4@izsqazgbiehp>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
 <20251114-ath-variant-tbl-v1-2-a9adfc49e3f3@oss.qualcomm.com>
 <b9b4f1bb-45ef-404e-b75e-962e85a557a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9b4f1bb-45ef-404e-b75e-962e85a557a2@kernel.org>
X-Proofpoint-GUID: 5xNjFVA9YXAJZT4vVMHDpTIPill94y7h
X-Authority-Analysis: v=2.4 cv=Rdidyltv c=1 sm=1 tr=0 ts=69170c45 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Nd/jlyMbCgud2ZEcqXkYLA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=iIcxu6EjtSR0Qi8y410A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 5xNjFVA9YXAJZT4vVMHDpTIPill94y7h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA4NyBTYWx0ZWRfX3NeA4ShGMN4i
 qrwlkdz4rSyVRT56LdBwe74PMlqDbbWXK8QVaOYmx8NxuP9vzqzLTtK+/81UZQnf/4c1s101DbZ
 2CHYH3KZq+MHzZo8laoYYGi3Xzaqe+Ju3JBZfqY9Da/ynHtulGcGtu28f2wqelMTDYOh5LSUlfw
 erWpb66AstWdYntUBh7cgRX85ocyqVSLTWtGv5GBr1O2SNHVhPkn51Yo0/mYeybCATlrmQ3H+aE
 UMyb39zNvVI9g4Mz64VaccVqq7XAa1YSkMBtA7z2VHH0jnMBkwrw2ubmcG/Uq3bNs16ZHCnDM7a
 hyy9eYfhW7mACTOiI8hbCliu8Y6nQuYpR8n1SMXwuVZ4iohvCtUfJalq12kxE0R7fZubqOo/hbI
 zA8JVZeV/abHT75AE1NESj6YwVwWFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140087

On Fri, Nov 14, 2025 at 11:47:25AM +0100, Krzysztof Kozlowski wrote:
> On 14/11/2025 11:22, Manivannan Sadhasivam wrote:
> > On devicetree platforms, ath{10k/11k} drivers rely on the presence of the
> > 'qcom,calibration-variant' property to select the correct calibration data
> > for device variants with colliding IDs.
> > 
> > But this property based selection has its own downside that it needs to be
> > added to the devicetree node of the WLAN device, especially for PCI based
> > devices. Currently, the users/vendors are forced to hardcode this property
> > in the PCI device node. If a different device need to be attached to the
> > slot, then the devicetree node also has to be changed. This approach is not
> > scalable and creates a bad user experience.
> > 
> > So deprecate this property from WLAN devicetree nodes and let the drivers
> > do the devicetree model based calibration variant lookup using a static
> > table.
> > 
> > This also warrants removing the property from examples in the binding.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> 
> The problem - visible in one of the examples here - is that one board
> has multiple WiFi chips and they use different calibration-variant
> properties. How do you find the right calibration variant for such case
> based on board machine match?
> 

I suspect the legitimacy of the example here. I don't understand how a single
machine can have same devices with 3 different calibration data.

AFAIU, calibration data is specific to the platform design. And I don't see any
upstream supported devicetree having similar properties.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

