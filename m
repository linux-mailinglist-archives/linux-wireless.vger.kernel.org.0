Return-Path: <linux-wireless+bounces-2334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B0836F9F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9BF287F9E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9FB48CC0;
	Mon, 22 Jan 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hMhwfQjv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218248CC1
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945671; cv=none; b=h/gu9EoiL9+x+qGhtzYLCtUC22hablhXNgJaltryozAtjtZFV/BjI7QW4fC2nyRZGzeKG3IyWrBKA/hb3selAgGe5APRFFankDB8sgEq7/GppqHcuKrT9GTTWFCGj+GQvMXLbPAwz3kQb8eA1p2xCBqEHo9N9DZoJB3SWbjFvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945671; c=relaxed/simple;
	bh=UjDN+nej4ZOC2s3ri4OiHmlU7Di1f1xC8WNzA2704wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OeNbP7JHWNjSFr26DB7z1ydVcMzKY8NzVY62rBcXcqVO4TPGOmpnW9Lex7QZzIiVTSbLAxExfDuLzMXJA2xPYQF/LJwuHE0oxe9Q0qlDNx1eTx6WJ3KrC3Z4g+6DdWRN+gYXTWuMTGeUGPn0sUiaEaTIKQsgo2e5UWeqa+en4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hMhwfQjv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MDPvam016608;
	Mon, 22 Jan 2024 17:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nHiVdvVHqT12Ix7/o54Eufibla46GocvCvN5VVrxm+Q=; b=hM
	hwfQjvtyQaPXjK9kKx/raAwUYkIDaiodLZj7zWHGvACiRvPKN8clEXkth9xl5Z07
	n19FVdLNluqE/zTEaBA3KMpERTMZEqAaCB3xT6C0a1qTMFZ2M6fkl/SS3U2oJHAy
	7YI+6jURbKyS4Bu/vli/9Yi2L1yu7QvSQrC6hUr7QIPJ6pnw6ap6NH7GaTEN+Pqw
	1T3jCHL2C2dl9j/2i3/eNpinacsrUx+jLipRtqBGzEWUY9HmQ/VvIoVSY8B66JFd
	T61TZqK6/7fl2VmxMe3LqdEIq5+qxJcxBshe2w8SaU6Mv7Ji4t1EX+nialbl/wIp
	gK1rOjEmPJ8siYLX5faQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsjkthra4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:47:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MHlfwH025320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:47:41 GMT
Received: from [10.110.26.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 09:47:41 -0800
Message-ID: <ea2952a4-8343-407e-9a9c-3c93f4afd607@quicinc.com>
Date: Mon, 22 Jan 2024 09:47:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath12k: add processing for TWT enable event
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240122085336.3985-1-quic_lingbok@quicinc.com>
 <20240122085336.3985-2-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240122085336.3985-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mIk_ro77vV-eSaHwdlp1LdSNIf7-_4-I
X-Proofpoint-ORIG-GUID: mIk_ro77vV-eSaHwdlp1LdSNIf7-_4-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxlogscore=856 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220124

On 1/22/2024 12:53 AM, Lingbo Kong wrote:
> When ath12k send TWT enable command to firmware, firmware will return a TWT
> enable event to ath12k. Through the analysis of TWT enable event status, we
> can easily obtain the status of TWT enable command. It can be more
> convenient to debug TWT.
> 
> This patch works with WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
[...snip...]
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 06e5b9b4049b..7570ef7be38d 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h

Qualcomm Innovation Center copyright missing 2024

Kalle can probably address this in "pending"

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


