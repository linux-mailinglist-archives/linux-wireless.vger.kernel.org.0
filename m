Return-Path: <linux-wireless+bounces-5845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 221D48977FE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40CE1F22D27
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889B152DEE;
	Wed,  3 Apr 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EbQl8Uk1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACB153593
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168241; cv=none; b=YTdQBlk98y+HCaJtUroi85Qi0BTebkeeRMjCBI6Bb7XYtC4Fk1GmWhp6Qltr8hDzPrAMREA6+b1djbmDnPdapukqbSL+N9kvH/6GW22vmHMYO5m1gVT4CmXhccMJtttzEm19myJ/3VTp74Mspa7ewD9Uzc5hLsOhwTwxYsrXIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168241; c=relaxed/simple;
	bh=HlVeQ7T0ZudjqIH6Vwvvin//t8wn9ldvzeFLpCshyt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UIWQ+vNm1owDboc2GKv/OIIEaRWL9+N0CfI5SgxR/ho7NpLrViS1tCrPh3n928RZ15x+He/XihNlH3/7NZUC8z5h02OCarmiejEXmbOkAVvBrva5CmlZEopZrl11x/QhSUu+Pl7zLwMMSy7snJCk0IsJKFmj8cUxmgGUyIzTjYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EbQl8Uk1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433AtDQ7023560;
	Wed, 3 Apr 2024 18:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=O7oMtTy+fMWt/T6Jsy0xtxrd5aOIVO8wJk8+6lcvZxc=; b=Eb
	Ql8Uk1RE67toY28Y9+l7b3U8eflT06za90+CqaM3SZVe4rsnlxFbuEtO//SedegJ
	TX4zCAHEkOAG+7TJirCrAAzgPmaZhESzL8yHmn2edb5N+R7WjOyoffUnaayhGYzI
	DASqas+dkT/LioYRfj/5STZRA/ow1J8AsTNWa7L1iR8YS1FInPvrPeBsReBBpvEI
	ACQ5eWf9yxkAfYDyzbSQnLBTIKsyhC9Keh97XvXC6ugqwSDsCXpuKsunk2nLVCSa
	depW8c4un2uaeRqkdQi6oZ/zfOvEeXYxw0sv6SH+R7rIEnrgFtrpnV6Iev1uMdSZ
	aknMdwGHEtiVz/qq60WA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93u59f25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 18:17:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433IHEkY030150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 18:17:14 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 11:17:14 -0700
Message-ID: <75e2d784-f91a-407a-bfaf-abf6bc39d0c7@quicinc.com>
Date: Wed, 3 Apr 2024 11:17:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] wifi: ath12k: refactor arvif security parameter
 configuration
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
 <20240402210538.7308-7-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240402210538.7308-7-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NrFcf12KQhnDTB13lYrOPHvp3MhAzuPy
X-Proofpoint-ORIG-GUID: NrFcf12KQhnDTB13lYrOPHvp3MhAzuPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_19,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=804
 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030121

On 4/2/2024 2:05 PM, Aloka Dixit wrote:
> Configure security parameters in a separate function to make it
> easier to support setting the same for nontransmitted profiles.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



