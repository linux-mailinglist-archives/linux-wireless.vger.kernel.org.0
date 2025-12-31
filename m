Return-Path: <linux-wireless+bounces-30232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0037CEBED3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 13:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D1933026284
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D22FD1C1;
	Wed, 31 Dec 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RMabYfAV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W7dXQZHv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9B28725A
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183398; cv=none; b=nKch+mF4GoBHQLrHCm2sSYq00eCCMFKVupXx2b+D2j8UtxqW0HkWhx3iyxWfs9qTOvWotekBfh5RyTT//dghoXMvdKs9+uiGmac5TXAzBVccdESIQw130SvzIV5/IM2n5ihXFqP+qNelwU3RMM3C61sYpe7Nyz9CikcMdPPdmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183398; c=relaxed/simple;
	bh=MR3AmbLZ5anPbDIh6appxGPnZYKMJT7zJ1pCI1xBgTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrmBUTkYbzSbfIv87vvlXKZLfrFe4stv6eBOcIO46XpF74ATbRMgAvq8qozKUY+8d/faAO2L9Gw4Qe7pDs/qnvnKAg/YuagJvKCd1oQ5sNwiyd6O6QAUya2/kHcNf5moTc+Osf1nitkCeFFMEc5FZdFBhkhC4UqQ1YnoJgQMlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RMabYfAV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W7dXQZHv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV1w9xC3018711
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FmHPQhUPWUftI1dUKYWlCg7G20zAEVRZRn28G5U5nz4=; b=RMabYfAVrgVgQTB5
	9jkiNcMhmfzvt1CSh7z1Axyb6mW+0bqqcmtggZmOWYa/utb+nWBPPsiZ7xcHC327
	XbHmlAJ/MnA2N+K2RSc1OLJbAcdzUnqnNtlhsKJmRdQZohVdBVlQLeYG7JsOQetd
	gFmqFGsn0Haa09YG2izW2il4W5EWV16fZ0OQVE05W2INkTTk8zhl5nKDVWEn2TCv
	pDOdCFr9gHNXeoY7OiC0kN/qXK4n99UXuQed2k/0MHBkag76J9zPouNUtPpjgMnH
	N/ckmQpVkhrT+Ny1VlqviW1zz93M7GiMRg9ZadfFmFxABY+Ylh1G5fuETJJg4LlX
	SvZk/w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0vdm9rf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:16:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ede0bd2154so34276561cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183395; x=1767788195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmHPQhUPWUftI1dUKYWlCg7G20zAEVRZRn28G5U5nz4=;
        b=W7dXQZHvmYzBFuZF4NQ5uhFsFkvCPaIbPzbRF7J0CDUoMKmRvfbQp0oYnFI5OxXZpw
         i7rePM67lZfoLB00AVtQaBnkqFkDsXhIG5x9OlYxrpS4SF01HixeWTID2PBipPOdf7EJ
         MMivgsoCKKXaX0eHaEDGre+Z/QqeEHf+6ptQsZXqszdKbX8DXS85MMZIqL1JAUUpdR7Y
         u39Ac53l/3Dp2SETqT2dREFNwkaUgLRZ6gMcjRE6OtgXwsuQbmt21QjG4mev2qreuDT/
         lVQMIwpgv3SM+EC68TcJKPMj+LqJZ607miNgeIUGQ1gyb9f5J3yuDipfleWyfYbY39/o
         L2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183395; x=1767788195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmHPQhUPWUftI1dUKYWlCg7G20zAEVRZRn28G5U5nz4=;
        b=dif3+yUaA+gDrClsy09wPNWRAQQYe7d+uRdtJJgFJEuMbZ6qjrG8W++jWNX4zdF8px
         DX+1PQGHBAxkp+O7blc44ns+gRy//POvIBgOvxZk/cJtUXmSft8w44S4xGfHWQ81eo3j
         8UQIy6Lb8u0QC1DI3IdPYMnS2R/YnbBHI3MlZcSgFgxWhpgiYKrzaV9msI7YKhL7eaJP
         K4HAqXBpTUs/tTTKPpAcreYKgInyQkeg69mrfe7E16nVEx5+8tlAyt79xW0dQbqvCDN4
         90SM225T5wzSv76o9gZ1Uzdqc9OrsvjrJUJ38vFeTjFcreps7iMmgPjXlPbxBLXkulRG
         ucJg==
