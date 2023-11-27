Return-Path: <linux-wireless+bounces-127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193247FAB3E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 21:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD211C20DD3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA545C0E;
	Mon, 27 Nov 2023 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QumiNdTh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3528919A2;
	Mon, 27 Nov 2023 12:20:52 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARGf8ni000705;
	Mon, 27 Nov 2023 20:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PykEI3kBnGArX6ZTILAiHR5jrndvm6I7RF6QCjTaLxM=;
 b=QumiNdThgZdTCIo6a1bU6S1RLbFHn6GQHpsQD4eeqMVdotC+FiuIeJHLi4USf20BbLRE
 iiY1zguvESxyfjQPvuRkEz6rC8gafRyuiVgvtHqzQa7orgWyZuLL7vmeZbV7Q2jFpPHm
 Pt5CF6Qm66uN+TfK5pt3jXcOem9bbC4UvGIXhptov40KJJ6aCwr1MwGLY0eqLaV9tIdz
 fOe8sG0kykhLehwK+H+B/eicjbLPH5RAuj+QYivh7E9Nxny5UJVRAxebzLSqK57/vn+d
 ZH2hU/BXOlhJGhYLR1JVWMdyAVFjF9TsVckKCPxHkk93eZ9hvzkebLm4khJ7xfFQvOgW DQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk69udqu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 20:20:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ARKKirc022822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 20:20:44 GMT
Received: from [10.110.63.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 12:20:43 -0800
Message-ID: <13582287-09b3-4da8-8d5e-5521777b2758@quicinc.com>
Date: Mon, 27 Nov 2023 12:20:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix layout of scan_flags in struct
 ath12k_wmi_scan_req_arg
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath12k@lists.infradead.org>
References: <20231127180425.1695427-1-nico.escande@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231127180425.1695427-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _z9fHolTNOK7Dv0jbk9V-CUe-wvBjoTz
X-Proofpoint-GUID: _z9fHolTNOK7Dv0jbk9V-CUe-wvBjoTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=997 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270141

On 11/27/2023 10:04 AM, Nicolas Escande wrote:
> There is a layout mismatch between the bitfield representing scan_flags in
> struct ath12k_wmi_scan_req_arg & the bits as defined in the WMI_SCAN_XXX
> macros. Fix it by making the biefield match de #define values.
> 
> I especialy checked by adding WMI_SCAN_FLAG_FORCE_ACTIVE_ON_DFS to
> scan_flags and the firmware started to unconditionnaly send probe request
> on DFS channels during scan.
> 
> Tested-on: QCN9274 hw2.0 PCI CI_WLAN.WBE.1.2.1-00148.1-QCAHKSWPL_SILICONZ-7
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 629373d67421..2b5b46f8898e 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3307,17 +3307,17 @@ struct ath12k_wmi_scan_req_arg {
>  			    scan_f_filter_prb_req:1,
>  			    scan_f_bypass_dfs_chn:1,
>  			    scan_f_continue_on_err:1,
> +			    scan_f_promisc_mode:1,
> +			    scan_f_force_active_dfs_chn:1,
> +			    scan_f_add_tpc_ie_in_probe:1,
> +			    scan_f_add_ds_ie_in_probe:1,
> +			    scan_f_add_spoofed_mac_in_probe:1,
>  			    scan_f_offchan_mgmt_tx:1,
>  			    scan_f_offchan_data_tx:1,
> -			    scan_f_promisc_mode:1,
>  			    scan_f_capture_phy_err:1,
>  			    scan_f_strict_passive_pch:1,
>  			    scan_f_half_rate:1,
>  			    scan_f_quarter_rate:1,
> -			    scan_f_force_active_dfs_chn:1,
> -			    scan_f_add_tpc_ie_in_probe:1,
> -			    scan_f_add_ds_ie_in_probe:1,
> -			    scan_f_add_spoofed_mac_in_probe:1,
>  			    scan_f_add_rand_seq_in_probe:1,
>  			    scan_f_en_ie_whitelist_in_probe:1,
>  			    scan_f_forced:1,

+ath12k mailing list

Repeating my same message from the ath11k patch:

You are convoluting two different data structures.

struct ath12k_wmi_scan_req_arg is used to represent a scan request
within the host driver. This does not use the WMI_SCAN_XXX macros.

struct wmi_start_scan_cmd is used to represent the scan request command
sent to firmware. This struct uses the WMI_SCAN_XXX macros to fill some
members of this struct in ath12k_wmi_copy_scan_event_cntrl_flags().

So your change has no effect on the driver operation and incorrectly
tries to foist the firmware definition upon the host internal
representation.

So NAK to this patch.

/jeff

