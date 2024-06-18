Return-Path: <linux-wireless+bounces-9144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E8290C92A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F441F21B11
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BAC43AA1;
	Tue, 18 Jun 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bJ53wUid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD432B9B6
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705905; cv=none; b=ngmURZwRf/f1f01YbTb/yeH5+iD4CJEwf/ryRXMRCsN0FesmaqgmnEYwfLsYWykFzK0c7xpKvCoXEjoWNi04Y8fHLHWSMdnRgP04CooDz3+9tf9So6LpVT07WkDQUpQ4LB8UHo2nbzIj5A9725rfDLwzCDqdiINYC4dgR8owYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705905; c=relaxed/simple;
	bh=yf3vquqbPUHcJuJ2Z5SsSY3DnZEIA64HRclGKvFL75Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c/weGCgDj3iDVTLYo9x+gm1IOYYGYdB7HB7eaWrGt/Cg7sLbbK3Lseq9zYESRFXOVv6q19ljdEI/rDPmChAB3qu9vvr369xFQhQ6zAJdESftrWhAOA0floltqbwrOnSkWNtyJNbfF70UUtALbsAddhH/LfQxwoDKxInGxkRGLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bJ53wUid; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I8MQje023008;
	Tue, 18 Jun 2024 10:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SiRK/V9uXo4IwdHQ1b4a/xc9UcBByoDKp524xt/+JUg=; b=bJ53wUidfZA8dpmn
	2KZ/cT+UgrggNNVxAHWPssvbJbpD7BtQmC/16yzGQL0NJzLJVNZsi//WjGMsVfGN
	iD2dU5FseKKOdqv8tIAVmW0wBcK6Tt/oFbfphfXu55a0Vmm1aYxanftL1pDQjNJq
	sAb2pkld3bvK3nwrFBYxITvYH62+IOBavLvuRo3YuRsPd2g5uN0WHUMOe1dAT13w
	VxRqp/GeTL1Rwei1C8o3POPkvZ3hZDmB2fVFm76cpzO1FrPsI3dBT5jC3zaK2Sj7
	waxAWFdDIkwZWLNVzyy0mGIm57Z7spZPVPP4yj53lw9syO1ANq82Fn46r7VF9+/k
	VO1ihg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yttyr9nx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 10:18:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IAI7Wu013138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 10:18:07 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 03:18:05 -0700
Message-ID: <73182626-9638-49c7-a536-332415310595@quicinc.com>
Date: Tue, 18 Jun 2024 18:18:03 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
To: Kalle Valo <kvalo@kernel.org>
CC: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R
	<quic_srirrama@quicinc.com>
References: <20240617131650.3288118-1-quic_ramess@quicinc.com>
 <20240617131650.3288118-2-quic_ramess@quicinc.com>
 <3754f5f3-0e67-4c5e-9b56-888ad5071622@quicinc.com>
 <87ed8umysh.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87ed8umysh.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: endHykqvqBmoSwqaOMMUca0bmdw7wgbG
X-Proofpoint-GUID: endHykqvqBmoSwqaOMMUca0bmdw7wgbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=411 impostorscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180076



On 6/18/2024 4:37 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>>> +static inline struct ieee80211_vif *ath12k_vif_to_vif(struct ath12k_vif *ahvif)
>>
>> better naming as ath12k_ahvif_to_vif()?
> 
> Thanks a lot for the review, I appreciate it. But please edit your
> quotes, having thousands of lines of quotes makes use of patchwork
> practically impossible:
Didn't notice that, will do.

> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20240617131650.3288118-2-quic_ramess@quicinc.com/
> 

