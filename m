Return-Path: <linux-wireless+bounces-9805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D851B91EB6F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 01:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632791F225B4
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7703171652;
	Mon,  1 Jul 2024 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="chYDLrya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9A2F29
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877327; cv=none; b=rzWIDWDYg6r6UICFCVhkX0thpfPJZZcsMtIrqw+rWG9cojsSaAiLtkbsXKPk1NHJE3u9tZd5PjiEMSdaWO4mvZMmVOgrLRHKib3rDJqTDy8L6iYqQPVb6+2A1ILNwo/TV4ih3KuUu06AdcDd3TpeMjAQ8udmjFY+66XfLEvr90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877327; c=relaxed/simple;
	bh=4jTqTnYQiTymE5FzikQSLWtPeZy3TfyzJJGcu3jKw5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YnR8edlUsU+4UJDMXkhHApVd0Eya6bOdkZp/AgIHtv98dLnTRWPZfFe9Qgf2wguw1Nrw/kqQ0Z8CNHEKVwrfeY8LHtzK6dI6AY95JjzkOfHqcQCTnNBQVRQNqy4vOM/wRdc0KveYsggWbig1npMT4rh97BuGoiMM6ld5m6GXAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=chYDLrya; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461LPEgA028596;
	Mon, 1 Jul 2024 23:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gUBhcNEImxlod/dV7kan7xcxdhN5NaGpplFn9g+i3c4=; b=chYDLryaZAhAdaPQ
	XULVO/dC4/edaV0ejj05z4XuRqhcH9dxjyivSTTtzJP43FzVXIfmxcdylYc+Cxye
	/eGags9YqcUbcOc518lNQ1g9zeBb39gcHtnVxTykZb0F617WpgrlNWPZQYqx6rEX
	0bivWPCvqYPXoMzVJVgRniy9ZhWm6ZmAtajzYWVqdeBC3yVHuVg6c86xASOoPtOE
	AfAbHoNHSw1uwoWT6lPWZoHVcFAXIq5pXEAMi4DqHorpMrUot818UdiKjPHLrTGm
	pN01SjbwXRQpSBzujH9QFZrFNZMK3q1lQJzIejUf5i0iDLw8wwyEiF9CZzUvJY7i
	OW3lnA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029kh5m9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:42:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461Ng1Vr004095
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 23:42:01 GMT
Received: from [10.48.245.148] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 16:42:01 -0700
Message-ID: <99f5c1d0-5586-4790-bda1-198cf7682472@quicinc.com>
Date: Mon, 1 Jul 2024 16:42:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240628095139.292952-1-quic_hprem@quicinc.com>
 <20240628095139.292952-7-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240628095139.292952-7-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qqECejiUXVjmA8LjmtcfbmLLDh062pcq
X-Proofpoint-ORIG-GUID: qqECejiUXVjmA8LjmtcfbmLLDh062pcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=778
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010176

On 6/28/2024 2:51 AM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, single device is probed and once firmware is ready, the device
> is registered to mac80211. For multi-link operation, different bands of
> different devices or same device would be part of a single wiphy and for
> this, hardware device group abstraction would be helpful.
> 
> Hardware device group abstraction - when there are multiple devices (with
> single radio or dual radio) that are connected by any means of interface
> for communicating between them, then these devices can be combined
> together as a single group using a group id to form a group abstraction
> and register to mac80211.
> 
> The grouping information of multiple devices would be based on device tree
> during device probe. If no such information is available then a single
> device will be part of group abstraction and registered to mac80211 else
> multiple devices advertised in device tree are combined and then registered
> to mac80211.
> 
> For device group abstraction, a base structure named ath12k_hw_group (ag)
> and the following helpers are introduced:
>         ath12k_core_hw_group_alloc()    : allocate ath12k_hw_group (ag)
>                                           based on group id and number
>                                           of devices that are going to
>                                           be part of this group.
>         ath12k_core_hw_group_free()     : free ag during deinit.
>         ath12k_core_assign_hw_group()   : assign/map the details of group
>                                           to ath12k_base (ab).
>         ath12k_core_unassign_hw_group() : unassign/unmap the details of ag
>                                           in ath12k_base (ab).
>         ath12k_core_hw_group_create()   : create the devices which are part
>                                           of group (ag).
>         ath12k_core_hw_group_destroy()  : cleanup the devices in ag
> 
> These helpers are used during device probe and mapping the group to the
> devices involved.
> 
> Please find the illustration of how multiple devices might be combined
> together in future based on group id.
> 
>                 Grouping of multiple devices (in future)
> 
> +------------------------------------------------------------------------+
> |  +-------------------------------------+       +-------------------+   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
> |  |         (Dual band device)          |       |                   |   |
> |  +-------------------------------------+       +-------------------+   |
> |                 ath12k_hw_group (ag) based on group id                 |
> +------------------------------------------------------------------------+
> 
> In the above representation, two devices are combined into single group
> based on group id.
> 
> Add base code changes where single device would be part of a group with an
> invalid group id forming an group abstraction. Multi device grouping will
> be introduced in future.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



