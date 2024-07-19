Return-Path: <linux-wireless+bounces-10400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EEE937E09
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 01:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D031F20FAD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 23:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145D15EE8D;
	Fri, 19 Jul 2024 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gsRoDe20"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A829A35
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432063; cv=none; b=Dvd9iWxSVLFh/wz+9Tyz+d/qKMrLnTbXnP4p3DWmN+gof6IKwct5gf73db3+fqhpsPpCPuJvwZYi/pmrxgWMDIZ6IlAeROA5UdMGfMGpw6SZ1Bp49g2tfhN+NE0f0g+p0TzS9qUEWGFPrfFfTrwcvUeL+yaF0Rwq7tH6I6npxj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432063; c=relaxed/simple;
	bh=UEpNDHkzeo/RzV/Fdr3KFsrC56sOyKh7j7W/IcvaCpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WhN2KphYRQNY2VM2OTEhpC4f4XpmdZkatG0LMKNpXqLgr8hEgIq2Nt10wOuEz1phvIFICEOWj6RfbTouvzA4z/RC6tpBmlp3NiQz0aqdLi6uNl/PKF45UTGb9XVobi9gsN41Gtuo8FNw7DgYlm5k4dFMHFMsVTZOM8fo/kWUw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gsRoDe20; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JCaK5X018986;
	Fri, 19 Jul 2024 23:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M1wPQSMK1/R4Y/tnTVlEXZn5wtI3Wg5xGFEFrehCtLg=; b=gsRoDe20tQOQH6TI
	Xri1qO7RWx5zbnYNnFfVMXZ5kkz/8TZUKLAIg0tdvxA7P2+hkcV3cWQrug4JWniH
	P/aAR82W78h+8v+nR/B+aX5H7q9lfd6ZSloVI5v5NiQWwaQr4mJgi8CdgST4CwaT
	8AfXNYrVA1fxIML4mzz+2oNI/c1GfUC5nOqxLjScds6UrS8W5s/CT1zkysq4Wl/7
	D2Xsx5EFD3UqGOj/ItiEUgLNjCcBdZgQ5lQ7cauSkim90kUsRS9BN3BXItuTn/GF
	5KfNZ4JPn/Ome378qFMnaAwcefLs0g69H9Enzofv8yjb2nzR0XOdPGxTEgS+nl3o
	90xq/A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40fe352m72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 23:34:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46JNYFSN002691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 23:34:15 GMT
Received: from [10.48.244.127] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Jul
 2024 16:34:15 -0700
Message-ID: <90b0db09-16ea-4d70-a1c0-01ea81eb3406@quicinc.com>
Date: Fri, 19 Jul 2024 16:34:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] wifi: ath12k: Dump PDEV receive rate HTT stats
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240718064659.109893-1-quic_lingbok@quicinc.com>
 <20240718064659.109893-3-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240718064659.109893-3-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 969q-Z_FYJg7-E6NOUSd9n0c8If3JvNg
X-Proofpoint-ORIG-GUID: 969q-Z_FYJg7-E6NOUSd9n0c8If3JvNg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_09,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=638 clxscore=1015
 mlxscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407190174

