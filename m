Return-Path: <linux-wireless+bounces-9559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04DE917146
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 21:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB667287A50
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD17179206;
	Tue, 25 Jun 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QCsvsbXV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C987178399
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345196; cv=none; b=HiWsoFl7sM+VNT/5ajS3DTPQHi6HWC72qWWTP8pW5KPrPS72MKGL9oVuNaaLxykepzWpCquXNdpBB+J+iwDMhKW/OdAC8x4qJGxJIwV/HVBas2MO3t/LuUCkieb5gKsEZn2hP3sJ5aRTN/Sq//1UuFpD3ersUjNsbhlte6CJSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345196; c=relaxed/simple;
	bh=eQaKVyU8x3ckr1RqnIOZnz8Qo8B9v6WKYQGWECInt2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dI0KiGTNVqVZWJ3e+Hgjd+BAP/6eV86MljEk5aQuwjPxuzEpcNI1izaVmoginKB8y05ObDc4ZnrxN99tnpDL2HBysTUNoGr6l3w0HCRVNrpcLCuLXlWfJbL38zXGtwXy1p5qBAk9QG/n0bxHEd+m19/gIqnwDNQs9HgZsfg4Jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QCsvsbXV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PH7hPF001496;
	Tue, 25 Jun 2024 19:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RBaFcAHhIgqJBvR3L2W7vdV0+C2KDhc2jXEITTfXMBU=; b=QCsvsbXVoSDRW8kZ
	vjcfR/ryN5tfDyWWqf/NzbLlikJPLqz0ujPK3SNgk9SFqVzZ37cWHWAj6V6B981+
	KppZx3yKSB2lSgx5RP/UAnwYKi/CgPOFr572Vv/IZlMetD/0qMVMPgGVtzSYsIH5
	Jqi/wrNQwSQTBdWQWTCHqWse0ZmZ6XiXn+xR8UPkjoFmUmx57iiRECUIbpfuxNDF
	XpF6My2S6xkFnCOJfA7AWEGqfqcjOdly+PxvszGwFJBdkNwoNBV2FUTqhoyQUkxw
	/uMON1oAkAENstSses5TRNMXpTtpfLCcOqf7ZYIfSAdVgYvvuqgiGGuWTdG0k3nP
	dqeWWQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaeyxyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 19:53:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PJrAgv020097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 19:53:10 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 12:53:10 -0700
Message-ID: <e9e51341-9245-48f3-91d2-99d0889b838b@quicinc.com>
Date: Tue, 25 Jun 2024 12:53:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: Support Transmit Scheduler stats
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240625042217.1303332-1-quic_rdevanat@quicinc.com>
 <20240625042217.1303332-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240625042217.1303332-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DTIv0Axlv2x2RV6yQfP2x9RbyJ17-tAf
X-Proofpoint-GUID: DTIv0Axlv2x2RV6yQfP2x9RbyJ17-tAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_15,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250146

On 6/24/2024 9:22 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request transmission scheduler stats from firmware through
> HTT stats type 4. This stat gives information such as pdev stats
> scheduled per transmission queue, transmission queue command posted and
> reaped, scheduler order, scheduler ineligibility and supercycle triggers.
> 
> Sample output:
> -------------
> echo 4 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_STATS_TX_SCHED_CMN_TLV:
> mac_id = 0
> current_timestamp = 952546828
> 
> HTT_TX_PDEV_STATS_SCHED_PER_TXQ_TLV:
> mac_id = 0
> txq_id = 14
> sched_policy = 2
> .....
> 
> HTT_SCHED_TXQ_CMD_POSTED_TLV:
> sched_cmd_posted =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> 10:0, 11:0, 12:0
> 
> HTT_SCHED_TXQ_CMD_REAPED_TLV:
> sched_cmd_reaped =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> 10:0, 11:0, 12:0
> 
> HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV:
> sched_order_su =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0,
> 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0
> 
> HTT_SCHED_TXQ_SCHED_INELIGIBILITY:
> sched_ineligibility =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0,
> 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0,
> 34:0, 35:0
> 
> HTT_SCHED_TXQ_SUPERCYCLE_TRIGGER:
> supercycle_triggers =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


