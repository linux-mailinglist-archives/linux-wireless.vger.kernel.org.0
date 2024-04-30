Return-Path: <linux-wireless+bounces-7066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46E8B7F3D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B621C20A47
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557B537E4;
	Tue, 30 Apr 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pijcxnuY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20920326
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499408; cv=none; b=gNtsUedV3jMq8eNS/o2KH090auo+XZGGkFZEDlVpYhAdzAnEYoMwuEYUnHI7qxX5oys5Xi2ydv+SOjqxvB2UdgeaXLsVboTlfnmUG+EBU/AX1t6doMq5ckiP5bKR7kvnx+RUstzoIn/LYtPF6KGwlVTLCyLF2Q2tR/yjJ+1kShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499408; c=relaxed/simple;
	bh=/VR63forc6AjUk0moPLQU5KkaxvKO1MXChCLF/4Um2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OJtJ6DqOhZtKjNAZIR2nweSI1toUESP7ipn99aQEEofflqYcK4/j68kZ/a0xynKd7LIQqHUWBjScjsmUwc+/MF0UlvXBXMQMwcp5pzy8aB3HjI4Li7K/Cd+p/RlxDMK67W+L+vo1I31lcEhskBAaQEAUBVruelwlEzgnWZYmCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pijcxnuY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U5raBU022930;
	Tue, 30 Apr 2024 17:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yKD1iZb6pj0NGWFcHL6EDvAPMvG35Pd8GV5knQMFkNg=; b=pi
	jcxnuYFkCa00EoZ9z4FX/zoawvcGS1yMnoYblfhczZiWGI0DUpXxkYrgNMAcYbmy
	hdHZo6kSYsKrYnkpQb9yIGp/Z5rIzz8U6c5d6J4Li7w7F5Q7h1HjyFi0ePomLk8L
	yQ2iNkIpjL3+k6hzRoLVFCUEv6uzEp26B2othvKAlYYGUIvVfnWAdWpDPUwG/RGY
	QXkUgbkZApxN0euWaofQGimlqw7B3nlsAZf+Aw3JkiycHGzF1bquWmTe189Ir+oE
	vLu3kG9+qsrnG0f5wqgknZHY0/aSNcGJzUt6lqEWTQnW9e4FErxJGlu++FTFLHCW
	1AkFvWE/fhjFmTcxwfCA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xttw3hr7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 17:50:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UHo2gM012900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 17:50:02 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 10:50:01 -0700
Message-ID: <8a7823bb-dcee-4ddb-93e0-077371408014@quicinc.com>
Date: Tue, 30 Apr 2024 10:50:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] wifi: ath12k: drop failed transmitted frames from
 metric calculation.
Content-Language: en-US
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430074313.885807-1-quic_kathirve@quicinc.com>
 <20240430074313.885807-3-quic_kathirve@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430074313.885807-3-quic_kathirve@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G-RqNz_jmsdSXQAwY2Fn4a0U9pxik0Zl
X-Proofpoint-ORIG-GUID: G-RqNz_jmsdSXQAwY2Fn4a0U9pxik0Zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300128

On 4/30/2024 12:43 AM, Karthikeyan Kathirvel wrote:
> In mesh node traffic, internal firmware-transmitted failures are
> reported as transmitted failures in mesh metric calculation, leading
> to the breakage of the mesh link.
> 
> Fix the issue by dropping the internal firmware-transmitted failures
> before updating the TX completion status to mac80211, in order to
> prevent false failure averaging in mesh metric calculation.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
With one caveat noted below,
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

[...]
> diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
> index 63340256d3f6..71e8c8a091ae 100644
> --- a/drivers/net/wireless/ath/ath12k/hal_desc.h
> +++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>  /*
>   * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.

should be 2021-2022, 2024 per current guidance

Kalle can probably fix this in the pending branch


