Return-Path: <linux-wireless+bounces-6672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902978ACFC3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 16:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64F31C21111
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F9152503;
	Mon, 22 Apr 2024 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fVgQ1jNg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4E15219A
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796966; cv=none; b=CHOaohK6diLvy5xGwiBd1Gci91D9vRDObCNHfh5Rdbsih3OAD8cT27drEQdv65oW0BtOvDVyvbkmTcOGhWll/9H1y8f+sL3jD2nNgn1Yvza/rcTIbtAHCZBEA0bcm0qaTaUzRIFreoEqfgAiw+tabnvzdZVQGFjGPYSQluIJPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796966; c=relaxed/simple;
	bh=J7slH1Jf+VTyXWmIkC3fgl7Mqt8KJLY2lAL4yxorQCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DnZ4W4/64KupR+na+1f/eJLSyfYbxAiT2PNeT7d/+qseVZ0f4LmL24BJWmkqhxpsVxFPnvScm6xTVfgZ4dFrBZO2GIFRcdcXpCDOPFTKBj0cis8JZ78XXsXff53ErTx/HoRrYx2BenhmFi7AfyocqlQdBTNBwbDL7DkhMBjtwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fVgQ1jNg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9OlKX026485;
	Mon, 22 Apr 2024 14:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lZvMuB/bw1+y2U0Cr/lazdZkdY4Z+DXTa+VUdToEdYI=; b=fV
	gQ1jNgOm0gtEpOn2SBANuwZnMM+13TIO8CBMlpD4OoBVlIWvIsrQNMcEOtn4LFOf
	wbxnvW70Fl/NqQY/pMT91wIjPtkA/8xFoN+hRZ7IWqOwC8mS8DM2OpmMH14lltNw
	omam2mGqGfK4TIhuENxL86YwBLF7EIYagU3PmeonLNZbBOYkuM8J8jZpCAMlM55O
	mH1yshFJJtDqLWMWlZ1BTQ49QdPQY0IuJyiRDm82XYV9D7C/BctDftY7qQ8l4vWk
	jwcYAsyaYvUnmKQKICnlwIh2L7pI2t76FsrHTAy41EvAKbwXrauQS96YKAoUn4qQ
	2cZka6qSziX/izvAIaqQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82gsub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:42:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MEggC0008323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:42:42 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 07:42:41 -0700
Message-ID: <030a9e21-3ce8-4245-9650-b5b70e139479@quicinc.com>
Date: Mon, 22 Apr 2024 07:42:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: set mlo_capable_flags based on QMI PHY
 capability
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240418125609.3867730-1-quic_rajkbhag@quicinc.com>
 <20240418125609.3867730-3-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240418125609.3867730-3-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5azx2hr0YpVduvcqjfI3JgJ64vZkzjFi
X-Proofpoint-ORIG-GUID: 5azx2hr0YpVduvcqjfI3JgJ64vZkzjFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=993 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220064

On 4/18/2024 5:56 AM, Raj Kumar Bhagat wrote:
> Currently, mlo_capable_flags is set to zero if dualmac device is
> detected based on One Time Programmable (OTP) register value.
> This is not generic and in future dualmac devices may support
> Single Link Operation (SLO) and Multi Link Operation (MLO).
> 
> Thus, set mlo_capable_flags based on 'single_chip_mlo_support'
> parameter from QMI PHY capability response message from the firmware.
> Also, add check on mlo_capable_flags to disable MLO parameter in the
> host capability QMI request message.
> 
> If the firmware does not respond with this optional parameter
> 'single_chip_mlo_support' in QMI PHY capability response, default
> ab->mlo_capable_flags is used.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

