Return-Path: <linux-wireless+bounces-7613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88B68C4883
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 22:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A387C285E91
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 20:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D08004E;
	Mon, 13 May 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fIifYwVp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD26F067
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633581; cv=none; b=QdSVdsoACApxHdwrEV8yGQkfXweVSP3/kazNPV21IWxzk3BYumIT+xhQx85e8O+zLmz2eKf/aht8J1lVF/dUvR20B/+cvVYOThiNSF3jyKHZRILXGjHORU+6iQ1/EXr7w/2EPwohv9cRRCRQXVR6okOUu0RP+KslYzYZTsasAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633581; c=relaxed/simple;
	bh=gvMvAW8k6jcqR3dm0PHEQbojHnMT1eoi3ncLntERUlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GU4gMAryeLpb91NSnMLd6B2nNYVWwezJUzWR8lbCmSUe+bLmmVdHJHZLTRVhpFmWvSR3Tb8ssLdc9vMvTS42itN0fpuDryaPrKGcT5jhPAK7hA7eCJMW7b4Xty82IjYRiue0oPAo6zgj0BylbRlvDV8i6yxU09OHvWGXH2yIQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fIifYwVp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ9ecQ021855;
	Mon, 13 May 2024 20:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KlAB3PEVnJnHR7ezRDyHLEM4TnsRvS5VHczB2RlIEh4=; b=fI
	ifYwVppIyc2+RQrhoJ6NBbjBhN2VW+ftwyTbreb9Rz0DPy+U8oFV5wDn+1kgFaIy
	NAvs50d3CGHbSGzd47D7oqmTQayuP/nrvtl8pUyLhMnp04XVoiuMjkpn+/JkMwG8
	5r1/nXm8KyGEbokv+gSJpLCue1XRb0+TyS1FzKC1KULMlNe8aG57u05m5IKo2j7x
	HiqYjZsMxJvbEgJnQHMDkPJ26pyhELne99uCq/dpahUsOH4MQBOB+D5Ed4EEfgag
	ZLDmqJGqwvwfYzjjcsUfm1Yi+ZA+kt8PwDFGvu3LI4/H8xGVXhIZu6BZi+QZr7T6
	0eEvRDi4/Dln9/4S4E7Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y21y7vfuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:52:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DKqu8K017585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:52:56 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 13:52:55 -0700
Message-ID: <d12b2d31-2f71-4a7f-ba91-2748528d2aa7@quicinc.com>
Date: Mon, 13 May 2024 13:52:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 08/10] wifi: ath12k: clean up 80P80 support
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
 <20240508002055.17705-9-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508002055.17705-9-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LD00rB1dQ4-uK8pVLoAZqa8UdnuMg2Gt
X-Proofpoint-GUID: LD00rB1dQ4-uK8pVLoAZqa8UdnuMg2Gt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=732 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130143

On 5/7/2024 5:20 PM, Pradeep Kumar Chitrapu wrote:
> Clean up unused 80P80 references as hardware does not support
> it. This is applicable to both QCN9274 and WCN7850.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


