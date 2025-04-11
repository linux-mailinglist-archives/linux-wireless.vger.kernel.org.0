Return-Path: <linux-wireless+bounces-21429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA0EA854D6
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C3A466BDC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7F627CCEA;
	Fri, 11 Apr 2025 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LFJfoWyK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966627CB1A
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354678; cv=none; b=ajv05+nO5xhGlg+4NKqbUUMWiQ5JZKetwZks57MULesf/ykTZHH0WTPVS8NXR+A1YEkisWvhq76h1jRZY1xj4vDoK8R32C4+iwUxNCex9Zhht47D++wovKZpD/tuV3EgfNdyjSccPBE1DG+NTFuR2gupMntRDr3P83luCYAVJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354678; c=relaxed/simple;
	bh=pg0Rm+UMLqc7rPB18db/zqWANyW0YkoTdWc4tgbfvSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qziAzagcozVlvLWmCItog4EL6N1nsJ1/y30AZpCfMyf77/dCvaLQHFokMTbMhvex8cLS1mjlZq2d+u95dNiS6b/I9ztW0vqDAHWB9PZBT0di6Rx2xdO524DlW9oKyozJl6xAVoX0u5CqNT5bfjOzOsXLbPTw1uO6T7frp8LGvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LFJfoWyK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ALUDuY022952;
	Fri, 11 Apr 2025 06:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aQMWegePLQiS8NqXwuv0T8SS9vuQL5A7QhIATb43Z3A=; b=LFJfoWyKRUqsR3Ni
	b0Q9NAsRc6CHEehpkxLA3OK34t8EHg8QOVGhBy93kABaNjNg5ZGE5hPk0+v1+NRs
	jQTdyLWb/KNghRj/N1q2rDN25FvaUYMB3TJu+92QEy5cnPeHoRP61utVCZuEd1aW
	x2O4TKTg6zOG4RN+6auHLZooO+Mcqwlj4NwBuL3Cd7SKsbtvILY3M8OR7n5xSNGe
	KxqZgsViMSKkUtk3ZCecqVgmoVO8kw8dKllmNQ/Hd6lBJkKthIbgo49dyPzUUMMA
	IMHVXOc4y+xV5Q3b82wgHHpvPmSC+6Msj0xa0+4npnM/XIrAJtiR7X8eGoXp5bNo
	/TRuQg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtb9kpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:57:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53B6vrmH032274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:57:53 GMT
Received: from [10.50.62.95] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Apr
 2025 23:57:51 -0700
Message-ID: <a47a67e4-5756-459d-b49c-6e517b37e492@quicinc.com>
Date: Fri, 11 Apr 2025 12:27:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 2/2] wifi: ath12k: correctly handle mcast
 packets for clients
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250411061523.859387-1-quic_sarishar@quicinc.com>
 <20250411061523.859387-3-quic_sarishar@quicinc.com>
 <24179c31-f351-2ed9-2699-d98615742d4b@oss.qualcomm.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <24179c31-f351-2ed9-2699-d98615742d4b@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M1N4wQBjRvhba2WnziIJxoqSV8ClcBrb
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f8bd71 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=wQAdryeFk3HcVtR1vyAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: M1N4wQBjRvhba2WnziIJxoqSV8ClcBrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=593 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110048

On 4/11/2025 11:55 AM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 4/11/2025 11:45 AM, Sarika Sharma wrote:
>> Currently, RX is_mcbc bit is set for packest send from client as
>> destination address (DA) is multicast/broadcast address, but packets
>> are actually unicast as receiver address (RA) is not multicast address.
>> Hence, packets are not handled properly due to this is_mcbc bit.
>>
>> Therefore, reset the is_mcbc bit if interface type is AP.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> 
> Should there be a fixes tag?

This patch independently does not fix any known issue, this is required 
because of patch 1 in the series. Due to 1st patch some existing issue 
is exposed, to address that 2nd patch is required.

