Return-Path: <linux-wireless+bounces-1819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F0E82C2C6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 16:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DBC286500
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C506EB52;
	Fri, 12 Jan 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rnjgk88E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FBC6EB51
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CEFIdA031495;
	Fri, 12 Jan 2024 15:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=h5mVp3/xObHym7rmC2F8GhBk/QnGnpyN1twM5tGTTb4=; b=Rn
	jgk88EFmi1LmE/NRDYYAcTwzqEaqRqidWZOAXub2zZ00SrzofD8C0zSbxb00OU8B
	4W/MwRZO9h8MgLqEtJhuvM2YHh2p02BuYbxQRkVzwWJsn0RVEA2DgF0Yo+831Yms
	M2buxEWpxWap92DaExpw5RByX5AqQl/SDVYuZHMzvRMyxjlBkX7XyvIZXQgp0xhm
	rYUZoTHOkhWqKgruQ6uyS17W9gE8pSaRDa5Ok9C/Mrp3nuxwvwexWcq8LIy6M2fY
	FLhQPag0QlJm57FpSyu+etlWUHaesd/r6n2oKa8L+Rf2pUEDodgxqxNqNTi7jcjE
	P2w+Q+8Ze1EOnhjpwDwQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk4vsrd45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 15:33:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CFXMUF016663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 15:33:22 GMT
Received: from [10.110.16.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 07:33:22 -0800
Message-ID: <2a214850-46a7-4191-935c-8a766063d89b@quicinc.com>
Date: Fri, 12 Jan 2024 07:33:21 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: rely on mac80211 debugfs handling for vif
Content-Language: en-US
To: <benjamin@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC: <lenb@kernel.org>, Benjamin Berg <benjamin.berg@intel.com>
References: <20240111170629.1257217-1-benjamin@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240111170629.1257217-1-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OJieljFLGiGSR4IeBcSmBEtNIxx4axOj
X-Proofpoint-ORIG-GUID: OJieljFLGiGSR4IeBcSmBEtNIxx4axOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=501
 priorityscore=1501 clxscore=1011 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120121

On 1/11/2024 9:06 AM, benjamin@sipsolutions.net wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
...
>  #ifdef CONFIG_ATH11K_DEBUGFS
> +	.vif_add_debugfs		= ath11k_debugfs_op_add_interface,

nit: can we rename to ath11k_debugfs_op_vif_add()?

this would follow the convention used by almost all of the other methods
to use the name ath11k_<component>_op_<method>() but in this case
dropping the redundant "debugfs" from the method

I'll submit a separate patch to rename the method below to also align
with that naming, ath11k_debugfs_op_sta_add()

>  	.sta_add_debugfs		= ath11k_debugfs_sta_op_add,
>  #endif
>  


