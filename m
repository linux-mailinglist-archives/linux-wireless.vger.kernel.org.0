Return-Path: <linux-wireless+bounces-7345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3BF8C0311
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5E21F22844
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A174612C558;
	Wed,  8 May 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TFzvu3TM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566A12C7FD
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189346; cv=none; b=NYGvI9iIJ60hNodybyUrLKd6XWF3ilE/a6TNlchgpyiWCBpdOj7NbCbIPuwt0W12d6ALJ7xr47O+w7I3SHO8Xwkxp+IqJ1WenLNz8p0l6Ep3DzwacGqRbM4AxKKRVj460DWcs04peqmnivgaT1k+5LX3kurIclYr2NETpiO9Uks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189346; c=relaxed/simple;
	bh=fwA+/CLy9GgYdWKmNdTyaXJdjWA7W/GX/z0+kOg6Eu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PnOQlNxvX31csTyy6W0o5OtF7bzsagnJvuCYztsoU1WIb1c9N46cDXhuPOOfNF6rpdz1P1zJEUjVz/av4R4GtYDl+Z99YLF4n7/zxvXUBFnjxDOkgJfY6h2aCjIgexeoMQyXN3GspTT2hM5XTGSzvngR/pjUsD7fLzTpDhW0Cio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TFzvu3TM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448AdwGO004571;
	Wed, 8 May 2024 17:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/Znukd4a9vLSq9iBLbwtwUpukVCClnHX+oVKK1a4Xt0=; b=TF
	zvu3TMcIOUwm8GBVp/ldWxW36oCkAt4ZOYYTGvC6F3+1sO7FtJb8CAu8VbhWSOIo
	QfVffpwYP91IfD99gHNMA01AYaD7Ke9/WSDuek/1G3CAAyiYj6UYBp7LAG+A4Rzu
	pS5NFr96cPwgbVA883vpRbdd3F79RT670FWa5+bw2ZCwn0BovKwdkCEmTs8GwilF
	umqb1KVhdsAyboNyfDcd/Jm2CozMHyPwlSn+QBqGnoehdIioWWJwWXNSFoAaAjvZ
	2kuSB36mSJYMj+dJaCQC8cp90m/wcTSLqNWuqjYQvJHGa+cfgEVLScmz7gfHnx/Q
	gCKn1or/wKIFGVW3qlrg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y07u9905x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 17:28:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448HSWkJ024231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 17:28:32 GMT
Received: from [10.227.91.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 May 2024
 10:28:32 -0700
Message-ID: <88beaf14-5b78-4d8d-a196-4f3ce4f2c361@quicinc.com>
Date: Wed, 8 May 2024 10:28:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/6] wifi: ath12k: refactor SMPS configuration
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
 <20240425221902.11553-6-quic_pradeepc@quicinc.com>
 <d7b57775-711d-4180-b3de-5ab59aad0ec6@quicinc.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <d7b57775-711d-4180-b3de-5ab59aad0ec6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xGDdwCY9mQJIq5d_zXVVA7uCnvROAnfi
X-Proofpoint-ORIG-GUID: xGDdwCY9mQJIq5d_zXVVA7uCnvROAnfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=865 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080127



On 4/25/2024 4:40 PM, Jeff Johnson wrote:
> On 4/25/2024 3:19 PM, Pradeep Kumar Chitrapu wrote:
>> Move fetching SMPS value to a new function and use u16_get_bits
>> to extract smps value from capabilities. This will help in
> 
> s/smps/SMPS/
> 
>> extending the functionality when SMPS support in 6 GHz band gets
>> added in subsequent patches.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> 
Thanks Jeff..will address in next revision

