Return-Path: <linux-wireless+bounces-30239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71568CEC394
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 17:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F463300FFBC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68436281358;
	Wed, 31 Dec 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y56WiDHy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R7hDBfOX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE5328031D
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767198002; cv=none; b=ukY3DiCsvUeVg7HQEkgLynP3MyZ8azhFMtjrLRQlxWoIcWIuk8vkFEUZK5HN9YnI2/YIr/BIm5WZ2SuoOoj6I/AmZBfSna7IH/dXsZrOWYBEO9zedbXBeLr6SLgDFOOBMSHV58aEQEtD893tBvWXCIuEFf0CMsFLsfKBnwhvgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767198002; c=relaxed/simple;
	bh=TjWyl/IKuzTstBsl5AwfCxuvTaP7c1/nmqk17o5zekE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO14jvOfxdxd3bWG3KBMiKfC0sj4ohUKVVU+xwhakfjyYTx/ToYeMk7PBGQTL7GuVyfNfDUHhSGnpgAOXW21dbZqdOSAY9aGToQVUXvyCsbQCVryRtKk0dE3K/tamqBJ3WADu47r/kbqv52OKXUPnOZb1kVzVVzBMLb0+dTuVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y56WiDHy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R7hDBfOX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BVFSjd62990605
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=68Auck60GyYj13jsQrKu1d0p
	myBuLZkKakUCDN+kvEQ=; b=Y56WiDHy7zvU0OWvNzDvl3lFHBxgcjngMAAiMLl1
	+0lnLb+eNZ0BAQ+EAwqgX3EBHGSZnAKY4yPPdKbQxB/Mlu8vJ94/SJwlimPu0khg
	1R0TOG82MaUTqqWMyrUnGtLDUI5BtEn1DjeG8gVTs2XpcxtVrWi5HKPvq8ogxbz7
	8hxan3I7pKUMR2SUGZk14S1YgMCGYEuahfTmFnCTOgkCiXRW+q1K4ufkf4LonRUI
	K9hEUpmLOIT7lBgpFoJx5to/ei9oYHx14W9+lH28qlfG2UgC2zGPOsV3ISBsjBBR
	80A7/vyQ1UEH8qapElypV71/OBFAHyjDjPZtytge8VRmZA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0vdmpf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:19:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edad69b4e8so230545071cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 08:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767197999; x=1767802799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=68Auck60GyYj13jsQrKu1d0pmyBuLZkKakUCDN+kvEQ=;
        b=R7hDBfOXE2gvli/DdVlNgn0McHMQt4YegVEZcgYxoP/kN8ExoktUGZUtN/17YxQr6D
         479GnonL4Z63HTE2bNYOae1MN1/CXW5GujkR3i4R/FyMsSts8nC5jkKQ+rRDubS0MMwY
         gyRk1LaubJgRbUTwVRWRfrE9uxfF7TSb69qq0CxK7HLBirPtbkqjFBQvsn+DkwD1AKm5
         ozDO18Mx/TO9D7+3RVZeYVsRdO4+pcgmVSJGxAg9lTXcqIgWewb853UGGxK/WtOlFYHL
         sG2qyaKiCMzd4mK6m0pRx6Tb4EJdkdYQ1ttuNkPefq+21vpLGi4j9LZpukObJZYRYvLQ
         NDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767197999; x=1767802799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68Auck60GyYj13jsQrKu1d0pmyBuLZkKakUCDN+kvEQ=;
        b=d81O3luvYpEC5Bf/OCEVP6dnlOv4A1SEu2G4G9WP5srKmM3WpYobEQznBKf/bJsWXU
         k9LkhNe/WKuO52Z2qXe8GV+NrwzWZ6T8SNaD83TWMkSlpKqp7L7vxpu567wYzc4txmqP
         OfJFcI7oGmo3V0FwKfupapUwiTAPT8VQWFAjOyzIjCI+ghKzCEY6hx2CmT8G0JBAFEm0
         fOMRATCOIdXJznlqNzZ2xYQBK4wvQdEGVWIViar+87IYYLQXi03rT5r/NxrBL9Qd6l7H
         /SqzUowDoCaZBm/jIKly70jtmsMEJhtsVqGf6FHpaEVPeCd4mPlGlkT9e49AXuKC5ksz
         G5qw==
X-Forwarded-Encrypted: i=1; AJvYcCX41do5jxb7smgV5vcOSO1uFKHXU9bXXWfVIdY5jXgH1Hro19EON8jtyRRus2juMjfzJEmuElLL4LvMQTrg5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuB9agUNMPGqSnbzdM4J0xBAyQ8OLMjE0FxcjIK7PXBftRGSPc
	uC+Kf3C5aiAGTvlUbSoyaFYvctLzngPhSymrQujukZLUBZVaswY6U0r+iynxcq82xyYGmZygSx1
	skFTl6PKLqf1TyHHKyCkQHSLEypl3p3on64AwdYjBxOIyDkHwdOCilmZu8BJyaWfSWeJksw==
