Return-Path: <linux-wireless+bounces-30233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5388CEBEE0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 13:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03CF530019DC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214B230FC3D;
	Wed, 31 Dec 2025 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YStJLcQ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqeetFvo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E32C325C
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183475; cv=none; b=Y2H6Z5eb68R7ocbEIh7Y/FPttcKyK3qK5yFOWEX3ghmaUQOd8GlCmQeU2cDDA4Fy/q481Uj4MSe2LxFa3jk2x2MX6CNRL9j6OpmPF7eBSFEYRy7jQHM87ra9u1FZFpbJKvhhC7OOuyCItCqCEW+HhBgSYEW6M0qbRzvZn/tmggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183475; c=relaxed/simple;
	bh=gcWjQ0ei8NJ5xBZ0hZlXZvs27R2RGWslCP9YD3TTtLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/knQO+TYDjKjD4cfgQZvKWSDq34mcxQMWWdP8uTH4vHV5DaPd2SJ99DM3kmL3MzSt8fJz0hCedhIuVWebKl9S4zs+KgKz88f3uG90i8G0Tr7VUOSmTqHlGy7XZRdiYuGSJCD0ad5Z1HqZbfLj9S+lAQX8ArdHXvP1R3HiC2oK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YStJLcQ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dqeetFvo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUMcWIg1701189
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ew+Mk6K5YGioVRYwAsfxjNNsouazMty9EXE0iT6bafo=; b=YStJLcQ/1gj1QPk6
	WGuc2zuuj9YusxG62FdQwA7h0YomzJC5GzziFKj+hKRHqULsP+Cw5zcTarpWCnFz
	uRnUn/5lykugUEgRu5XmtjAksJR3U2c+z53bM5DR7d1zWAjx2PLSJp+ERoSKFk9C
	mNFvcxyXdmKNaKuxlpl0ui4VrF8IxGvRGxIu01R1Y4/UXmnL2UTGncDDRAkcNpQU
	cRqjlMk9n/qmplXKUrRptyC9CM80vtB92iB7N/CVmey1F1Lg3nhvr9bsdeOaRgQI
	2PY+g1zVKxP2t/2nVpb05a5Wa0Z3x7VWztkqmz4ZCaAKgcV0FHdSiyFGL/pH3lAy
	mZVfSQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0vdm9u9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:17:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee409f1880so29276321cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183472; x=1767788272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ew+Mk6K5YGioVRYwAsfxjNNsouazMty9EXE0iT6bafo=;
        b=dqeetFvoKH4HrRlWz45xfpVyz95h8QBhoCFjhirTtobQ3rki4o6z5WTQvFzsgS8Hlc
         ZB7JwPh1nz0GVYWvSRinbQWcvWlMczehNqRDrPpC7refHPnkQExQkTwu8SOiEFsR6MER
         lPtG/k16XnJ0cgG8X+6Sqt5IOmMymbDU2rCwkJSilqswuJewYJ8W0QT4V9x9sniPBRVH
         PinZLxa2Opwf1pnIe55ynpgD2/IqIHPVpbAU49YgIGcqkrg3dM2cDAJqf2Vmxi65lZwN
         I/3sC/fTqRc9HedaURC8ylQbDln5tY4zd6w/APmQo3eMtTC2os9mkw5qZjeJjN+15lFI
         lB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183472; x=1767788272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ew+Mk6K5YGioVRYwAsfxjNNsouazMty9EXE0iT6bafo=;
        b=F2e3MLedOTpV6y9f0Jmg5yVekJ8Mr1lkSDiLynjngWLqjEwvov9/677iTlpOvTlIv6
         MTAw1VjyFpy04+pvagsY2zK3O+ofRB62eJ69fZjreBsbilDsJIbbku7+5BDfAe5VE0X3
         SR7EJQ8BfUs2QYLprf355iEMBZ1QZz3xzbHd8R9mKF1mQPaxYWatGMahZ0UXSyF4QDrw
         iv/RLLViCDmLw1BM/ivt3hgKxcGn212wK9NAdUja3CzUpRrNG/tnkQPRPjDaYttjQx/s
         zJUNUTtevF30mfQu0YN2Y9krIaCvSI/ihYM7v5dQOUrOGz4oEMdLRt3J0IWv2L9XKy6Z
         jeuA==
