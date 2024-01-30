Return-Path: <linux-wireless+bounces-2841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE41842AA4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 18:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F8DB26BA5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC82786AF5;
	Tue, 30 Jan 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g5lk1OSH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693A12BF09
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634967; cv=none; b=hVUMBqYbLPfHfE2BshGXxQbmkR633UMGx1ZvKRuWuD+c6zJ1+fINF+RmVq5YzMDTlHWeTNy/76jhr2Fw+dLdiufiruXfQV5RjplRsG5JXQ6T2QxAMr3KxnjgRu9pJ1nA/DneCs4JJ3qbbp2dnHRv4KfmOf1mV5MiW/m303jAAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634967; c=relaxed/simple;
	bh=eZ4Rs8TpUgcqnJ90xpMh1ciwJ/iXAdqUJVA+sIcVNNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OOZH4iH7RdgUiizpTsMVD77atFBRteaJVC5n2gy/LS93UF7X4jJgpuo14aAEbQvo4EKtET5jfwb/lTLjescx6YTb0csZpyZL87Hm07uecuk/WvmZbr8ZeTNg5MTkS6DSNXGcDX0oHd96sw/sM37NyL9CiGBRvznvkeGjISmStxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g5lk1OSH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UHCR9T021092;
	Tue, 30 Jan 2024 17:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DCvOTW2vL+gvjIXj2EV8KTJfzfGFt5pO4cWF7soE7KA=; b=g5
	lk1OSHjwGUQALIz/Jvha8Z20Q+ZvWz7q0RZX3l9kbdD601xicruZ8T+xmQFrbzUs
	Zzmrxs0DESJOdjGUoCjEIAZQf78oNHqc1614VbPHwolHufXbFwCGVVWRurUd+VMC
	ln9igi55jjaJftS88hRqL4heiXZxWuALggQJ83PHuXX4EzHDN7zqSfLad3nOiIkL
	mk5rnfb/UvxAG2ObKZex0Ym88NvM4vm5ptb9EyewcDFKToEt43kkY4FxJXzkSdL9
	VTXta/gQMY0KMHvS4UxRtJGkwlrKZTQBo3Ssgxklc8hRCW+l8C+rOMxhXRMbP60R
	2KgCYSFgDj+t8GNlESQQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy4rq82yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:16:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UHG2fj028436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 17:16:02 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 09:16:01 -0800
Message-ID: <6cd96388-a832-473b-bf4e-cff7b8f5a121@quicinc.com>
Date: Tue, 30 Jan 2024 09:16:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] wifi: ath12k: implement remain on channel for
 P2P mode
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-7-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130040303.370590-7-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dFOjzrInLoJA82Ux_0bC-zvQ9ImuZUic
X-Proofpoint-GUID: dFOjzrInLoJA82Ux_0bC-zvQ9ImuZUic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_08,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=596 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300127

On 1/29/2024 8:02 PM, Kang Yang wrote:
> Implement remain on channel for p2p mode in ath12k_ops:
>         ath12k_mac_op_remain_on_channel
>         ath12k_mac_op_cancel_remain_on_channel
> 
> P2P device can trigger ROC scan. Then keep listening or sending management
> frames on particular channels.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


