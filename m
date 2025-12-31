Return-Path: <linux-wireless+bounces-30231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4479CEBEA7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 13:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA1233009C77
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA59320CD6;
	Wed, 31 Dec 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mezau7Nz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBTXveCS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF832039E
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183052; cv=none; b=VSwkdOFAE4K1y/K1IFAGVEJtLRGl0oEQnBdLENs3+GvvmGjU7/uTOi2a7RUlLUPeeZbBrLKtx84BbWD/QwsQhtx4go9Y8Ip35d62+zkHfRBYh2cj48Os0/82hh+cIpKrHGK1CdhZtvpMSvOj8aRxGdSOCY+A8omLxyTs4Du0ufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183052; c=relaxed/simple;
	bh=FzhfKAYKhvE4b1t8D4IAourbx7nVeMnR85FO5C0OjB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn/JtXxK2hL6wDGdQegKxDsKXoMQSJ5OhB9yz7TAhEomnanOumlEdxY6zXED7avepg/j+tNig8lAPRgAF23CzAKANzI3ky4gLPTVAbh3iVbi7UEHTITIjuUZR3PJ74ZO6651HE00rpN0Ou/DOo8nBcNojIb/IzFfdgEk10VhHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mezau7Nz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBTXveCS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUMKWV11329013
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XhaBQ75Rf71lV8FkiGxgw61r/Y/XZi/ecHt0oI9jQCY=; b=mezau7Nzk3XUhMQV
	4EiIg/pK/tFORCyMGoQ/PLNKi4tMRaTvpOwC0hf/CJOAwOsS5nHynXeO0jPK2Lug
	+ctgHBC8aflVVXSofn8SmFDUW5efcuJmNwmuSPIQsKR9k/E/ztH8qFR4e4ygZUH6
	lnWbWyLOZG1JeLAWomz2chAgobMNfAA2BHSbm+k2aTAOiDm6xF0kpNe76juVtC2n
	ZnDJT1ez9iTgc/E6xnjuf66FbrEslT5jCwInbzye1qu+dCeskUyPWcfpuKBXv7hJ
	ZCVWEpV0v2AIeA5mKI34UHkQlCDc0pUkV0ZfJkBE0t/b1C0s7AN90fguASRIdazO
	Z+V8qA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc06gvcnf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:10:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f34b9ab702so28126591cf.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183049; x=1767787849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhaBQ75Rf71lV8FkiGxgw61r/Y/XZi/ecHt0oI9jQCY=;
        b=QBTXveCSkMcebfwv05aNYzqiTq6OFGOS4yST3rcC6ZQF3BFxBZruUmPsOxx1AqHhFn
         avVg2wKVfb77vU6hjXh+e49NKNtlBFPdIhUTfflRgZYZ3nLQeLAlJNc1yEj2eHglAwh4
         5wbMMHmmJ6c8U/iBrq8qt4i42CL6c6ys+JSy0JO9alqx3pNkiQ4IpyyykZmo0L76+mkj
         wBzALwvIF9ZmUqc8CZufPPE94xcFWt5jyFW4o1o/KBTJxWxteIhyYMhqVcmjC7UKBo6a
         7sVPyOv6dCN7oq8M3uh0I4d17mDcMNdw7CB6GB9j1NJaPdHAnY2Gl19xpJ7VLxm1CW7x
         AIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183049; x=1767787849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhaBQ75Rf71lV8FkiGxgw61r/Y/XZi/ecHt0oI9jQCY=;
        b=KRe/48ayWx1anad90YBT15vpDitbutw7P+QSxqOCnUjG+se1rSQWvQAdf3Ow+wcJQa
         lfkNIhI0z3eVSNUogk0SbjDQIUj5L3544c8oKxqTJCKJj7xhUbfuAh1y+5yxqY20VL1G
         u+yv0jpy2aKp9fTKahRiymqr3eEPiBEoPxsY21l/S0EDhbAWfyxEg9AjASNW4O3Wt7NQ
         wHZbT3j+6wnOzwLEyfWtaGkumFeSzVwcyKacxBbKbF0QWq1KkVFo6+G3cZ5FZEkuvP0d
         hLOVQL5SX2znQDF6jEHj+1x/Srzc91mh1attmIUEiVT5ZqV9cii8LKrpsdkjLJl+AG1t
         1/XA==
