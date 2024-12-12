Return-Path: <linux-wireless+bounces-16298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFEE9EE2CA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 10:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B2A161796
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25B20CCE7;
	Thu, 12 Dec 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X0EipQOn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95C20E713
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995307; cv=none; b=SQbM3ateDX/ySMXicP8pUfUxf++o11L8+7DdZAYTu1mzNU8+2zjcNZY73eBIuj4XAUJIdEz8cYBcFEmaw0Ndb7DH+6ILUix04Vsh8EIw7U2DZIXcjD8Teyn2VVtLqQyq/Qh8LjXhX0Yccci8wbusutCLR3WgTbGTBcEqtH81ySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995307; c=relaxed/simple;
	bh=CxBRH2HLaH/29+kZKV2b0wONblCMp4VC5TUyt4bDxUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FKC2eqtE0hp/7tqqMCQDdaREBlJUvmKwwehqO1LtkQBTG7sHdNJPGWI/vOUt7P+8SJxUJrMFniyiu1VU/3rGrNbAoxNGd62XjnoyccmYBtCvbcUNo+mA2fFEKBU0XzRSJ7lIPFbcmrx9UUYwDzaS34E9hsrS+TYFWdub9Fjh7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X0EipQOn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7YbXO032522;
	Thu, 12 Dec 2024 09:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ort0GV31p2YM3MvyRNsoGkSoXOVVWpb4ngbvI+xOaDA=; b=X0EipQOn/rTDLZdK
	TOz/fcWTZlbkYaZLywngtoWu5nAZlzdMnfpYnflha6NqomhVaq7otN1o0J0v/aC4
	mNxrv3Efz1HXY4NxrbJW/2UaQL64cnEEMfzLHoU3qRthwFPpFj+pWh51tmWUD7Oi
	IwowjwHb9IHKusNsdtO4n9hCVGt9W1DWDVJCFan5jvNlhjInwxjJAw+3xt9YqUQM
	5/+Buem0Z8HEzJFZfsKsHedGj4YUq9ibu29nFHV+qPhATD2fKvJEN3ADEKgxPD4t
	kQFwqW5XA5cx7uAs8aVddQ+tYPWiH+NgYPB1Y3dYR+UJB61jodF2NHWW9xBhqdf4
	eVz0zg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfbn8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 09:21:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC9LXna002207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 09:21:33 GMT
Received: from [10.50.0.236] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 01:21:31 -0800
Message-ID: <c9605cae-809b-6f52-927e-9bc59a6d9c02@quicinc.com>
Date: Thu, 12 Dec 2024 14:51:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] wifi: ath12k: Refactor ath12k_hw set helper function
 argument
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
 <20241212004906.3087425-2-quic_periyasa@quicinc.com>
 <878qslqr70.fsf@kernel.org>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <878qslqr70.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2I9on2QdY9TfPxn6MG3FGOCgB_rN4xVk
X-Proofpoint-ORIG-GUID: 2I9on2QdY9TfPxn6MG3FGOCgB_rN4xVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=752 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120065



On 12/12/2024 1:16 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
>> ath12k_hw set helper function takes the device handle and the index as
>> parameters. Here, the index parameter is specific to the group handle.
>> Therefore, change this helper function argument from the device handle to
>> the group handle.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> What's the user visible impact here?
> 

No user visible, it just help to avoid the dependency of device handle 
(ab) for using the helper function ath12k_*_set_ah().


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

