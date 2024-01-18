Return-Path: <linux-wireless+bounces-2195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2242831D29
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 17:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43BF1C2305E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 16:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34A2942D;
	Thu, 18 Jan 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E5IaCDK/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D92941F
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593826; cv=none; b=P634Ij+86EgQSRlJRanQCIjGZSP/OUaS8lpRuIYs4HXSVedOuOYAazljchHHUr6eKAb2jwH9a+2QyYzeCZHeX5OnZsJlcES3Eu5T4FWUWOKPgMpruppwryOsSRsdacBa7MlelYhiFsZlcmV/D/fEL9G7NBjltqwDB2xdOBorTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593826; c=relaxed/simple;
	bh=Vz2AB98O/kVTf7zYaCybtj+qN1xSwyRZPWENjRT7b9U=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=o3/3DP+FmFJXCpDsS8oMxSw0VUtitwIJQjmTDyN6XfUTeXKT0eMHfyH9PkMsvO+botaxFRx/njGv8dv2T0KmblbHvAieaot8POtYjPyTKrKcfgWXSjANLS+/p8j+bxuCouD9IjMWcD6Til0ISbELQKoT7VfThzAazvO1M0j4ldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E5IaCDK/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IFt9TH029504;
	Thu, 18 Jan 2024 16:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K2xpEeGSfJVjk46W2XfRvf92gdmwu5SggqYR//qJ5yI=; b=E5
	IaCDK/irI8nE3S+WVcBGhl5Liq47Oe3pexFo72IKFidpDhzazSw9RiSSIkmvhGbb
	fxUvQyaM52/z9+S7i9/ZyEtvaOvoA2xrPWWKqGX3nxzHofZ18Aklc7Ec1ti26qwu
	k28IfKZ0cniJf3FutI8T4G+2WVAH2dgogfIqnJIOksQIoMhe0S8skmnWx+4AdPOV
	wp0AXEtF9d8yeSmhGukh+aTytXY9/yyC8HrlMQIoYHKhU7q/4bRSz0Uke6yX6H2F
	jOhgCctPFOcesor9IaPSm/x70bpMKKarJ55SapokWhHy15dTitVRM7HkcD08v7Sr
	Hkq2yWuKDE1TqFK+6dOQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq6ub825q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:03:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IG3cYK016793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:03:38 GMT
Received: from [10.110.99.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 08:03:38 -0800
Message-ID: <1c57b675-1f56-430a-8bf9-4fcc89528bcd@quicinc.com>
Date: Thu, 18 Jan 2024 08:03:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] wifi: ath12k: Introduce the container for mac80211
 hw
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240118010320.3918136-1-quic_periyasa@quicinc.com>
 <20240118010320.3918136-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240118010320.3918136-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nDlGouNXYyLH0NNkRExdCU6QMw1VGURG
X-Proofpoint-GUID: nDlGouNXYyLH0NNkRExdCU6QMw1VGURG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=730
 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180117

On 1/17/2024 5:03 PM, Karthikeyan Periyasamy wrote:
> To support multi link operation, we need to combine all the link/pdev
> under a single wiphy. This avoids the overhead of synchronization
> across multiple hardware instances in both the cfg80211 and mac80211
> layers. Currently, each link/pdev is registered as separate wiphy,
> tightly coupled with link/pdev/radio (ar) structure. To enable single
> wiphy registration within the chip, we decouple the wiphy data entity from
> the link/pdev/radio (ar) structure and move it under the chip (ab)
> structure with a new data container (ath12k_hw) structure. This approach
> improves scalability for future multi link operation support.
> 
> 		mac80211 hw private data structure diagram
> 		------------------------------------------
> 
> 	Now						After
> 
>  +---------------------+                          +---------------------+
>  |mac80211 hw priv data|                          |mac80211 hw priv data|
>  |                     |                          |                     |
>  |                     |                          |                     |
>  |                     |                          |                     |
>  |                     |                          |   ath12k_hw (ah)    |
>  |                     |                          |                     |
>  |                     |  +------------------->   |                     |
>  |    ath12k (ar)      |                          |   +-------------+   |
>  |                     |                          |   |             |   |
>  |                     |                          |   | ath12k (ar) |   |
>  |                     |                          |   |             |   |
>  |                     |                          |   |             |   |
>  |                     |                          |   +-------------+   |
>  |                     |                          |                     |
>  |                     |                          |                     |
>  +---------------------+                          +---------------------+
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


