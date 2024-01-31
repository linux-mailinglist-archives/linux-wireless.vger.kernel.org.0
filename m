Return-Path: <linux-wireless+bounces-2911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB3284496F
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCC11F28F3C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4E538F97;
	Wed, 31 Jan 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KYZzWyQ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235939843
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735292; cv=none; b=GRtXtztc/k9EkwDVlyavpxnWR23oIubAvMTU2I/Hq0PG4U9gGMetcv3PPDOLHrJv7dZ6R/me2NszdZ5v6LikH7UNYNzCZ6ZgYaD1uf7gAlT7qEXn+gOaHzlNRggWsG0mhyFiXDLn2aOWiwaoQNW3Xt3lDS1wv/0TvELO7Fmq3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735292; c=relaxed/simple;
	bh=AJMkKXX41S513xmTMqzF0G6wH13GAVHKc3IRGvAlSws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JbpZ8Chuw5rfGY7YysEfJYA5NTKC7hWiYvQIMUbU6hhRyoLx727Uu31ZDsxFvFEgLXv52Ld+x+QpXLL788vsMnoMWuF47OM1h2JTOIsmt1XcjujJ5rdiCjeM54Ar5vdrgB9TjWWuOgCn3SVMOjRSAVNLkrCoV91dLoX9jZ+C5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KYZzWyQ4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VKG3ND027407;
	Wed, 31 Jan 2024 21:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Fq1N07ZqMWX9HNidJ+zUIfQ8pVcLFqKEUlt22qlHnkI=; b=KY
	ZzWyQ4KP0nSU63WZYgnUA3iAOiV9ctLIVAQXCgOPFw3bTfAq4B+0nXifj5UkiylM
	qDhGy4ZxY9Vhkj0wUg9JtR6W4Z2/UJwBtV2kneL85x+MGFP8IOq8/sD4/qtD3SLq
	rEaV3mwVrA97kDA9rA37+BD6XuuOIfPA4LhTCZRJtlnWZmT/Kbbziiw3ic9VLrDO
	M/hsBaAwK2ouRpHJ3kR5XotKRmZ4Ymyh4wQKQwnlzuAh27N6P2UVp2cBS6V4inXF
	ftq/9LIUoaYB/inuoU8RIa6H2FCS6TqwY12yhbOOpgGkMMxJIGxdKI1tlU5sQLBW
	9w3+TD3OuXPwe2t0OiTg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyfnjtep2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:08:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL86bs009855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:08:06 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:08:05 -0800
Message-ID: <909da932-fbb2-40ab-90ea-8d31ff1900dc@quicinc.com>
Date: Wed, 31 Jan 2024 13:08:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] wifi: ath12k: add MAC id support in WBM error
 path
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-11-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-11-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tst5vWwzl8a5hk4SCfibzROMsLKTCDnk
X-Proofpoint-GUID: tst5vWwzl8a5hk4SCfibzROMsLKTCDnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=703 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310163

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> When more than one pdev is supported in the chip/SoC, the packet
> belonging to second pdev is given to first pdev due to not identifying
> the MAC id in the WBM error path. So ping fails.
> 
> In WBM error path, src link id information not available in the
> descriptor. So get this information from the msdu_end 64bit tag. It
> is necessary to get the src link id to identify the MAC id in the
> given chip. Then only we can pass the skb to the corresponding pdev.
> 
> The msdu_end 64bit tag is available only if compact Rx TLVs
> descriptors are used. Thus, src link id is fetched correctly in WBM
> error path when compact descriptors are in use.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


