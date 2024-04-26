Return-Path: <linux-wireless+bounces-6933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C416E8B39F4
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22629B23BDE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91C14A600;
	Fri, 26 Apr 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KnUgEL9B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9114884B
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141603; cv=none; b=fb6XlSqI4SSLoa4prh0wS1fl8PmADdwAJUPHkQFxoB8KiS1h2QpNHxmiH0gYIkyXcDCShTD+47Ryj68vnL8EIo0gIvHFEysohlK7touXU1OyE6PS1rYn3JJv9vrH4GpRCUhIYWxZfqya1u4xWP1426nZPwot1zGvqCRq8o+3daw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141603; c=relaxed/simple;
	bh=Q36UTtyChLbp/tP2u+r5MvIl6k3n22K2y/PmAKl/t8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UZA4h2swNA+w95SKFj8mW/SKD3FhJpXsToSgTvMFWS0X9qgOetLXkDpa7OOff4KFNffmn1kbZNK32J59DKGcS9bjffLsTSQbWI9LFZqT0m5UkdCVwop4xZa9vh50LdxSqucJulXuXCdun5ASfcVaLJPy8ldMSKJuY8OTu6RV6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KnUgEL9B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QE0NdT018165;
	Fri, 26 Apr 2024 14:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bxpfBaSY7XWTED3Ye4K61KzTz8WRpqE4sxVVo0t+tJ8=; b=Kn
	UgEL9BJOOa1EycoAAiaa4iaIOT9EdSQn+VOa3cVWBJQ/+VjnVQgq0xEJcOsgybLO
	fOJqc59Go0Trky0ZrZSnQgifUGMU1yGTgt65+EP3h7EorOuvfVQul0DnBcOMrWT/
	F6T86x4CtgOeJf/jtQJGpfxit9b43/v913qz4INDgGl4nOjNbKTKxx6l6nIxRX63
	5UDf+gunmtzgQsg2JjuSk5Vi3ls2s27ZsX+HdLAUQZPnHS6nu17UHZ0lhQovVz8Z
	ktaEOBd2iQRbQQNaQIiwBJ8SbjMfLP/Kw382BXAsMAXi1MlBX5aft4kYtMQv+m04
	BlBtJS9gbTtpYjEaDS1g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrdmr025g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:26:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QEQXI0005043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:26:33 GMT
Received: from [10.110.19.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 07:26:32 -0700
Message-ID: <e5500935-6ef4-4717-9d94-3136da197262@quicinc.com>
Date: Fri, 26 Apr 2024 07:26:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] wifi: ath12k: move ath12k_hw from per soc to group
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
        Harshitha Prem
	<quic_hprem@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <20240425055759.1181165-9-quic_hprem@quicinc.com>
 <a02ee04a-23af-4103-bb0e-2b989a59342d@quicinc.com>
 <6e2df4425fe442ce8c6a1afd56dbc4da@realtek.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <6e2df4425fe442ce8c6a1afd56dbc4da@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cT-Qn61J_oZrcZH_mxAbOrwnKjz9_GLR
X-Proofpoint-GUID: cT-Qn61J_oZrcZH_mxAbOrwnKjz9_GLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=867 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260096

On 4/25/2024 7:33 PM, Ping-Ke Shih wrote:
> Hi Jeff,
> 
> Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>
>> On 4/24/2024 10:57 PM, Harshitha Prem wrote:
>>> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
> 
> Will patchwork take 'Tested-on' tag you added automatically? Or you have a
> local script to add that tag. I use pwclient to grab this patch, but only
> your acked-by is added automatically. 
> 
> I have this question just because I want to refine my workflow of patchwork.
> 
> Ping-Ke
> 

Tested-on: is not an 'official' upstream tag -- it is our own invention. That
is why there is a blank line between those tags and the official tags. So
those tags are always managed manually.

/jeff


