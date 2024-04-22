Return-Path: <linux-wireless+bounces-6689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA08AD38C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778281F21C0C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA6152197;
	Mon, 22 Apr 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mysh+ody"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790D15443B
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808336; cv=none; b=Kx+epkhwNwW0lhAPmDVlZCW5Thcf2rQaEoMcu9tiAEpe7rkXx7GNpRFMQhwl6oVCoSgTN26wxHNF8uqjqQ+8HcoQcesMe+50uZI3NHfoioPZTwkZgMb4vxYkv5i6reyWmiCqFBwrhZxhEWdi4Psn2mDx41frUPOQAcBfrb2Hslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808336; c=relaxed/simple;
	bh=WW+03q863luKQo5O86QzFWfZIlYJ6GqzzHzTEghVAss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qy1YsaNiZkgko93pwyYeIAPzoaySWbjKoB8f9HELmUXtS8mlRnTnuvzzLoJMWdXjApT5Vd2UUfwpniqgwodAl64lm0JD1s5TD7PGcRUgGKP8JeVLh1qQgX7ub8DAZGCuJFCO/W7rpTftta0hJImttOuBPoGUfXUq42X9t5Zu92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mysh+ody; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M870vU009346;
	Mon, 22 Apr 2024 17:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EEn0V02AuhXE7r52CmjjMCc8dfhh8auUxTS0XqiCtNU=; b=my
	sh+ody7wywdNhYfzmNuGpxf5r3EhpdZ5mMo3ejSmlhTfTgvvgUMcvnKi3FQVxkP4
	iPTR39+2PDNvFEvEoS1qbZD7Nw3CqNY0nn/taal5HTC32dpW3dhuC6ARIYoZMTLZ
	D365XWp8oCU+qj16k3lCn+kNwcgzgtazEWkwTj4WwEKZIrZW0elfI4L+DFHoGrYN
	y7833oYPaFVRd2/XfT5SnT8eIEnXaOJNX+A9AmunTcOKK/ZiXuQCHBPfOhUINDzy
	m+pBKUmr3mctjM2/fy088noonjc6jZ6PPHG7LXqj/bOKqargpCHoJu5OdkGdgOfy
	gcGF4M/9zFHvEYaxKH1Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4qddag1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:52:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MHqAWk001149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:52:10 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 10:52:09 -0700
Message-ID: <b87f21a8-c34b-42e9-a9e6-c7a31f2375f5@quicinc.com>
Date: Mon, 22 Apr 2024 10:52:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] wifi: ath12k: support suspend/resume
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <20240412060620.27519-10-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412060620.27519-10-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gc3aOPEnO1s2__yG3lsOm8by43XcJGPl
X-Proofpoint-ORIG-GUID: gc3aOPEnO1s2__yG3lsOm8by43XcJGPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220075

On 4/11/2024 11:06 PM, Baochen Qiang wrote:
> Now that all infrastructure is in place and ath12k is fixed to handle all the
> corner cases, power down the ath12k firmware during suspend and power it back
> up during resume.
> 
> For suspend, two conditions needs to be satisfied:
> 
> 1. since MHI channel unprepare would be done in late suspend stage,
>    ath12k needs to get all QMI-dependent things done before that stage.
> 2. and because unprepare MHI channels requires a working MHI stack,
>    ath12k is not allowed to call mhi_power_down() until that finishes.
> 
> So the original suspend callback is separated into two parts: the first part
> handles all QMI-dependent things in suspend callback; while the second part
> powers down MHI in suspend_late callback. This is valid because kernel calls
> ath12k's suspend callback before calling all suspend_late callbacks, making
> the first condition satisfied. And because MHI devices are children of ath12k
> device (ab->dev), kernel guarantees that ath12k's suspend_late callback is
> called after QRTR's suspend_late callback, this satisfies the second condition.
> 
> Above analysis also applies to resume process. so the original resume
> callback is separated into two parts: the first part powers up MHI stack
> in resume_early callback, this guarantees MHI stack is working when
> QRTR tries to prepare MHI channels (kernel calls QRTR's resume_early callback
> after ath12k's resume_early callback, due to the child-father relationship);
> the second part waits for the completion of restart, which would succeed
> since MHI channels are ready for use by QMI.
> 
> Another notable change is in power down path, we tell mhi_power_down() to not
> to destroy MHI devices, making it possible for QRTR to help unprepare/prepare
> MHI channels, and finally get us rid of the potential probe-defer issue when
> resume.
> 
> Also change related code due to interface changes.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


