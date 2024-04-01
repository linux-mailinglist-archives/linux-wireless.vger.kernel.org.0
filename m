Return-Path: <linux-wireless+bounces-5717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7685B893F28
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 18:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168F31F226D7
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D764778C;
	Mon,  1 Apr 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mrLgnfXa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E54778E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987965; cv=none; b=FQg7kTyB/GZp5PTGg2ea7aapH7nhuNW7ZILrTVQeTiPflGSxKvPcdqt3SeYRikLlINkYSfdqJryuf2C4K0r0RPYP61vOwlIIergHUfbMrXkcMZfQkOcfVyhPuWP+R5WYdQ1Y2lQyRPzuLpts4THPHBZsOAodel4Fk9hidLna7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987965; c=relaxed/simple;
	bh=cPCe4e9OC7nBK8C8brJeXKwF6+/fZbN3EFBUUfzb3Gc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=PAPtMEcK40MW+e5tPIIrxM9gfPdJbWX9JvP1pHPOuDf5RXXCZJYGeVsZWe3+SRP8TuFM2wdUeWzfL5vBmTNA4LE3gzzH2DcA+LC23q6F5J45aZ/zxydahE+fKEV/V+yLnjLXyKyl5WIPmh3GiMYOjrkef3Cb9jYNCCdav4qwAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mrLgnfXa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431ETOXc003775;
	Mon, 1 Apr 2024 16:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2UiHXwQ3IC4mMGzz86hDn+w9Rdaqn/hBMPT5QXoJXHs=; b=mr
	LgnfXa/fRw2u1VyFW6lK6JgUYpILO3lhBczI0fCxG0MDyinzlCPWiONQTtnKSGMA
	YJLO7Opa5S04ejfoxmLCN9PyX2x5X7zDMWDv/IfxGvADCZHKjqgwZJq6xO+D2k3Z
	730Xovo/Y+sYTeAzTBGrCa9G92S7hdPxxhyRXVeinTVUVUkqECPU5z5HT5vL/Oks
	oPw1CMNKf4xra1EiiTx3lSIg0V1HlfYvZSn7Q9tVBegKTJEDJJnmZne475LJNpOx
	MBi95mUrAGx56py8rQoHMdBBjo5ADnpPMvcchImA/2xs3bxI695kQrQ1k+NCSgNg
	SPSlZM4/9aJm2Ze0jWLg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7qgw94yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 16:12:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431GCADR019021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 16:12:10 GMT
Received: from [10.110.126.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 09:12:10 -0700
Message-ID: <6b08a911-1ebd-4bcd-bc18-56764ac83729@quicinc.com>
Date: Mon, 1 Apr 2024 09:12:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: fix BSS chan info request WMI command
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20240331183232.2158756-1-quic_kathirve@quicinc.com>
 <20240331183232.2158756-2-quic_kathirve@quicinc.com>
 <c4924128-817a-4026-93f3-acedfe70c858@quicinc.com>
In-Reply-To: <c4924128-817a-4026-93f3-acedfe70c858@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8_5KyyO4d6BWOW8RejgHmnjnl4oiiHvR
X-Proofpoint-GUID: 8_5KyyO4d6BWOW8RejgHmnjnl4oiiHvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_11,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=883 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404010115

On 4/1/2024 8:00 AM, Jeff Johnson wrote:
> On 3/31/2024 11:32 AM, Karthikeyan Kathirvel wrote:
>> From: P Praneesh <quic_ppranees@quicinc.com>
>>
>> Currently, the firmware returns incorrect pdev_id information in
>> WMI_PDEV_BSS_CHAN_INFO_EVENTID, leading to incorrect filling of
>> the pdev's survey information.
>>
>> To prevent this issue, when requesting BSS channel information
>> through WMI_PDEV_BSS_CHAN_INFO_REQUEST_CMDID, firmware expects
>> pdev_id as one of the arguments in this WMI command.
>>
>> Add pdev_id to the struct wmi_pdev_bss_chan_info_req_cmd and fill it
>> during ath12k_wmi_pdev_bss_chan_info_request(). This resolves the
>> issue of sending the correct pdev_id in WMI_PDEV_BSS_CHAN_INFO_EVENTID.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: d889913205 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>>
> 
> remove this blank line. Fixes tag should be together with S-o-b
> 
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> 
> 
Kalle can fix this when he merges into pending

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


