Return-Path: <linux-wireless+bounces-4636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E92879DF7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 22:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7992840A5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 21:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC1143732;
	Tue, 12 Mar 2024 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pVwyKQxB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7913B2BF
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280715; cv=none; b=Rtlb2avWqPSdv6i50QpFvKbx3emK10gxSfMqRxDp8c0YpquthzVMlB5N1dp2JFCGatEj96nS8PLBB1DqhGS23WejpS31CV3/QFe0DPMzQo59nVW2ca1ByOs/lqt5d1gnMyjOQho582U42UlqCyVKB279unnT4xKR2KI2nq9Seqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280715; c=relaxed/simple;
	bh=gkZsJDgTOREI/sKLEjsFCSalA75JhB6bgycMEDPQWhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WwVd+now3m2k36NB8fcIWTv/K/f9dfz5C9XvanaRUWH+hgP/KsQ86raQFIdVNY+8KxjgJIdWhhzM8XPKxn8nTZmDMdjYK1RWsS/X/R9i1LoE90MZO7R1/4pLXfPtsqeIh/MNUrlNbBzbSrbXtAdh2/7fLsn/lpPEFb+zSctDVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pVwyKQxB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CLXi7W032245;
	Tue, 12 Mar 2024 21:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=R6fxnjGQ25FjYpI9+FNsWUddqnO8/9u0rGlXt1Yjmls=; b=pV
	wyKQxB/yu9TX8oiDfd08KOaINk65WnPn5vovjWcffzpxlC5yk32ciFT+H+gxqGhL
	M9jKLmLVluM3ll7mSoHvsvAwDoMOrWfK6XB6JFQ+GRVQp9XoKixeE+/7JBB4UoeV
	Qnu064eJlDgoQhT9kJwLMmDKFkdPZz0HWW6sQk5vZiLKN+WdX3OUM6cYjB0tNXjv
	6Y25P5dPWLIjj8bZOwVucwj6wZs+YV7b4dXeoLaetKnaTbxsLzLXibxQZQWkru1G
	2A9wrprWcq+d8Fxt/yQh0vWv/Oz2Y5X/ZzcZpMEId85TSh1U4C3y83piavN7prwV
	ygv0hqErbbwL4UGyhZ6Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtwpur8cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 21:58:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CLwT28024964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 21:58:29 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 14:58:29 -0700
Message-ID: <6615e7c0-5665-4ae8-832f-0ffaffbc6ae0@quicinc.com>
Date: Tue, 12 Mar 2024 14:58:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] wifi: ath12k: Modify add and remove chanctx ops
 for single wiphy support
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-3-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240312135557.1778379-3-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pi3dq2oUajzhFbIuO-CFhHiQhTk2OpxR
X-Proofpoint-ORIG-GUID: pi3dq2oUajzhFbIuO-CFhHiQhTk2OpxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=662
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120168

On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Modify add and remove chanctx mac80211 ops to fetch the correct
> radio(ar) based on channel context.
> 
> This change also introduces new helper function to fetch the
> radio/ar based on channel context and ieee80211_chan which internally
> uses the radio's low/high freq range.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