X-Forwarded-Encrypted: i=1; AJvYcCU2FdLk9nmGZkGtExFxvnFYDIg/y9Gkv/uh5xZ+5ykSp+3lkGVvU8wNVLiev1oyQOVyolajQWRr3xxCaVHlQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMo7YY2xzO1iJmCkNS6SRXI+B0tz5xAslcbZSq42UmuoJaltf
	imeXPOMMmAKR4wwR2djaTpoQ9b9sFteZDtCTEQwIGkxpNXORNEzdvQQaBUtQuUBxVC66FAs/yWl
	e1dBunBEykcT358AT5v7PMEu6DBV1uvP8uVt93CLztcvPEz+XWJZyIidf/kEy+RoO2E/mIQ==
X-Gm-Gg: AY/fxX430WwoKtUPsYF3djEvNJj5JWzrnHJRsqBUvaITXoow/nvQJD5PXIBrKQD6dVt
	VOo9bcyJW4OrisjwKGKXAtHd5sfHzmrBNvQZUBPAiw3Jm6nkgA7jYDD+CTmSSfeKVd1ObFqp/B0
	V8WKCLBJi4dwVVCM1r/uFiQDe5ygvpAmFTz5uiiiUcb5hFvCu9s0iCtraLy1LwFuVjUBPgy6KVz
	AzMezmZRJtOrGMYPWRiimWpyoaxZzrnkLIYErTuhiSSZPIWoIsq3s7Qk2yiuJ45rY9hif2czAzv
	FXzcD/bUJ7Wme2LmnSqg6ZaWs8WIDPwblXBefdPLXxZhTCS+nSw+YxOtS2ODeZC1ta7peQi1jpz
	4gLTMZoEz0RJiaSNA8vMKNpxXupmrmo2bJNEq+XCslUMrrkywo5GPQa8XIY7M9MiXVA==
X-Received: by 2002:ac8:5a46:0:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4f4abce1a3cmr428476701cf.1.1767183395142;
        Wed, 31 Dec 2025 04:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Pfwh+egtxUj/QdUbBygykdOyCe3AD9kpBY9v2ldni3kiCg/sIQlD059WEMSwkll6E6T/RQ==
X-Received: by 2002:ac8:5a46:0:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4f4abce1a3cmr428476301cf.1.1767183394596;
        Wed, 31 Dec 2025 04:16:34 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdf3sm3954791866b.12.2025.12.31.04.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:16:34 -0800 (PST)
Message-ID: <59f3db15-77f1-42eb-97e1-31129fdf363d@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:16:30 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dfONHHXe c=1 sm=1 tr=0 ts=69551424 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=83yv27ILqWWRH8MFNrwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfXwGMPg5BJaYWo
 ihi1FgmfDSRTbYGNvO2EsOUnW4ss8+hCzBZvVw8YykEI7qD/MSUgFEvOpwkwFhayN9MOPxkWN7L
 VRPnyxCdo5MtY+bl7fmTXYXFyKkbJfOeJ2MwBg217YqBGlPHhmagxosT2jFLDit9dMfsrEdnJ+J
 LooJ413pxYTIkDk7ong5Pb3jAbkOVjU5Cn5McNLxfXzkfiEZr38VA1G8Ozo/D65NErmvyTjoe+T
 1rR1z2m3jKfz1nMuEXr8Cvhd/USRyw5ourftCzi7J8VoG0i7efZ+l8rysKBaNfrNNSP00vKnr3z
 HgWyae3ZZ9Nog7NPjUmOHE3UMCq47t4/9+iBaC1Ikhf21vJ2iKvN5q0xdts/5kMAIueC14xP11o
 FkFIUXtqVVQ/XXVdxoOheyUgajmPPOJne3CRNS2uxy3Ufld+2mb6S5zvHcWUvTP6agqqpS312aD
 RPzcfxANaYlh6FHqcLQ==
X-Proofpoint-GUID: uDZsSBTFoUTVOBoWxJ9-XDyFdL08Dbix
X-Proofpoint-ORIG-GUID: uDZsSBTFoUTVOBoWxJ9-XDyFdL08Dbix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> Properly describe the PMU present as a part of the onboard WCN3998
> WiFi/BT chip. Enable Bluetooth part of the chip too.

[...]

> +	wcn3998-pmu {
> +		compatible = "qcom,wcn3998-pmu";
> +
> +		pinctrl-0 = <&sw_ctrl_default>;
> +		pinctrl-names = "default";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrfa1p3-supply = <&vreg_l2c_1p3>;
> +		vddch0-supply = <&vreg_l11c_3p3>;
> +		vddch1-supply = <&vreg_l10c_3p3>;

Again, please double-check - I see UFS VCC is on this line too and I
would guesstimate that antenna supplies may be separate

Konrad

