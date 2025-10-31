Return-Path: <linux-wireless+bounces-28429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BAC231E7
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 04:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE66D18848F8
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5E255248;
	Fri, 31 Oct 2025 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ir9GRC5J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F29c+6sv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126962F29
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879945; cv=none; b=b5UuVZPCefCsFrt+8x83VxbWiEoCGuYjCHH/ceMClnYZiJBao5qfd9W52FXZ/CxyjQW1iFIoYbA/7TFjK8JqwillCmwAC3cAVxCSFWC086Mxzl3ZpaQYXJ07yzuaeSUEPgLcgJmVsLVQzzT1hiw3wKQsS/aSE7Pi2RdbGwv03XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879945; c=relaxed/simple;
	bh=mE86wz7+ATc9Lt8rm7y78Jrs5jraf62IKAio4zpOxcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duLF9kYNXwwxyJzPXFLMnC/Tf9XzNAhfGkESpmQgPQzSzc4L/ibRhCwZc+/RlvwZBQcHnmo3lOQvZyTAgpYSresbJchbWFL/tZODs0TqUUneq3i4LqGNYlyPzXSh2khQA19jViq+Jrg3cLANrgKpbzkJBOFt4t08i7lZrWqoXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ir9GRC5J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F29c+6sv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UIAkSq3115499
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MA5lbu0DUz3G5wLJNDxBqMZG25p85XEtyG0AHNBXzI4=; b=ir9GRC5JdjP+/dKQ
	Z3dS46kEeRXwFXfgpq/7sSfwJmM4Fu8zpdK35oFx02SFxAHxINam2GoDa/DWDGH9
	lhYU21Dj5S05UIULdYGfa7Szw/IK2vN5UDH5p5xCY7+50HPosPPt5/ds4wlimKQv
	/ePubbdff1SFoZJ1L9mq2l7vRBp8hReln1x+3CdgOIXQb2W1bHNSZ+wrkLcQDODG
	OFWveYBS9itq2b3zo5jWRdRjAwUGc0FhpPw+Cdf8pAfBCSgpTSDjB11xW9uocdpF
	qigeNIbjRwkx5LQTIGx1I0qR4R4bouqmHSTafa1S0lfD9051NX/3/eTFnDZyMBPE
	m3d3MA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b42q3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 03:05:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso1743068b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761879942; x=1762484742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MA5lbu0DUz3G5wLJNDxBqMZG25p85XEtyG0AHNBXzI4=;
        b=F29c+6svxfcV9HewP5KFjzO7qyzf273WrMjHlC1Ul0laYPkP+FtuEJ6wZ4QNf1IHNV
         aFMvJe/MLRuuFgABW6Kf+SUStbnuUJFSBs8uz+TeydUtzoF4vpvZLHzTLnY50tU+EJGG
         kigNE7DrhmUNWflxv4nd2HWfSJzKxSsl8Q5V2CcT0K6XZnuMhA06qxlAU3Oj1KriVbVF
         zUZ5YwmFJNyIFJcKldFPkNbYPvMjJy0/+NsYvMVGInzNXPgcDHDiYB5YjdMRwzmoQjIi
         qy9Wo+KPwdLge3tGdfKJjME+/jG0468PdDH78IAVYdU/6QYQTfDLGZ9LvrlF8Scb0JFJ
         V08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879942; x=1762484742;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MA5lbu0DUz3G5wLJNDxBqMZG25p85XEtyG0AHNBXzI4=;
        b=CJJ617xN/DJWxy1bQNMn3r1XLYGr3rkn4c4uOhh4RDE3JkDIpNrOHbazYwl7Zk2opi
         dVfGM7s2GgmPE+cBX1yqYZEM8XwQMeEXLhKgRq/Q0phdNQiavmqFn+cLCbL8eut7Vdt5
         KP/y6x/LiJMrfWww+dHvbp/v6MqihHpU8wQAqfSyA4ds1WYfcfi8Q/LUUZJ2jARXpKKz
         q1Bh1rtBbsp+yWyFohThqDw9NjbO5mJQ7bUF2JbFvvc1cgD0axPtT3C0/yYk+JzveCdu
         D50Xc9hPgR0URv7TcixR5QRuGn3NQ7zvRJn37KR/oZu66lxovgT1FO2U34cS1GPe8nwV
         vVxA==
