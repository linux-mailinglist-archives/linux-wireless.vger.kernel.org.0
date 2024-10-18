Return-Path: <linux-wireless+bounces-14226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0419A4785
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 22:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D35A1F250C4
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 20:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A3320492B;
	Fri, 18 Oct 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzXnKPLo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94476C61
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281644; cv=none; b=MsVXeomoFTjBmWJfsHH0qr5QW89vRGNeOOzeJwJwDxQkCyA3D+3NSbzMvE9kZyu5Cr937l/5MPkJ+clq6QYGeXJ5AleSQVngPIKwblTZFnYKbiWeFXJJ/NhBhrYmYqwa5irQ8/p9rlXoOgpBFZpyf5SFPJdRAceeDuejwdakV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281644; c=relaxed/simple;
	bh=big/RDgxfpSfVSQtJWLcewNoNAjp6aU5JtWSCscIjdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULGoJ0tlmkRFjxoMGH1USmJ9+9knqVjDSPHbMN8hIFVmP+s+EOk//Gq2qAYCbUYAslOyj/hvAsggRxhdr/Gb0F3lJXTTAyeHGYIaTBSe9+ifRI91iVlrMcRsqdG5S2be6BJl5Z2yBQb05fm8AFpK0drPJ5s2t2q4vcasJ4u5UfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzXnKPLo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IFEZll010153
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 20:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0tGKOhQP9AnanB1aw/7BV3wpUi1rDbiQvMRXCGixeyo=; b=UzXnKPLoshLJjtBC
	YsSRPz+SOjzQjAFYx703qyUPHGm/QO6WBK342i+HQsdU7yzW8XfNAZnNpiGE1bZQ
	prQ+ARrfUOBRhYQj2JSPNkUMtmyWODbi/5Z9bXLHDJx/FSduZsvni4evbbMcAIcu
	3LEPmn+g6J3/izyYl8BNuCO7xXwWqydxAWWkfsTEpgXRdunPjzsPhxxzVyX/4Qcf
	D8RikVfnl+2cXj/pa+aK2PMYYD59ELcqZhVjCYo371YnG47dMKpcZtejjl7cEbi+
	9P0uj6LRBJ6OCytIFmYmuEbc52GCPuInYZReDJVVwlZ4FxU41Ssa3k8jdKO3sKll
	FICuqg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bt540pty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 20:00:41 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84fcaad02eeso76676241.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 13:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281641; x=1729886441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tGKOhQP9AnanB1aw/7BV3wpUi1rDbiQvMRXCGixeyo=;
        b=JMQM7XAb6Q3Rm6Hp/3oRYmu59hd51mVZ1kKU56FW6ckLukMZIiorUkWGrtO11pC+zt
         63bRTvj3UCdcARbcC0MpjnKnAns1zTiqR7OcKztLTKkhmnRXKq3VMiKDRMXSk3qYF3+Z
         ZTkPxZv1pegLeIm9PbFMV/ZRiG+0ehZ4vR+ykSFm7SzeYUyC66DNZX8umUB9xrbYHM8C
         7bPnIPMnnxhcdVm7k9a8O30hBC53UXSMd6Ew/vziDgieg5tyapL7il/CjYEPJJYvA3y9
         VXG58eS74QnrD1k1UcwnuvJELfPrJMlj7YimAzVRqZdFYPPFOun6rHzK2E6m/9gx8CLS
         DnfA==
X-Gm-Message-State: AOJu0Yzx4enMXxeawrv6M59ooiKUx88MbQ482PM7ObIgxfoVooo5DtPT
	3JAnRVnc2EpEYSNMoAL7Qp2DcCdI1c02Ljsr2QKC9+LvAgJ7H4zvi3L5t713U9Ox6xMXvk0M6fS
	3REFP+XuSs13Ht7xUKODlmecnaSmj2sYfLHKWwb198HBgMEVxcVcZzQ63ZWszZwYMdg==
X-Received: by 2002:a05:6102:2ad6:b0:4a4:91e1:9939 with SMTP id ada2fe7eead31-4a5d6bffee7mr1498631137.7.1729281640654;
        Fri, 18 Oct 2024 13:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSpLOvXy2ZJYFYCESLX3QZsA4k17+P+w4yaJ6g1/oZglutsaQiEYVFZTCLMNovcB+2umfTeg==
X-Received: by 2002:a05:6102:2ad6:b0:4a4:91e1:9939 with SMTP id ada2fe7eead31-4a5d6bffee7mr1498582137.7.1729281640242;
        Fri, 18 Oct 2024 13:00:40 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c271c3sm132517066b.193.2024.10.18.13.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 13:00:39 -0700 (PDT)
Message-ID: <4961d425-b660-4dac-8744-36d69993d1e1@oss.qualcomm.com>
Date: Fri, 18 Oct 2024 22:00:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/22] wifi: ath12k: avoid m3 firmware download in AHB
 device IPQ5332
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-10-quic_rajkbhag@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241015182637.955753-10-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aUFfN0Q4_ipmSIHp9Y6GkbyRsQGhOGMV
X-Proofpoint-GUID: aUFfN0Q4_ipmSIHp9Y6GkbyRsQGhOGMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180127

On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Current ath12k devices, QCN9274 and WCN7850, supports m3.bin firmware
> download through ath12k driver. The new ath12k AHB based device
> IPQ5332 supports m3 firmware download through remoteproc driver.
> 
> Hence, add new parameter (m3_fw_support) in ath12k_hw_params to avoid
> m3 firmware download in IPQ5332.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/hw.c  |  8 ++++++++
>  drivers/net/wireless/ath/ath12k/hw.h  |  2 ++
>  drivers/net/wireless/ath/ath12k/qmi.c | 28 ++++++++++++++++-----------
>  3 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
> index e5e2164c27d2..a4e0c21ac4b7 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -1299,6 +1299,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>  		.iova_mask = 0,
>  
>  		.supports_aspm = false,
> +
> +		.m3_fw_support = true,

'support for m3 firmware' is not a fitting term.. maybe "needs_m3_fw"?

Konrad

