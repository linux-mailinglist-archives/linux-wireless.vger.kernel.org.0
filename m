Return-Path: <linux-wireless+bounces-3869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A085E42D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7551C22B3D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA785839F9;
	Wed, 21 Feb 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pH3GaQar"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A183A0C
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535670; cv=none; b=UNTYMbceA+9lkOiHziBaO823PNU/cK5YgoX8XQMvBMdQ1dMFeHXLezn9qOZmvg/bEZ9Jnnq6fiMxC2/gwptdn5R04AeB2gX3c1AlvTGVcBPg5gJJ6KPRKA9GUINU+0Uq5Rh8Z+ONAsIc6uG38YZ9QtMMV0usoctTkYvCzWqI28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535670; c=relaxed/simple;
	bh=dAKbVjZeR40CA2/ysh7OgJdA1+H+XP24rRphn/kmeP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nUPNjjq60IAKwrrxEe3DuqZdikc3Hl487ihTQdjh1+JwtDwo8cHFipj1xuntyXZGowEhGdJgJ8Z2s41fdfJYr26gutJkNcFw6ZFD5UwxpO4owCYuO/jTzHfiJeTnCqSdVnbqYBprottF2HThOUsOBK03XQ8sMp2YLCBYl1Gm48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pH3GaQar; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LCs4lM002699;
	Wed, 21 Feb 2024 17:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JFKsWSMH1wT9/nviMB5tbVoBa26crR99WH6fhbTJAqc=; b=pH
	3GaQaruKUpqv9dobWlCKtd2xWtlsMsHD39yP67ldK1rxFDu/jLmGWkZnEkbzbhhM
	fIQg/JKHD78FL/Z9tIKoFDJdn4PAtVvI7IGgFkzZtIP2REyyxBZplh/FgZo1MA49
	rc44DDmxggibeQbb6ZTulAUdozwptKLXe9db0k0yNtvqUmECWoYLpKX2VLDPy7aF
	QrbP2mKwSbed1/A6DkTkfMMAkIRW38zF+SYegq1m3eAV4V9zAgCVCDPN+kmG5LdZ
	xeXW1DgyUd66Xd6YgYq/tqyCXIPGvZWAXnCBfURV9tLYUXxUMa32P4oIdrg+OSEl
	gNMfTC4yBsLzzlfdImJg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd22s2mdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:14:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LHEO7a024672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:14:24 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 09:14:23 -0800
Message-ID: <8160c395-939c-4d39-b9ee-0d0b780bb955@quicinc.com>
Date: Wed, 21 Feb 2024 09:14:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] wifi: ath11k: do not dump SRNG statistics during
 resume
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
 <20240221024725.10057-4-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240221024725.10057-4-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0Xr-DsvXWXQAiNy-1R0Oz4Mdcn7K_3qI
X-Proofpoint-GUID: 0Xr-DsvXWXQAiNy-1R0Oz4Mdcn7K_3qI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=725 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210133

On 2/20/2024 6:47 PM, Baochen Qiang wrote:
> Both the firmware reset feature and the power management
> suspend/resume feature share common power-down and power-up
> functionality. One aspect of the power-up functionality is
> the handling of the ATH11K_QMI_EVENT_FW_INIT_DONE event.
> When this event is received, a call is made to
> ath11k_hal_dump_srng_stats(), with the purpose to collect
> information that may be useful in debugging the cause of a
> firmware reset.
> 
> Unfortunately, since this functionality is shared between
> both the firmware reset path and the power management
> resume path, the kernel log is flooded with messages during
> resume. Since these messages are not useful during resume,
> and in fact can be confusing and can increase the time it
> takes to resume, update the logic to only call
> ath11k_hal_dump_srng_stats() during firmware reset.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


