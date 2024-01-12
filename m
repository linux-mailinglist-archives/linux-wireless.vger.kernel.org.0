Return-Path: <linux-wireless+bounces-1824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB3082C3DE
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A38285A6F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688FF7691B;
	Fri, 12 Jan 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZOxml9t7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE176915
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CFxORp010509;
	Fri, 12 Jan 2024 16:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sOCEDzel1H4poWe2j3Gs1k33+vb40Ybzkt5feTZDjFM=; b=ZO
	xml9t7o9EWuCAIrVXStrfGEKwVp8YxhnbIWyCfUeIgKnTZQk+aR6mZ8BI9QPY1mg
	lK6x4s22RLKw+l7tf8kw20zvB16hWk6xUt2h94hEz0mpHPgf/jX+PkfZdyGVZwNQ
	k/X8h+E6+XX9jf1KP3H3OL97QgEybVM4x7G1CVjGF6NEijmzmJKgccaIczMSG9zt
	Gs1xzwYlKFkVPorXYYy/u0Ycql92I3MFjlTn2s1UpAcLovlfUQq6dVVSvtnHwrQQ
	zKbWNobzLrGnwLBlObTVxFr4MFILvHKnELfxSOmEDld4p60iNs78Otra7DINX2t8
	lvfHYtoPaTz3BhoBkZuQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk1x195ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 16:44:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CGiP6h018677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 16:44:25 GMT
Received: from [10.110.16.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 08:44:25 -0800
Message-ID: <138fbc0d-4bb9-4a04-986d-c98facb43c9f@quicinc.com>
Date: Fri, 12 Jan 2024 08:44:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] wifi: ath12k: Add single wiphy support
Content-Language: en-US
To: "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <f1431217-447e-4d1e-a97c-e5cea6ff2c36@quicinc.com>
 <606709d9eab84207b0ab73d12e7defcd@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <606709d9eab84207b0ab73d12e7defcd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z1t3RfJ-E18mjPIpzjgWemHo_NwYCVec
X-Proofpoint-GUID: Z1t3RfJ-E18mjPIpzjgWemHo_NwYCVec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=586 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120131

On 1/11/2024 8:34 PM, Sriram R (QUIC) wrote:
>> -----Original Message-----
>> From: Jeff Johnson (QUIC) <quic_jjohnson@quicinc.com>
>> Sent: Friday, January 12, 2024 1:46 AM
>> To: Sriram R (QUIC) <quic_srirrama@quicinc.com>; ath12k@lists.infradead.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH 00/12] wifi: ath12k: Add single wiphy support
>>
>> On 1/10/2024 8:50 PM, Sriram R wrote:
>>> This patchset is dependent on "[PATCH 0/2] wifi: ath12k: Introduce hw
>> abstraction"
>>
>> I'm currently unable to apply the prerequisite patches to my workspace, so I won't
>> be able to review your patches until that is resolved.
> Sure. I believe its resolved with "[PATCH v2 0/2] wifi: ath12k: Introduce hw abstraction".

Yes, I have now processed the prerequisite patchset, and your patchset
applies cleanly on top of that.

As already mentioned you need to add your S-O-B to all patches that you
are posting on behalf of others. But let me review the individual
patches to make sure I don't have any other comments before you re-spin.

/jeff


