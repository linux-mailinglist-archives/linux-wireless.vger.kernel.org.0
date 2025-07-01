Return-Path: <linux-wireless+bounces-24700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB024AEEC59
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 04:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231E91BC27BC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 02:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6F11E515;
	Tue,  1 Jul 2025 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gmip1stQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C886328
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336070; cv=none; b=dL6HXNkRTIPdoEJNwomeIJmt3k1G9jQo6RsXJplKy01GXihI8eehTjhDqx5YsU4nMuwq2GkQOYAluOtA2r7OBaaqZEPxlvJb0D8g/51kwI3/7eWVBDu78qft+GROIfpI/RJjZok8uojOHSRrstj8TBXEawCZzaeuxNOHj2+64+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336070; c=relaxed/simple;
	bh=azglsArCkDIez0n8QCezhzZIz+CuX6OGai+53uj8n6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6PAYIZ0q3x/s2YdJ2uUPwG91UU8jWDVeuyBResWQ3I602Z16tt+O2L2+BTLaQFWrpi7R4YMQhg1y9W7OT+I7YcB6HVf7chRRAcsTdmuB3Tv5RveCUIEYQJK2amaQZTCYc8K7CN3NrPf2+Pj/ZVYy8m340Wma8wlQ1vGNJGUEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gmip1stQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UG7sek029422
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 02:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HHtKxWM11+Z22kidvQGi6Fw1MG9JX6Dkd9yt+AT+dMo=; b=Gmip1stQimUj7a4x
	ILqELKq6zz7Ui9ByPoYeBEEJ5umyeSFpGyeKw3JIp/q0DawFB8r2HERbq80AmSlZ
	RnsEwh5UTT4ytZcu+wOL+6bxpTk6X/2hvpD4PtGnL2KB8EfXdq3GKuW2ACsWbLfG
	/Dv9irFblsHymImHWTjFMwUMdbMcuBxUkkJaZn6DWIDfVYAt9fTsUdd5PlX+otiR
	YpIl8c/9o+iuvKcnQzL54I4LPWr+TVyOh3kQ6p1O+JMTP3cSMpZ/Jz2U1DEtOXCP
	Zv8Go9rZeEJyCQzIM7ycEve2tcs2JJH2HmqA4DuIfES1lWVJAxNzd+7JT7gkBpir
	KWKUQA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j95hxmd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 02:14:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b34b810fdcaso2234101a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 19:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336067; x=1751940867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHtKxWM11+Z22kidvQGi6Fw1MG9JX6Dkd9yt+AT+dMo=;
        b=bYk+BBN7CzZlaT5rgRpN2Nm6Fp8tdxGT/WRJtDzL55Q5S0wt1glBUimi2KLB4CH7l7
         mfqpbCZuH+pgmyLrFZEJ9D/3WfaYkzWZ01exreRo+t4rsUh5uf+wZU4BNJFfeTcZfB7S
         /VQ29qiVecsWQPv2jR52l+aSS961aVa2lQqIJ+jnAGiFqWUrA8mGLsMsydAX4SzMk1kd
         3i2DVk5Md01io5taANn9T0Vit/j1y8Wy81mgnr1lrzoh8XuRcviG0rHvie4ifkTHUVHt
         9o7cge/RRvmTDVxZxDx29vWb5wtM56U7cH+E+AP7AOEMcMybe7kjaCHM5N55s7wV69rS
         RuWw==
X-Gm-Message-State: AOJu0YyqY/tph0JRq6IBewu+h3gzTAL1iHGE4aY4zNe90ke8sXYsjIoN
	ScM3MadDOm0WGYECfjDGhf4nvVZJ49B3s9vm6sQQJpbUaNV9cviPAEeDYU99brdMcurC9kGUpha
	w3dl+PR7420WEt9UcouYbBZltF02CLc9aCQUJPqUi7FZBoNWUeUSXGIznVEW1R3F7bFSXVj3APg
	aljqT2
X-Gm-Gg: ASbGnct0PXthcYa1YdbAcCJPICXESTeaNMapKMKt6qn87li60P+iIXkfSqyYYAMW34j
	AS8kWy4EJ13ThjqIX5TPRAVFIWPI2n9zWn+JMVJ7IQBFPnS/+YZ9GYQVYRAKUv2fD5MdOErdGw0
	iXf2ZRSZ3C+/BTkSUXwTL4FBDoQ0Q1pLNsRGna+GGp7fwV4hGkeI5bDA0zm4sZVoo4Mh0zdeFk3
	lxAXleTX00E9wP9z+BpLCwSFyolsy3NizHQkuk+iX9y2zqHqUKH3cSMdg9B2t/ix2zDJSUDfxEM
	3AtQB3rizQ4+XbLpfVHbX4MTp8UsJFsIq8eTa2GdogLURfeb80UkgylRDHlz3wEQYM0/dXuZkDd
	KNU8K6tLx
