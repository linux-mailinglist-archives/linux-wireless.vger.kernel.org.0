Return-Path: <linux-wireless+bounces-6745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE188AF805
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 22:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0361C228F6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84F53361;
	Tue, 23 Apr 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OGpmElmt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D246142E85
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904241; cv=none; b=jPrN1jmRcUcA+ktEOlVWo6nF5AmRUE/RTlGrTpNC7osinuueb84dBOUsl2FIwJABcmGA9v7NEvr2Hior7QLfUbpmAFSyIBePQhigJrqyiRfmr8UMX7Tu9+1mzaXl1JpGmu+ZPkanjBqB3n0arlGA9v86wWNaQy04GVpFdRLiYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904241; c=relaxed/simple;
	bh=59ZI0bNuTl9UW685B1AAVlWeovB4spKknT6C3SdHLCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EPohgOAguNGMvmSb1tFDfl/0ZSd2LaQ7wi/122BD1qsKqpHkajZ7AIPa8tKTqAOLmtWOaZZCD7fuENoM/hBDhXJJrBXejxRodghFnazE+lglk6FUn7IfZLuT+Rwp1goDg1TSvxbsCmh5TsY2UH3+Dfnxk8RdeZolPsc8odlYECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OGpmElmt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NIHJDn025337;
	Tue, 23 Apr 2024 20:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Utd6z/wdEm13KY/Z1v5E6ghRL/QJ/Xz5ibHjid2fvGc=; b=OG
	pmElmtu+PgZJlPZU3O3GOdVQ85jogSaJGPedpM+ztMg/TubqoDoleiFtW72yZ5wn
	/Z6J1l6OkkpsD5ESzEpLLY3Sz8RQWps1HbyNUCc0nvkiEr3lk+7pcc8RJSvFHOmO
	9OSJodySzo0B1EYkY2j1CKjJFzKZKRZiHxIVQjYoiHz8Q/YpaxW27GKRxDRR9PCp
	qgkyj1pbKk8RX4mfPI5M7qFdLIvvTWRHHxtiNo0eJnkpZ4kfrw1cGvqsh15+VET2
	sovj5zB/oG19BqluxPmfUn39JkpKqB8KCNYxGAsTd3bTxNes/f5FGIZDe5UQYAbu
	dpe1mmdkU4z4BrIMooVw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnvtnbm0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 20:30:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NKUZ68010457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 20:30:35 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 13:30:34 -0700
Message-ID: <ae05d969-399a-47ce-99cc-40a9f77cff6b@quicinc.com>
Date: Tue, 23 Apr 2024 13:30:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: prepare sta data structure for MLO
 handling
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240422125630.1469456-1-quic_ramess@quicinc.com>
 <20240422125630.1469456-4-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240422125630.1469456-4-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a71YYsO1Qor-6oOD4Fdt0NibpZnayt6T
X-Proofpoint-ORIG-GUID: a71YYsO1Qor-6oOD4Fdt0NibpZnayt6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230049

On 4/22/2024 5:56 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> To prepare the driver for MLO support, split the driver sta
> data structure to scale for multiple links. This requires changing
> the use of arsta to per link and not per hw which can now
> comprise of multiple links.
> Also since most configurations from mac80211 are done per link,
> do refactoring of the driver functions to apply these configurations
> at link level.
> 
> Split ath12k_sta which is the driver private of ieee80211_sta to store
> link specific information as ath12k_link_sta. For default use cases
> the ath12k_sta will have a preallocated link sta called deflink which will
> be used by non ML STAs and the first link sta of ML STA.
> 
> With MLO Support to be added, remaining link stas will allocated during
> state change where new STA is added. These link stas will be freed when
> STA is deleted.
> 
> 		Current ath12k_sta(arsta) structure
> 
> 	 +-----------------+       +----------------+
> 	 |                 |       |                |
> 	 |   ieee80211_sta |       |  ieee80211_sta |
> 	 |   private data  |       |  private data  |
> 	 |                 |       |                |
> 	 |   ath12k_sta    |       |  ath12k_sta    |
> 	 |   (arsta)       |       |   (arsta)      |
> 	 |+---------------+|       | +-------------+|
> 	 || *arvif (link  ||       | |*arvif (link ||
> 	 || vif of an ar  ||       | | vif of an ar||
> 	 || say 5GHz)     ||       | | say 6GHz)   ||
> 	 |+---------------+|       | +-------------+|
> 	 +-----------------+       +----------------+
> 
> 	Proposed ath12k_sta(ahsta) containing ath12k_link_sta(s) (arsta)
> 	(deflink is preallocated member which is always the first link if
> 	 ieee80211_sta is ML STA and is the only link sta otherwise)
> 
> 		+---------------------------------------+
> 		|         ieee80211_sta                 |
> 		|         private data                  |
> 		|                                       |
> 		|         ath12k_sta (ahsta)            |
> 		| +-------------------------------------+
> 		| | ath12k_link_sta deflink (arsta)     |
> 		| |                                     |
> 		| |  *arvif (link vif of ar (5GHz))     |
> 		| +-------------------------------------+
> 		| +-------------------------------------+
> 		| | ath12k_link_sta *link (arsta)       |
> 		| |                                     |
> 		| |   *arvif (link vif of ar (6GHz))    |
> 		| |                                     |
> 		| +-------------------------------------+
> 		|                                       |
> 		+---------------------------------------+
> 
> To refactor existing ath12k_sta to make use of link stas, following
>  changes are made,
> 
>  1. Limit ieee80211_sta argument mac80211 ops unless otherwise really required.
> 
>  2. ath12k_sta now called by variable name arsta stores multiple
>     arstas(ah12k_link_sta) and also has a back pointer to ath12k_sta
> 
>  3. Pass ath12k_link_sta to mac functions that passed ieee80211_sta arg
>     and fetch ath12k_sta(ahsta) and sta(ieee80211_sta) internally.
>     This is done to avoid passing link id in all the functions and performing
>     validation across these functions.
>     Rather the validation and sta to arsta conversion can be done only at the
>     mac80211 ops.
> 
>  4. In this patchset, only ahsta->deflink is used to be on par with the
>     existing code. When MLO support is added the link id will be used to fetch
>     the arsta.
> 
>  5. Change ath12k_sta_to_arsta() to ath12k_vif_to_ahsta() to fetch the
>     ML level sta. The link sta can be fetched from ahsta->link[], or the
>     deflink can be accessed via ahsta->deflink. API to access link
>     sta (arsta) by passing link_id can be introduced with MLO Support.
> 
>  6. The ieee80211_sta can be accessed from ahsta using ath12k_sta_to_sta()
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


