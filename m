Return-Path: <linux-wireless+bounces-6206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A70A8A2122
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 23:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23E2B21039
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 21:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFA33717B;
	Thu, 11 Apr 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ks13s0Vw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CAA3D0D0
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872326; cv=none; b=Lwt7/W/Hxoe6dnKN5IqeXi9vf/lCeB1cdeoJ9K5v1jfpu/cE4GnANUKHt1BRufiYc8VTuN2VUmYUECNsNYWI7RdDc5bGK6WkUUfdiAjgQQjMx4FChZ+r+zwoAfbHQfshfTFdnL3UdYW/qGzKJQrmsP/pBQ6qQW2l/Lij1Cm8cCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872326; c=relaxed/simple;
	bh=c/+9/1qu/6XWdpJdrBXtd4FPHVcygBEh2qzpYeXvN0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A/2IKrVQbQXvKPjRaArichyLu76snodwQ+Bla5oNU0xuGJYBF3j7vA4AEcoKQiivCI/z2ivFYD9vI0rV9BSirkyIvMkHNro+46lj4ZsMKMYwz4OSXmeE7Z7kSNWbeLeP4omET9jztodzgl97yoaZkYGcbK1ZbFY4Xv6Vy8wapNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ks13s0Vw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BLh5IS006971;
	Thu, 11 Apr 2024 21:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+EBsWja9zhDx/KBvBicZy9awn7EbNNURM87xXV6BPFo=; b=ks
	13s0VwTcm4RWeEFtEk3rxvGYVm940vrhHSKfaQSkySvjGsQw1o75TzzTMoteRyqX
	rpWcdQ/hDlUbji8wEIqfDUwLxolwdiFn83ae6wCdt1eKv/IMWdWBhtJVTr+Ia0lK
	SYgJKBOrtGvNyWbasWbepTMSWobiaa37ik2bU5HL6x1HmikSS5szBuxCF/GxFBGg
	PomvIjcj2Vr+JpLYrzGeZRvT7GYr9YZUx+ydguO+f4crBnDwkv8VXXTOy0TxJgpa
	Tu5F7c8Caie1B1IBjyysfucDDuJhLbs7Jb/fUxrC/dZ5cHIvbrzAZon78Zlw2Ye0
	OiyOJf6NSc1FjsqHBIvA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xebq1tcsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 21:52:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BLq1Zk031192
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 21:52:01 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 14:52:01 -0700
Message-ID: <b2a14919-6478-4a6a-bdca-e018393eac34@quicinc.com>
Date: Thu, 11 Apr 2024 14:51:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: report station mode signal strength
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240411025322.33888-1-quic_lingbok@quicinc.com>
 <20240411025322.33888-4-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240411025322.33888-4-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KsP22C6maQQGW54agyQyxtEsoHGo96gi
X-Proofpoint-GUID: KsP22C6maQQGW54agyQyxtEsoHGo96gi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110157

On 4/10/2024 7:53 PM, Lingbo Kong wrote:
> Currently, the signal strength of "iw dev xxx station dump" always show an
> invalid value.
> 
> This is because signal strength is only set in ath12k_mgmt_rx_event()
> function, and not set for received data packet. So, change to get signal
> from firmware and report to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct signal strength.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  36 ms
>         rx bytes:       61571
>         rx packets:     336
>         tx bytes:       28204
>         tx packets:     205
>         tx retries:     49
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      83
>         rx drop misc:   66
>         signal:         -24 dBm
>         beacon signal avg:      -22 dBm
> 
> For WCN7850, the firmware supports db2dbm, so not need to add noise floor.
> For QCN9274, the firmware not support db2dbm, so need to add noise floor.
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |   2 +
>  drivers/net/wireless/ath/ath12k/mac.c  |  56 ++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 130 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h  |  48 +++++++++
>  4 files changed, 234 insertions(+), 2 deletions(-)
[...]
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 78afc94a815d..9016eda03d57 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4811,6 +4811,52 @@ struct wmi_twt_disable_event {
>  	__le32 status;
>  } __packed;
>  
> +struct wmi_stats_event {
> +	__le32 stats_id;
> +	__le32 num_pdev_stats;
> +	__le32 num_vdev_stats;
> +	__le32 num_peer_stats;
> +	__le32 num_bcnflt_stats;
> +	__le32 num_chan_stats;
> +	__le32 num_mib_stats;
> +	__le32 pdev_id;
> +	__le32 num_bcn_stats;
> +	__le32 num_peer_extd_stats;
> +	__le32 num_peer_extd2_stats;
> +} __packed;
> +
> +enum wmi_stats_id {
> +	WMI_REQUEST_VDEV_STAT	= BIT(3),
> +};
> +
> +struct wmi_request_stats_cmd {
> +	__le32 tlv_header;
> +	__le32 stats_id;
> +	__le32 vdev_id;
> +	struct ath12k_wmi_mac_addr_params peer_macaddr;
> +	__le32 pdev_id;
> +} __packed;
> +
> +#define WLAN_MAX_AC 4
> +#define MAX_TX_RATE_VALUES 10
> +
> +struct ath12k_wmi_vdev_stats {

this name does not conform to the "Naming conventions for structures" outlined
at the beginning of the file:
 * _params is a structure which is embedded either into _cmd or _event (or
 * both), it is not sent individually.

> +	__le32 vdev_id;
> +	__le32 beacon_snr;
> +	__le32 data_snr;
> +	__le32 num_tx_frames[WLAN_MAX_AC];
> +	__le32 num_rx_frames;
> +	__le32 num_tx_frames_retries[WLAN_MAX_AC];
> +	__le32 num_tx_frames_failures[WLAN_MAX_AC];
> +	__le32 num_rts_fail;
> +	__le32 num_rts_success;
> +	__le32 num_rx_err;
> +	__le32 num_rx_discard;
> +	__le32 num_tx_not_acked;
> +	__le32 tx_rate_history[MAX_TX_RATE_VALUES];
> +	__le32 beacon_rssi_history[MAX_TX_RATE_VALUES];
> +} __packed;