X-Forwarded-Encrypted: i=1; AJvYcCVuGfmNdXqvxDFD519K66YOHq8dK7vYNS5cSbFmW9lpFOp9hXP/3qaI4Fo+ir48IJbIVK8V1QGnp9w2va3uzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCedlM4QaZJSmavZyn56Px5k9rsj+e34YMuyXI8l68SWMLrMeq
	IgUuJxY9DWDxa9BBBW+Fddv8iOEEMRQOo+rNKL0CPF8dKV/zZEhAGCda4OOdAwKkk4SHir1kQPv
	cjkAhULtRbsj15UzOM/2e4GwNCpj70IbuEK5obf4SybDmdgfjVNgPWKSpEi0bL+DB/761dA==
X-Gm-Gg: ASbGnctRTe3YzWkB5AZz32p9+uh1HAcPtz+FWKx/kF9ekAaYH/JDRc8y2oH6P/8zjKD
	cXwu2P0UYde8ZzNbH0L//F3isDhaCSXsY6ZtLS6e5RLsZmZDpOsxaGdldNXLXmvvGCHnQopKfMc
	xnaQYQxZZhu0aU0nQC+1vaoyA+kFNd1V3uiKm+h34UsTodKwcew6Q7lOGN6Er0j+/EuBJernABT
	8al9+nghXrxIKe9EbRpWvAyZXJrqZdWr43slmqst08lIpyg/El7hHvbkqvYokZoNh31U3Jest7d
	wCzAHCiGTxRt3vLrwYGf+KuUxmYZjLYkX0B4loueu6uxUct9Vw/M8B+OCcb9cqtKKHDY1oa9wkM
	vQu75vQpsRCs/AHSRtHRiA8PfNIn1SX15jkFhWq3zZlinnmVJsmCkHWNS8CAIYxFHRW3RIUY=
X-Received: by 2002:a05:6a00:cc7:b0:781:157b:3d2e with SMTP id d2e1a72fcca58-7a778cf3894mr2507812b3a.21.1761879941876;
        Thu, 30 Oct 2025 20:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgqFq+x83K/w0XoHv5jjm7Z7A1qf/no0XyscJ358L9PqS4j8gmhhK9TxM/9BK5TD3G5lEVAw==
X-Received: by 2002:a05:6a00:cc7:b0:781:157b:3d2e with SMTP id d2e1a72fcca58-7a778cf3894mr2507767b3a.21.1761879941288;
        Thu, 30 Oct 2025 20:05:41 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8e6fa5bsm378826b3a.27.2025.10.30.20.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 20:05:40 -0700 (PDT)
Message-ID: <69db0369-91bd-4fb3-83aa-4db1216fc747@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 11:05:35 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 6/6] wifi: ath11k: Register handler for CFR
 capture event
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-7-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251030043150.3905086-7-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyNiBTYWx0ZWRfX4ZRk+2zfbjS7
 I0eqE//1lJ/bG2FrQoG6HeWP2NCDjyAI0bvvWq370hbC41r9KwQhjmvvNJCjwDdoEG940/3BSva
 rRkaq6PkQbO77JiEG08LSQABDx0ntxP5hIYP9Iw4GogjwDWMJhpBP1wVtRxHp5cXDJPjTkonIjT
 sv35RiU+E9NVNjNL3IO34jADXfztMPg3iBCSFf2b0lPb+eFK+/e3e0Av3XRyzbu+89d4YdAAIE5
 s8yd6wWaMIG7OTLszK9sDEtcc51IPPnjXqSP+G9PQyFFkoCCfmvKFVA8/fAwdqAA6dFWGFErLjh
 0/0DsdjKf8Zuzb7hoKEhD7DPKfRuLl3leHF74qG8iJRwYdHEWAXYlrNiXdRUn6jzoo+r4iDCF62
 quEfUeCvdZVFl+lY4CjddSJdSwDNGQ==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=69042787 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=c2OXSssSWZ9PRKTZbFMA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _RxgW7GgUDQf-MWrSM7gdwKCOfQ4X3ku
X-Proofpoint-GUID: _RxgW7GgUDQf-MWrSM7gdwKCOfQ4X3ku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310026



