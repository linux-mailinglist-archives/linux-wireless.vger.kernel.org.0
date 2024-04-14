Return-Path: <linux-wireless+bounces-6287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDA8A42A1
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 15:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24818281A1F
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6C224F0;
	Sun, 14 Apr 2024 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mA8hCuh2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276014292
	for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713101679; cv=none; b=Cnb0JA1nc9T7HiyVkhhE3pg6Y8oEzzC4v232gTzNFdbTSKWrCtxOJkfDzHX9lmMi8GkY5okUK3So4SelJTsctyihG+nDMNp1O40nkgOs9Vssa9cX4zjqofnXSFadi0wsVOeB5UBVXkPhdslVVTMLQGNnYgQzeLMYKk1LrVEEu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713101679; c=relaxed/simple;
	bh=3uLDil0DG96S0bEGotKQP0EdEjK5A+b5kLmLYQPj44U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tL4a8ZPOT8kHHEqdLK849Gw6WBj9LmgpmgwTJTEclp5edbtV0ihOrNjm2coqaO+mmrKoY7oPg4fiDcCEDVWlLADCRt+j1YUMr4fymnLCquron/YAl9FKy4X5/2vxKKJwU5Erjwnkd7F1j4uNLgKV99B1sDGC3mojTBMFRQxAELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mA8hCuh2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ED0tq5022087;
	Sun, 14 Apr 2024 13:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HMCaeiGsTkaQf2mcTwDFyVW2yYzd34i4kAKfSklt4Tc=; b=mA
	8hCuh2oluIixmzsx1zCSgXYnyeDkXlY9ak/B2xc3lYt16tV+KiiWTFK2Z8Zw34Wg
	Vv957a4rqt6C61YwXXmieiuawTsb1/GYvU0t97z/xFmc2N2j/cbX9CLtC6vGYoDK
	PdtaUiw6mRO4LdXIfvwYM9wPoj2k1ydcKk1tBllLjDs92D5hotGTr+cGU5Gwg7ux
	cubiyJC+bWF0ecTDyMBCTXqmu8B13HcSi5MS38L/ByyyuK33m7iyVBF279tOPS2s
	YjOicTjfr+QSt+ArqMzOMPxC/oiTxfKiPBIkXAdtSHSddcj62OUEaGFP6fp9Ssu/
	U5JA/BaP4+JvrUqLwE6g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfk7q1v3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 13:34:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EDY2lJ023664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 13:34:02 GMT
Received: from [10.110.8.16] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Apr
 2024 06:34:01 -0700
Message-ID: <e40eb820-438b-415e-b91a-d448ac60d9a4@quicinc.com>
Date: Sun, 14 Apr 2024 21:33:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: modify the calculation of the average
 signal strength in station mode
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240309121129.5379-1-quic_lingbok@quicinc.com>
 <171034681684.2322265.9660346495295315212.kvalo@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <171034681684.2322265.9660346495295315212.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x-xkjMdtD3Rv9-flZumOXT7rJvRLSHDG
X-Proofpoint-ORIG-GUID: x-xkjMdtD3Rv9-flZumOXT7rJvRLSHDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=894 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140098



On 2024/3/14 0:20, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> wrote:
> 
>> Currently, the calculation of the average signal strength in station mode
>> is incorrect.
>>
>> This is because before calculating the average signal strength, ath11k need
>> to determine whether the hardware and firmware support db2dbm, if the
>> hardware and firmware support db2dbm, do not need to add noise floor,
>> otherwise, need to add noise floor.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>>
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> What about AP chipsets like QCN9074, do they also work similarly?
> 
Hi, kalle,

I observe this patch's status is deferred.
https://patchwork.kernel.org/project/linux-wireless/patch/20240309121129.5379-1-quic_lingbok@quicinc.com/

I think it belongs to bug-fix, so, could you please merge it? :)

Best regards
Lingbo Kong


