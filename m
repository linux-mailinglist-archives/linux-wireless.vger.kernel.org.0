Return-Path: <linux-wireless+bounces-17927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F69A1C3DA
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2AD167AC1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69661CAA4;
	Sat, 25 Jan 2025 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FihVOUzC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB028DB3
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737816903; cv=none; b=AIOP4jxfFDrQWsn5msqEbRfuiCUASfVnydNo/KeHnpKNN+kWaeBWw9v+yPWarL3LZNkrunZr3PnsPcAV9DHMsMMSAbG5yQaB6aJq5om9OsF2phBVkMryWi05bHkY/18xui32LJrFodwG6eMkdlQRFUGPGlSdDtokreN7jl4qCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737816903; c=relaxed/simple;
	bh=bmXYoGG70srCzQ82uw5cZtaKL80po1cT/hgmAgJ0pu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DtPyTjM5n1bT+1nnoXryTtcS7u9Rx5vv9cioEM0kVuENgU3xNqymGDY9PfIgdu7fUdKPouDdVGEP7E+MQgvDT62Lodav1ppRwcdIeUATRwbAOsbQXO5Qc9JsoUZkboV5tO3RtfUXB21k94JL40JIR8Yx+sCvapme20j0TCvSZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FihVOUzC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50PDpwUA028002;
	Sat, 25 Jan 2025 14:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Injy+A2hUDANxiSbkkLu+yFWY8rBMNAZ7kmYrHNJCOc=; b=FihVOUzCtOwoBX1H
	6h3Ba/sNW6DywZbptMpbLxYni9tBuqyX91NXe47R/rg87M0QJLbXZ09hJiq2PDcb
	qBhIeszWlx2GQX0B+V6SR7+sB+vtk5gs76wb+L41DKbtzoEujSlCSfmqWoy2WQyP
	xsxlfe/EKY9fnxiT9D8ijJPrwgFNKtsUTLPSN1QSvigrP+TKDqBun0JLakUD7hNp
	xTHIq8GlnGMcer6tXWIpajIHXpH92L4S9Vdf/3Rdbdw8LxVD67AimYOiRfk3IGYM
	jrbKvf2ZFtNhds9hRHSZ+AeK5ookqw6cnrl4lHtewcnNkCR6T7f3Y70RbHC8cA+o
	iUMOqQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cryr8mh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 14:54:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50PEstqR021369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 14:54:55 GMT
Received: from [10.216.27.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 25 Jan
 2025 06:54:53 -0800
Message-ID: <18b47227-6b77-a029-2e80-04a0455ac091@quicinc.com>
Date: Sat, 25 Jan 2025 20:24:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: fbx: fix ath12k_hal_tx_cmd_ext_desc_setup()
 info1 override
To: Nicolas Escande <nico.escande@gmail.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250124113352.93638-1-nico.escande@gmail.com>
 <a979cbc5-5cfe-160d-d5b9-9e5ed7513ed1@quicinc.com>
 <D7B63ACJOYD0.1XBZ5VB991KOW@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <D7B63ACJOYD0.1XBZ5VB991KOW@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0ktJQa8NM8MI0TQhCa-Wo6r1pSiR5vrj
X-Proofpoint-ORIG-GUID: 0ktJQa8NM8MI0TQhCa-Wo6r1pSiR5vrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=957 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501250108



On 1/25/2025 6:23 PM, Nicolas Escande wrote:
> On Fri Jan 24, 2025 at 4:31 PM CET, Karthikeyan Periyasamy wrote:
>> On 1/24/2025 5:03 PM, Nicolas Escande wrote:
>>> Since inception there is an obvious typo laying around in
>>> ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding
>>> flags to tcl_ext_cmd->info1, we initialize + override. This is needed to
>>> make broadcast frames work with ethernet encapsulation.
>>>
>>
>> SUPPORTS_TX_ENCAP_OFFLOAD not yet advertised by ath12k. How it work with
>> ethernet encapsulation ?
> 
> Yes indeed, I made a small patch that adds the right hw features via a module
> param like one of your CLO patches did:
> 
> +       if (ath12k_frame_mode == ATH12K_HW_TXRX_ETHERNET) {
> +               ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
> +               ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
> +       }
> +
> 
> But maybe as this feature is not yet enabled upstream I need remove the fixes
> tag ? After all It seems that in native wifi this bug causes no harm...
> 

That's right, also you may want to remove fbx prefix in the patch title
as this change has nothing to do with any particular platform/hardware.

Vasanth

