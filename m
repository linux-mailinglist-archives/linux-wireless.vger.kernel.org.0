Return-Path: <linux-wireless+bounces-27773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C8BB2472
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 03:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695543808CD
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3081C28E;
	Thu,  2 Oct 2025 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZjEqmjeW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02BE41A8F
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759368685; cv=none; b=JkUBrza6rLSELZclEjsiUXv9Db9QSJHp18io/5gUZhxx/sQ5N6ytFCBPgnXxb1QVE14C1FG42opRCY62ohe7MCov+eVWWGZ3hIcmoRTqYhGhxecl7jXWKWubpezQm3+oOd8CZj7RrOAu+G/eBKr3i5iiAaRLAZ4JKZPVUKW6GvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759368685; c=relaxed/simple;
	bh=0hpeT//2hfKjNAfNeqxYsNsV26aoT9HG2JStyPiTlFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4G36Wa7lWQJ/pVYLi0jQtoDqttnpkoc44cYFvDcyUSkRTx9ODrRYMfk3vBkAZkh5J/rTVrVkKl86UQy/rCMzoSNhdvX/wg+nO4uYrJCbTFjwM55R2eui7Fm5mhqvJ+xJYCt5S/YMyLIGjaFKyjxR5CLA6k4nAXxYm4+G/zkx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZjEqmjeW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ibv8j023416
	for <linux-wireless@vger.kernel.org>; Thu, 2 Oct 2025 01:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AiL66kauMPMVWPXmFSeQSWxeq5FUUwcmFuKC2oRp9Gs=; b=ZjEqmjeWplSPcul2
	F9EUVb00t7Hj0vW4ENP7ebzsvtOZHUbSB4gr6nYqrY/X+i5kh4H+xDHwKFHdEDR/
	ZbHj2n2DkIg9xP38PREGm20r5Yw1zo9ZhM2+Z2SicEK/UCAOlhegXcF2grPBLXBf
	kitnILvyaoOlvraGDuqCJL1cNU/5pSg4qAg6/6mMMaHfUfYpR7H9tarWKmhibRqt
	4di1PxpNfm7qZ+LpzcbHg1S15pGuKIaK6FE/Lpm6WihRjg7u024rYeY2yfuMB/LE
	akNeaEtOPDWFbJ6RnmR6/KX5Ez5C2OrHMPcrs4QtQ+tSzA51UJWjROZm10eOe18s
	48RaXw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977x68k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Oct 2025 01:31:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78038ed99d9so728764b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Oct 2025 18:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759368682; x=1759973482;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiL66kauMPMVWPXmFSeQSWxeq5FUUwcmFuKC2oRp9Gs=;
        b=v0F2BM9hlojEHskEWVFweVjbykctW9r+uA9aK7nPoZhkilVsWftAVJBTddNBbyK/1H
         lWMimIlfh7PbW68FmwWRWnhtShu7wDfuVIGHNBKEYpQtyciQlKiNdi//Dg2O/HJcPy/H
         csURq10AhUDPsbX+x4cn94Qo9gC4WXveg0KV6QJHdaTGRSY6bV/hZkK42vIflQIdiD4C
         1E4zJtIVuLnBSMXjS2ovuHt9ksVHgZhN2jdKJjwkn1P8CzCUBZORd87T7JspUfENPD5/
         jFlb31gz/4yvQszMf2p4FwRSw6ShbX0/G4ro5rFfDIA3e0OWk5DFkiljI5B+p+LNrYEU
         47nw==
X-Gm-Message-State: AOJu0YypikXJsag79g4lOOdEdCkTLEFTgsxrgA6kTWFqWjV8FW4GYmRF
	W1BWA2jB1v+hOG3SfY0CT2hqFrWEofxw7lWK9Kwdz+nDDV1Pyb7hreUzEvDOdasjXnv5sobcXxF
	ONIMaEy9HTb9EOj6lluOfWlagKinTniX1QxhaL7I7AMQTuHJJRtvS9xjWXI7Ysg+f+Od4DQ==
X-Gm-Gg: ASbGncuxUe+nUACr8oIQZQMh/1qcIboRu06Lf9iYpolWPsQrFXqyAsEL2BWP1TpY6Hj
	R1dpO/g5ANjMjap0sWqpeljuV1ZQr/FXzQimI/fuAITT1udHGyxLn0mxvuRc29DflGzIV2FRmf5
	qxhmNS5bvsyQ6AJRgoQZJ8k5fv4NCC5297TMImI5Uqrzl/3HvvhoBD5L/3cU4wVMmxCpKeEbbT6
	bE/u/4a89aZTt7cG0R5ayDU1Y3PcxgyxOZPrle1HVwKTMTrG/4EZicxnmIxXg99bEYiGJX+MggP
	tJRDXazvOr8dEvGbDOLuGBZSmSbalFj3xp5FtV4MaGilecP2NFuzQfmBUgeXsljgnJPiyI6nieo
	8ikr59J+oOq/tK/2NnujtpCB1xMeDzBpu07ueTdtyWw==
X-Received: by 2002:a05:6a00:2394:b0:781:189:ae43 with SMTP id d2e1a72fcca58-78af41f0cafmr5412417b3a.20.1759368682106;
        Wed, 01 Oct 2025 18:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTVzJY67RACi0TodPLYA1YjzMfML7zyChxCiuFn84v3wTsFYFyOBxf3coDpYkVbO7jP+P6lA==
X-Received: by 2002:a05:6a00:2394:b0:781:189:ae43 with SMTP id d2e1a72fcca58-78af41f0cafmr5412395b3a.20.1759368681533;
        Wed, 01 Oct 2025 18:31:21 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e814sm928930b3a.68.2025.10.01.18.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 18:31:21 -0700 (PDT)
