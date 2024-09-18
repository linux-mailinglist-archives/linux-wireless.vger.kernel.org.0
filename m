Return-Path: <linux-wireless+bounces-12929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2397B6BA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 04:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708E61F23319
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 02:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4261A933;
	Wed, 18 Sep 2024 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L+6gouLU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450A749C
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726625682; cv=none; b=eVLl3yWnrtRMYfwzn+oGu3fzxipUgLqzBs4cSTyY8Ai4QBOW3ADeq0fOqXQk/O1mi2+6Qg9enrGi5INWHKOgeEHnfBEQdsMFabMaXAPzS/KgOlvcYPRo7jS8mUtIypikoou3ZTLkpdAsBAMprSFIMVd/ySy8b81N9c1lGWZuUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726625682; c=relaxed/simple;
	bh=q60zeMrmb4cHMTCjJ3AcybgBnp4mbb8WUxwbhG+j69Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dSfn3d20Pq+/3cdmeFTwwfP6T31YVWILpa9kYQ2frabdj/oDjCwkvLrcWiAId1qJQ8SMibxLxtaEcbns5Ynci8BV6gUIdWNcx4LTqOGiOhV/vKf5UIgzrwMpA8UyoMkoVHxawHBfv/TvnzOfP/3bvy9Pao4MK6iR0erfJibOkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L+6gouLU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HJaaKV016863;
	Wed, 18 Sep 2024 02:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	It4eXS9THUuHtK0Fd3B18Ev/5ytwBm7fzlC11Sf8278=; b=L+6gouLUdX+upoIA
	9amyd0OWDc513VTEJzkFxWfJacBJSeuyK3wGeF9K+y7x99cNoLyCN1tkwc2I1i/V
	iuQEqLSA811Rp5VPnzIq5LRSitIQpXVRVubg/xW6phUwL/u6GgU+OPvJ3z+w6Api
	PxUOosY4XsKJ5Eppn20U5tvXBOPtI+2JSCoKsLXzoxputSx6GW03UF7HYy/2dXaw
	FZt1nsd3YVhYLeSNhM7E3h3pA8NOaVhhQcRbiASfuqPQ9Jlw01gLrTR2Zt+qYlaI
	3MfMZVk2MlBaXT1ehwkNV1aWviQSQXwWg6SGXhlOyHL/EuZRDVNuqG67EvwTwUe+
	rvD6/g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hh8fwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 02:14:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48I2EVMT029932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 02:14:31 GMT
Received: from [10.253.39.169] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Sep
 2024 19:14:30 -0700
Message-ID: <59a975c7-083d-4387-96ee-fb795e588a42@quicinc.com>
Date: Wed, 18 Sep 2024 10:14:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath11k: fix full monitor mode
To: Steev Klimaszewski <steev@kali.org>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <87ed5kaxxp.fsf@kernel.org>
 <20240917073547.99604-1-steev@kali.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20240917073547.99604-1-steev@kali.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kWIr8pOo9IxBHRh1UUm8gh17Hyq_XsTq
X-Proofpoint-ORIG-GUID: kWIr8pOo9IxBHRh1UUm8gh17Hyq_XsTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409180011



On 9/17/2024 3:35 PM, Steev Klimaszewski wrote:
> I would also like to know this.  I have a Thinkpad X13s with a WCN6855 in it,
> and I've tried going back to the .30 firmware:
> 
> ath11k_pci 0006:01:00.0: fw_version 0x1106996e fw_build_timestamp 2023-10-13 07:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> and with your patchset applied, I'm still not able to create a monitor mode
> interface.  Is there additional patching needed on top and this is just a fix
> before that comes?

For WCN6855/QCA6390, still need some patches. This patch-set can only 
fix the full monitor mode on QCN9074.

> 
> -- steev


