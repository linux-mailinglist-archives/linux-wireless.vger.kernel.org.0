Return-Path: <linux-wireless+bounces-16301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AFE9EE311
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 10:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E807A282D6C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2F5EADC;
	Thu, 12 Dec 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mDAysNBz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF563187870
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995873; cv=none; b=cgFJo3A3jPnttavI+4hKXdFGHyXFvKAppzGunZ8mNFybmW1BVI+9nwaHkcqnSTuehHw5L99OnPsofNrr4yqCOfYgaego9UQVzqVRiWuW3ZO+SKsFUY72Ilq/bt41Jt2hBjtmcLrSqujlmq64pdBFvCGIrXfXqf6xPz6U1afCF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995873; c=relaxed/simple;
	bh=V7SumzVJoZW5xzLQPJfpj44dLuSoi2GBj1KntKrFZiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rSAWo4Oeb/Wx6k6UNNthqS3YNMenMRGXo4XkROmvQHQoJDkCjATdDl/urwXaa60ZPCXnzpemvLPiRqnXlkChJ5va95gAwbQnh3NpuN+ZMpipr0Uc3B07FD6OhxwkLelwmKLrL2xJEWcMTyWTvE7uFh6u9jZK/nFzGaAD3FsEArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mDAysNBz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC2rRTV000455;
	Thu, 12 Dec 2024 09:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VVyEqOENryfNsOyXSSwXK5bRPyH6O9hMNHtCfIiGicA=; b=mDAysNBzHzcAOphz
	kPYbVKB+jVa/w5cZ7z7SHNr10RqMcH4itlHBv//6cSLA8MPCp6p2wnYxtb9/TkkF
	4o/tVzFdXCdgPxHzKtD8m6h+kTjmE16hhyyQFWYD/n6HAKdAvWQjqGpBL50KKGZn
	Wds2cihkgEHX7HwCmI2Y5fj+t5c6jyj1+1c1UWDJ2AouFv+C7Ekr1ZFaPEQuokKI
	BpdEa7MRSzD+OAerPiNMs9G3iX2aRZO1F+55C3dTwGDKengUteIbsJGBrGVUlHyM
	1RRL/W+pXrveUe3smsEnq192pyPr0i8I4ICX1aNhrbja44E528n4eJ5AgSSvYzpH
	qV8hzQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes0vm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 09:31:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC9V47R020168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 09:31:04 GMT
Received: from [10.50.0.236] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 01:31:03 -0800
Message-ID: <3696af43-bb2e-868a-e301-6e612134a142@quicinc.com>
Date: Thu, 12 Dec 2024 15:01:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] wifi: ath12k: Refactor the ath12k_hw get helper
 function argument
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
 <20241212004906.3087425-3-quic_periyasa@quicinc.com>
 <874j39qr5h.fsf@kernel.org>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <874j39qr5h.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nmXdAXVY4EIfsSZeVQYWXlHAQjCr3IsU
X-Proofpoint-ORIG-GUID: nmXdAXVY4EIfsSZeVQYWXlHAQjCr3IsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=670 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120066



On 12/12/2024 1:17 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
>> ath12k_hw get helper function takes the device handle and the index as
>> parameters. Here, the index parameter is specific to the group handle.
>> Therefore, change this helper function argument from the device handle
>> to the group handle.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Why?
> 

It just remove the dependency of device handle (ab) for using the helper 
function ath12k_*_to_ah(). Now the caller can directly use 
ath12k_hw_group (ag) instead of forcing to use the device handle from ag.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

