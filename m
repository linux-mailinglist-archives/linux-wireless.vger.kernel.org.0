Return-Path: <linux-wireless+bounces-2579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BF183E62D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41772B23572
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 23:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FF255E5A;
	Fri, 26 Jan 2024 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BqAc79VX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DC55E57
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310330; cv=none; b=NodO77yrXvA8htTFmeCV3vXoHOQNy/w/GVI5UDe2uHzpz7uI+0tdjNp04MWW8xBwt3MCQw+GQZpbaLlAGZ5espUi4WKbvKzBRTpEt0B+PtNdtuoLHhohXfRd0Gm6cTJaGE/d/ueGw728/MAZCz1Gfg7Z1vPe6wOBIP1RtcTvnM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310330; c=relaxed/simple;
	bh=kqf1PS25O3yZUv9TgxtONuPp6/sf9wCGt9bjjrG4k88=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=L3do/2IaDOoZX5eOud8YJWDVvz0o0NWViSFSMIoPUz6tuAGD5+1e06mCPXfKyvkBvGVttcLMtBwJF/aEsFam1bOnI6x4PD0zuv3Oz9+zpnkHztKMRqFUbAeMvwhkDpBHSUUmW6pf5+cGoK4iIQKU4pCgKPPeh1Nch2u71J07t4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BqAc79VX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QMlOL0010839;
	Fri, 26 Jan 2024 23:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CERkHsU70nO+wGZCCWbleHhRn0h1zZWsX6mSTCTy/dk=; b=Bq
	Ac79VX1NzGCdkYswGDBxv/HopboIcgR4cyE9ob/Mmdq3+pztdOWEihI1wE8mE7Ss
	biPrucQEqpEGV9zP6d+RICqXW3AyOxiPePmO2J6Z4ZbcxC3hDgcqE8fO09g3cXeN
	H0vjSHGIxHLaG7nk0kuLOvyEU0ULVCZSAfXGdhjI5CMDoEE7ZY37IB2iU5UJWXdD
	ejNYDs542QotsFNYzF784FHWv0+kw4xeKdUu708xdBM55Fhql2SlxxlQ7Cnasqgg
	kL8vIHscBVcp48jpXqdH6+2qhigqiuoEdqjuGTDeQlcVpCeArdSbnRjd2W1iPQe1
	akwrZnhyREr1XvnbD2uA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv8e89sg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:05:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QN5Prl006555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:05:25 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 15:05:24 -0800
Message-ID: <0b39cf96-3ed4-45b7-9254-2604716afe14@quicinc.com>
Date: Fri, 26 Jan 2024 15:05:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] wifi: ath12k: fix incorrect logic of calculating
 vdev_stats_id
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-11-quic_kangyang@quicinc.com>
 <0dd4948b-e967-4562-b98e-2f4643205ca4@quicinc.com>
In-Reply-To: <0dd4948b-e967-4562-b98e-2f4643205ca4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ckL5O4yvz069kGwa3YCzDUuroDFRat3n
X-Proofpoint-ORIG-GUID: ckL5O4yvz069kGwa3YCzDUuroDFRat3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260170

On 1/26/2024 8:56 AM, Jeff Johnson wrote:
> And it seems there is another bigger issue here since, as the firmware
> document indicates, the vdev_stats_id field should be ignored unless the
> vdev_stats_id_valid field is non-zero, but in ath12k_wmi_vdev_create()
> we don't set vdev_stats_id_valid -- and we cannot set it since it isn't
> even present in the ath12k struct wmi_vdev_create_cmd! And comparing our
> struct to the firmware definition shows we have missing fields!!!
> Everything is correct up to pdev_id, but then there is divergence:
> 
> our struct
> struct wmi_vdev_create_cmd {
> 	__le32 tlv_header;
> 	__le32 vdev_id;
> 	__le32 vdev_type;
> 	__le32 vdev_subtype;
> 	struct ath12k_wmi_mac_addr_params vdev_macaddr;
> 	__le32 num_cfg_txrx_streams;
> 	__le32 pdev_id;
> 	__le32 vdev_stats_id;
> } __packed;
> 
> firmware definition
> typedef struct {
>     A_UINT32 tlv_header; /** TLV tag and len; tag equals
> WMITLV_TAG_STRUC_wmi_vdev_create_cmd_fixed_param */
>     /** unique id identifying the VDEV, generated by the caller */
>     A_UINT32 vdev_id;
>     /** VDEV type (AP,STA,IBSS,MONITOR) */
>     A_UINT32 vdev_type;
>     /** VDEV subtype (P2PDEV, P2PCLI, P2PGO, BT3.0, BRIDGE) */
>     A_UINT32 vdev_subtype;
>     /** VDEV MAC address */
>     wmi_mac_addr vdev_macaddr;
>     /** Number of configured txrx streams */
>     A_UINT32 num_cfg_txrx_streams;
>     /**
>      * pdev_id for identifying the MAC,
>      * See macros starting with WMI_PDEV_ID_ for values.
>      */
>     A_UINT32 pdev_id;
>     /** control flags for this vdev (DEPRECATED)
>      * Use @mbss_capability_flags in vdev start instead.
>      */
>     A_UINT32 flags;
>     /**  vdevid of transmitted AP (mbssid case) (DEPRECATED)
>      * Use @vdevid_trans in vdev start instead.
>      */
>     A_UINT32 vdevid_trans;
>     /* vdev_stats_id_valid indicates whether vdev_stats_id is valid */
>     A_UINT32 vdev_stats_id_valid;
>     /**
>      * vdev_stats_id indicates the ID for the REO Rx stats collection
>      * For Beryllium: 0-47 is the valid range and >=48 is invalid
>      * This vdev_stats_id field should be ignored unless the
>      * vdev_stats_id_valid field is non-zero.
>      */
>     A_UINT32 vdev_stats_id;
> /* This TLV is followed by another TLV of array of structures
>  *   wmi_vdev_txrx_streams cfg_txrx_streams[];
>  *   wmi_vdev_create_mlo_params mlo_params[0,1];
>  *       optional TLV, only present for MLO vdev;
>  *       if the vdev is not MLO the array length should be 0.
>  */
> } wmi_vdev_create_cmd_fixed_param;
> 
> (note the deprecated fields must still have their space allocated in the
> data structure)
> 
> So currently when host is writing to vdev_stats_id firmware will
> interpret this as the deprecated flags
> 
> So it seems like we also need to fix the WMI struct to:
> struct wmi_vdev_create_cmd {
> 	__le32 tlv_header;
> 	__le32 vdev_id;
> 	__le32 vdev_type;
> 	__le32 vdev_subtype;
> 	struct ath12k_wmi_mac_addr_params vdev_macaddr;
> 	__le32 num_cfg_txrx_streams;
> 	__le32 pdev_id;
> 	__le32 flags; /* deprecated */
> 	__le32 vdevid_trans; /* deprecated */
> 	__le32 vdev_stats_id_valid;
> 	__le32 vdev_stats_id;
> } __packed;

Sigh. I now realize that patch 7/11 in the series fixes this, and hence
why this 10/11 patch needs to be part of the series (or the 7/11 and
10/11 patches should be separated from the P2P feature).

Let me re-review the entire series instead of just reviewing the 7/11
patch without the associated context.

Must be Friday.

/jeff