On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:
> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> 
> Firmware sends CFR meta data through the WMI event
> WMI_PEER_CFR_CAPTURE_EVENT. Parse the meta data coming from the firmware
> and invoke correlate_and_relay function to correlate the CFR meta data
> with the CFR payload coming from the other WMI event
> WMI_PDEV_DMA_RING_BUF_RELEASE_EVENT.
> 
> Release the buffer to user space once correlate and relay return
> success.
> 
> Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Co-developed-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/cfr.c | 145 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/cfr.h |  62 ++++++++++-
>  drivers/net/wireless/ath/ath11k/wmi.c |  90 ++++++++++++++++
>  drivers/net/wireless/ath/ath11k/wmi.h |  44 ++++++++
>  4 files changed, 340 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
> index e8a976d64733..61eeb02af6c5 100644
> --- a/drivers/net/wireless/ath/ath11k/cfr.c
> +++ b/drivers/net/wireless/ath/ath11k/cfr.c
> @@ -247,6 +247,151 @@ static int ath11k_cfr_process_data(struct ath11k *ar,
>  	return status;
>  }
>  
> +static void ath11k_cfr_fill_hdr_info(struct ath11k *ar,
> +				     struct ath11k_csi_cfr_header *header,
> +				     struct ath11k_cfr_peer_tx_param *params)
> +{
> +	header->cfr_metadata_version = ATH11K_CFR_META_VERSION_4;
> +	header->cfr_data_version = ATH11K_CFR_DATA_VERSION_1;
> +	header->cfr_metadata_len = sizeof(struct cfr_metadata);
> +	header->chip_type = ar->ab->hw_rev;
> +	header->meta_data.status = FIELD_GET(WMI_CFR_PEER_CAPTURE_STATUS,
> +					     params->status);
> +	header->meta_data.capture_bw = params->bandwidth;
> +	header->meta_data.phy_mode = params->phy_mode;
> +	header->meta_data.prim20_chan = params->primary_20mhz_chan;
> +	header->meta_data.center_freq1 = params->band_center_freq1;
> +	header->meta_data.center_freq2 = params->band_center_freq2;
> +
> +	/* Currently CFR data is captured on ACK of a Qos NULL frame.
> +	 * For 20 MHz, ACK is Legacy and for 40/80/160, ACK is DUP Legacy.
> +	 */

please check comment style

> +	header->meta_data.capture_mode = params->bandwidth ?
> +		ATH11K_CFR_CAPTURE_DUP_LEGACY_ACK : ATH11K_CFR_CAPTURE_LEGACY_ACK;
> +	header->meta_data.capture_type = params->capture_method;
> +	header->meta_data.num_rx_chain = ar->num_rx_chains;
> +	header->meta_data.sts_count = params->spatial_streams;
> +	header->meta_data.timestamp = params->timestamp_us;
> +	ether_addr_copy(header->meta_data.peer_addr, params->peer_mac_addr);
> +	memcpy(header->meta_data.chain_rssi, params->chain_rssi,
> +	       sizeof(params->chain_rssi));
> +	memcpy(header->meta_data.chain_phase, params->chain_phase,
> +	       sizeof(params->chain_phase));
> +	memcpy(header->meta_data.agc_gain, params->agc_gain,
> +	       sizeof(params->agc_gain));
> +}
> +
> +int ath11k_process_cfr_capture_event(struct ath11k_base *ab,
> +				     struct ath11k_cfr_peer_tx_param *params)
> +{
> +	struct ath11k_look_up_table *lut = NULL;
> +	u32 end_magic = ATH11K_CFR_END_MAGIC;
> +	struct ath11k_csi_cfr_header *header;
> +	struct ath11k_dbring_element *buff;
> +	struct ath11k_vif *arvif;
> +	struct ath11k_cfr *cfr;
> +	dma_addr_t buf_addr;
> +	struct ath11k *ar;
> +	u8 tx_status;
> +	int status;
> +	int i;
> +
> +	rcu_read_lock();
> +	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, params->vdev_id);
> +	if (!arvif) {
> +		rcu_read_unlock();
> +		ath11k_warn(ab, "Failed to get arvif for vdev id %d\n",
> +			    params->vdev_id);
> +		return -ENOENT;
> +	}
> +
> +	ar = arvif->ar;

ath11k_mac_get_ar_by_vdev_id() is better?



