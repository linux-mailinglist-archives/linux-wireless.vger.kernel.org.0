Return-Path: <linux-wireless+bounces-5716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C26893F1A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 18:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF2E1F22810
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629FB43AD6;
	Mon,  1 Apr 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ECcGwP3K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1050F47A62
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987926; cv=none; b=lB69DObS5IXicR4LJ3VRLMpvnTdgxWrBd8JwKXmLSiA3EUHqlDLMiY57TmYsa8YwSiLa0u2Kvpp8eXJ5RHiK5werqkXm9uxActTZZ8ZchJ+WJrp8axB5hBkPX1FOxTa7FDtb0S5Jc9OzSAcHHbAs1LFjIHwjFk77Lj8J/gCTz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987926; c=relaxed/simple;
	bh=sAFPRuTFIwECG2Kj4A167pqEqafJ02wmusFBheriWKY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=RNAxMW1xY9r61U9tOcCUa6gtHGKpDXEOHwQN2sE1nQqt9otc57PUyGkwlq4yHhipxpp9aMgzK7xE8BD+JAdI3Vi4MYQpsK5YXKlvFflJn1FPJ4NlZOFLeYhA/iSiJYb9Q7/a4vaPF0Ri77/Jm4SipSXFLbz8G9EVF98B30utYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ECcGwP3K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431ERvrP031119;
	Mon, 1 Apr 2024 16:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TA0nV97rtgv+Y5iM+M2MaCzWOpu3b5opvrWnyuMcovU=; b=EC
	cGwP3KyiqFpZcdBElaGileGst6O3s1PGfQGxIGKJr2pE056MhdTPZ+XpElu6PrnY
	kbtRm6YnS5gbhF6bdRk30FFESgUz0HTl5Lt+7vIsNNedjvUKhH1kpGb2RQxPk4oQ
	hNdC5wBjtpQ5hFcxu5+4UsQx7IK8aq35kSvPEXwC1/e8bzZBS2tRABoMxwRWlvMf
	wE9ClotsM0ivYwkSa8aRYv1KmiCEn1fxVMEPRqU9ivdboFlLiMjPXvNzg4fjoYFn
	OYCSKnJ7g9WZ3XM7g7dIVbs/pe76Gkwe9Z7e1X9MW+E/vmNNKt1AOuCIbn+CcEZx
	O9Lp7f9NWqPwi91a9yRw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7r5712p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 16:11:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431GBwcT006204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 16:11:58 GMT
Received: from [10.110.126.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 09:11:57 -0700
Message-ID: <daca162b-b434-493a-993f-8817e586e5da@quicinc.com>
Date: Mon, 1 Apr 2024 09:11:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: match WMI BSS chan info structure with
 firmware definition
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20240331183232.2158756-1-quic_kathirve@quicinc.com>
 <20240331183232.2158756-3-quic_kathirve@quicinc.com>
 <59c05ce0-14ab-48f6-9ed2-f10d3f548a85@quicinc.com>
In-Reply-To: <59c05ce0-14ab-48f6-9ed2-f10d3f548a85@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hz14U8lmYXJxqSIwkC31AHuC_uObUCO8
X-Proofpoint-ORIG-GUID: Hz14U8lmYXJxqSIwkC31AHuC_uObUCO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=668 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404010112

On 4/1/2024 8:01 AM, Jeff Johnson wrote:
> On 3/31/2024 11:32 AM, Karthikeyan Kathirvel wrote:
>> From: P Praneesh <quic_ppranees@quicinc.com>
>>
>> struct wmi_pdev_bss_chan_info_event is not similar to the firmware
>> struct definition, this will cause some random failures.
>>
>> Fix by matching the struct wmi_pdev_bss_chan_info_event with the
>> firmware structure definition.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: d889913205 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>>
> 
> remove this blank line
> 
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> 
> 
Kalle can fix this when he merges into pending

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



