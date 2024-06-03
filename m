Return-Path: <linux-wireless+bounces-8436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB8B8D8AB1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 22:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881EA1C2200F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 20:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8F13792E;
	Mon,  3 Jun 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S0ggxyhX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F046A4
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445172; cv=none; b=m+udDUmwEvJbylT/ISCNwcPW4s2rY2yZ70OUng22VECxxq7JvvMz1DMGffPbb8v86vOTS/te+WPLCjdZAzgtnvdntY4MDjmSHed+pRa/TIk7CuElJ2XeHAli99miec9IPo/eQWnykOmghPd+UhOBirvokbc+R9at0wT9rjTRBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445172; c=relaxed/simple;
	bh=homUpHOzYYrLbaQjiF5NPPh7eIAm4THTX/sBQt7yk0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BmZ333Get+jC2D0+sLztrriJ4OE6INxnRDE4eYOeq6uX6t60YokjHE7ODQoQGBkLeOZivKNXo51R8S1YMoMMCUpD2mFKPlSh1Y0NHt1X95WSzjo35KPVQMLYEr0euQE72I7TorMDgxauE9sxpiUL7Uy/9sohpCxXH/NONObsYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S0ggxyhX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453C1HCd014253;
	Mon, 3 Jun 2024 20:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5lbfRk8qESQEtjJkQe/c3k41eelBu0guNMtSq6GXh7I=; b=S0ggxyhX7Nw0tkxf
	VAlZkZ6xDRrusKFJBpRaan+TADFiuSb9V7z+vdA2i1bI/u7Qy2alJ8NXf9Qds5VT
	p6Yn1qAuYCQQjEdUFscVlF2MwooKbVsSqQg2p+fwx8UxwPkh987i1N5hhHf/MKZ+
	1KG9HkDx7ff6AY4oAEcqwLQzRncJtjrY3yRJF2AOUyYOm9ZsNeCnoZ75ACLMzVxR
	Caho5mVHBfkB7xwLiG1AtgI4zVSBKMizi72KL/410m9YolJ7JhDtbRBn0Jk2nmAd
	eww5PRksKMPSKNTzrwezPpL9shDvs4TkgPAEdJHEq4GTOZ8S5L2yrqfSpzzqb5n3
	dyWP/A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4d5276-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 20:06:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453K62wd019041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 20:06:02 GMT
Received: from [10.48.241.139] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 13:06:01 -0700
Message-ID: <28ae372d-0304-432a-92fe-b8fa560c454b@quicinc.com>
Date: Mon, 3 Jun 2024 13:06:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix RCU documentation in
 ath11k_mac_op_ipv6_changed()
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240531022411.6543-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240531022411.6543-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MpRBb5YDsibw1dbFBCTyjrk0Zu99kY0t
X-Proofpoint-GUID: MpRBb5YDsibw1dbFBCTyjrk0Zu99kY0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_16,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=716 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030163

On 5/30/2024 7:24 PM, Baochen Qiang wrote:
> Current documentation on RCU in ath11k_mac_op_ipv6_changed() says:
> 
> 	/* Note: read_lock_bh() calls rcu_read_lock() */
> 	read_lock_bh(&idev->lock);
> 
> This is wrong because without enabling CONFIG_PREEMPT_RT
> rcu_read_lock() is not called by read_lock_bh(). The reason
> why current code works even in a CONFIG_PREEMPT_RT=n kernel
> is because atomic_notifier_call_chain() already does that for
> us, see:
> 
> 	int atomic_notifier_call_chain()
> 	{
> 		...
> 		rcu_read_lock();
> 		ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
> 		rcu_read_unlock();
> 		...
> 	}
> 
> and backtrace:
> 
> 	ath11k_mac_op_ipv6_changed
> 	ieee80211_ifa6_changed
> 	notifier_call_chain
> 	atomic_notifier_call_chain
> 
> So update the comment to make it correct.
> 
> This is found during code review, compile tested only.
> 
> Fixes: feafe59c8975 ("wifi: ath11k: use RCU when accessing struct inet6_dev::ac_list")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