Message-ID: <4bb3de8a-92dd-444e-bed0-13ec2419cd34@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 18:31:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V16 1/2] wifi: ath12k: fix VHT MCS assignment
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Baochen Qiang <quic_bqiang@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20251002000732.1916364-1-quic_pradeepc@quicinc.com>
 <20251002000732.1916364-2-quic_pradeepc@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251002000732.1916364-2-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: i-SZdaRppAu_wiC-KVlhecRGxi2GrMiT
X-Proofpoint-ORIG-GUID: i-SZdaRppAu_wiC-KVlhecRGxi2GrMiT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfXwLQfgnGur9V5
 OfTAme3BIUtMZK7JHZIugFOuwqrsxQ24MQSBQX/reJLIIa8zYIZv9dnLczFUHt24QIdpjBBNrVB
 OWRmMpo7R7dBtpahNupZ3hrUBaCLZ1RzJEStOs9QbTp8SP+x1DEHyfRKz6p74YQifN9GHk+td14
 Kyqo5nY0Ep7MX5nf8OhV020ieL1XM3QJAciC2W498c6mpkqsHA/3iwhc0tK9Et4/e4ww3AlZxHX
 slmmYAtMRomweF5OpyrE/GaBsG2fTW5puxnsma1TN0IX8noZsWoxKMu1j51EO88vu/sJhYO4cvm
 kBfuUHyfs8LbHFX8BECNm4kXzi23HZzldn8iH/bBENmTXgokoGnyRyg7l2JlflU+gdmraU79xt8
 KmlCvCvL9xGUuTXdh9qubQMJCYgTyQ==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68ddd5eb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=m5BbQQhsH88fZy18W4kA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On 10/1/2025 5:07 PM, Pradeep Kumar Chitrapu wrote:
> From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> 
> While associating, firmware needs the peer's receive capability
> to calculate its own VHT transmit MCS. Currently, the host
> sends this information via mcs->rx_mcs_set field, but firmware
> actually reads it from mcs->tx_mcs_set field. Thjis mismatch is

s/Thjis/This/

> incorrect.
> 
> This issue has not caused failures so far because most peers
> advertise identical TX and RX capabilities. Fix this by
> assigning the value to tx_mcs_set as expected.
> 
> Additionally, the rate control mask is intended to limit our
> transmit MCS, so it should also apply to the peer's receive
> capability. Update the logic accordingly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c |  7 +++----
>  drivers/net/wireless/ath/ath12k/wmi.c | 11 +++++++----
>  drivers/net/wireless/ath/ath12k/wmi.h |  2 ++

wmi.c and wmi.h need copyright updates to match current guidance.

>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 1d7b60aa5cb0..0d425a1bc0ab 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2249,7 +2249,6 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
>  	struct cfg80211_chan_def def;
>  	enum nl80211_band band;
>  	u16 *vht_mcs_mask;
> -	u16 tx_mcs_map;
>  	u8 ampdu_factor;
>  	u8 max_nss, vht_mcs;
>  	int i, vht_nss, nss_idx;
> @@ -2340,10 +2339,10 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
>  	arg->peer_nss = min(link_sta->rx_nss, max_nss);
>  	arg->rx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.rx_highest);
>  	arg->rx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.rx_mcs_map);
> -	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
> +	arg->rx_mcs_set = ath12k_peer_assoc_h_vht_limit(arg->rx_mcs_set, vht_mcs_mask);
>  
> -	tx_mcs_map = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
> -	arg->tx_mcs_set = ath12k_peer_assoc_h_vht_limit(tx_mcs_map, vht_mcs_mask);
> +	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
> +	arg->tx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
>  
>  	/* In QCN9274 platform, VHT MCS rate 10 and 11 is enabled by default.
>  	 * VHT MCS rate 10 and 11 is not supported in 11ac standard.
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index ff6b3d4ea820..2682d89afd44 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -2367,10 +2367,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>  	cmd->peer_bw_rxnss_override |= cpu_to_le32(arg->peer_bw_rxnss_override);
>  
>  	if (arg->vht_capable) {
> -		mcs->rx_max_rate = cpu_to_le32(arg->rx_max_rate);
> -		mcs->rx_mcs_set = cpu_to_le32(arg->rx_mcs_set);
> -		mcs->tx_max_rate = cpu_to_le32(arg->tx_max_rate);
> -		mcs->tx_mcs_set = cpu_to_le32(arg->tx_mcs_set);
> +		/* Firmware interprets mcs->tx_mcs_set field as peer's
> +		 * RX capability
> +		 */
> +		mcs->rx_max_rate = cpu_to_le32(arg->tx_max_rate);
> +		mcs->rx_mcs_set = cpu_to_le32(arg->tx_mcs_set);
> +		mcs->tx_max_rate = cpu_to_le32(arg->rx_max_rate);
> +		mcs->tx_mcs_set = cpu_to_le32(arg->rx_mcs_set);
>  	}
>  
>  	/* HE Rates */
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index a8c3190e8ad9..6d9c645e3d5d 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4218,8 +4218,10 @@ struct wmi_unit_test_cmd {
>  struct ath12k_wmi_vht_rate_set_params {
>  	__le32 tlv_header;
>  	__le32 rx_max_rate;
> +	/* MCS at which the peer can transmit */
>  	__le32 rx_mcs_set;
>  	__le32 tx_max_rate;
> +	/* MCS at which the peer can receive */
>  	__le32 tx_mcs_set;
>  	__le32 tx_max_mcs_nss;
>  } __packed;
I can apply my two comments when I process this series if there are no other
changes required.

/jeff

