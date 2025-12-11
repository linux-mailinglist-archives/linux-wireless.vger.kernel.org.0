Return-Path: <linux-wireless+bounces-29677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B334CB6891
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2122F301C084
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAAB3168FC;
	Thu, 11 Dec 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+woqyuD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dE5UXdQ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2653176E3
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471447; cv=none; b=MiN/LhoCLDUllemcBRX3diz1DW/r+Ps+y8iP08OY0Y2PKsdbH4BGqS7M+G9nkTWOrx58EvDjFAenLfBm/Rq2UbmCkQ4KrWFsJ2G5D6/n4LjKwT8ZZjQmrN8tq8HapHJMUXWcxjN2DyFVFbYzeDCx+mKjponNq/gjtpL6kxdBEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471447; c=relaxed/simple;
	bh=OTyBKu42+YrTjO99BWnw0fajBinNrpyZL59fGzv9RF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SolaM4pgbgd1FJp2reFEzAXV/LhBQ/2GbH07gjabpnxi5FbNh1zJzx28mC/CBhRbFxgubJi27WHj2Op3KExdVWR8+ko9pDSJ5DnWGB+LZ/aW0wq1nMAEeOYsYtyCbJrKciwxCRwwyZGylPhaP+vyqE22lPG5lCt6rZ9o5eTRQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d+woqyuD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dE5UXdQ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBGVjk22372568
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 16:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tztu8MTIBXFG4TzKiJ9hLxKbuxymdp4FTScUcSbkKO0=; b=d+woqyuDaG3emg73
	+uT0ANtO8v3vQZXZid38Vrp4QByPcvB0+x3iL/T0XeV5lF6BdkCoY8eUj9axfr2C
	QUzolQ5FtjX83Iaj+JJE5Ee0R3yTNoJ00qp4ZQBN4FZ0q5+kBwM3hWIZjwN1GFwU
	HijNwoZluvuGLeRmOUCZBWN7F2qVW04dVeDwGr46Qu4WjZqcJG9eEppvAutqsyoP
	yvo1xXkSQ4ERRzya07fArP6Uwdb4scIi0OHn8nfceseG+0vxfi/BV4kdraiqzF4e
	d7Q4bEgE8RViwfdQsZWyoKja1Hm0DOqWSpI3LPjx9/se2N0fg33SeQnq08P3P6Bn
	yt9Uwg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b01j8g10h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 16:44:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7dd05696910so289663b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 08:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765471443; x=1766076243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tztu8MTIBXFG4TzKiJ9hLxKbuxymdp4FTScUcSbkKO0=;
        b=dE5UXdQ0eK+egDRIx86MhooNY+t6FISFc32SuRVGZJxqzzzYEjZhlI8jj6PU6w+WoK
         jZ0g2UnUAY01x85uBUYSwrWVt1AyYX2qXR4utMKSkj0ZStkd22lBGDM4VqwH8+BmQ6TJ
         8pCQ5kFVcxkjbzQ7LXPiyarCMKPaidNzrK8gFyb1qpPA6mJeXEiEcc+IaiudMARiGKvK
         qEanOr0JONDQGM1A6CPxWgjYNfvDaPlPUQQs7tv4CLflZ4ST4Rg/A62SffKrLa05xsVd
         0waYnpS+PByodcBWx3ItcHNMpLiK0lWlOhmCmjFvgRrSskXuKAXTKoFPAHfp/nL03eGE
         dA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765471443; x=1766076243;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tztu8MTIBXFG4TzKiJ9hLxKbuxymdp4FTScUcSbkKO0=;
        b=vZE2n4HY1u4v8FY95m2DSmhjgFEWPdDgy8NjuJEc11kyF17eXo9b0q+4xIfKWTWHIL
         +S4tiuYhi1xlJS5Ry3f5pc/y3gTuzcIPHYWOJIyq6gTmI80M1JEZCwu7Has4Z8FN7zSI
         3a5m8Th1NPDt6swSBfacco2XnYj+LXssuMvihCBB9x1m0eJ3KgLp11ogu62TrEL+uK6L
         i2zbys4dBabgepd+fRuPxm44KVp7YRba4UlDShfmesWPC5uT+QnZEKPiC/ruXcCGvIpV
         1XO4ICgsr79FN1eTvKB7F2MZ0dWq/lnBqGqFF8tCU4EYGvvunhVoYK26eBuC9mQaIhto
         M1wA==
X-Forwarded-Encrypted: i=1; AJvYcCVIs9ogPBG0v4shOUyn6B9+cU24X7+cg8wDG5ezoXJwaBAfySvGhxmyWThQOoSa0IwgymwoUYaUrB/r5XmbgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMOULDmEw8Pc3sDnDxQeHPqwL2rXtoukqHRY1ybWMAfDlCi8nH
	c9p+fLfnB69BwbphLZQx5bLjlqhEhIyH6h8m/77voDZ15SISaXPes8puFohHYmVXVyhl9j3x56E
	sjlkug8bOoZQ72VocgB1VVDmT9n7KheTmstuUaadHiKD1uVZrjLx+JTJwacwopoedzb1aTg==
