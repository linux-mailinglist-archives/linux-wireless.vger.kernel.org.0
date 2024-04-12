Return-Path: <linux-wireless+bounces-6258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803E28A30C9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD3B2813CC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162B713E890;
	Fri, 12 Apr 2024 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h1TrNMSk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D3213CA91
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932586; cv=none; b=qh/RlBsgnHV0jY86bW/htn1p2VScdX++4kbSAJwd5JUHQuRu2v5cscLbfcEjD2u+X3s2qrHhxZ86CscxRe4PfAupAHN+iR4aJwEyRFgNozyjSlNjSN6huU+RjVmpJNhVxB4gB6O3Oo+h+uErxY9z62OUfbGSsgPzXo2x5GYbnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932586; c=relaxed/simple;
	bh=ptCskjwLuGe3xu4heDr4BdcQZS+YlPiOQBpov+2FISQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VqLK2szrtVZJJl8aB/ZQwYtCVCnPF1k645RueIBJORSx3y2fVEG0/zzf9E4o2U3QshqBLZeUhxvB/MChPVWHf/IhOO08+SiKqIsWb9Rvksww1SyDqD9rMY5fVSBMIv6q/GmFY4tPybbYYRgZHda3BkIfuqZOvf2VoPHruRF/QzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h1TrNMSk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CClT4n010818;
	Fri, 12 Apr 2024 14:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uhvahIrlB8uSeCJa0p0eowW6sGuPWsBdrk2P7izv/4Q=; b=h1
	TrNMSk2qvS6j3irvvSNlU5paGVOzdmrVZ+M40ThLpchIBAmaly+6RmD/9Vxaw/Aj
	zX1XvP3CdG4ndQQAKvML7nHkxc0hRFjJFmZsR7V/93Sxs+RunoKHBvU82iCAb9/t
	hye7ING1LJe87P/HcM7dEGBPSSk+qgkL3EQcOtTLjopIwNRyONl0B11MmMe3Ldyy
	RUXh5EI6HCP9ES+vb47FWKgZYVbuX5NUc4vD2+VAlnI/b4u93YkzOh+tMvaSLVHF
	FkN8XzDiye3Q2Bn7H7e9ACV1kdosm7JwqbLBPZG8xO08NYXhclORQhs4lfvYajqv
	EEDLqxtF9RXbbITRnupQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeyev8xww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:36:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CEaLtD001153
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:36:21 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 07:36:20 -0700
Message-ID: <c6860d94-be1b-4d3b-a840-a7afb143823e@quicinc.com>
Date: Fri, 12 Apr 2024 07:36:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: add support to handle beacon miss for
 WCN7850
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412094447.2063-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412094447.2063-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DCvYzYX4uSPnavxznftwkYIErjw8O_9E
X-Proofpoint-GUID: DCvYzYX4uSPnavxznftwkYIErjw8O_9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=689 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120106

On 4/12/2024 2:44 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> When AP goes down or too far away without indication to STA, beacon miss
> will be detected. Then for WCN7850's firmware, it will use roam event
> to send beacon miss to host.
> 
> If STA doesn't handle the beacon miss, will keep the fake connection
> and unable to roam.
> 
> So add support for WCN7850 to trigger disconnection from AP when
> receiving this event from firmware.
> 
> It has to be noted that beacon miss event notification for QCN9274
> to be handled in a separate patch as it uses STA kickout WMI event
> to notify beacon miss and the current STA kickout event is processed
> as low_ack.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



