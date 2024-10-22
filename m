Return-Path: <linux-wireless+bounces-14291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C959A9AA9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925921C221F0
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57ED14A604;
	Tue, 22 Oct 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CnZLv6wR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE1148FEB;
	Tue, 22 Oct 2024 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581262; cv=none; b=FHQSoBDAhCVzZeqg4bUi5mknByuuRPT0np2mlchIqBiNyVJLmbKmUzAcxdBkejUPmjh0DGRZwF4c+LOgWSP0xe5ErmziRxR/wsW2koK4FPiQPMQCLqSvD6KTyaKFsikrZhrnkquLC84insSeXpBSbebOPThKLvtihkhnICDVxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581262; c=relaxed/simple;
	bh=/Rgpo9I553gF5Dq4wZ7FZfxuASIDdLW/V8cSYDAMXD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lzwBuB/2c3IyjxIRkkzGLWydK+A4QPU67XrRoYXnORLbIL+3P0zXFUZWbaP6SIPZZr2clDyHhgH9BOelIqZ4002Tb8jGD9Eb+RnlUK8OK8Y/LW8p4BH4zOIDjwQd1cHwnKtVkwAkTUYp1b2iulE6qwMq27vdDjdvqkWlatGvFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CnZLv6wR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M6uVqZ019049;
	Tue, 22 Oct 2024 07:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2OQf0si/CIXxYVkyVvj9sbbdpTRNuvie33M0zB2wTuk=; b=CnZLv6wRZlLSPWbP
	azI4Ryr3rzSb5MJECbNKX3AtFZErqfropwue0i0kbznUMcqc4RT4FFg04Sw9v6v3
	LOMMtWAvioq48XZDgw2MzpztdpZ5uNUCEAOSzUjsd9HFUkE8jGzdBzENwnGvV7R9
	48RvAqBCEQBbWmH+kwR2BWe9IO9nftszC1DbWWowSI10MTAZwM7yQGt57kLIqGtJ
	RjLNOhJqcK3u41ezFei+w0zFCV8Gje/5Hxj3YDgU2rn3voqMtd40r8+xHaTmZqO7
	ktiYhyw7371VoV0WvlMz2rss/bqyvSNRaKXvHMpcev/VQ3u8CjswqbaTwPgaOlt1
	8AfGIw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42e77pg2ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 07:14:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49M7EFWn024228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 07:14:15 GMT
Received: from [10.151.40.160] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Oct
 2024 00:14:12 -0700
Message-ID: <09be6843-52c0-4d84-bcba-e6cbd0cb51a9@quicinc.com>
Date: Tue, 22 Oct 2024 12:43:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/22] wifi: ath12k: convert tasklet to BH workqueue
 for CE interrupts
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-17-quic_rajkbhag@quicinc.com>
 <877ca1q0yq.fsf@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <877ca1q0yq.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ds6dUeqqETgxjzzffRHEvUQO7UndozCn
X-Proofpoint-ORIG-GUID: ds6dUeqqETgxjzzffRHEvUQO7UndozCn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=967 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220045

On 10/21/2024 2:36 PM, Kalle Valo wrote:
> Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:
> 
>> Currently in Ath12k, tasklet is used to handle the BH context of CE
>> interrupts. However the tasklet is marked deprecated and has some
>> design flaws. To replace tasklets, BH workqueue support has been
>> added. BH workqueue behaves similarly to regular workqueues except
>> that the queued work items are executed in the BH context.
>>
>> Hence, convert the tasklet to BH workqueue for handling CE interrupts
>> in the BH context.
>>
>> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> 
> 22 patches is a lot and I'm not going to look at this in detail, please
> reduce your patchset size. 10-12 patches is recommended. For example,
> this could be easily submitted separately.
> 

Sure Kalle,

We are working on other review comments in this series, in the next version
we will reduce the number of patches.

This patch we will be sending separately as v3.

