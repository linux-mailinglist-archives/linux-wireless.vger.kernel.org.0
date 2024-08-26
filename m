Return-Path: <linux-wireless+bounces-11938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C622395E839
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 08:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820C22817AA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 06:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2561680025;
	Mon, 26 Aug 2024 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RJVV2LWe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990B7710E
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652285; cv=none; b=UBQyoBylDYQP42Vb9NAGiRvBws7QehiPeX+GVHvlvqy3Jr5INIQRKczVvfy6FPMhYTZCS0+6CF/cAGBcqwJmNNzvTICDhepX8zO7wChLOxAZI1k2YwNTOlvvK166IiFzJKpJIgk9ChcXhts4iUsL/vZnvJX27M7KrCC7cQgvvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652285; c=relaxed/simple;
	bh=njqg+eQdL7uIuZgFqch6fSWCgHcii648KBQy7e9rx8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tQmRqvbZdgYpIGFoFzU25bPwDLuWAF/nzS2TJprUcPNWn5l0gCUYV+P27utA9xvs1zmaZCpWZCx6J2tA6eHq8fzf5g/fr5x4/pU+mgqQlc5rIOPiFIgH0N2xVEowMy6U2CcGRZIFsmqti0/J9b7HrXXgNdKrcngwTC77NdTL11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RJVV2LWe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PN0eqZ009201;
	Mon, 26 Aug 2024 06:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9NZ28nRp0AH9lnqwmjlDKM9fE4ojjn32EOCI4LEa3L4=; b=RJVV2LWeWiP2BTyw
	TrFwe6YWdttFCamAqjjt6U9xxIvspUUdhF7wrYG8ABvDuJzGSabzjfFTSINHiy5a
	4LtWiS0k6IkfUDhLQhcZ6bCukpBBDa9tHwNi9G+kmVFkZqfHrQsVdZ4uc4WOYVDE
	tbGASLjQN0zpH4xPbmlZb+9NIYIfvz2vsEi++xSFgE7mtsdDLt4c1yowq+QihwNd
	97rDs3Vh6JzgUJZ2mr4CBNs4curcG5AxtqBRSNtPwI34xaFnOfcJhJjNmAPS42oW
	eczRHYLs+8E5reflSN5fv4asa4Lg1Lp3UIT57xh61uAgxWfr0huiKspCZ03ZRJ46
	ptpaqw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417988akhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 06:04:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47Q64Us4002872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 06:04:30 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 25 Aug
 2024 23:04:28 -0700
Message-ID: <68bf6f43-d851-f2a5-54db-61538cfb46ce@quicinc.com>
Date: Mon, 26 Aug 2024 11:34:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] wifi: ath12k: Introduce iface combination cleanup
 helper
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240814103423.3980958-2-quic_periyasa@quicinc.com>
 <172434561175.2469785.10367608474646125650.kvalo@kernel.org>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <172434561175.2469785.10367608474646125650.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mBIRafPMEORtSlIzLh1n4mX6D_SBOcIt
X-Proofpoint-ORIG-GUID: mBIRafPMEORtSlIzLh1n4mX6D_SBOcIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_03,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 mlxlogscore=817 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260048



On 8/22/2024 10:23 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:
> 
>> Introduce a cleanup helper function to avoid redundant code for iface
>> combination cleanup. Remove the cleanup code from
>> ath12k_mac_hw_unregister() and ath12k_mac_hw_register() and replace it
>> with new cleanup helper function.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00183-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> I'll drop this patchset because of MLO cleanup.

This change not related to MLO dependency. Its a basic to group multiple 
radio under a wiphy.

> 
> 3 patches set to Changes Requested.
> 
> 13763255 [1/3] wifi: ath12k: Introduce iface combination cleanup helper
> 13763256 [2/3] wifi: ath12k: Refactor radio freq low and high information
> 13763257 [3/3] wifi: ath12k: Advertise multi device iface combination
> 

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

