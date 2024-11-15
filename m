Return-Path: <linux-wireless+bounces-15334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA49CF6E3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 22:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E819283B88
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D0174EE4;
	Fri, 15 Nov 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aCenDRq0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9318B463
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731705393; cv=none; b=ujhL+0NaW87GSmDvSIGMunocArPDOrk+mekD+37f0B000Wh650NSvQWhD3LQGq+yKxyr/pBt1Smj2Ben6JUteZZxLrhPRu3zuBvK5jQ9lkemhtQflFCE8EdCNRk80eqF6+oTF45gXI6qa4QkG54hnFblmfYXcINEcBrEtHHdOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731705393; c=relaxed/simple;
	bh=7IgNyq9HszjoQ4g8SNBvNH4a/IQhqhISrsVhTcmGJR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t+XgLbU7TcsiymJ1s1b4uA8R6PIEV/gz6GrtZsGAJFZ23Zx5l+3N2N5a+WUAe1qbkSm8RDbeQldh/gpqi9xbnFCy+681ivCbBfuVeOsWKloLwckTsVCkvuBx+1zAnjQPDRDpalA2DCp78XPNXFxI1YVALxBmJAwQ4bNawHzJvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aCenDRq0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFK9090024008;
	Fri, 15 Nov 2024 21:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eanNcV4f2Cug1pdblOpiQtL0P1PI9AUtq8WWXzuiHyI=; b=aCenDRq0l/n7gKVA
	xtYESQdiodWHC65tlF6/74IN+GgOqosWdz6N1T9nThi6sr6Y63SsvBe8BlDhtkwQ
	VfKqt8A3tC2IUgKzUFTcDX5G/Ec2z0c6grjlfz38hplneP+egJ6UbN1/ltj2r9cE
	fRXp2kwNUTGpEj03/wcmmcnVBSAgbg9mvjfuBTZd/GRA3HfFNxoMl2veQMPVaMHw
	fn5ejzWKnMP8p8cdYo6n710nW+Y0BH2VW66/rBaunA5JpKvUwtFkT2VlgLA0VCuO
	3aFiiRa0KjujiK7mw/nDwMQfi/EELQXw7R1jsdLBRdC2mTGd1UDhmbrJWZFHiwHF
	u5mkCg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42x3achuxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:16:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFLGRpj011503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:16:27 GMT
Received: from [10.111.176.23] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 13:16:27 -0800
Message-ID: <13d6d7a6-5073-4dc0-b229-c9b4365756d1@quicinc.com>
Date: Fri, 15 Nov 2024 13:16:26 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] wifi: ath12k: Support phy counter and TPC stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241115062854.1919672-1-quic_rdevanat@quicinc.com>
 <20241115062854.1919672-3-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241115062854.1919672-3-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M-0itLfGD0zBi58Y4P-Tl77HdcCH37Yp
X-Proofpoint-ORIG-GUID: M-0itLfGD0zBi58Y4P-Tl77HdcCH37Yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150179

On 11/14/2024 10:28 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request counters and Transmission Power Control
> (TPC) stats through HTT stats type 37. These stats give
> information about counters like received packet count, CRC pass
> count, error count, transmit abort count, etc., about counter reset
> like reset cause, channel frequency, number and mode, channel flags,
> etc., about TPC like transmit power scale, maximum transmit power,
> gain cap, EIRP, etc.
> 
> Note: MCC firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
> support HTT stats type 37, i.e., the firmware does not respond to the
> command requesting stats.
> 
> Sample output:
> -------------
> echo 37 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_PHY_STATS_TLV:
> bdf_nf_chain[0] = -92
> bdf_nf_chain[1] = -94
> bdf_nf_chain[2] = -94
> bdf_nf_chain[3] = -93
> .....
> 
> HTT_PHY_COUNTERS_TLV:
> rx_ofdma_timing_err_cnt = 18068
> rx_cck_fail_cnt = 0
> mactx_abort_cnt = 2612
> macrx_abort_cnt = 0
> .....
> 
> HTT_PHY_RESET_STATS_TLV:
> pdev_id = 0
> chan_mhz = 0
> chan_band_center_freq1 = 0
> chan_band_center_freq2 = 0
> .....
> 
> HTT_PHY_RESET_COUNTERS_TLV:
> pdev_id = 0
> cf_active_low_fail_cnt = 0
> cf_active_low_pass_cnt = 0
> phy_off_through_vreg_cnt = 0
> .....
> 
> HTT_PHY_TPC_STATS_TLV:
> pdev_id = 0
> tx_power_scale = 0
> tx_power_scale_db = 0
> min_negative_tx_power = 0
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> +struct ath12k_htt_phy_stats_tlv {
> +	a_sle32 nf_chain[ATH12K_HTT_STATS_MAX_CHAINS];
> +	__le32 false_radar_cnt;
> +	__le32 radar_cs_cnt;
> +	a_sle32 ani_level;
> +	__le32 fw_run_time;
> +	a_sle32 runtime_nf_chain[ATH12K_HTT_STATS_MAX_CHAINS];
> +} __packed;

it just occurred to me that these structs are actually misnamed.
these represent the payload of the tlv, not the actual tlv.
Kalle, as a future cleanup I suggest that we either rename these or modify
them plus the parsing code such that the TLV header is included in the struct.

I have a hunch that in order to support future firmware that extends these
structs that we'll actually want the tlv header so that handler code will have
the length and then know what version of the struct is present.




