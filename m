Return-Path: <linux-wireless+bounces-5705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDB8937C3
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 05:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32C6281B7E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 03:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8B846B5;
	Mon,  1 Apr 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fCdOgJOH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B02138C
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711942216; cv=none; b=oVcYLF9nOvAzHDLZjHscuBnLr1iqw87mmICoTluS4cIGe37YUYCe4FoD9NWYr2bUwwPPYfGrxsn5KIXW+45fskK0xW/DhMQGsRqLdkTqe8AVBF269+aZw5NVhyWrPvTz2qZQYyp3FgEQtyngpBZMgVAv0Ue6RTnAXYLFcibK4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711942216; c=relaxed/simple;
	bh=fLQfqi8sG0zzGcDSgtXM73hc7NxgVvTIPMnjMBwDmLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P/V1/dQW0MJGvmDCQJItrNPVwD5SfjHgW2KW1tCWWZtI1ILuxqcajzPvioiMqQaC2RjFLuZbZ7307VKLjJXL5vHVurhbADBB57ZCc2qJHviwvb1KqL80vtyywgLrl63c+fsiS6XN1g5Ibo59KalEQbse4SXTYl8L7a/jhFMCSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fCdOgJOH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43118ouh020552;
	Mon, 1 Apr 2024 03:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cSojqtgQkPXkc6/pNQm/dipSaLKF9ovzc/xo4XVz7Ow=; b=fC
	dOgJOHGsUfLifxvk19709OubVi0oqAu3x7ljoolcS53WsCTNBm4NJ9PVZRybnRdX
	h8uAVjKtp4D9LZsm0EKATKJvDqTKpRR98Vtpz2R07eROkVdRXh0tQzUMdAHpTT94
	NsdedIOAeaGcFLWeQIZC6RptFTrTockCUHS4IRMfsEdyxHXBkCluCc7+nTaYI9Ru
	umUjOj4GuYa7Iy26iprd90Z/Ho/ljDoZNzwUJhy3ykevdc57NAq7Wz/Vp2ls57jA
	Gu7OVY65JBlVvmqGjG3yRHyS0bWCzJp4uLRSFm2er7ymuWm99Us3mtoe33vdnRIE
	7CVm79LwtdkqyDuDfA7g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x69rbb1uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 03:30:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4313U9le007168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 03:30:09 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 31 Mar
 2024 20:30:07 -0700
Message-ID: <6e8fe8cf-315c-47bb-b8db-5b17f7323109@quicinc.com>
Date: Mon, 1 Apr 2024 11:30:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k failed to enqueue rx buf: -28
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        James Prestwood
	<prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
	<linux-wireless@vger.kernel.org>
CC: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <5c63a3a2-29fe-444c-96f1-f87c89d7af39@gmail.com>
 <216b223b-e871-42d4-8e53-59dd64efe4b9@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <216b223b-e871-42d4-8e53-59dd64efe4b9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zou7FNRr0pFX8hhgPz-Sj0WuaF4eJN40
X-Proofpoint-GUID: Zou7FNRr0pFX8hhgPz-Sj0WuaF4eJN40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_21,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=816 adultscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404010023



On 3/30/2024 2:39 AM, Jeff Johnson wrote:
> On 3/27/2024 9:25 AM, James Prestwood wrote:
>> Hi,
>>
>> This error was brought to my attention in the kernel logs and I'm
>> wondering if it is of any concern:
>>
>> kernel: ath11k_pci 0000:03:00.0: failed to enqueue rx buf: -28
>>
>> It seems to happen every few minutes or so. I don't notice any bad
>> behavior associated with it per-se, but maybe its an issue of some
>> buffer needing to be increased in size? Does this mean a frame is being
>> dropped due to no room to receive it?
>>
>> Hardware we are running is:
>>
>> [    4.610399] ath11k_pci 0000:03:00.0: wcn6855 hw2.1
>> [    5.777030] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb
>> board_id 0xff soc_id 0x400c1211
>> [    5.777039] ath11k_pci 0000:03:00.0: fw_version 0x1109996e
>> fw_build_timestamp 2023-12-19 11:11 fw_build_id
>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36
>>
>> Thanks,
>>
>> James
>>
>>
> 
> + ath11k list to get more specific eyes on this issue
> + bcc to internal list as well
> 
I will look into this.
> 

