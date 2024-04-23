Return-Path: <linux-wireless+bounces-6743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF748AF803
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 22:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C5428C1A9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1A328B6;
	Tue, 23 Apr 2024 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eAdTFgtT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B920B3E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904238; cv=none; b=TypA6f7Fpi2+p53Oe3FyN4bPl74Ds0Qq8buMEkDEpuilHN3QWrUqNow6GcODXhnRMSZtb68x2IgpMXo07fJM+HBhyspQF3IRrjOTx1gfsXb7ggbszixNOtQkxh16vnU58LkThk167xN1ZgE1M+dtaCwUWjl2NEF0E2i+NoD3sUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904238; c=relaxed/simple;
	bh=pXsM9z4I4WGVdXxlawiCqnVefEvU/SJo9E2K2podCxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o43IccxVE0GzJ5EQ44/8aY/OXYNl4uwV7WlJmsg/WgneNr63O5Y7EdMcXC2ZoT/ve3h37t3AqUc5NB25IZrl8rz+4Ur3r3D65xGtym1NFQH1ttQijzR/rf4RkBc6ZmeXTHIDJxKs3ZE+t27Ny8+4+1Hfe+I3hiji8EhxQQwPkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eAdTFgtT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N7vBJi021592;
	Tue, 23 Apr 2024 20:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KwhishAK9ZJ5e7hj+OdV92ttsecf4A+xBXA8wTaEueo=; b=eA
	dTFgtTmA3EP2mg8LlzPApDF2c6ESl1jx6ErwzjzSim2lij6ngQY50ZFBNcaiOtGK
	JKSjH0InofnJdPrhHNiNNaZr09n5OEmrRKgfQJUeBtLbgMJr71VeHp++OMMmxJus
	gDV/xOawqQvNx04awPmTnAF33qcIq2o5vuqJdjU3Zc8RI0Adrhqfxh9lQrfJmp8c
	khmZOItltg5sm0WvUNLGlC16fulentCH8GK54As3llHLjaxfAQO8rL8xWfH5785U
	oSuPAo0t2GaTBLrfegWDn1/8NUATBaCopN9PhAB2ZblU5fMjywMYqCSlEZe1qbGP
	p65Nd7hoisj9CgkDxoFQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp91rt7j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 20:30:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NKUTpJ032601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 20:30:29 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 13:30:28 -0700
Message-ID: <00028ab8-6cef-4b56-b9ba-766fe2317b9e@quicinc.com>
Date: Tue, 23 Apr 2024 13:30:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240422125630.1469456-1-quic_ramess@quicinc.com>
 <20240422125630.1469456-2-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240422125630.1469456-2-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2GC_i75IJlgywu4EIxf5gV0YCJRQNYJk
X-Proofpoint-ORIG-GUID: 2GC_i75IJlgywu4EIxf5gV0YCJRQNYJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230049

On 4/22/2024 5:56 AM, Rameshkumar Sundaram wrote:
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
>  5. The ieee80211_vif can be accessed from ahvif using ath12k_vif_to_vif()
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


