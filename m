Return-Path: <linux-wireless+bounces-7014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821418B67B5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 03:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2114D1F226F2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 01:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280541FBA;
	Tue, 30 Apr 2024 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NJsXV8jI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31041FB2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441899; cv=none; b=j6Y5vsLX1+CahEVAeg+xehUOsVmCVgCjt8u7IJgrc0/MsB57W8jzJhtcEh/nfSeJyRoO6lRIRP5ApriVwWyGwIdZBrvxKkV2Rr8VvojUdzG/uGjCmChbkzd7Mc/aVYi/2N18MhpQm+dP0jiSIO59TZhMyCrrYK4a+VqG7iE0DD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441899; c=relaxed/simple;
	bh=tLIApoA7utxzo5dYrNXe2xjbRPoz7eshH0MXdJd4VZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EBaRJcArMT8ljDCM9785rWNXmBpLoqYBLEo1+8gTSpd9HWuQ2XOtIfp+6Xepu/VP6950H7pzgrVyxVdDgcdsf7kijGq3YiIo2SKWsHJXPKhcX09JmQ0Xsvm8BuSIJfd8eBX6FUXhVc9ce58E4izdzGli0VideE1NIh4+bxDpfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NJsXV8jI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TMp1bY002388;
	Tue, 30 Apr 2024 01:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kLV9jDQC6ISn9JYyf1c8SVeqZuQ+/rZ02Rk06O3kNGs=; b=NJ
	sXV8jIz1x2tS9HaH7lWkzNklOjpaH2WF+muJ7fYFMmbbrm65vjLltxDOmDZ0p+0h
	cHLcClK+LGPR06hRtvIQVSgQ7HR2z36kGml/MV0xNvS27ZoRyyG1UnKxYj0Cc40y
	EPKt470iv+TPek2pkC0WVcDe7hreMSQ4TUy+exa0wmMCz80DA++KkG5PpyPUSS4I
	ybVceAnBryH/AZUJseYtUPwOVRVUw0a92wTwiK4umhoTnb1CMhcNI22SRk06S2p2
	4j4itRbuN95sZQNVBTQwjrOhyCwS8VRrpU9asQZjXeHNZyKuDCvHHw4Hr5BXM+x+
	CR2Gn7Ex3eG4pNf5nfGQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtm3ugqwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 01:51:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U1pWid018177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 01:51:32 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 18:51:30 -0700
Message-ID: <e32ac83d-02d0-45e1-acac-7a466cdf41e3@quicinc.com>
Date: Mon, 29 Apr 2024 18:51:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] wifi: ath12k: avoid duplicated vdev stop
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240429081525.983-1-quic_kangyang@quicinc.com>
 <20240429081525.983-3-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240429081525.983-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0VwLEW_rgIoLGnK6dfldd_foqZHxdUk1
X-Proofpoint-GUID: 0VwLEW_rgIoLGnK6dfldd_foqZHxdUk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_22,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=799 adultscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300012

On 4/29/2024 1:15 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> ath12k_mac_op_unassign_vif_chanctx() will do vdev stop in
> ath12k_mac_monitor_stop(). This ath12k_mac_vdev_stop() will do vdev stop

s/This/Then/?

Kalle can fix this in the pending branch

> again, then might trigger firmware crash.
> 
> So add judgement to avoid duplicated vdev stop.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: c9e4e41e71ff ("wifi: ath12k: move peer delete after vdev stop of station for WCN7850")
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


