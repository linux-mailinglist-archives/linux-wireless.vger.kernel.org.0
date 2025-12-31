Return-Path: <linux-wireless+bounces-30230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF6ACEBE9D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F20A3042802
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C4320CAE;
	Wed, 31 Dec 2025 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/uBJnT+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q47NQ4Ru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB69320CC2
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182998; cv=none; b=Zcq+TXytx93C+8IjX5vUlBBWixBNKZ8XQVa3+EZCTMvx9juErzOCS9BdHal8oV5wDoc6m2C4zs9eJknQiOBT4JNEnt4aN5XBxXWAlC+eTV7W2HKNi5OAH+j9+G9NjzCwu36Ancbg5EJ4ggfAgi/Xzp5FBdjBCGy3vTOMVLFV+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182998; c=relaxed/simple;
	bh=sCKczhGejw5Oag+FXj0FW00PVZyNXveA4dF3esLudH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRFN0NjRSZuVqXW3EPJoaSArLolCf736pLbNyMHHeYy/AW7T8z8SMyGBqo3Nf4J8GQZwqyT7fuWY8+vY45rlsWZEJ/QjluX12bUIqeqOw7DtQD9kb/dHKpmGsnvIcvHqcKlmAsE77peLahlFGFDF/x4AZeczFUu6qEOwWRGZLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D/uBJnT+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q47NQ4Ru; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUMZXhA2551543
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IOnm9Ff2w1gpsH1R8vKSe+pdwXnYXE8q970eQ6bQ+7A=; b=D/uBJnT+MgFVzrOh
	VcyEuTJ9k3SW65QA/vYvh6jlMZ1FjiJe/chMPajG/6shTRTgPbshQfu6RMD5wH4Y
	kXCh+qVqe3g+qjiF6Y/7a5Mm1jBccR7uZQRDk59rfAbULFYkqUz61qOX24HryXHh
	ix9LHHOliWO+wm1uEYu8RRkTGHHkCAYLLSrOmueK8NGgH3hMkObkRTK+UaLi9gF5
	xAhapq4+qkL5AAmaOUCKOi5UBpTlG24GVzFWKyx1XvK90C+JV0XJDWYuexeOE14B
	Tjy7lh5ZJdKOEq1OTYooRqGU0B17yNgcwShCmiuNKeljUYJoKtTcLfiue1wcOM2U
	fUGfGQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0skm97h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:09:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee07f794fcso42571331cf.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767182994; x=1767787794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IOnm9Ff2w1gpsH1R8vKSe+pdwXnYXE8q970eQ6bQ+7A=;
        b=Q47NQ4RuSPWBk3wzBvmA2T5CebiYPzpqg+pWdlyrYHbySrQ/RNFVYXzRRuTSLPplj2
         3FSiOLLP1bH71XOEgPc6XY3woMYiOj8tUB0ZUxJxHKROAArR0R99xRKyVJy/0h0Kl6iz
         NUSsl8aXzJm+3WQ35GPy2qG1LdKzDRrgz5X6f94DIm5dyXla5iLFt05GlJ1RHb7yabqT
         h4tD4VWpwIJEBHyYOOUt1OkY1KuK725siSttTOI985u4ZHORpduXTKQJub8ntisT+x3q
         j0j7exiu64bEBSg0vQ/d0rWU9KZr1MXCZYCQTTRkhOKX0MZdZkR+316kSnI56LM5qiOZ
         +Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767182994; x=1767787794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOnm9Ff2w1gpsH1R8vKSe+pdwXnYXE8q970eQ6bQ+7A=;
        b=k4bb9bSFnTysRV8d1vpdwFiSUIaEAKoYzsaCWGL4wFFEBnqDgknp8F//rcMRfkBMoA
         nLx5SGG9L2hrAwg6CvQ4vahlQEaZPKYiQtf/lYRyleg3LaTteCe+12qhGtSyvL6p3MGG
         P2MDP/H6TCyulDfjjsjn8A37mKr6XRmPe9COTcnTd2qLaTzLOVSLqP3H4Ix+PPT6bA4e
         4qh7jjzZwJybP27MVDn7SWrFG4nO/oNmcqqZtztNQ6gxocJ0vLcFTY8kL8O894yJD4Lv
         nZwW+iiqzE/fEpACDMI6nHqMRJ6IhjF0Cc8lrCschHdc9Jnu2mWe0woIEzV9ggs1q9rq
         YDAg==
