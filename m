Return-Path: <linux-wireless+bounces-14256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1E9A601B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 11:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF221F21466
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1111E282F;
	Mon, 21 Oct 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S4s9EYU3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63104437
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503142; cv=none; b=DvU8OgqcXiWb38LmXSWHConlxmxOqcdP2Lchnx30TvyKC2Hfcp+xtxUalEfxEuFERaAvPwo/32KXBBmh2jRQ7WUF1hTsH24rwO6/k3PMDXG2AzFDc0Kjdru57XlZwLtE03vhGy6IzVxRhTTirbWId102440Osltw4NduaEcrq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503142; c=relaxed/simple;
	bh=bq2ROV4vnAn6Q9ACvg6AjQaOMjOEEiN9I7FLYke8yyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TGTkeSEUbHq7cyGfFkpeuozI25xCuCGTYh//ZJmrT7vUzgtELsPg3LXeDrBUUaGrLCRdbFCh8i12CPwAgf0eukUhpXAsqSEY7M41XQwIU0J2dg51+KZGAMuLnHzRWEwJkE7Xlp01YGKN3Yo/k0guKgXEAQJJSXbFu8seaWi43x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S4s9EYU3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8JrWY009625;
	Mon, 21 Oct 2024 09:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rDgdU1n3NSZ18mfp8AusY3Rj4Du7Q8R28DmTiU6cuus=; b=S4s9EYU3PF0t+iRv
	dR1fBdLGFG8sTSdpl1SxC0+8+ZdrdPJr9LkuuhgpnbYQ4sJnZ/osRhbkdx+JmUwD
	VCPRiEW43aQ19EU3wzI6Wdo0wqJhUCJA/v3j6S5gkta9NR6UlfpUU+I4G81iwKj/
	GOnCzVwgwKCUeODcDUz/lIqP4xV4mn88adqi0hsKxYCw9uz/9nu8/ZGZE2IYSFD6
	YFwS0BisaZEURvMzec1xxqKunDU7fYw/q3wPeMe8mvnCtggGMqi5Zx3BhRHeBA0U
	adHdsS/mAkm6yNIa3ErGt1w/7KLNx67zHyusFodKkPZBQb37EltQjkSnL5UT1AEN
	q75ZEg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkbt0br3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 09:32:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49L9WDsS010012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 09:32:13 GMT
Received: from [10.253.15.238] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 02:32:12 -0700
Message-ID: <a0a3c468-6f6a-4236-9b09-45534ac51c37@quicinc.com>
Date: Mon, 21 Oct 2024 17:32:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] wifi: ath12k: fix struct
 hal_rx_ppdu_end_user_stats
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
 <20241016065700.1090-4-quic_kangyang@quicinc.com> <875xplrgj5.fsf@kernel.org>
 <87sespq1pa.fsf@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87sespq1pa.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R9gNbjjRYcyRPOyeXix8GsLv-KMn08qi
X-Proofpoint-GUID: R9gNbjjRYcyRPOyeXix8GsLv-KMn08qi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=557 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410210068



On 10/21/2024 4:50 PM, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> Kang Yang <quic_kangyang@quicinc.com> writes:
>>
>>> Current struct hal_rx_ppdu_end_user_stats in hal_rx.h is not matched
>>> with hardware descriptor definition.
>>>
>>> So update this structure and related code.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>>
>> What about QCN9274? The commit message doesn't mention anything about
>> that.
> 
> I have the same question for patches 3-6. Also I would like to
> understand the backwards compatibility with older WCN7850 firmwares.

For QCN9274, we reuse the same struct for them.
WIN team already checked them during internal review.

The struct definitions in patch 3-6 are hardware descriptor definition, 
won't be affected by firmware and host. They are fixed.

> 


