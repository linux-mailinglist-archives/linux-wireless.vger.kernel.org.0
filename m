Return-Path: <linux-wireless+bounces-18616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F12A2BEB9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 10:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7138A16A081
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE951233156;
	Fri,  7 Feb 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EbxzQbVw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AC1D9324
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919130; cv=none; b=CbPFfdzp+WcOHuU4ARizFN/Lij2uYvqEAjFGdnIAEYfYfwxtyN+PnQ2OfGntj8Yhb5/x6x4uWfSxv1rCq5zQqBjZKs/OWYZe1H78IjjOf0D/NbCgBZy3fM8BpIayLuQi8a0Gj778dVj/fbVietCJ0+1NlQwUVK2JMubvU4yVZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919130; c=relaxed/simple;
	bh=lqanDBa/8VB8ZyN6C7SGtS2BWaQIomF3OrhtdQ8vhf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i+KPLK7cO/PvgwVC+7HT2U2NrpGvx6idjE2pUUILube6WhIgXUrHYnGfPv9ePEwciFR1b3gLWITcXfOo+vX2WyP6F0msxa1hhpW8FsB47ZYwCIWyy4XjsXNUvcrd58f5I1+XahOZfCOMFzI0Nvbstb/q0oAucd8xShCbzFLLhdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EbxzQbVw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5172JVk2004869;
	Fri, 7 Feb 2025 09:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	deOoZprUQ4cEZkRCsB7rGwrPfYEpijDIgS2TVxENs8E=; b=EbxzQbVwjEUxrMOb
	LrLATijo1VY4etUpMPnrDFtarHEw5PEQBz6ePUbbhdtyJ/vrDiM17O+Pd6b2ZuVo
	PsIVa1gkvXGexZ2wZ9QW931bVgAvNt3rIhEkXz5Q+s9QBBZFxy6KftW3lXBBJlQ2
	cfTW4tDkESu77FODRI6wjtJDs1sNFks6J+lEY44kODuczYqSxFNmdkNTMXMKc6DE
	adOZntllIls7gw5bf1KmUfZ6qhJZwgVNqixcUzgaXlKwbLMVOCUwop53xrSSc6Q0
	MEjVxrY5Ce+/ZZtxOe7EsvIlpjk0cQtqLAcyo6iKV74UX6tmAWY9PbjtpxblBp7b
	GzNooA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44n99e8vut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 09:05:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 517952Iq018215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 09:05:02 GMT
Received: from [10.110.58.120] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Feb 2025
 01:05:00 -0800
Message-ID: <44dc86f0-7775-4d47-9058-17cb048cd976@quicinc.com>
Date: Fri, 7 Feb 2025 17:04:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Abort scan before removing link interface
 to prevent duplicate deletion
To: <ath12k@lists.infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250124093352.481-1-quic_lingbok@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <20250124093352.481-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D9Teo-Vgfka2ithrk9RvS9TpSC5N6LAp
X-Proofpoint-GUID: D9Teo-Vgfka2ithrk9RvS9TpSC5N6LAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_04,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070069



On 2025/1/24 17:33, Lingbo Kong wrote:
> Currently, when ath12k performs the remove link interface operation, if
> there is an ongoing scan operation on the arvif, ath12k may execute the
> remove link interface operation multiple times on the same arvif. This
> occurs because, during the remove link operation, if a scan operation is
> present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
> from the firmware. Upon receiving this event, ath12k will continue to
> execute the ath12k_scan_vdev_clean_work() function, performing the remove
> link interface operation on the same arvif again.
> 
> To address this issue, before executing the remove link interface
> operation, ath12k needs to check if there is an ongoing scan operation on
> the current arvif. If such an operation exists, it should be aborted.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 329c05003721..cdce88787182 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -9333,6 +9333,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>   	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
>   		ath12k_mac_monitor_stop(ar);
>   
> +	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
> +		ath12k_scan_abort(ar);
> +		ar->scan.arvif = NULL;
> +	}
> +
>   	ath12k_mac_remove_link_interface(hw, arvif);
>   	ath12k_mac_unassign_link_vif(arvif);
>   }
> 
> base-commit: 376673aa393c1c232299be3e910d7f2e6d974b2f

hi jeff,
do you have any updates on this patch?🙂

/lingbo

