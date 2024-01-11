Return-Path: <linux-wireless+bounces-1685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C882A6A6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 04:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3ABD1F270FC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 03:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88FECD;
	Thu, 11 Jan 2024 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gAZaNDF6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA07EC0
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B3o2P8009204;
	Thu, 11 Jan 2024 03:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UVMt6fToAllQFrClvWILlYgLYF+6BORiv9l1L7NxkKs=; b=gA
	ZaNDF6U/NUgXOVCOVXj1WyFIUEHAjs438ilZd9e6ndPqXcZEEUJvbi+eQHltv9yE
	Nkgqxb0B3DNiUTE4OXiOzzFwASikyOvjvxrQtLSzAe1OWcG+YqSSYefBxBkHUyE4
	aQ1boE9zPucnTepZ905dc7otCTfyRwB+JqNxm4tAlFWC8/3x4lzAieFqe/pdpndc
	atrftVSfuhK1iFVbz9Nm5Xt0HIqm4LO12H5Q+pjjIiocdsWHsIUsJcrzXN05J38o
	yAxRi1uRah7BZE1mnzJnk6EOSfgeroy+CLGsCllUI+zyit9gQOGrLDRYzj3uKDFU
	fLLIVtHuunzTXWeBnqLA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhuak1shx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 03:51:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B3pmiN026079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 03:51:48 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 19:51:47 -0800
Message-ID: <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
Date: Thu, 11 Jan 2024 11:51:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org> <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D-D0YlF1A-GtY3t7Ei8om8a5L3O7tLue
X-Proofpoint-ORIG-GUID: D-D0YlF1A-GtY3t7Ei8om8a5L3O7tLue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=611
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110028



On 1/10/2024 10:55 PM, James Prestwood wrote:
> Hi Kalle,
> 
> On 1/10/24 5:49 AM, Kalle Valo wrote:
>> James Prestwood <prestwoj@gmail.com> writes:
>>
>>>> But I have also no idea what is causing this, I guess we are doing
>>>> something wrong with the PCI communication? That reminds me, you could
>>>> try this in case that helps:
>>>>
>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>> Heh, I saw this pop up a day after I sent this and was wondering. Is
>>> this something I'd need on the host kernel, guest, or both?
>> On the guest where ath11k is running. I'm not optimistic that this would
>> solve your issue, I suspect there can be also other bugs, but good to
>> know if the patch changes anything.
> 
> Looks the same here, didn't seem to change anything based on the kernel 
> logs.
> 
> Thanks,
> 
> James
> 
Could you try this?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k/pci.c?id=39564b475ac5a589e6c22c43a08cbd283c295d2c

