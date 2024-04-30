Return-Path: <linux-wireless+bounces-7052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895BD8B7A52
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 16:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B921F1C22A24
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09D817B4F5;
	Tue, 30 Apr 2024 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vwi5M7cP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543817A932;
	Tue, 30 Apr 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488013; cv=none; b=BNMW5RtIE/PwSW7K1X8sQq4sBt7qeJJYxnX4pyufR/mFjbKsSLYcffs9Bw4zwn1D0981LJaThygp3WKnZmzwQFY/6/Fw+fc4TgnJq5iWqv8Rn0qHmjZO08OweAF9eVS4lP7HKJpQxNiAhpnEn9TtJBg2TvbWL3cmzDHSuQDO15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488013; c=relaxed/simple;
	bh=/AEqrNMOUjrzNfbBtYknalmZkmXb1enndlA9Aa+9OPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lWnIEh5HhIWGSKZ+lAwaPPgnQDTjWu0+RXNZHwr/2EfbzguC/KwTn2+v+GK8Es+tgolMAZaT2VeKnupgmMCCRMt0TMnDzMk0f5rT5cj9ERKhNJcey/asSJkxAssEPJlsoNB6RcnR28ZXZR9JFZblEcv+4aYBlrThq+H2mMlpYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vwi5M7cP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UCuFsP004534;
	Tue, 30 Apr 2024 14:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ued16y1uSeCs8rS0Ad3FyF5Hi0UmCNEkRJJ6uGnvzb0=; b=Vw
	i5M7cPm4w9Pn8U3xYPUEI9wi+PZo0ZATL6CxYV/wALmk7l+kDh+TNZsXulNCLH1Z
	zmwiSUuk5CeZtGN7kriS+M34nhVWtDl+UjtX0rml7JzFjgqkWjsxKNFVvyIDTMft
	BiaQL+ho4+sBJ/jiTRc2LufG4avK4kkWr4ye+EpELuNNAKq5+ewxXUJdAcvwtSHT
	tC0iL37wBD2l8lqF+NF0WJ0S5Rf4dPAFZb9uJ0fthBVV1RlRVQz7MZ8JoZ4FJ1SX
	ATV/qfvjwf1Pb/khYKGmzoHf6gY0DyAF6tKM6l5v5tV+xSB91azNwM/XCryGgcKg
	gkWik37fYlwz95fWksCg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtm3ujnex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:39:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEdwMq007021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:39:58 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 07:39:57 -0700
Message-ID: <5b790d38-0cce-4132-9d6d-bef016c2f4cb@quicinc.com>
Date: Tue, 30 Apr 2024 07:39:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] wifi: ath10k: do not always wait for MSA_READY
 indicator
Content-Language: en-US
To: Marc Gonzalez <mgonzalez@freebox.fr>, Kalle Valo <kvalo@kernel.org>,
        ath10k <ath10k@lists.infradead.org>
CC: wireless <linux-wireless@vger.kernel.org>,
        DT
	<devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Arnaud Vrac <avrac@freebox.fr>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        "Jeffrey
 Hugo" <quic_jhugo@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Alexey Minnekhanov
	<alexeymin@postmarketos.org>
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
 <23540303-5816-45d5-a1af-5f09d645a73b@freebox.fr>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <23540303-5816-45d5-a1af-5f09d645a73b@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z30xhft6aTgRwL6IqHhwciXKflP4ukiC
X-Proofpoint-GUID: z30xhft6aTgRwL6IqHhwciXKflP4ukiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300104

On 4/29/2024 7:06 AM, Marc Gonzalez wrote:
> The ath10k driver waits for an "MSA_READY" indicator
> to complete initialization. If the indicator is not
> received, then the device remains unusable.
> 
> Several msm8998-based devices are affected by this issue.
> Oddly, it seems safe to NOT wait for the indicator, and
> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
> 
> fw_version 0x100204b2
> fw_build_timestamp 2019-09-04 03:01
> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.1.0-01202-QCAHLSWMTPLZ-1.221523.2
> 
> Jeff Johnson wrote:
> 
>   The feedback I received was "it might be ok to change all ath10k qmi
>   to skip waiting for msa_ready", and it was pointed out that ath11k
>   (and ath12k) do not wait for it.
> 
>   However with so many deployed devices, "might be ok" isn't a strong
>   argument for changing the default behavior.
> 
> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> ---
with SOB cleaned up:
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


