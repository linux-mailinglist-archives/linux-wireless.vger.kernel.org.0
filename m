Return-Path: <linux-wireless+bounces-6888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F458B2B17
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FD51F227E1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB72773C;
	Thu, 25 Apr 2024 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OOu66NaZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40EC15573A
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081149; cv=none; b=iM72ft2fV0Cd0FVxdcRW0ouZa3PmXSquYTTV4/DWO1n+JSUr33biEeZwQf36k8rOwfBSKpLPHxGUdRhVdEKiEW/yloZCQvLp+ByDr6iWoIh6R06ZmDvySDOGzwCPi5rQQECSQ1J3Y9ncdV6kgGnoSe4gZdry7j31P+PTcGRMTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081149; c=relaxed/simple;
	bh=kh7ibcx8Jto9bTZM2CGr8sJNXFSGIsr75XfdmOfyIMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sqM98+x9WjE7ZtICUv/QzNQYse7eJ1NZ0OAVF8aQGBOp8PPETFBXIsHKXja7bIgYop+L1MUyGaJ/Res//rqQphTYTqouzBByAF0qKHuKzR8N710EGiu2wB/E8GtS9jOJ+R9VDeU6okBZmMlo8/in2hKYI1wyYpt6PCsOHIV8Cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OOu66NaZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PKokCs029808;
	Thu, 25 Apr 2024 21:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qV8nu7BFdbzCjnKCkstWdn6gMp+GYqZJTQATgDRcvbI=; b=OO
	u66NaZC/bdqnDHKk+z91NXoObva1Oitesuc4iRloM1cR/KkK65wJFCz1ckggVXPe
	nMrShiCerTkEC+H2xLlO9PyEMvD0xKxiaDW1113bz5kWw1JP1z31EJW4LYnCFGf/
	kSGb1P3RTnIhEv0rbMAv4n8GlJjRFWWYH55DN+2jP7WGxf4aMiey0vz5F78w6kpg
	gqdg83d1OSbku40AzrzxV8gA5FggkeT8cj4oSs9r/4IKtZuGG1D1iyCO8cFzm1NA
	Vf5NqMJAL+TBA5U4vmxXQMIndK5E5E8ICk5K94rdWBU8pj66J6HA9IME5gayIjBv
	6BiW6t8vukPSYgtKdA0w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenh3rnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:39:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLd4Gf032452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:39:04 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:39:03 -0700
Message-ID: <a5b87ff2-1094-4631-98a7-cc2189e7da00@quicinc.com>
Date: Thu, 25 Apr 2024 14:39:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] wifi: ath12k: refactor core start based on
 hardware group
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
 <20240425055759.1181165-8-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425055759.1181165-8-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HDcLKXmzNk4Jq8bCHEtmVFdGYEj_LNyg
X-Proofpoint-GUID: HDcLKXmzNk4Jq8bCHEtmVFdGYEj_LNyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=798 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250157

On 4/24/2024 10:57 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, mac allocate/register and core_pdev_create are initiated
> immediately when QMI firmware ready event is received for a particular
> device.
> 
> With hardware device group abstraction, QMI firmware ready event can be
> received simultaneously for different devices in the group and so, it
> should not be registered immediately rather it has to be deferred until
> all devices in the group has received QMI firmware ready.
> 
> To handle this, refactor the code of core start to move the following
> apis inside a wrapper ath12k_core_hw_group_start()
>         * ath12k_mac_allocate()
>         * ath12k_core_pdev_create()
>         * ath12k_core_rfkill_config()
>         * ath12k_mac_register()
>         * ath12k_hif_irq_enable()
> 
> similarly, move the corresponding destroy/unregister/disable apis
> inside wrapper ath12k_core_hw_group_stop()
> 
> Add the device flags to indicate pdev created and IRQ enabled which would
> be helpful for device clean up during failure cases.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


