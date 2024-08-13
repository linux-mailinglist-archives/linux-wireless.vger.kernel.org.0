Return-Path: <linux-wireless+bounces-11353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483095086F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08C01F218C0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A873B19FA98;
	Tue, 13 Aug 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kHf0qKYU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4219F47E
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561467; cv=none; b=HEo3aeCYjuPOj9NtiZdypgSOGqBQousSbcm/M1/UbVSoVHOmurtcJCRPMgpqTa5jyYTXQdew7mOeJSYZQ/VEziAaJK0DYPT6Qqwi18TEBm9I5sWyoHoqIfpr+D30p/7VOtHncyBEY1p8jvTJ3RgxSa80+kJF0Qlh7xAKjStyAjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561467; c=relaxed/simple;
	bh=NDbcH9qcEoyK9HbUz23317A3+45q1+Ho6+JqVzlY0jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fCsvp6NiMx1jRvzyuclK6MQDVXDNvnqhKqPKoKvZOZUtT6WoeK76h+/oGIFY2VRJxM7ELuKFJA7ZEcEZL4N8gMw6WO/uLoL/GY6SRt3r/tRNfGi+YBzikrkvwxvQjtQQ66t1NVdH0i1EtgCSPFmezDZ4a8HfM9bMZi/B17nz7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kHf0qKYU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D8XbAh026741;
	Tue, 13 Aug 2024 15:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zmBoucqjTdVU4jvEzoHxwH39US3sy0JsoE2UfuwSyKg=; b=kHf0qKYU+tOCw2fC
	yJMy5xYoN6iAYEdCaRESs0BCS7QuhnaFhOYBP8+EcIaYwjMQoWmf35ZlN4yWftgh
	p7Hy0XljiQqFJW6YzTJWdQSos6D/kSA8y1fJu+qxYaTE/EwO8O04zhZJw9wbFwUk
	ymxJ+Bc14U7GtCYczbVkmZyRyxbAmYXmLqy1I3oyweoi3RLe2z4GtgBCugY4SSdI
	xeb6G3B3rVF6rxrlnRSAZ+S8Y42cfP+ADNtKGOD1yaU1t4BkEC85+6G3MRgLpYsx
	yKpqga2GG5D0RHaaudKDFrflnePO0HJXBru0b3Q30xzG2QOtnPNKI6el6Vh7siDz
	mByCmA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410437s9ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 15:04:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DF4Kse012715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 15:04:20 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 08:04:19 -0700
Message-ID: <b995936c-484e-4a31-85be-decba7e47845@quicinc.com>
Date: Tue, 13 Aug 2024 08:04:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath11k: fix NULL pointer dereference in
 ath11k_mac_get_eirp_power()
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240813083808.9224-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240813083808.9224-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7Bu9DKsTaCesbnodz10kqvsWE5CUkVPu
X-Proofpoint-GUID: 7Bu9DKsTaCesbnodz10kqvsWE5CUkVPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130108

On 8/13/2024 1:38 AM, Baochen Qiang wrote:
> Commit 39dc8b8ea387 ("wifi: mac80211: pass parsed TPE data to drivers") breaks
> ath11k, leading to kernel crash:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000018
> RIP: 0010:ath11k_mac_get_eirp_power.isra.0+0x5b/0x80 [ath11k]
> Call Trace:
>  <TASK>
>  ath11k_mac_fill_reg_tpc_info+0x3d6/0x800 [ath11k]
>  ath11k_mac_vdev_start_restart+0x412/0x4d0 [ath11k]
>  ath11k_mac_op_sta_state+0x7bc/0xbb0 [ath11k]
>  drv_sta_state+0xf1/0x5f0 [mac80211]
>  sta_info_insert_rcu+0x28d/0x530 [mac80211]
>  sta_info_insert+0xf/0x20 [mac80211]
>  ieee80211_prep_connection+0x3b4/0x4c0 [mac80211]
>  ieee80211_mgd_auth+0x363/0x600 [mac80211]
> 
> The issue scenario is, AP advertises power spectral density (PSD) values in its
> transmit power envelope (TPE) IE and supports 160 MHz bandwidth in 6 GHz. When
> connecting to this AP, in ath11k_mac_parse_tx_pwr_env(), the local variable
> psd is true and then reg_tpc_info.num_pwr_levels is set to 8 due to 160 MHz
> bandwidth. Note here ath11k fails to set reg_tpc_info.is_psd_power as TRUE due
> to above commit. Then in ath11k_mac_fill_reg_tpc_info(), for each of the 8
> power levels, for a PSD channel, ath11k_mac_get_psd_channel() is expected to
> be called to get required information. However due to invalid
> reg_tpc_info.is_psd_power, it is ath11k_mac_get_eirp_power() that gets called
> and passed with pwr_lvl_idx as one of the arguments. Note this function
> implicitly requires pwr_lvl_idx to be no more than 3. So when pwr_lvl_idx is
> larger than that ath11k_mac_get_seg_freq() returns invalid center frequency,
> with which as the input ieee80211_get_channel() returns NULL, then kernel
> crashes due to NULL pointer dereference.
> 
> Fix it by setting reg_tpc_info.is_psd_power properly.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: 39dc8b8ea387 ("wifi: mac80211: pass parsed TPE data to drivers")
> Reported-by: Mikko Tiihonen <mikko.tiihonen@iki.fi>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219131
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



