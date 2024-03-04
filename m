Return-Path: <linux-wireless+bounces-4339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DEF870611
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 16:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791641C2113B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9316C47A74;
	Mon,  4 Mar 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WjmK5HMq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D803F9E8;
	Mon,  4 Mar 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567024; cv=none; b=lKxlXDrT1aK4MQy6bMzwasy9fRkTtKzNgeWEmJdq31zruNq7X+/62AYa0EwAohANB56ZvE9hBi5L6lGSAk6Klniejm0W0sSgip48sivFywsSeCWhA3XKIRukQeVX5SPGJcTiOAFPgerHhUAf5PLTU6pTaZSW7dQJp6KE6WCPIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567024; c=relaxed/simple;
	bh=xuZd+cgrnZMlbvNt5kc6N4y+J5AumquEEyJsSE57UGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SEmRr2Ch3b+kkcO7iuAG9LJmvdHMyav/qAM/Uith5UG1BWZl44q9Y3fVau5BtNl1WPfoQQiwOKtNaB3RGJ+PL1b3Mcm9A7ngeojSnaigjX1QaRbWQQtNw4Y6hYaattozPbt4+hxlU8DOdOVtTPnyckXX6a4ih1h9QBfo8SSCgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WjmK5HMq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424DpTpY012644;
	Mon, 4 Mar 2024 15:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=deRVXEzWEHdzZK+Mwu06ZOOus810hUYZYRCV3UNPgGM=; b=Wj
	mK5HMqhA31kVDitqHBmpfSjz408304m6gbeR7htqsgtJ0+RCAQt5Vy2aN5COemd9
	kp2+Du0uDiyouanV0IJVM1YOlGvav/5SkrXC0K9Hdvh1HXkIfYlpGOua/s6tCNce
	oFj31YU5XGOlW0tyUJYMAQx7p+F44bTpLqd8fMamXxoS0/pyRy0LUrJ3SwSeQEOm
	YtrJZnnn8alfzPdm/fAQ/GsM4mryJLgITN2+A5RDrC1akMzU0yP1sRFizmLsIYFr
	WFX2lGwKKwTl7bg0Z9iu6G/8aO+HBkuhoOzOAXpLiAxxHXp/++MaQUJkkQuasana
	z7ghdqASt0d/Ml8qGr2A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn5b39ek4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 15:42:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424FgwxO020247
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 15:42:58 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 07:42:58 -0800
Message-ID: <95c5d498-e00c-4f51-9517-1881a9b3585d@quicinc.com>
Date: Mon, 4 Mar 2024 07:42:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] wifi: ath11k: support hibernation
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>,
        <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240304060932.80839-1-quic_bqiang@quicinc.com>
 <20240304060932.80839-4-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240304060932.80839-4-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hrrJl6C6UIcbQ-X-j1sKrhXvHn1IHjTX
X-Proofpoint-ORIG-GUID: hrrJl6C6UIcbQ-X-j1sKrhXvHn1IHjTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_11,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=692 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040120

On 3/3/2024 10:09 PM, Baochen Qiang wrote:
> Now that all infrastructure is in place and ath11k is fixed to handle all the
> corner cases, power down the ath11k firmware during suspend and power it back
> up during resume. This fixes the problem when using hibernation with ath11k PCI
> devices.
> 
> For suspend, two conditions needs to be satisfied:
>         1. since MHI channel unprepare would be done in late suspend stage,
>            ath11k needs to get all QMI-dependent things done before that stage.
>         2. and because unprepare MHI channels requires a working MHI stack,
>            ath11k is not allowed to call mhi_power_down() until that finishes.
> So the original suspend callback is separated into two parts: the first part
> handles all QMI-dependent things in suspend callback; while the second part
> powers down MHI in suspend_late callback. This is valid because kernel calls
> ath11k's suspend callback before all suspend_late callbacks, making the first
> condition happy. And because MHI devices are children of ath11k device
> (ab->dev), kernel guarantees that ath11k's suspend_late callback is called
> after QRTR's suspend_late callback, this satisfies the second condition.
> 
> Above analysis also applies to resume process. so the original resume
> callback is separated into two parts: the first part powers up MHI stack
> in resume_early callback, this guarantees MHI stack is working when
> QRTR tries to prepare MHI channels (kernel calls QRTR's resume_early callback
> after ath11k's resume_early callback, due to the child-father relationship);
> the second part waits for the completion of restart, which won't fail now
> since MHI channels are ready for use by QMI.
> 
> Another notable change is in power down path, we tell mhi_power_down() to not
> to destroy MHI devices, making it possible for QRTR to help unprepare/prepare
> MHI channels, and finally get us rid of the probe-defer issue when resume.
> 
> Also change related code due to interface changes.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Tested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

As was the case in the MHI patch, this looks strange. If you are adding
Kalle's SOB just because he was a proxy for v1, please remove it. But if
Kalle provided significant modifications then you should add a
Co-developed-by: tag.

/jeff

