Return-Path: <linux-wireless+bounces-4643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78686879EDB
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3356A2814BA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB22BB1E;
	Tue, 12 Mar 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DDoByb2v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC12B2D7
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282910; cv=none; b=htc9vqZWcIbaEq1X9RkuoEQhPXXxc95UV0v2s1ryr6SHcZpHGgUWjYyd//kVmH9RHwWlzAIHo4yI+cO1G67rSBs0+JEP9OM59FGdvf/ST8jq/8AcPy23xWe2WUtVsv1g7U0ReOZkBBEW0meUBkn4vnv0Y2U4YlC+r6EYOJ4YlWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282910; c=relaxed/simple;
	bh=6kPoGA5fRcPkUoeNjiK8yOVPuslrhHUEVroEKjGMHSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DfX4x65Wqh3QDoGnppPSsVG1+B97mv2WFpOPNy+FENddXC7ty6BQ/Xb1MbI6x1ny5FooCUH5bHZbRumByYwJ4ZS4Xt9JJXHwajDTOf0DzLNRP4hFFOKrAkYGqB772nZg4gykg067i78fn9n4nx5b87x9kfqSb80b+8XhfF/SNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DDoByb2v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CLcuRt012064;
	Tue, 12 Mar 2024 22:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vsyVJruxp+6dWhHIK32pwu/f4gts7QyZJscu6ziDTnI=; b=DD
	oByb2v0m8R/jfI9s6XmZbnIeIGrgAZBVhC9QXmOqg2Gyo7Q5GnKc+pwsgqdEBMZl
	WVWwfsXZw9Ob4hVzA72Lc+duW/xbCLZVf/1UPFCIIWy0VZwK2kEdnxY9epzX/W7a
	MgpZPRtDFGddvymNY8l0NYIauNygRhIvAxFSbZT1KvjPiFxr3THEXLTue6YBWT56
	YHn2xPsjWqyS+8RdngKASujmrxB9AhWJdABD+pbr7nZNGcZA9Hw3BPdbjFQjymnQ
	wB0Bd6Xsq61NklFqaXv8+O4PGaoyQv6Altq6pcTAa8DcgxHA8uTfB8Zb0ZhDlvp1
	DpMetwhRxUjI7ZYOaYyg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtjwut0ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 22:35:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CMZ3pu020905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 22:35:03 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 15:35:03 -0700
Message-ID: <34ffab82-44ec-485d-84a5-d5bd9aec9a85@quicinc.com>
Date: Tue, 12 Mar 2024 15:35:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] wifi: ath12k: scan statemachine changes for
 single wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-6-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240312135557.1778379-6-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lT0LqeB8uZXsE5fUCer7zhQhjnq1INqr
X-Proofpoint-ORIG-GUID: lT0LqeB8uZXsE5fUCer7zhQhjnq1INqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120173

On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> When multiple radios are advertised as a single wiphy which
> supports various bands, a default scan request to mac80211
> from cfg80211 will split the driver request based on band,
> so each request will have channels belonging to the same band.
> With this supported by default, the ath12k driver on receiving
> this request checks for one of the channels in the request and
> selects the corresponding radio(ar) on which the scan is going
> to be performed and creates a vdev on that radio.
> 
> Note that on scan completion this vdev is not deleted. If a new
> scan request is seen on that same vif for a different band the
> vdev will be deleted and created on the new radio supporting the
> request. The vdev delete logic is refactored to have this done
> dynamically.
> 
> The reason for not deleting the vdev on scan stop is to avoid
> repeated delete-create sequence if the scan is on the same band.
> Also, during channel assign, new vdev creation can be optimized
> as well.
> 
> Also if the scan is requested when the vdev is in started state,
> no switching to new radio is allowed and scan on channels only
> within same radio is allowed.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> ---
...
> +	/* If the vif is already assigned to a specific vdev of an ar,
> +	 * check whether its already started, vdev which is started
> +	 * are not allowed to switch to a new radio.
> +	 * If the vdev is not started, but was earlier created on a
> +	 * different ar, delete that vdev and create a new one. We don't
> +	 * delete at the scan stop as an optimization to avoid reduntant

s/reduntant/redundant/

> +	 * delete-create vdev's for the same ar, in case the request is
> +	 * always on the same band for the vif
> +	 */


