Return-Path: <linux-wireless+bounces-12270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AD3966781
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 19:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E2B2867D8
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 17:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208F16C68F;
	Fri, 30 Aug 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PKC+crzK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DBA13BAF1
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037294; cv=none; b=q35MR3AmaOxDcimHVREfOGfHDftgu4UYyP/p6/h0JoVm73Wq0CMANcT4J3bfRJUPyW+21EHFpcbM4taIkSuBv2BToToMg1H44I/Gq6ta1oShD2Fb8IKXsF4ISTkpc9ayr4nDtD3mjTLp/9sAHDHXcUlG48USLlkzkzfRtVJwTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037294; c=relaxed/simple;
	bh=EjYbkY9SfiMQbM4vujw83Ia2kAYkjYXhsVwESzq+Lvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TVW+JUtz0Ob4wo5tAKwu/QmptcjOfVvEdRM6uWHUgM5RJd+gTsUfMUGSVnD+cVS+hxl4r6K2LdYG+MK1ahQ2WqI8l5x1ae4VZRq92K9EmSnNLyCx2bKk8fpb3jgOZMQJNo/X5a3MVlhs2j3oKB4UBerwr9mBbgVmz5d5ISeddWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PKC+crzK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFZS3I002700;
	Fri, 30 Aug 2024 17:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vAYYszW5xxU9NccYzBfKnyDR4cuCaW7X78i1OftrGDQ=; b=PKC+crzKp0uYDK03
	Ps63FXe/QzBs/OUFcVfZ5GbzVijZWoRkeYqcOoE2YGuCAxM6iiOE7cpU9CPdxiSf
	lIokw+XLLTMQI/a6Z5WFPa+FEwk8Hz5V6X5MWCKBLqRG3j+T431mzFpZ9cQv34V8
	GpOrZNRjz7b0x8P2ukHPenjsjMZy4x9XZJSgc+BbNO5sM88YKNWMIqEQKoPPSMRf
	f00JnuPRxhCJM7NK4ZWQAOC2xN2YGgnyUJUG1R4DTmGSxuur+18XajHJ9dL4JO6w
	gsJ6UwW1yUuTGH+dZl/Q01OsI5vyADiiF449vThiSynXYMqFC8n+YEukfcMV6uZ6
	ROhyrQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puu1q31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 17:01:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47UH1S1m021976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 17:01:28 GMT
Received: from [10.111.180.95] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 10:01:27 -0700
Message-ID: <72427069-d332-4296-a15f-5ef054d380c8@quicinc.com>
Date: Fri, 30 Aug 2024 10:01:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: move txbaddr/rxbaddr into struct ath12k_dp
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240830081942.3623380-1-nico.escande@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240830081942.3623380-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TnExw-nTVxTdOB5SMQR1jKR1E5ZBG4yA
X-Proofpoint-GUID: TnExw-nTVxTdOB5SMQR1jKR1E5ZBG4yA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=866 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300130

On 8/30/2024 1:19 AM, Nicolas Escande wrote:
> Those two fields are used to store the per SPT page of tx/rx descriptors send to

s/send/sent/

> the firmware for cookie conversion. Right now they are in struct ath12k_spt_info
> which means they are duplicated PPT page times while we only need one instance
> of them. This works for now as we always use the first spt_info as a global
> storage for all PPT pages.
> 
> Let's move them into struct ath12k_dp where they belong, alongside of the
> spt_info array they are tied to, to avoid waisting a good bit of memory.

s/waisting/wasting/

> 
> Tested-on: QCN9274 hw2.0 PCI CI_WLAN.WBE.1.3-03283.1-QCAHKSWPL_SILICONZ-2

You can add...
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

No need to resend, Kalle can make these edits in the pending branch


