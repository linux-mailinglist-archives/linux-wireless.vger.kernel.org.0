Return-Path: <linux-wireless+bounces-2897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C3844601
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 18:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7121C24DDC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F3312C52E;
	Wed, 31 Jan 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pIOYdF/n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502A12BF33
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721786; cv=none; b=Rjw4/bB6RelCM0gehjA3M/djDVH1ybs0QdhiWmudKAyep/xRSjSUrdMD6QO6wCcIW9rwKxHwn2u9oIqyfHq3Cp4q6DfZ0zwItDyOdt3FW48EEKkVVz+m2Y9lVC0c85L8N6lvRFUp7UYN4QB7zf36p3K4ipIUUwvlnJNneL5pp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721786; c=relaxed/simple;
	bh=YAwEyBHcy/Iiq5Ia00MLlPa5GZu7HeQ7rMNRAdgkbEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gMi1Fcss7RTkTOVxuhidAR+e+pC8SuMvWOvwLsxjDZGiDm9SzM0lntH/hneQf3ctyiZyBkV2qdFXED95MXSig8GSKo/9uYW9zZ1crRYA0TbUwiTvU8aMaiIfionAJANC9aVLRhXudO2YzQTL/DWy8KxDfGcrsGIGw/n2aJw+xJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pIOYdF/n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VECmSQ004357;
	Wed, 31 Jan 2024 17:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N+V1XOC7wNWvASBY3Ytq8zfYk5micrfPTMF3VutHgV4=; b=pI
	OYdF/n9v2XxwK/mYFf1csXp8EGBO0LH2GxYfcV05/GsDe/Co0zBwjtBvU3rnVexM
	lTA5/YetrrnlwlN5itoH0RBTKe2puP/bd5oJfLakTWfubwJj985HFj2v6hLLj5YI
	fkKCD0UJw3OV623U3c8jQ500j1bCvAy0DqHsi3gHAW5W+hNzKi03LqqQ8UlQQEUv
	pIHfirxwcnvgPa7hXZAMbNcAPmL4LBD3+CfbjTYFkWq0WpyVl/sCzJIEqOyrQ0Om
	LA36FKdqeIilHczEsLDqx0hLlfS+wwVA6ThEiom4KuXhsc+VM2r17zhH2+VAcXOo
	VND5nnltKauNlMCH7yGw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyfr31r1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:22:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VHMvXd025617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:22:57 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 09:22:57 -0800
Message-ID: <1feaa828-f4ee-4acb-85a3-94769546a10c@quicinc.com>
Date: Wed, 31 Jan 2024 09:22:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE
 before WMI_PEER_ASSOC_CMDID
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240131021832.17298-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240131021832.17298-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 55TkHPW9NvBzumy_lBOKQiV4E1UMK63v
X-Proofpoint-ORIG-GUID: 55TkHPW9NvBzumy_lBOKQiV4E1UMK63v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=922 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401310134

On 1/30/2024 6:18 PM, Baochen Qiang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Currently when connecting to an AP with 11AX-HE phy mode, host sends
> WMI_VDEV_PARAM_SET_HEMU_MODE parameter to firmware after
> WMI_PEER_ASSOC_CMDID command. This results in TXBF not working, because
> firmware calculates TXBF values while handling WMI_PEER_ASSOC_CMDID,
> however at that time WMI_VDEV_PARAM_SET_HEMU_MODE has not been sent yet.
> See below log:
> 
> AP sends "VHT/HE/EHT NDP Announcement" to station, and station sends
> "Action no Ack" of category code HE to AP, the "Nc Index" and
> "Codebook Information" are wrong:
> 
> Issued action:
> IEEE 802.11 Action No Ack, Flags: ........
> IEEE 802.11 wireless LAN
>     Fixed parameters
>         Category code: HE (30)
>         HE Action: HE Compressed Beamforming And CQI (0)
>             Total length: 152
>             HE MIMO Control: 0x0004008018
>                 .... .... .... .... .... .... .... .... .... .000 = Nc Index: 1 Column (0)
>                 .... .... .... .... .... .... .... ..0. .... .... = Codebook Information: 0
> 
> Change to send WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_PEER_ASSOC_CMDID,
> then firmware will calculate the TXBF values with valid parameters
> instead of empty values. TXBF works well and throughput performance is
> improved from 80 Mbps to 130 Mbps with this patch.
> 
> Good action after this patch:
> IEEE 802.11 Action No Ack, Flags: ........
> IEEE 802.11 wireless LAN
>     Fixed parameters
>         Category code: HE (30)
>         HE Action: HE Compressed Beamforming And CQI (0)
>             Total length: 409
>             HE MIMO Control: 0x0004008219
>                 .... .... .... .... .... .... .... .... .... .001 = Nc Index: 2 Columns (1)
>                 .... .... .... .... .... .... .... ..1. .... .... = Codebook Information: 1
> 
> This change applies to all chipsets.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Fixes: 38dfe775d0ab ("wifi: ath11k: push MU-MIMO params from hostapd to hardware")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