X-Received: by 2002:a17:903:22cb:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23ac3dec2damr203708075ad.6.1751336066841;
        Mon, 30 Jun 2025 19:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEah756PkrXyZjdLbRVeC6taDGb8DFPvCLCg1nYwqQmUmacq7NGEn8t2UNmihcTj9KqCH7Idw==
X-Received: by 2002:a17:903:22cb:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23ac3dec2damr203707805ad.6.1751336066327;
        Mon, 30 Jun 2025 19:14:26 -0700 (PDT)
Received: from [10.133.33.126] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b0052sm93404815ad.158.2025.06.30.19.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 19:14:26 -0700 (PDT)
Message-ID: <ac2398f4-4720-4e15-bf8c-c588c7315960@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 10:14:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V15 5/9] wifi: ath12k: fix TX and RX MCS rate
 configurations in HE mode
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Baochen Qiang <quic_bqiang@quicinc.com>
References: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
 <20250701010408.1257201-6-quic_pradeepc@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250701010408.1257201-6-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAwNSBTYWx0ZWRfX6rCd0UsJddWy
 7eSDg8xJtSYOrOwbygNmLJZaDoynnudambJSFDOfpxBROqV+pWfjwE4S4lz293spfptSTFszPyO
 y6Vy2b23ABcaPmSM/3xnymj5Ru+RvKv51zmD9NdbqtCNdvaFYfqkzvcnRPm650awpWbGTVgpWn2
 Z8getKb20gGFMG2qoYogS4wYegZhV5RZM0RhhfLlY+bZK4v4Y9gADhBwO2v0CSUJWy5yBScQfCd
 HaJvAJo2bBM0P52JkRPe9QKiKLus6dTMRPNUtikW1covGSBcd+VLnvgLibjAd94sRySX/a9xGHS
 RtbBlI9F7qenKNLwH/VObL9QfwlnJmfzrM11kniZZcJj03DHeTUKtHIKymyFTyU8L0LQJSfWqzV
 arw/o4OCdGQFxJL3NoMmneBcXdWvO+H0XsMsJre6qMP2Z95UsSd+FCbdrt/bUFjNGUuvw1LJ
X-Proofpoint-ORIG-GUID: tGdoQksP3c4lA0sQZoRiarHE1grIFNF4
X-Authority-Analysis: v=2.4 cv=EuHSrTcA c=1 sm=1 tr=0 ts=68634484 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=Un5vsAVSn38TPk-1xuEA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tGdoQksP3c4lA0sQZoRiarHE1grIFNF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010005



On 7/1/2025 9:04 AM, Pradeep Kumar Chitrapu wrote:
> Currently, the TX and RX MCS rate configurations per peer are
> reversed when sent to the firmware. As a result, RX MCS rates
> are configured for TX, and vice versa. This commit rectifies
> the configuration to match what the firmware expects.

Please mention that you are rectifying only for AP mode. For STA, current code is good.

> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

I don't see the need to add my S-O-B here, better drop it.

> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 19 +++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 6c6354b3e18e..cdf3406302ee 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -2183,6 +2183,8 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>  				   struct ath12k_wmi_peer_assoc_arg *arg)
>  {
>  	struct ath12k_wmi_pdev *wmi = ar->wmi;
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_link_vif *arvif;
>  	struct wmi_peer_assoc_complete_cmd *cmd;
>  	struct ath12k_wmi_vht_rate_set_params *mcs;
>  	struct ath12k_wmi_he_rate_set_params *he_mcs;
> @@ -2198,6 +2200,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>  	u16 eml_cap;
>  	__le32 v;
>  
> +	arvif = ath12k_mac_get_arvif(ar, arg->vdev_id);
> +	if (!arvif) {
> +		ath12k_warn(ab, "failed to find arvif with vdev id %d\n",
> +			    arg->vdev_id);
> +		return -EINVAL;
> +	}
> +
>  	peer_legacy_rates_align = roundup(arg->peer_legacy_rates.num_rates,
>  					  sizeof(u32));
>  	peer_ht_rates_align = roundup(arg->peer_ht_rates.num_rates,
> @@ -2333,8 +2342,14 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>  		he_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HE_RATE_SET,
>  							    sizeof(*he_mcs));
>  
> -		he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
> -		he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
> +		if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
> +			he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
> +			he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
> +
> +		} else {
> +			he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
> +			he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
> +		}
>  		ptr += sizeof(*he_mcs);
>  	}
>  
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 0964ca03069a..7ad84624600d 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4162,7 +4162,9 @@ struct ath12k_wmi_vht_rate_set_params {
>  
>  struct ath12k_wmi_he_rate_set_params {
>  	__le32 tlv_header;
> +	/* MCS at which the peer can receive */
>  	__le32 rx_mcs_set;
> +	/* MCS at which the peer can transmit */
>  	__le32 tx_mcs_set;
>  } __packed;
>  


