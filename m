Return-Path: <linux-wireless+bounces-28841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7150C4DF1C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 13:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49361883E58
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDFA32470E;
	Tue, 11 Nov 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OQfOSgYR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isCtypYe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D581324702
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865223; cv=none; b=qOxx4Pxp8xM/JfL3vu3Rc8WMIZ2hj9Ciz67b+YXQEX9qMHg2OB+pWBk261S1gOcVG/vdtSGxXvZkia8LQP8Dn0S9eYtbz/1oYqie7fN0DXvhvBD8sPxG5z7krmyTUmWPulgyJChvb4hJrQ3OTjF4jfJG5lBU+f7zSEAnXcFQzec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865223; c=relaxed/simple;
	bh=vI2c24xcDfLO+jj774i6XGCsjUpNaRMZS3K8xPM2Qr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmXSzWEU3Cf/h+6TbI6W73Edu0Jkp6vOSw/frobzT4sbOkjZv+0Q2N1/6OMl+47ZmQTLq+khBHNcypHC/Xjx7pgluH4zqWP+oxcW4eQ3RoepBBlweqyDUyq0jIkwH290EuJz035fiNY39xoVAlrkiuwrptty3EofyLZ5tvcxzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OQfOSgYR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isCtypYe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGZXS1937378
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 12:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gcgrCPztTJBR65GQBdHRM8vG
	IBP891DcZKanjQPvZlk=; b=OQfOSgYRI409fge3xzAPl1zyGh1B5qggKlE8dJ9t
	7tGU0Iy6M3IpsQ7petXXseFGlD8E2Fjzu1/UXXq1xmotBXJ5PEtsxTlwh+OpV69g
	Jd2CqZlRGXOD85TNRmKFGa6jgJYlo4dTgpQzM0kN51g6l01LlZbs9nJgpmTbTEOz
	oYFhm6zy30mLObmBJyMilSLomeqaFxxlToA2AzNdqKBQSei/1kKkOr1TJHhaQZNk
	E9It9O4+VrxAYgj151rDfZvzTmVsj+kMyPO+vGzD7/jnRhEGQRwS4bIvJnM71qtB
	2AZsIUQWQt319t/kgHlprzALrj7ARmEAacxX0voP7QALMg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abwtj9dxe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 12:47:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed782d4c7dso96878161cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 04:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762865220; x=1763470020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcgrCPztTJBR65GQBdHRM8vGIBP891DcZKanjQPvZlk=;
        b=isCtypYewDqx3Xqp1Bie+YA2n4Eyke+4xOIX/aZFBsD3gA2z4Wk4IF9y5QCwDaLbis
         UGU4ja2rWyGTu/6AHSU6wfIiOiy49fgQwZzW0kswmv+LIgHNgR02BRX1cSAzSyZqSLsU
         72C/z79D8CbBbOBaVbtj71iYPW5eAhH3Mbajr63n34e9xvRDY7PAaE68vMmV3VJ64edK
         UuswBH/pW5E91NcDS2IX9j9qFXVofF6ZrIKCoD13f83xhWo00FIX/aIoSgaOkG9GoVzy
         uFb1vNMLvk5CX2A2GVttLGMionkbk6q5l25JZaafK4DyjtQr7velDN8kYt87Gss3V+D8
         JS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865220; x=1763470020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcgrCPztTJBR65GQBdHRM8vGIBP891DcZKanjQPvZlk=;
        b=u8tGTYF9eJWzLtCJRaVPRFGPPTcMIMbBn2uHd/Lg8WrLcdyYW9pkvWjfynV7tOc8vA
         bbvL6LlzlU1ULPCjH4nIiOQTeYro5Z3BRIEhFj9fOC2uwjIlrmv9m+nkaJh7elfJlAGH
         lgxsauWiw0AwcszGBEmkItLK0ziyaE/OB1XjxPJj+gSpLAGZ1pmTYVZBnZjLKTfF6SAg
         YDgt3dx6TBkgqCvAVFaCXnGwkJRo6W3JRD7XqG32icf+tKqU7r0gaM9D8JlnCLrzRJPD
         A5bXMNzlFSTg9okyl2x/M9khaiYbQt0c5F0YarZZdbF9hX/hxJFuBOxJZquNRXGE4Fyw
         xBOA==
X-Forwarded-Encrypted: i=1; AJvYcCXhMh1nplOhJjWHZr4OfLfMvIHlzPQ2KxXUMOKoZHIcF1huV+7Cchnw8qnt0viN2ERyL75Q2Se3jmUKnQrxEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyGeQrKpc9US0PNyG1LJFX4i/NZ0O+vR/sJRhtyjNky4+sV6x
	IrOXW9+9q+8RP9DwEkr2p5EUHpO5RwOvmMN6Z9PGCNR9uIQRF9db37ARA22H+NdFqDAfjR6jmdw
	N51sjRBmIRkWzvRrsPI/NQLO/hzI832IqFcdiz6LD/xt+2hTwfrKGx78UBwxOcL1+ghdfAA==
