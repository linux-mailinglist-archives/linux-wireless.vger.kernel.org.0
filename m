Return-Path: <linux-wireless+bounces-5714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59212893C7D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 17:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B681F2199D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1681328684;
	Mon,  1 Apr 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U5S7vXsj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763184501E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983683; cv=none; b=vCH4CyoSbaVUdIQptu+rczu4i7rP3JJvmHz6LoDnSLYoNfhDNOynf0IZ2R7CsxvwTXirAMJZXX3o+p55TggXoLa02+mtL19mRbI84/Z6I9PVX3xrlZs3hrIRvtTlj/78D0N/SlMUBFlCJ3FjplJVhih0TOD0jxRcD1Vf+WoxrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983683; c=relaxed/simple;
	bh=E3aLejlBGW2cnxpvbUyJ/YkxcXUIbVAzhM0lJMLzMTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i18tS2IN/xLn8AMMWtUyyr4K31aqXElsCV05Bw5PsQ8k/vs3afbeKpDLHk8jJgs1xfLNd26ij7g7gRkqH3Y2+T18LYFNckn3BA6+2+XGF3wsnU/mDkVdE1S+AEFWVggXhdLVjinTysVwlEe+HSjMU/0MflI9k97rCVCd5BCssjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U5S7vXsj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431BqAjU001371;
	Mon, 1 Apr 2024 15:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=In5MwfNtTQDXWJRPI/WPKRi9Brgt2M4D6lm0z3L3HsM=; b=U5
	S7vXsjii3JsSbJPquULjLlKoWCjjMNcqIHULziJGzYMgSbserdcwI/yhqprHuAn7
	JuyRkS5rTY8yBOXQ5yidKrs6AbWRB2lyMg5EPzxXX4fYPkCmulYGOg62J31HBIEQ
	eGY0xYxaG3fLc1OJwdViDWZyjDrWeDCLpz1JECuUeJiRIKtnShNylM7J7SCZwZ+T
	cKG9WzdWkCWfBfinIhW8hvk5Fk8U3aU4YCv0mAQwXPR/udQsvGV3bGSStqNV7nho
	5R1QxSCjZGZH4dgM4jKzcMe7psqdUKByI8Yvp+tWkfGkLsprizpxBJQGvMu0aIAU
	U/wyQKYOpse8+37IYJHQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7qcvh1kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 15:01:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431F1HOx025475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 15:01:17 GMT
Received: from [10.110.126.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 08:01:17 -0700
Message-ID: <59c05ce0-14ab-48f6-9ed2-f10d3f548a85@quicinc.com>
Date: Mon, 1 Apr 2024 08:01:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: match WMI BSS chan info structure with
 firmware definition
Content-Language: en-US
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20240331183232.2158756-1-quic_kathirve@quicinc.com>
 <20240331183232.2158756-3-quic_kathirve@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240331183232.2158756-3-quic_kathirve@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jTQgPx7giUW4JZTRUhDIFCLgOCbt8eol
X-Proofpoint-GUID: jTQgPx7giUW4JZTRUhDIFCLgOCbt8eol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=775 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404010106

On 3/31/2024 11:32 AM, Karthikeyan Kathirvel wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> struct wmi_pdev_bss_chan_info_event is not similar to the firmware
> struct definition, this will cause some random failures.
> 
> Fix by matching the struct wmi_pdev_bss_chan_info_event with the
> firmware structure definition.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> 

remove this blank line

> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>