On 7/17/2024 11:46 PM, Lingbo Kong wrote:
> Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
> 
> Sample output:
> -----------------
> echo 10 > /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats
> HTT_RX_PDEV_RATE_STATS_TLV:
> mac_id = 0
> nsts = 0
> rx_ldpc = 96
> rts_cnt = 0
> rssi_mgmt = 4294967240
> rssi_data = 4294967250
> rssi_comb = 4294967239
> rssi_in_dbm = -46
> rx_evm_nss_count = 0
> rx_evm_pilot_count = 0
> rx_11ax_su_ext = 0
> rx_11ac_mumimo = 0
> rx_11ax_mumimo = 0
> rx_11ax_ofdma = 0
> txbf = 0
> rx_su_ndpa = 0
> rx_mu_ndpa = 0
> rx_br_poll = 0
> rx_active_dur_us_low = 1000106
> rx_active_dur_us_high = 0
> rx_11ax_ul_ofdma = 0
> ul_ofdma_rx_stbc = 0
> ul_ofdma_rx_ldpc = 0
> per_chain_rssi_pkt_type = 0x88
> rx_nss =  0:40, 1:56, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_dcm =  0:0, 1:0, 2:0, 3:0, 4:0
> rx_stbc =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> rx_bw =  0:1175, 1:0, 2:0, 3:0
> rx_pream =  0:435, 1:644, 2:0, 3:0, 4:96, 5:0, 6:0
> rx_11ax_su_txbf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> rx_11ax_mu_txbf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> rx_legacy_cck_rate =  0:641, 1:0, 2:3, 3:0
> rx_legacy_ofdm_rate =  0:267, 1:0, 2:72, 3:0, 4:96, 5:0, 6:0, 7:0
> ul_ofdma_rx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> ul_ofdma_rx_bw =  0:0, 1:0, 2:0, 3:0
> rx_ulofdma_non_data_ppdu =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ulofdma_data_ppdu =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ulofdma_mpdu_ok =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ulofdma_mpdu_fail =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ulofdma_non_data_nusers =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ulofdma_data_nusers =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_11ax_dl_ofdma_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> rx_11ax_dl_ofdma_ru =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0
> rx_ulmumimo_non_data_ppdu =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ulmumimo_data_ppdu =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ulmumimo_mpdu_ok =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ulmumimo_mpdu_fail =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_mcs =  0:0, 1:0, 2:0, 3:0, 4:28, 5:8, 6:37, 7:21, 8:2, 9:0, 10:0, 11:0, 12:0, 13:0
> pilot_evm_db[0] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> pilot_evm_db[1] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> pilot_evm_db[2] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> pilot_evm_db[3] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> pilot_evm_db[4] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> pilot_evm_db[5] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> pilot_evm_db[6] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> pilot_evm_db[7] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> pilot_evm_db_mean = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rssi_chain_in_db[0] =  0: 196, 1: 29, 2: 29, 3: 29
> rssi_chain_in_db[1] =  0: 196, 1: 29, 2: 29, 3: 29
> rssi_chain_in_db[2] =  0: 128, 1: 128, 2: 128, 3: 128
> rssi_chain_in_db[3] =  0: 128, 1: 128, 2: 128, 3: 128
> rssi_chain_in_db[4] =  0: 128, 1: 128, 2: 128, 3: 128
> rssi_chain_in_db[5] =  0: 128, 1: 128, 2: 128, 3: 128
> rssi_chain_in_db[6] =  0: 128, 1: 128, 2: 128, 3: 128
> rssi_chain_in_db[7] =  0: 128, 1: 128, 2: 128, 3: 128
> rx_gi[0] =  0:0, 1:0, 2:0, 3:0, 4:28, 5:8, 6:37, 7:21, 8:2, 9:0, 10:0, 11:0
> rx_gi[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> rx_gi[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> rx_gi[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_gi[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_gi[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_gi[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> ul_ofdma_rx_gi[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
> rx_ul_fd_rssi: nss[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ul_fd_rssi: nss[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ul_fd_rssi: nss[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ul_fd_rssi: nss[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ul_fd_rssi: nss[4] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ul_fd_rssi: nss[5] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ul_fd_rssi: nss[6] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ul_fd_rssi: nss[7] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_per_chain_rssi_in_dbm[0] = 0:-60, 1:29, 2:29, 3:29
> rx_per_chain_rssi_in_dbm[1] = 0:-60, 1:29, 2:29, 3:29
> rx_per_chain_rssi_in_dbm[2] = 0:-128, 1:-128, 2:-128, 3:-128
> rx_per_chain_rssi_in_dbm[3] = 0:-128, 1:-128, 2:-128, 3:-128
> rx_per_chain_rssi_in_dbm[4] = 0:-128, 1:-128, 2:-128, 3:-128
> rx_per_chain_rssi_in_dbm[5] = 0:-128, 1:-128, 2:-128, 3:-128
> rx_per_chain_rssi_in_dbm[6] = 0:-128, 1:-128, 2:-128, 3:-128
> rx_per_chain_rssi_in_dbm[7] = 0:-128, 1:-128, 2:-128, 3:-128
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



