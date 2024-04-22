Return-Path: <linux-wireless+bounces-6685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6478D8AD388
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A9286D7A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA63153BF2;
	Mon, 22 Apr 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qc8cEtTx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01448152197
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808328; cv=none; b=IBLtozJOP7HZc7wd8vMf1QCeo1rMRelAgElPfZOwS8IM+8t3TmPwkBKBsenk9FU0fV0iaejQS6x9DaHTX/wcx1NEk59SitKs/OVQR/cbk5x4ERRU3LDUtH0zTqAWMcKE+xZ54Yqg+tDeUnKCxHRjRR7r3rbGsSGXtPAeYpFsQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808328; c=relaxed/simple;
	bh=d3QqXfIzhty6/hT92+vVRbHMeQI1lByYAKVf70KCBoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ghXtamfBPjpl9T/S/i9fXgp7tsvenPQ9CAm3msrd0OFnJQ0+HJnc2SrZ1zYwEpNBHWrAMsMN34ZT9i+hi7sNjG3oOcShpzl7tKui6u79A+DEJBkG021AsTZki9R54Zu5hzkuF9Wg1IqR3VM2a02WNX3o0JRmdWgxH07XTyHiViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qc8cEtTx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MDOKtN003901;
	Mon, 22 Apr 2024 17:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ma+VlJhGdG5yNDRDs+hfr7Rqsb3rzYLQzurgicoqwtQ=; b=Qc
	8cEtTxHZ6mO4yZEV6MqXrv/R/Qaadn2PDtBV3scHT4ZCKtkd68e4m7/NRs5TRRod
	JbSoKFdqTi1fiuNm2oN6HMbdxIOZXR0aP/sFll856LNT1MiJYxiAhomKFraDQKFm
	hzl6E6RDoTYBmFEFuPI8IrWx3hXrUJHLr+YxZlJl84Z1I+aZ2SZyY5N+T8WfgQlJ
	15OcObJj3FjLDQNVEgl1wpU5q2NUYsrKn6x2sPpKJyuPxhkcR6JZQzA6z83Wb4SR
	mUBcaS4Od3aqj2i6bkSRj5D/MY7WzyClaPoSs0hbKHNl4dYJhdnkTXdFUzTPzoFz
	Z+Dg1vDJEf7VVXB4cDzw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82s94g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:51:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MHptFK024416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:51:55 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 10:51:54 -0700
Message-ID: <2295c7aa-5de6-4a21-941f-e9439dc6601c@quicinc.com>
Date: Mon, 22 Apr 2024 10:51:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] wifi: ath12k: decrease MHI channel buffer length to
 8KB
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <20240412060620.27519-6-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412060620.27519-6-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oOMe361UtOczZMF-C9i7kGDgWHUBrSYL
X-Proofpoint-ORIG-GUID: oOMe361UtOczZMF-C9i7kGDgWHUBrSYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=731
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220075

On 4/11/2024 11:06 PM, Baochen Qiang wrote:
> Currently buf_len field of ath12k_mhi_config_wcn7850 is assigned
> with 0, making MHI use a default size, 64KB, to allocate channel
> buffers. This is likely to fail in some scenarios where system
> memory is highly fragmented and memory compaction or reclaim is
> not allowed.
> 
> For now we haven't get any failure report on this in ath12k, but
> there indeed is one such case in ath11k [1].
> 
> Actually those buffers are used only by QMI target -> host communication.
> And for WCN7850, the largest packet size for that is less than 6KB. So
> change buf_len field to 8KB, which results in order 1 allocation if page
> size is 4KB. In this way, we can at least save some memory, and as well
> as decrease the possibility of allocation failure in those scenarios.
> 
> [1] https://lore.kernel.org/ath11k/96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz/
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


