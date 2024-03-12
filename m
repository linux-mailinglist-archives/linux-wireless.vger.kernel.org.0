Return-Path: <linux-wireless+bounces-4649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6F8879F9F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 00:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A150282080
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584D46449;
	Tue, 12 Mar 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K+h6scNa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A346551
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285542; cv=none; b=pHbEUHwFhkfeVhbEjeJyL/qziGLi2BcGRR/Z8KV3bt4UUvfWNn1dID9f5qIUWnWAZYHqCTEkzwO1rzZB0Njp9nH9cglJC4/lF96Vvne+ykwLTtyzawU+2FWVDUJUwokzJaNQrnzLmc+sha81RRTM9bRW4hdk32DWsxXdhUfSGMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285542; c=relaxed/simple;
	bh=Gm4DG/xj5V9lMzmBnEva4N13B2+wR+Ytv7eB4CHOrBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YIK1izeOEBZkGUhqIjtzqQSraJ68kg9hQ5fhPMH+noixN6Z5AcNBwhVs21ykNw5P+Zp+y4En01mK+YvZy/8aC+Zfp+6qru5yTeF07luaKvGmQrOgRH2dUGK8j4fcGjHqnTQwY5tdPLd7iG4ZMZY8wzkehZolQy/U2Z623t7hbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K+h6scNa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CN12ZM013998;
	Tue, 12 Mar 2024 23:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cotIPoucwE701AUg342mTXNZJnAldQtZmWJn35Mt/fQ=; b=K+
	h6scNagFrehwp3Om2cpSBQ1HrEshfkv1wV3h9a1KBxQZJUTD1LV1dMmHdpCh4+rI
	2gyy1gXcK+lSOu/wlsTcMU2VE6R88afDpak9zX1Z33jKgwvgoolgctLpd/vJPtZt
	IZ+DjdhVmUdN6wARJB+PjvQIURoGSkTCl6jUlVOeuT42POoQXaSPHmVk5LSMJDAh
	DKWqha+SFJJ8zRuTCSWYHfenTgsYcAFlfnb7kTz5LwrdhaFRMzo1APSFq5zB9/Rf
	lYazqH4uGF+1YErQyeOqCqe0kT4lH5Afw/gqBblBQ8BNRPPGLeOiVYS+Y7+Ogm5T
	Ppr0HiU3zVegscVT0m2Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtw4frh0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:18:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CNIt7h009482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 23:18:55 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 16:18:55 -0700
Message-ID: <57a85337-d0ef-4855-b512-88d49cedff7b@quicinc.com>
Date: Tue, 12 Mar 2024 16:18:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] wifi: ath12k: Modify set and get antenna mac ops
 for single wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-11-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240312135557.1778379-11-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dkMAQ9divMMA7uTtQAMiroQV-g9ofPAv
X-Proofpoint-ORIG-GUID: dkMAQ9divMMA7uTtQAMiroQV-g9ofPAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=849
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403120179

On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> As multiple radios are combined into a single wiphy, and
> the current infrastructure supports only set/get antenna
> for the wiphy, the max Tx/Rx antenna capability is advertised
> during wiphy register.
> Hence, When antenna set/get is received we adjust the set/get
> based on max radio capability and set/get antenna accordingly.
> 
> Multi radio capability needs to introduced with interface
> combination changes to support single wiphy model in cfg80211
> which would help extend the wiphy specific get/set configs similar
> to this to per hw level.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


