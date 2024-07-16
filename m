Return-Path: <linux-wireless+bounces-10275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D8933300
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 22:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8161F23B78
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274E2335A7;
	Tue, 16 Jul 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jIKpYGV7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC73B784
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162330; cv=none; b=IIkvg0bYnCX00iFKVH2gKu3wuiXfs2B27pgSmpo11UNgWbrQmZhxJTWLV9pkgdkpqod7oPz8aYyoOzXSPsayzHNtaSQMTYQ09/5/gJn3bSu1uzOpcT0wR8nsVdKzf0QNEJNHYfEK5w2iDQru6OVSqnXrr6iE4/sdvekd9mmq8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162330; c=relaxed/simple;
	bh=5VGOEEuIcy4k3qNo2e4Y4b9wZV5fPL6HtEYxyiAbcbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dLgPole46x0wGWP2/Fletf+SInFFezP5tppVZZjspAtrjO6fOlM9YTZvEswA9YwVnfCmQavXlBFKJ3WfYRiDu+4HQlN6sThf3dtdYOErIiopI0Pqbb1JbiyyEs1HR+JlqzffSvjIIFiQmgj6DYGGPqIrSVVwHSm1z276lf8xCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jIKpYGV7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHk7uN030146;
	Tue, 16 Jul 2024 20:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jbPXHDSBzQ9vy53sLpp2ZUBKo1geBIqfFO4l3jZ/DCw=; b=jIKpYGV7O3YzaeUY
	bA0FSD+dmO9MEljnbBYq6nS1F+bTS6B44U14ksDoMJZ8ff5sc2k6sXEo79zG9tc1
	5MpSx6zrhMZ51vM1KuvAIjwKzOb1+ND0BqMy+o0Ni5Vx87fdnWuewuAArOPN1Uk7
	LckKe4bSpbSqoKRBQsLjgxyxefO4U6R0rRNhFaYmOxGfWrHqjfN5Kbyst/EZraUy
	gsBk6CGLr5QCC3VKfSTHfRMUZms6OTx9Q91zDG0+f2xjdik9+dUCE6zwJTHJ5sNJ
	9bzx2dcMMfbDstIFZtcFQrdsjDPl9kRw46+oa4QHsPZ1GDFKlgSMY8x0xk50K4M7
	APLHfQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwj1gaw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 20:38:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46GKciEX007319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 20:38:44 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 13:38:43 -0700
Message-ID: <ff16ff3b-3600-4a76-8df8-1e265467d740@quicinc.com>
Date: Tue, 16 Jul 2024 13:38:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240711165511.3100433-1-quic_ramess@quicinc.com>
 <20240711165511.3100433-2-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240711165511.3100433-2-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hgNrM9WVGZ1Hw73JLjuqc78MK-KOS5ir
X-Proofpoint-ORIG-GUID: hgNrM9WVGZ1Hw73JLjuqc78MK-KOS5ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407160150

On 7/11/2024 9:55 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> To prepare the driver for MLO support, split the driver vif
> data structure to scale for multiple links. This requires changing
> the use of arvif to per link and not per hw which can now
> comprise of multiple links.
> Also since most configurations from mac80211 are done per link, do refactoring
> of the driver functions to apply these configurations at link level.
> 
> Split ath12k_vif which is the driver private of ieee80211_vif to store
> link specific information as ath12k_link_vif. For default use cases
> the ath12k vif will have a preallocated link vif called deflink which will
> be used by non ML and the first link vif of ML vif.
> 
> With MLO Support to be added, remaining link vifs will be allocated during
> channel assignment where vdev create/start happens. These link vifs will be
> freed during interface down.
> 
>        		Current ath12k_vif(arvif) structure
> 
>              +---------------+      +---------------+     +---------------+
>              | ieee80211_vif |      | ieee80211_vif |     | ieee80211_vif |
>              | private data  |      | private data  |     | private data  |
>              |               |      |               |     |               |
>              |  ath12k_vif   |      |  ath12k_vif   |     |  ath12k_vif   |
>              |  (arvif)      |      |  (arvif)      |     |  (arvif)      |
>              |               |      |               |     |               |
>              |  +----------+ |      |  +----------+ |     |  +----------+ |
>              |  |*ar (2GHz)| |      |  |*ar (5GHz)| |     |  |*ar (2GHz)| |
>              |  +----------+ |      |  +----------+ |     |  +----------+ |
>              |               |      |               |     |               |
>              +---------------+      +---------------+     +---------------+
> 
>        	Proposed ath12k_vif(ahvif) containing ath12k_link_vif(s) (arvif)
>        	(deflink is preallocated member which is always the first link if
>        	 ieee80211_vif is MLD and is the only link otherwise)
> 
>        			+---------------------------------+
>        			|     ieee80211_vif               |
>        			|     private data                |
>        			|                                 |
>        			|   ath12k_vif(ahvif)             |
>        			|                                 |
>        			| +-------------------------------+
>        			| |ath12k_link_vif deflink (arvif)|
>        			| |        +---------------+      |
>        			| |        | *ar(2GHz)     |      |
>        			| +-------------------------------+
>        			| +-------------------------------+
>        			| |  ath12k_link_vif *link (arvif)|
>        			| |        +---------------+      |
>        			| |        | *ar(5GHz)     |      |
>        			| +-------------------------------+
>        			| +-------------------------------+
>        			| |  ath12k_link_vif *link (arvif)|
>        			| |        +---------------+      |
>        			| |        | *ar(6GHz)     |      |
>        			| +-------------------------------+
>        			|                                 |
>        			+---------------------------------+
> 
> To refactor existing ath12k_vif to make use of link vifs, following
> changes are made,
> 
>  1. ath12k_vif now called by variable name ahvif stores multiple
>  arvifs(ah12k_link_vif) and also has a back pointer to ieee80211_vif.
> 
>  2. In this patch set, only deflink is used to be on par with the
>  existing code. When MLO support is added the link id will be used to
>  fetch the arvif.
> 
>  3. For mac80211 ops which doesn't use specific link_id, the config or info
>  is common for the vif, hence apply the config to all link vifs.
>  The links_map in the ahvif, will be used to identify all the link vifs that
>  are setup.
> 
>  4. Change ath12k_vif_to_arvif() as ath12k_vif_to_ahvif() to fetch the
>  hw level vif. The link vif can be fetched from ahvif->link[], or the
>  deflink can be accessed via ahvif->deflink. API to access link
>  vif(arvif) by passing link_id can be introduced with MLO Support.
> 
>  5. The ieee80211_vif can be accessed from ahvif using ath12k_ahvif_to_vif()
> 
> Locking:
>  Currently modifications to members of arvif and arsta are protected by ar->conf_mutex
>  and it stays as such.
>  Now with these hw level structure (ahvif) being introduced, any modifications
>  to its members and link objects (i.e., arvifs[] which are dynamically allocated)
>  needs to be protected for writing and ah->conf_mutex is used for the same.
>  Also, atomic contexts(say WMI events and certain mac_ops) that we currently have in driver
>  will not(shouldn't be allowed) do any modifications but can read them and
>  rcu_read_lock() is used for the same.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