X-Forwarded-Encrypted: i=1; AJvYcCWYSvpwQAYRlQn4Y2m60hPiCWu+SfAO2NsNRy5qurCw57APgGW6YZj0cCF5rnshdn4hBEkHPL3uUe1BQ88Gug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTijXsawLhviw/Zy6iuewIpur8t9f3owpRxvn3ujdjz0+JQHHE
	ACwDrKnmJe8PTJDxKl0OS9y5R+8u4VADY8cS+KkEdNAMiMU1oOSvFVhDv7aADLnuwcVUKbs0lLj
	sKN6+19NdT9S+AjclexFMpnuSmYyZEQc+r1cqBU+Q83pLdjzIQgto7wx9gxDE9kogivrlNA==
X-Gm-Gg: AY/fxX7YAkG4wma1UoWm05EPj4oseIJbkyBezpw+l8+1IO4DqpzoQF3Q5jHZ0syp2Vu
	phz7sJvryZlFOWsYehbtU19GK39Wpk7y9xt+vrAkYD7slkOMzgWT0L1QwopjlpEPWBEwpzTsgbz
	RbJpdxXadoAgulW6maqlsQ6yCuQqWPgikTmxe8kD/cBPtO8TBcgxM05lqjP8C/6sL9kpTMXNdh2
	CLTJlSq625g61exo6hVC5d38rAnBA8Zhj9H/fmAv8XWj7x3NNYXaZ0dcna1AjIdFV2QARrrBXaT
	2gY3GXzG3HqVkGUsZEDouEiDuulXkC6HviMlCnEzpYb6DhvCtKLNoQJT8YRmMVuicFg0ryrCwj4
	8HWCyN9YVxfN9g/Onc1KOl8czFFY0/w2fLaGgbEGUrYG58/M2VJ4hjKaWCCFjWrChqQ==
X-Received: by 2002:a05:622a:1646:b0:4f1:96c5:b592 with SMTP id d75a77b69052e-4f4abdfa25amr414239061cf.10.1767182993975;
        Wed, 31 Dec 2025 04:09:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk5b3tqRN+mM2aHAUILacSKkmjbV8QkOEbDA4Iwmhx4ecguWLY9T4Kw+x6gPy1+6oUic5zVw==
X-Received: by 2002:a05:622a:1646:b0:4f1:96c5:b592 with SMTP id d75a77b69052e-4f4abdfa25amr414238771cf.10.1767182993598;
        Wed, 31 Dec 2025 04:09:53 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f09149sm3924692966b.47.2025.12.31.04.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:09:53 -0800 (PST)
Message-ID: <ab7d6780-4328-4c77-9133-402dd1c4fcaa@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] arm64: dts: qcom: sdm845-db845c: specify power for
 WiFi CH1
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
 <20251231-wcn3990-pwrctl-v1-8-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-8-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNiBTYWx0ZWRfX2ULGACEJ9yn1
 i8WaRidj8MBcMEPZa6Eb+rdfh1KF2jLWEcJm7OIK03qInSapSoGFVEVz6elH5mq54fedjsGK45G
 3FjCtXDz6ZSXJNkNphqWfGObk3VYFxCtL/KWw0sO7XtnwA3xXHx93yVBhKMkxcA4HWwZ1RDEUA/
 3xHJliHqCcbVng6G7UCnxfZQ7hfDfFBBNDYZyI2LXmL20R91oBkO8051pi+kdXtB/pY7sPu0guw
 BPwGfmFUtR/E07oBHPnXdcl7h95uLl07dI7izKmJ7yifAhhLCA7TZS/RjfuU9Rig9+vFY9x71Si
 MvE1QEd+F/1uTjtfQc+dBxj2o9GU04L74dUH7qDtG/yUB0Do/ou5mU8nyu/PaGo06OYpvFT3YhJ
 fBk1WfnXxR8gzwZ8AdsUol2BmKHecQYOJwclevDmtddKM9V0Gs+ynV+B8QqQA+UNM18enYOyk1I
 C10CfrlclGckykhEF3w==
X-Proofpoint-ORIG-GUID: Yyysw-dlMLxNM2EEu6AS_kH1ibS9cIel
X-Proofpoint-GUID: Yyysw-dlMLxNM2EEu6AS_kH1ibS9cIel
X-Authority-Analysis: v=2.4 cv=FJ0WBuos c=1 sm=1 tr=0 ts=69551292 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=DbB6eazJVb8MnLPbLtEA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310106

On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> Specify power supply for the second chain / antenna output of the
> onboard WiFi chip.
> 
> Fixes: 3f72e2d3e682 ("arm64: dts: qcom: Add Dragonboard 845c")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

I don't have schematics nearby, but jfyi downstream doesn't do that

>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index ad283a79bcdb..5118b776a9bb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -379,6 +379,12 @@ vreg_l21a_2p95: ldo21 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l23a_3p3: ldo23 {
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3312000>;

Do we benefit from the 0.012V spread?

(i.e. is there anything else on this rail?)

Konrad

