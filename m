Return-Path: <linux-wireless+bounces-13428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A567C98DE5C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474DB1F27F01
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046B10E9;
	Wed,  2 Oct 2024 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HeLwqQRf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427F1D0434
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881583; cv=none; b=mfM9gEB7HC258gEXv17YobegPiXlYtmGvrVtZDcKmzEGqjJEpAZQQobaurNSYd2ZhvCbWD+8gFoIbPGc1svFsXTX9G/174Aymhdu9/v/FaYvD+9lRy944iIdFAOfsDVS0NhPRSyjKXLBT7GWIMHZtw3Wv85kREJJE9XNtbw2a/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881583; c=relaxed/simple;
	bh=Lf01oXF1G+xWyHQxUwDrPXpIkuvjTup1Iir20TzNeAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uI827gwKGIXy6k5ys4+Q7WRf8pR59VRgBLd9im4KnrYsa48+tv9ZaN8Gs6mCs0KKtZNyeB29e2Gqd5uvPAHauczJs4RallVJL9I0w6TrBwbLY8kuNHyJ3wWURhQ7FsXhwHk0ykr2hfz01tX7cNDjWHffw+JkdI49scDacq4lI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HeLwqQRf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Df7Q0018290;
	Wed, 2 Oct 2024 15:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ODg6hvjY2FzEQv6uvnSYOVw7rw8sEz+jBGskJf02+d8=; b=HeLwqQRfYNT9TVUa
	aWiPW1Pgj5+eTm97tkEeM8Y6mtX2yDRf2qRPtxAF8s9C4Hl+mxrpSvTc7UbtyYYP
	vf18fCVQYZ8ZRCoEI2ZtbEoqpCe+S8QqpOhJnPloBHdK24sUkFX/+4v0sMhgnb65
	7FmsBsBem1GqWuf8qQiwmBrwTgAxuYolN+Q27wEQQN1WbBhaigtaO7hQrJG4aLnL
	f8nvK0YbBciJlamwoWEyTLzl7lP8hY9wDCF/2g5cTUYt5v7BMSGVc46akAF0/S2G
	/6K333vpw6GLyR8aRKeElCn6MSPHHjMg/PxC4TaTa1Z5LfU95gC7EsI0RLl73ud1
	7+icFw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x8t6uxgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 15:06:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 492F6Et0013852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Oct 2024 15:06:14 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 2 Oct 2024
 08:06:13 -0700
Message-ID: <0b56d060-169f-443d-8c36-b22016ae4258@quicinc.com>
Date: Wed, 2 Oct 2024 08:06:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Support AST Entry Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240930174010.617123-1-quic_rdevanat@quicinc.com>
 <20240930174010.617123-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240930174010.617123-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KHeTWeH4ZPqfQ8xh_zUWTfFKp9fWSqjP
X-Proofpoint-ORIG-GUID: KHeTWeH4ZPqfQ8xh_zUWTfFKp9fWSqjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020110

On 9/30/2024 10:40 AM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request Address Search Table(AST) entries stats
> from firmware through HTT stats type 41. These stats give AST entries
> related information such as software peer id, MAC address, pdev id,
> vdev, id, next hop, etc.
> 
> Sample output:
> -------------
> echo 41 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_AST_ENTRY_TLV:
> ast_index = 10
> mac_addr = 00:00:00:01:00:00
> sw_peer_id = 0
> pdev_id = 3
> vdev_id = 255
> next_hop = 0
> mcast = 0
> monitor_direct = 0
> mesh_sta = 0
> mec = 0
> intra_bss = 0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