X-Forwarded-Encrypted: i=1; AJvYcCW+AZ8wum+WsYdQqZU3nkPJxVSMvy/KV+AN568Gajub5CoAsRgPbfAUx5MO5EkUlCGAoLlhdf/mbC/ycYMqmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPuVAo1iZXcFlLEpmSVOcdXu3mCPHxbj7kAR+sYyGYhYP3rkgU
	Cq11KFQalfKTFzU01/H/nfNzZq/bRWukvyeFq4N6sBjbjgORbv5iOLMH94bUTJ6qSg1lFGEm0sO
	NMXojkETo7p6XWR8fnmKs9LDmYJzl3qUfNW5AK3avV6OU+tmaJRTp82jpmXZzifEUVtpCQA==
X-Gm-Gg: AY/fxX6O+CLP27tBgHB9bsWpuOiA8HJuEyAGtMnkR1nRn39BIY5zFQ6isUjJjuH3W7l
	2q4C6mgijbSGv0DKDV32vJWPZZqIALbtgB/u0TimufS2fIUNJWTIuyA1EkMgSUvH0jV8t6RxVbj
	koD4kLNsT7BEqSIuSSqLrzvxkJeiG0g5HUAP/wN0773rz1vnqdxD5uLJMc745FTsGNkcSFXbkpR
	aLhX+/0/HG1upiZTrpRJEBQF2nD7+pS1gRJSdCkaJk+C1Hg6Qi3fEB3YaSMqODafuamBNt2Ul6D
	mNBcI8Li0qbzE6EwzqthS4ctpeDUa/ciZyEpM+lPFYbPsrQH5ip4iW7q/Aco9Hi9XeCVabtFGuK
	mXI7tNmgJnt3nFVlLpIavrPEfKhoMKDwfh/yQ4TUoeA8QSXvkOKhVFly55sVzphM7Og==
X-Received: by 2002:a05:622a:1983:b0:4ee:1924:c6fc with SMTP id d75a77b69052e-4f4abcb50acmr412852291cf.1.1767183049247;
        Wed, 31 Dec 2025 04:10:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6cFEFkyE8VRxM0b+yrpQtlOmvHQM/Qqxgrd4xJLvYLI3HpIrI34F73/M4v3Vqo3svEu2ifw==
X-Received: by 2002:a05:622a:1983:b0:4ee:1924:c6fc with SMTP id d75a77b69052e-4f4abcb50acmr412851731cf.1.1767183048729;
        Wed, 31 Dec 2025 04:10:48 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90414649sm38031586a12.0.2025.12.31.04.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:10:47 -0800 (PST)
Message-ID: <d42f24f3-ce9c-4804-bad1-f83c832bdaed@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:10:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm8150: add uart13
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
 <20251231-wcn3990-pwrctl-v1-9-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-9-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dmFhYzSdU6FCDdrGoF06M4-Uu_CvbRAH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNyBTYWx0ZWRfX1oehoBi5O8z0
 MIYR1lsoNzzYbmRthIucuWASTKdqp4J+27/hMbtV9uz5e0GQs0XkVFlINOFbR9aqQjJOWMEMVLT
 NihfaN3JxtxcP0Uqaupp8MgGSlBrtP7SoufBeMyZtKAEW4r3GurMu5goOAd09Da700qZzFjwn8M
 T+YDuUA25bDaKlOsPrRzKePNWKuFNP/sXj+mB/qq8CJbsdCCohz/cQWle9J7FOvCmZl5VS/PSrp
 rtHmuqz9pCQ29AofqXtQlUdhraaQvnHcJtxUXP+m9oX5LsRncRhHGVwboA6rlP4sK0KqwY0M2x/
 gsqVK7y1/Ccrlsq0L3JWaixYbWRWC4uEqPnwc+MxjZxSiPUcdjto4RRIdhob4782+izasyIUIEX
 BKVuZKLxBjs+ofOFBDxQ4p2jWcndP28QhOMxmicr5cFa6IJNOAFF9a6ig3Bp6uMrvy/OchkSbXP
 AxTen6jHzzGhCw1xLYQ==
X-Authority-Analysis: v=2.4 cv=A45h/qWG c=1 sm=1 tr=0 ts=695512ca cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ROe98goXJRv4GV1sSmoA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: dmFhYzSdU6FCDdrGoF06M4-Uu_CvbRAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310107

On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> Add UART13, typically used for Bluetooth connection on SM8150.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

