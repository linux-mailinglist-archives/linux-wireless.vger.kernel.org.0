Return-Path: <linux-wireless+bounces-6891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A78B2CEE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 00:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F90B1C21F61
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216D155A2A;
	Thu, 25 Apr 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YmSqcf0S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545B2135A
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083374; cv=none; b=VtHVt+g1PqjuvdV6e+k2TBup/jvW2drZkKlvsxseZHnDv5W41rE8swkPTWUh/S5Xx6gnwMOXb8jhzUJOmMrWFsIp726fZXp0KzrFTVivUxMNj7mN8pHnBf+qzTOvQr0/PQJzL4q1p0vOQgSv6QXK4O7GNzkJaRu5wVqsP143keo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083374; c=relaxed/simple;
	bh=pjLe820yF7UYZ4wRGd+xEJv3ao7VtZmG1fEfjOHHd7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XqXeN1lbs8d6EVhcXo9CVdptObSUE1acuHs1H19aGYS+96Kz76ZHY1TWMDq2VXnzPi9HJcG7W8UIS7KXYj98pzDiNTUiht0fONDtRyo/xC4eNOAqiAQcHBrAQ7NMaGgbKrIRBdhWPcxg9Ho3fBtn3kNuJgYnT6o0bSgeUYacOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YmSqcf0S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PKBa38025657;
	Thu, 25 Apr 2024 22:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Sn/H0hKXM7RhdXSnVLh3pgy7twh6PKdlOaetTj+y4rQ=; b=Ym
	Sqcf0ScfYyJjSM09dkSiIIMENO36QkPSWdJnqYjv+25dh3YRRRo+EN8EbcQO9NzK
	fJgAjXp9zetoK0TalZ40C4HCFY9E2v2zIs/Aots6sK1BHmuB6OWVDDTvrPwlwh8p
	wFkPm7ISEj7x9KzN0BRxtHttnZL3ConGsPmCC51gZ27pvk1xTfmxidM7YeU22oLe
	Qh4zDjggL9fdMUVQbeKbYNyhCIsejg/t+hq7bPFewU/la3kTrVYm+6RAhXvqjUH7
	OBpHt4v/442mMerliFnlEJM0cT5zmds/ob7cyBURE5yeFafS+n1rSvoq1dVPImkD
	gzVYEevcR/BlKueo/q8g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqx0386k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:16:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PMG7pY026490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:16:07 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 15:16:06 -0700
Message-ID: <22a96de1-1235-430b-bdd1-ca38afa2408c@quicinc.com>
Date: Thu, 25 Apr 2024 15:16:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix the problem that down grade phy mode
 operation
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240425083837.5340-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425083837.5340-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hu6ZzxkFJYQEMlfjPjumYp297SpqOiZO
X-Proofpoint-ORIG-GUID: Hu6ZzxkFJYQEMlfjPjumYp297SpqOiZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250163

On 4/25/2024 1:38 AM, Lingbo Kong wrote:
> Currently, when using WCN7850 or QCN9274 as AP, ath12k always performs down
> grade phy mode operation regardless of whether the firmware supports EHT
> capability or not and then vdev will start in HE mode. When stations that
> support EHT capability try to connect to the AP, the AP will set phy mode
> to EHT after receiving the association request packet, and then send
> WMI_PEER_ASSOC_CMDID command to firmware, AP’s firmware will crash.
> 
> This is because when the ath12k_mac_copy_sband_iftype_data() function
> handles EHT capability, it does not copy the EHT capability into the
> iftype[band][type] array according to the interface type. So, interface
> type should not be used as an index to get eht_cap in
> ath12k_mac_check_down_grade_phy_mode() function.
> 
> To address this issue, use types_mask to select the eht_cap in
> ath12k_mac_check_down_grade_phy_mode() function.
> 
> This patch affects QCN9274 and WCN7850 because they have the same issue.
> 
> Hostapd log:
> wlo1: STA 02:03:7f:37:12:34 IEEE 802.11: Could not set STA to kernel driver
> 
> Kernel log:
> [270894.816076] ath12k_pci 0000:03:00.0: failed to send WMI_PEER_SET_PARAM cmd
> [270894.816111] ath12k_pci 0000:03:00.0: failed to setup peer SMPS for vdev 0: -108
> [270894.816122] ath12k_pci 0000:03:00.0: Failed to associate station: 02:03:7f:37:12:34
> [270894.843389] ieee80211 phy5: Hardware restart was requested
> [270894.843517] ath12k_pci 0000:03:00.0: failed to lookup peer 02:03:7f:37:12:34 on vdev 0
> [270894.843616] ath12k_pci 0000:03:00.0: failed to send WMI_PEER_DELETE cmd
> [270894.843650] ath12k_pci 0000:03:00.0: failed to delete peer vdev_id 0 addr 02:03:7f:37:12:34 ret -108
> [270894.843663] ath12k_pci 0000:03:00.0: Failed to delete peer: 02:03:7f:37:12:34 for VDEV: 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