X-Forwarded-Encrypted: i=1; AJvYcCWdlcm5qJP9cXa2zntJhRiBzrH6wJqeBInAfdRBA3oO9XVFo40TvLZpIMf+X+wdFcgQ/9S53auBd2CuQ4P3ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YysOXhmrlwKhF3YGiHWS/liQ0JlCTj7IcyAIvpLLNdDRRIlD8wW
	4eM8gXU8PYVrKEI/vNKExZQpkFPAFgDVFU7Vs7cgwH40/y4FYBXPQRwzJgjTo2OLv57+fQ5dRdk
	u1F0vBAwaym0xWDXbjkYBIN+fQbCBj6AHFu2QZTaLaeZy4P+3mAEDohyeBzO9rf8UPg18Mw==
X-Gm-Gg: AY/fxX5syEWHZbsKsJA8DRjNLvWgdxQbQW8MC0qEOe3Ar4f71i1bzquymMwS0FYSCPO
	JxKX+6uv7iUZcO6xA42CqUgSA+mRWbH2aFVDQysS+oVcA/JtP3V7YkUVfd5ArXwFvGITnTHqheq
	gtGB/SoCQv8QKE5y8ddx8f0M37zVNLQoYRRFJZIFsKr+/r28QfrMTNSAHWil+S6lXV7jIThCH/Y
	tsS4dMr4S8qJ21740b1nlFOKKKS9sT4rDU15+imtw8QCH8bqD09yNhXhOyECSNjxvqhTTljnk08
	t1hldKG7FXs/2j9Q2qnr6o4IMRHeRz0rO97Ja0pj2vs7xwvL7U8K6iC9L7m/jp6MburN/nady/g
	/KNw+gjy6egCiUevekDqxspvojgx4C4mYoWmy2ah7D3Ma3MWP56KMA5C4hrhEORH3Yw==
X-Received: by 2002:ac8:5fcf:0:b0:4ee:2638:ea2 with SMTP id d75a77b69052e-4f4abde8fb1mr390251441cf.9.1767183472203;
        Wed, 31 Dec 2025 04:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH957KOviLl3ff9m92xdS8YGRjjD8sUTjMZEhIjpCXfBub9SZDcdgZ+jloiUSvjwXkZhRj+kA==
X-Received: by 2002:ac8:5fcf:0:b0:4ee:2638:ea2 with SMTP id d75a77b69052e-4f4abde8fb1mr390251091cf.9.1767183471721;
        Wed, 31 Dec 2025 04:17:51 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f4ef1fsm4017817466b.64.2025.12.31.04.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:17:51 -0800 (PST)
Message-ID: <604f92a7-580c-4bef-9d13-707f6b1c7105@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:17:47 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT
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
 <20251231-wcn3990-pwrctl-v1-10-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-10-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dfONHHXe c=1 sm=1 tr=0 ts=69551470 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YN4nVyxdPvXl5XCbABQA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX7X1MMtwLVfn3
 KRyD7nRIySlDRanWzkLcFxFi8+QzOYnnvTlo4+3I4dAPgAetf5bCMYmvwGbCxaJgtkaOppOD7Me
 Y3ws//KifEpFZVszZgy+GDGF4vIztZDNUjrPFsf0TNeLlG9lPZH3WPNhtxUlcX3b0ckMWcCup3Y
 e0VEMfujYsyY5h6J1Azd0JSEDcYIsgoklBq0vhThDI3xy1zJF/t+oSqirwSXRa49BCy24Dr4+yY
 VOhNu969FbJ/oFzeosCvxXY3pnLeIKH+4ec+n/wqPruKyf1+yfZsX+GSANej+pn3MwCkHGBKpAx
 +dkKycDSgCqN9TsDWJ0icdS8wma2WCqlK/Wt504RxJF+/zqdBCvZsSCcCilfgeWz6V/BJ1ijLk9
 byRelEhk14a9M+q9q0CzB/MrJsd/UNNFr22++73Z6Bitahu2XHfcQv3GOMosB66xZXlzp9Ai8EL
 brE2+KO1jJBVc+1bexA==
X-Proofpoint-GUID: ayHsCre4tvO9BNz6fWGCqsGfNujvsX1A
X-Proofpoint-ORIG-GUID: ayHsCre4tvO9BNz6fWGCqsGfNujvsX1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> The onboard WiFi / BT device, WCN3950, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

