Return-Path: <linux-wireless+bounces-18397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C625A26CBB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B723516218A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664C204088;
	Tue,  4 Feb 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DfONAgx3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106812D758
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654696; cv=none; b=fa8Oa6Y7VhTV/8SCu607dWKCIgAXGcw1q8MKzHD6i3qXDZdipFTU6+ZDqtcSCdHX9V3RUQB0n+Nx9+PgTQPSO/4rtXH8IfUKaFUQ1cQ29sM8ZoWL+OHYNcLA+J/RPqfFSIYYiCIgC1VoZAUdVlHfWKYkJr17hU3w1RA+a1iwLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654696; c=relaxed/simple;
	bh=TRZgRas/ebkWV918S265GNBLMQ89ctlljWAmv1hrIBM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mLuxPhIuV8fyNZqo4cP0fgci7fmVpn4J0LUY6DHtE0+UaOaR5TXkYAL48W3K0kJ6scqPGYi47HMgbUEXlq+bVnyrpZtw7XSxZ0sZRZHhDKGG3iiTdcn0YPOUYZqedTCxEZLLX4tZ50uoU2o0E5yCBJkj3Hnxo8a+f4CUggeqrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DfONAgx3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513GEZgg010461;
	Tue, 4 Feb 2025 07:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TRZgRas/ebkWV918S265GNBLMQ89ctlljWAmv1hrIBM=; b=DfONAgx3Ybxmp1/+
	QWBoIUTrIUcair2AC5nJwrmG1J9qf70q7XragxcOpSgfHdrZ36sSckXlJ4tARyIr
	QeOqu78/YbSC9LDbLbOW+AeKX76H4LGEXwfViGqC4R0NQtFZ8zrbnqkVkv1fi+ZZ
	ZS60NEn2jNf2GXe1EKWm5pPHVwBRmr7P6fngQzHKOvxQGFygI/tb7hWeNxLKwF42
	ONpqkONFPhl6GoWYd9g856K6HPq+gNKQR/Tmkj1/grjn3Df9QwdSrktWr6945CIJ
	7k0GPugUgydNaFn/baY2zGcC4WfQh6Y3fT0lr1CtVtj1tM22Sb29yWXG+3soGyuI
	WxDj4g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k159hrpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 07:38:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5147c9Kc016290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 07:38:10 GMT
Received: from [10.152.202.85] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 23:38:08 -0800
Message-ID: <5ea3edf3-4af3-8d15-a173-8f6ffb37b8db@quicinc.com>
Date: Tue, 4 Feb 2025 13:08:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] wifi: ath12k: add get_txpower mac ops
Content-Language: en-US
From: Mahendran P <quic_mahep@quicinc.com>
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250131193726.3568086-1-rameshkumar.sundaram@oss.qualcomm.com>
 <20250131193726.3568086-3-rameshkumar.sundaram@oss.qualcomm.com>
 <6ed7ff61-a62a-9cd8-1603-6100402b4ab5@quicinc.com>
In-Reply-To: <6ed7ff61-a62a-9cd8-1603-6100402b4ab5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UA_AHi42NtqRHHP0jypELVvIrLbSUkzA
X-Proofpoint-ORIG-GUID: UA_AHi42NtqRHHP0jypELVvIrLbSUkzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040059

On 2/3/2025 11:34 AM, Mahendran P wrote:
> On 2/1/2025 1:07 AM, Rameshkumar Sundaram wrote:
>> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
>>
>> Driver does not support get_txpower mac ops because of which
>> cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
>> gets its value from ieee80211_channel->max_reg_power. However, the final
>> txpower is dependent on few other parameters apart from max regulatory
>> supported power. It is the firmware which knows about all these
>> parameters and considers the minimum for each packet transmission.
>>
>> All ath12k firmware reports the final TX power in firmware pdev stats
>> which falls under fw_stats. add get_txpower mac ops to get the TX power
>> from firmware leveraging fw_stats and return it accordingly.
>>
>> While at it, there is a possibility that repeated stats request WMI
>> commands are queued to FW if mac80211/userspace does get tx power back
>> to back(in Multiple BSS cases). This could potentially consume the WMI
>> queue completely. Hence limit this by fetching the power only for every
>> 5 seconds and reusing the value until the refresh timeout or when there
>> is a change in channel.
>>
>> Also remove init_completion(&ar->fw_stats_complete) in
>> ath12k_mac_hw_register() as ath12k_fw_stats_init() takes care of
>> it for each ar.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
>> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>