X-Gm-Gg: AY/fxX5g6CYzE1WyKH+eo/vRam3vO/Bm9fzM8p6ApGIsdAypAtTS/654i7l99cmEG6j
	MxEaQakq7y9xGQClO2iLpPHJFJGhwaDtF7/AyrYcjD9MLJRPefiKO816gthbGQ/2LkMmeIoF6BU
	uaaQyogdtCNy0bM7ugykAcHuy3CW0DTPzn5qfyRY7PXrilPBmMmVnP03uITBSo9FmAZinL2tFCE
	x+jOxhcuiC2YxacHlithhB5mvJ2ehVb2URAYdCdp4Cddd/E7SHZ7S2IXqY+8c6+GZpEJNdgBvVo
	YN5ptsY7A63oFl1MryxbWq00wiDRAvcU6SxhYeoiWJsjXVTGKJR2Vb79ub7e2MunTVqi99dwsbT
	K4357TZIT2G3YR4zx13GZxiJy3x26Ly9m9McJETMLalR7h+1s+U3yd42Bu5dldXAjYlOhnJqDcb
	6p5K9ktI/gMV9MBAwVy6UFwRY=
X-Received: by 2002:a05:622a:510:b0:4f1:c1d5:e37e with SMTP id d75a77b69052e-4f35f2b5da0mr569785971cf.0.1767197998962;
        Wed, 31 Dec 2025 08:19:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTdCBy+pVg+IDVoeUL7VU7D/QmJWesvdotmIF1p1sLqgL4Z+uXs6v2Khhhh/si8HOFeLlgxQ==
X-Received: by 2002:a05:622a:510:b0:4f1:c1d5:e37e with SMTP id d75a77b69052e-4f35f2b5da0mr569785601cf.0.1767197998547;
        Wed, 31 Dec 2025 08:19:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10855511e87.86.2025.12.31.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 08:19:57 -0800 (PST)
Date: Wed, 31 Dec 2025 18:19:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 08/14] arm64: dts: qcom: sdm845-db845c: specify power for
 WiFi CH1
Message-ID: <brzdqbu3uiy3gd5a2uyzcgx24wvuhjrrs3fs5b4qbnj5jvmra3@rfbiy5kgwlbn>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-8-1ff4d6028ad5@oss.qualcomm.com>
 <ab7d6780-4328-4c77-9133-402dd1c4fcaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7d6780-4328-4c77-9133-402dd1c4fcaa@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dfONHHXe c=1 sm=1 tr=0 ts=69554d2f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VsWXYa84w75D6ua-j4wA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDE0MyBTYWx0ZWRfX+f6u8zQZ/RQS
 8uZw+m4W789KHgW4qsIyaBOqc/4oC9mLSqlLc71S7d9o42lfY9jd/QGHua4u+ZoPpkY4uOwTa/V
 HirT9O6kvjfu57tKavYCfc1f45hn8SwlMJKmGy1P8ceSV7ce6ZVcrBWLbBXY/w2ff/m+E0NsP2t
 N1VkqeRILrMuaQU6p02WYWSS1kMkAWsz3c0EOZZh1IPoJ6/HBWjOqx5Q49p6nCzWf12lc6F83s8
 7g8g5vQoGfcCJhOCi+SNVsfscrieXsEZ2DsrMqxdmYaiGEwINlDHEJHXVhr58vEmc4agkSZNq/6
 8sLWkrapiHkxbQ8oeAF9NqKdZ1ifsE92oNGiNVoe3dpM03F8IvL0fdMe66piAFbilCITv6s8v/c
 VD9DCdBrJvDOX0tyo+vyC3Ae5A17dpbV/4Zyknb68WQpRAgchme+zmgy8Y3LFXR2HLHMQj5TzH5
 gxzdQl4PTNVVXwordqg==
X-Proofpoint-GUID: p3KnXWq4cuhcbGIVL0edeGR52gWwQCmK
X-Proofpoint-ORIG-GUID: p3KnXWq4cuhcbGIVL0edeGR52gWwQCmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310143

On Wed, Dec 31, 2025 at 01:09:49PM +0100, Konrad Dybcio wrote:
> On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> > Specify power supply for the second chain / antenna output of the
> > onboard WiFi chip.
> > 
> > Fixes: 3f72e2d3e682 ("arm64: dts: qcom: Add Dragonboard 845c")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> I don't have schematics nearby, but jfyi downstream doesn't do that

I checked in the schematics, it is L23A.

> 
> >  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > index ad283a79bcdb..5118b776a9bb 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> > @@ -379,6 +379,12 @@ vreg_l21a_2p95: ldo21 {
> >  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> >  		};
> >  
> > +		vreg_l23a_3p3: ldo23 {
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3312000>;
> 
> Do we benefit from the 0.012V spread?
> 
> (i.e. is there anything else on this rail?)

I must admt jere, I just copied defition of the ch0 regulator. I think,
they should be the same.

> 
> Konrad

-- 
With best wishes
Dmitry