X-Gm-Gg: AY/fxX7i2mwW/9JKmVeWVU10Zicjgp3kXan2HdQRxOEAG8QysoAJzXmyE6upLVEMq+q
	wGiG1BlWUJNcjU1EXmiD4/utFtRUEu2jirY0pdcfl4NOg9xKFvYwUt2RMzwBOIr0gw4fzXN3Kst
	wPVpDiIczG6ezw9XvTuCK6qKMlmfhv/zYsI8Pe0S386SbnyR4l0rtggB66Zb27FoVtgCC73GknK
	s+hPIoNZ9v2DWcboIvc1Qi/qt5GhFu5AaRLW9LRMwjh8oGfgy9PxNWxZYrbWJI0M1EelAPB+SkV
	4jb3N/pMvdmCfOWsAHvpiu3Wbxust0izm84A9LrTmDSrGkSgTELu62H4ym2K6SjikLXQWSNgecu
	bYDmcDwG8k2vjeHd3/EqLlbJ86i+shHBZFDwi7VtazsCkWzesxelw2AR93GsDRNCU4lNFJA==
X-Received: by 2002:a05:7022:503:b0:11b:9386:a3cb with SMTP id a92af1059eb24-11f296d3091mr4753898c88.44.1765471443365;
        Thu, 11 Dec 2025 08:44:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgdzo6qnoe5tg4DwQZAjSr2PiHeHaStQv2xagD5QxoaxfQkFgfxaYLW5CJjRkYp+TPKHhc3w==
X-Received: by 2002:a05:7022:503:b0:11b:9386:a3cb with SMTP id a92af1059eb24-11f296d3091mr4753862c88.44.1765471442731;
        Thu, 11 Dec 2025 08:44:02 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ff110sm10048865c88.10.2025.12.11.08.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 08:44:02 -0800 (PST)
Message-ID: <f60bc80d-a947-4083-9e14-000a937de412@oss.qualcomm.com>
Date: Thu, 11 Dec 2025 08:44:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current 2/2] dt-bindings: net: wireless: ath11k-pci:
 deprecate 'firmware-name' property
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
 <20251204071100.970518-3-miaoqing.pan@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251204071100.970518-3-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BxVtS_CuurX8TWEzdVUksWsLKqODUoOF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzMCBTYWx0ZWRfXwQJlnK34OUgr
 IQ3EGV8ue9Wb8wM9+F7lUpOM2xXVak5S4ze5Y9Q/frvb6sK4g6X2CTtyVoYzQmDzQ7HviF8EQFH
 nWtFLzFPz3W90ujpBR54AuAnFMN3jlkQ5zvqCk1TA3wwITHjn7IDQnhpIWslbYf5RvCvVSTgfuZ
 MO+MZZz1kFfy11Q9luK+Qib58t7qPfyhHiX8IRi9HJBprF5LkgzvsCOQIyQXH3Uid0Oi++HLGDz
 4NfqDnhOO065Nw5rVe30rGlpLX6Mlxocco3xD6tI3FFUvG7gQmoTYrEgdqFkDCBS7env3OAlCKI
 DuuUz36MFSO7rhf93zZHpRy6g+K34rBl6iyo7XBBFd2q3OA8WVv2sd4CpKYbD2DtfDtLn7r5r/F
 pbJFl+L55Dq5z/lspMcc7fzOYID08w==
X-Proofpoint-ORIG-GUID: BxVtS_CuurX8TWEzdVUksWsLKqODUoOF
X-Authority-Analysis: v=2.4 cv=MuxfKmae c=1 sm=1 tr=0 ts=693af4d4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nPuZL2kYLRZDsrc0ShUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512110130

On 12/3/2025 11:11 PM, Miaoqing Pan wrote:
> The firmware-name property was introduced to allow end-users and
> integrators to select usecase specific firmware for the WCN6855.
> However, specifying firmware for an M.2 WLAN module in the Device
> Tree is not appropriate. Instead, this functionality will be handled
> within the ath11k driver.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
> index e34d42a30192..0162e365798b 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
> @@ -37,6 +37,7 @@ properties:
>  
>    firmware-name:
>      maxItems: 1
> +    deprecated: true
>      description:
>        If present, a board or platform specific string used to lookup
>        usecase-specific firmware files for the device.

The driver patch completely removes support for this, so is this really
considered deprecated? Or should this actually be considered obsolete and
completely removed?

Do any DTS files actually reference this?

/jeff

