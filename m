Return-Path: <linux-wireless+bounces-24335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B0AE3457
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 06:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5183D7A60E3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 04:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D397F4C83;
	Mon, 23 Jun 2025 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FF/XGpgA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D17261A
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 04:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750653484; cv=none; b=a9GK8/hxzeLoaifk7DtG9N+gUpSfip1F+X6OtTIysVwXlAY5zN5/juYMAMEZuFME3RKLnHyTnspw0ErirXB7zg/F9yihdlTC1ZorU4HTu+5k+SPx67ixI7d5TrYtDuDrycB+Ze8Eqt7e0ga3JDr1O5BJdLTzSlPMeLTCXc6o26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750653484; c=relaxed/simple;
	bh=/IfkbLTSeMnGhPG6KKMXbbrPuf+ylRK8ZtwqIS4gn+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iRXBPK+kczkJ61FL9+b7soAT9IE5n7wcFP3e+KxJGbH+OUF/kf8yhK8SzLEUthVZWRb9GxT0tlpyrCyjqI1OGkKGAUdrA6xw5uUZfS/AX4LQ3S5OB/yT0BKQWx/ghkgvZuAwqx2lNLeOk7wOs8DcoLPsLhI32KiukIqcp/E75F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FF/XGpgA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MNWCWY030575;
	Mon, 23 Jun 2025 04:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YTIZyQE9IAo85GBT9lARo+AsW2dcsyItZ4EVdUevqIo=; b=FF/XGpgAcJJJBV6a
	XXl71DNWobNV6UyjC5ehtxdsnhoezk73l7WXGHsa0SNCXHVzF6UEk4PtJd4t+IiK
	NgLYfjp7IWJfzwaDOs94uB87N74cLoeKEJXIzVyFiPNOCOwutjcP1slDo4mojHpy
	sk/fOgXbc9xpH0MEbAJQg4Dhj97j6aF3yAW2EJZc8VsK5ZZ3XmqV4UuVfC6gePaT
	EOO+qsM9froZPIpU0O5CkeXSPCba5OKw+O10fIGJ7iZje3Y+2iUD2ZaxxEoHuU6j
	b2sIubhZbgwtW1C1fA2zvtJIPGTtcUDe9v/cmOhJxEFWA71Yss6v4ICOrsai3g36
	RxV+4g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ege0s5nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 04:37:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55N4bwPj009388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 04:37:58 GMT
Received: from [10.216.31.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 22 Jun
 2025 21:37:57 -0700
Message-ID: <0e884c63-5c74-95c9-ae65-6fe8dc2cce2c@quicinc.com>
Date: Mon, 23 Jun 2025 10:07:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Pass ab pointer directly to
 ath12k_dp_tx_get_encap_type()
Content-Language: en-US
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250606044936.3989400-1-tamizh.raja@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250606044936.3989400-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7k5vuOEOHCA9VidKzFnBuBp83ZHWjtPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyNSBTYWx0ZWRfX6yKt9lEIAMbw
 qQMhCCnuyARfhI4PXaM4YjaT0C0p/yuxDa+FXZ16EE+QS/7gKhqIz+CtxXQRfaM9154KQKOP03B
 9SWDAxFFAXBv9uf1FaWQKOZAXxjEKguoefvZj29pPUOLkIAmWoy7FCM0SptgXPNESfCDoPDZR95
 YdbqdqcfdYpS4cSYH/8y3zE3o1wFsSiilLr6WcvvLwn81wNg85wuzTamL/Jj3A6/+E/0TnfT3JD
 kqMyFxxJnFUbNs/QjNlWUlLBTKFLJ+IFcz2Z94YwFAmhBkqYxvkd9Hnvg3lof0UvSN19SxjaYTH
 1ip7P9CejbN0cFDResODTSnSzTA1NvFyvePLsZvvGMq7hT2XRyDDvRk+G+4VIcIuOIO9c3QBOq+
 NljfWzvaL0KeXSo6RujOoocXG6rVlO7/IAwDNoGxKazoJXcxh9JMqlkKnUe/MhX0daXdPsIx
X-Authority-Analysis: v=2.4 cv=CesI5Krl c=1 sm=1 tr=0 ts=6858da27 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8
 a=pPNxntyw70oWO60yalIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7k5vuOEOHCA9VidKzFnBuBp83ZHWjtPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxlogscore=823 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230025



On 6/6/2025 10:19 AM, Tamizh Chelvam Raja wrote:
> In ath12k_dp_tx_get_encap_type(), the arvif parameter is only used to
> retrieve the ab pointer. In vdev delete sequence the arvif->ar could
> become NULL and that would trigger kernel panic.
> Since the caller ath12k_dp_tx() already has a valid ab pointer, pass it
> directly to avoid panic and unnecessary dereferencing.
> 
> PC points to "ath12k_dp_tx+0x228/0x988 [ath12k]"
> LR points to "ath12k_dp_tx+0xc8/0x988 [ath12k]".
> The Backtrace obtained is as follows:
> ath12k_dp_tx+0x228/0x988 [ath12k]
> ath12k_mac_tx_check_max_limit+0x608/0x920 [ath12k]
> ieee80211_process_measurement_req+0x320/0x348 [mac80211]
> ieee80211_tx_dequeue+0x9ac/0x1518 [mac80211]
> ieee80211_tx_dequeue+0xb14/0x1518 [mac80211]
> ieee80211_tx_prepare_skb+0x224/0x254 [mac80211]
> ieee80211_xmit+0xec/0x100 [mac80211]
> __ieee80211_subif_start_xmit+0xc50/0xf40 [mac80211]
> ieee80211_subif_start_xmit+0x2e8/0x308 [mac80211]
> netdev_start_xmit+0x150/0x18c
> dev_hard_start_xmit+0x74/0xc0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Fixes: e93bbd65547e ("wifi: ath12k: fix packets are sent in native wifi mode while we set raw mode")
> Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