X-Gm-Gg: ASbGncua2uLhgKNSTQCEXc+ZeidQsTYh6fW/mOWMhwKsIMuWCpWIAl5J0sreiJKD+8f
	cDX2xjA6KS4tCaYpYNsEmw9ZxluwlHOQriVqECAu61GYNow6ZtJZOhhDZ4rxCk1lmNDaae18sse
	WxAv6PBQ/MG7paujchy1538vYJYr/v9/O7oEO5Ba100chAdJbIFx99yP/GvWNg4EgJG2ZG8YmU9
	NqiLuK+H+B3rGimNChr4ZCZxO8x6Km0jF/aLWblplytk/vZFkYFACb8vrBBUj3eVnYWA6iM2sm6
	Gp9aY5NpoOOMfnqUvOnjnsJ7Li5qkNffekn23C7XI6Ci5QjJiPrXrMNY09VQhUwuEcHUMpcNep3
	zTqrPAJPpeyQvFu1jBSXayw8q5LbjTE1VwmPo4pkp2EDEDOeZ4Ts0a0Gr7Bdzh7RgBLFy4u6ENJ
	cYqe3Z3GKtjNu7
X-Received: by 2002:a05:622a:14cf:b0:4ed:5f45:448a with SMTP id d75a77b69052e-4eda4e8ca02mr155999601cf.6.1762865219502;
        Tue, 11 Nov 2025 04:46:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhAlncYp5HpdTxD1HrQnjF1b0//yHkzKS+jDNKrjtjAklFMPHNI+T7aD4cdfUGmuDLd6rdcg==
X-Received: by 2002:a05:622a:14cf:b0:4ed:5f45:448a with SMTP id d75a77b69052e-4eda4e8ca02mr155999401cf.6.1762865219022;
        Tue, 11 Nov 2025 04:46:59 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a39eb32sm5013667e87.82.2025.11.11.04.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:46:58 -0800 (PST)
Date: Tue, 11 Nov 2025 14:46:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Selvaraj <foss@joelselvaraj.com>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: xiaomi-beryllium: Add
 firmware-name qualifier to WiFi node
Message-ID: <wxvtfyfdso3ngqvnhvryeo2w6udoolfp46smv2r3qny2cl7n4o@iawxfnj7qtrw>
References: <20251111-xiaomi-beryllium-firmware-v1-0-836b9c51ad86@ixit.cz>
 <20251111-xiaomi-beryllium-firmware-v1-2-836b9c51ad86@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-xiaomi-beryllium-firmware-v1-2-836b9c51ad86@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwMiBTYWx0ZWRfXzUfHB1yKikLs
 H1T+5bNqItHCq5DKDeQ+haS853ShZ2LE9V2J/2zM11djR1PfUPujg+nQFeZ5Wcj43lxGBDCUlSq
 0kYb3IGggbZHgv6yTgOtNSHkT/NXavzaxE9gLRPpbeU7StxfSisHty6qsJnnYbGJ+Ok5cE64sl0
 oS3cdSFOVY+0jd0+D0wV3hKpxiGz4+5PIm9xnUXImPcF5LC1Uw3gnA35/2MliyDqB735sqrBdzr
 FVATmH2FIioIyFGCQx7YlGSfMX1pBGlAVX/zpwIDtft3YBQ0iBsiO+jkl8Ylwg0/hXLEtm1dm/a
 uxE10xrRCE8LKPxSr5konvwDGpfdN7dRegj6XU8tsYKofas0FuWU9ZeBoclSQmvCNVO0jILJ0Cv
 +TumqohypjTvpRNXhSW75PBtaJOnhw==
X-Proofpoint-GUID: R8vERXDR-amP7dHpHI_lWmGd4omxVmky
X-Proofpoint-ORIG-GUID: R8vERXDR-amP7dHpHI_lWmGd4omxVmky
X-Authority-Analysis: v=2.4 cv=UI3Q3Sfy c=1 sm=1 tr=0 ts=69133044 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qG9Bp93c0gXLeqlDJoQA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110102

On Tue, Nov 11, 2025 at 01:34:23PM +0100, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Add firmware-name property to the WiFi device tree node to specify
> board-specific lookup directory.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index 785006a15e979..9b0b0446f4ad3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -631,6 +631,8 @@ &wcd9340 {
>  &wifi {
>  	status = "okay";
>  
> +	firmware-name "sdm845/Xiaomi/beryllium";

This wasn't build-tested

> +
>  	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
>  	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
>  	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

