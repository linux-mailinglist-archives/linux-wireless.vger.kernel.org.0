Return-Path: <linux-wireless+bounces-3687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7CD8582E9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 17:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817111F23C9F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2FE12FB1F;
	Fri, 16 Feb 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cO2+ZKjU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8243687
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101967; cv=none; b=KdAX6fuqy1pPGL2yEiqPQaZk3PiUyha6/3Zylsbkj4XJFP+9oanyV+QcuMnWNL1gf2H+5Fd/IFRPFTWSR4dY8s3sWKupNTEYJn7DAVa+AtfVTNZ3v2QbESZcdVvujR9Unky/AvXCPrE2r6IOjOF3oYPGaDkH3n8Ucr6kPv1BwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101967; c=relaxed/simple;
	bh=38It3I6CYGpQ9keeSbjdPNzHB1k3sGKuTekEnOSxTAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jE29pEQVJiWTcr2LzRn0jMpParC+pMYkkqKdQFOLzAtr+abfRX0bPL4eX+DTOQunOavHYJZ9jeCcmXmW6TfpKZI8/9IKehRNpGQ1qLOF0Ew/eMibvjh2Gojm9Vza/OKT/8oC5kG9lI4fpfHAkO1adlscx8kw+ZXlKAUUUhxYs6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cO2+ZKjU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GErVoN025495;
	Fri, 16 Feb 2024 16:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vEH9reJzSJ6u2KRXYY5q3/m7eSnbXCysrVPfSl4mIok=; b=cO
	2+ZKjUtzH/0Eo4663ILJkucvbxpBBF0Drpz/UlmycJ5aVaNGMk077vv1ooK4QjLi
	LiC9pbcb5+tsMwdWwSNDlniXIPLQZ3taK8vrWHHSkC/o4GRpdOJIMxJmWUeZ1gpz
	xXsNLX1SXpJGnfuFdPgJMprvwQTdunut6I4L2Jy5vndKn+QGYML3IAIfSd7xvYki
	XNBgo2yUfhLUSj+EFzgoSHh7isPC8x2D39+4ZClNoN1g5+xXHGD5rLgCx6Iu/9YH
	W998F1SS4t7y1WWoYWmmnSxhiy9jpbAFBd+gIrNG/Bni87P45AKEmgcYHA+Si9gf
	LXNMH5+T13T/CCqrBAgw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9xdx9gxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:45:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GGjvVw024458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:45:57 GMT
Received: from [10.110.53.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 08:45:57 -0800
Message-ID: <2368ff4c-374c-4203-b0f8-f8a761370310@quicinc.com>
Date: Fri, 16 Feb 2024 08:45:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] wifi: ath12k: modify ath12k mac start/stop ops
 for single wiphy
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R
	<quic_srirrama@quicinc.com>
References: <20240206091954.4144454-1-quic_ramess@quicinc.com>
 <20240206091954.4144454-4-quic_ramess@quicinc.com>
 <8734tsnz8i.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <8734tsnz8i.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z7dAGSns-pLpK4OF1P5RbF_cgYslsxTp
X-Proofpoint-GUID: Z7dAGSns-pLpK4OF1P5RbF_cgYslsxTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=562 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160133

On 2/16/2024 8:35 AM, Kalle Valo wrote:
> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
> 
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> When mac80211 does drv start/stop, apply the state change
>> for all the radios within the wiphy in ath12k.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> 
> I haven't reviewed the patchset fully yet, first quick impressions:

I didn't review it at all since it has a dependency upon a series that
needs rework, and hence I figure this series will require rework.


