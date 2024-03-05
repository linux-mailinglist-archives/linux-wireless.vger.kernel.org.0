Return-Path: <linux-wireless+bounces-4365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABDB8713D2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 03:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172E428250A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 02:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303ED286B3;
	Tue,  5 Mar 2024 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QmLPtcIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BABFC09;
	Tue,  5 Mar 2024 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606813; cv=none; b=Mc2ODbfHAnfhjW5cAVezju2gkVjIYUplsYAqIlA6tNXtAvaDxZ0uT2biIVxrwh5PHbhx8M2zUhjII8jMCew4cZwprktaA2jkh/Djii8h5bI0BanmMhFt5gBZ5JQljXwINIeJUmIU5c+Y82omhxNBlEOOgfsjHd64yYWl0PWS/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606813; c=relaxed/simple;
	bh=wi1O6vhp6yalvefyIniYQ56KvD98lh/d88XSIE2cHYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B7kzdiv6FxszdPnHnMcRLIDfZeRC04hSBd05Wy83BzdX9zF4kkMtYsJiQt824UVWKKA8gn4UNw2DZM6wCXXa5cFaxXohUug2AH9GyCfj1p9Z1+KYiK9rb4L5zh90zynxHHTUW1OIsoeTBlsvQdaj0TLnhMJUWEjB0shtBkiz+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QmLPtcIt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4251P9oS020905;
	Tue, 5 Mar 2024 02:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SPseMgNHICrE3PG4zZrb4tfldUcXoYVBpbVb9JBbf0A=; b=Qm
	LPtcItY0+pli8PXxm6Ob0vNL5aOTGSe62SNnAo+d20x5cu3RqTj50xAkvm7Bvu1B
	NYlRoHeRefwP8a9GXiU82+grWF3K3oTgE8BPG3YDLthhG7xJof9V8zfcA/XNrJQe
	R7oniHUAmkOG0lokCZawIINVqOi8ncYCl/zR8ejE9NDnwNQxK4XaXbOocUUIGusk
	kq4Jkq/e2Fs1IJNFJoDinljcW0IQyU+a2su73O8z5zaVUY2PS1lhR0r+1vsqvf1U
	e68atX43MeKgefzXQ85VqaMLJKtIAH7JchdnJ0EiPaOzjTrGC9mOIoeWUwe1n8jr
	MqC53YI4uRpL87lTpw8Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnarj24xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 02:46:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4252kadZ018363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 02:46:37 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 18:46:36 -0800
Message-ID: <2cfaec27-7b7d-4727-b625-2df5b6879da6@quicinc.com>
Date: Mon, 4 Mar 2024 18:46:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] wifi: ath11k: support hibernation
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>,
        <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240305021320.3367-1-quic_bqiang@quicinc.com>
 <20240305021320.3367-4-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240305021320.3367-4-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: As1TGrEn59R--rOTg5BDEyvIMXJUl623
X-Proofpoint-GUID: As1TGrEn59R--rOTg5BDEyvIMXJUl623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_20,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=856 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050019

On 3/4/2024 6:13 PM, Baochen Qiang wrote:
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
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


