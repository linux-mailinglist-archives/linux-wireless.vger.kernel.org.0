Return-Path: <linux-wireless+bounces-6339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E558A59AB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 20:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BC91F22F9E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43B813A864;
	Mon, 15 Apr 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M/I/6t+I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFC84D24
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205266; cv=none; b=G7t2C8kkdcSH9rlJsQOFM9I8EzM1CZb0y6i4TQuDqikxg8ljl8nueccBxaWQmvANUwavmpgJcRyizsOnDuiP1M1IiMYw7ipkRHqzN3Y9O/HQxiHhgiTgxMn5t+gKlQja4Zau3DSok6hBIjl0+ktNnrc456jw36Yvx7PXRqtK1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205266; c=relaxed/simple;
	bh=7GqUBNmPZg+J89a0E+dD8GSrJIONcYvJVvNOOlWMyaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EEa/3Iw1Vs1mFk0RLi4H/CrtJVndvdI9V7NksFY+8DE4sngn5Itg4cMWi/2zbpCDxJERBamzjnYB07G6oORrrWYKfYcmd92cbDs2Ws3hFae7SBr7Al6ga8KDHyno6X2zxW/lYdXdBmiqb1UmgLAV4OfbMvkPgNr/SEIqjB2qLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M/I/6t+I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FHepbx013786;
	Mon, 15 Apr 2024 18:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eWaZSiWUv4nn8pi7lN1cSjmAy/P+iMi7P54lpPfTmqY=; b=M/
	I/6t+IfdmydB6fE/LMdP4INT1UI5OQ+LPqMOPqSQ9Qw/HpuGgX9QThSPmwjieqtu
	EMNj8bBJ7vnzDLGqBs6MhtqR1vlpQc6BFvYLrDEo1UKU6WKPmeVG7G7ZyFBO2wDp
	2pXP1yIfgeZ5dFwU7wDFdFAEtN6qYy5X3qfZwoHfHGCGESS4qKypKCMgStLLnT4m
	NsbdfhtJg21VQGuIdeiYlbs1f5bmm/zPbUNIN8Cu012tZWdTNeo8Tit3TrsZv9S6
	J2JDJOb+ylDH3/bEhy2j+aYvUK8PKEkvSK8/YRuHBTkSZW7p8bVOlG7EnoJ4fK8Y
	KmAKzBrezrRRMrrIsSYQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgw01sxqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 18:20:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FIKwsu004248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 18:20:58 GMT
Received: from [10.110.3.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 11:20:58 -0700
Message-ID: <a01e2408-6016-44ff-aadb-13471a43c6c5@quicinc.com>
Date: Mon, 15 Apr 2024 11:20:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath12k: fix out-of-bound access of qmi_invoke_handler()
Content-Language: en-US
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240415171323.2484291-1-quic_kathirve@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240415171323.2484291-1-quic_kathirve@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9KUUx2EkVLdugGAH7f9qTXCd0vnOHjIH
X-Proofpoint-GUID: 9KUUx2EkVLdugGAH7f9qTXCd0vnOHjIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_15,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=812 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404150121

On 4/15/2024 10:13 AM, Karthikeyan Kathirvel wrote:
> Currently, there is no terminator entry for ath12k_qmi_msg_handlers hence
> facing below KASAN warning,
> 
>  ==================================================================
>  BUG: KASAN: global-out-of-bounds in qmi_invoke_handler+0xa4/0x148
>  Read of size 8 at addr ffffffd00a6428d8 by task kworker/u8:2/1273
> 
>  CPU: 0 PID: 1273 Comm: kworker/u8:2 Not tainted 5.4.213 #0
>  Workqueue: qmi_msg_handler qmi_data_ready_work
>  Call trace:
>   dump_backtrace+0x0/0x20c
>   show_stack+0x14/0x1c
>   dump_stack+0xe0/0x138
>   print_address_description.isra.5+0x30/0x330
>   __kasan_report+0x16c/0x1bc
>   kasan_report+0xc/0x14
>   __asan_load8+0xa8/0xb0
>   qmi_invoke_handler+0xa4/0x148
>   qmi_handle_message+0x18c/0x1bc
>   qmi_data_ready_work+0x4ec/0x528
>   process_one_work+0x2c0/0x440
>   worker_thread+0x324/0x4b8
>   kthread+0x210/0x228
>   ret_from_fork+0x10/0x18
> 
>  The address belongs to the variable:
>   ath12k_mac_mon_status_filter_default+0x4bd8/0xfffffffffffe2300 [ath12k]
>  [...]
>  ==================================================================
> 
> Add a dummy terminator entry at the end to assist the qmi_invoke_handler()
> in traversing up to the terminator entry without accessing an
> out-of-boundary index.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


