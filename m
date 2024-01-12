Return-Path: <linux-wireless+bounces-1833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7E82C47F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715191F2241C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D6C17540;
	Fri, 12 Jan 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V8d9toMT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D689175B7
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CErH61028983;
	Fri, 12 Jan 2024 17:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Kj/P46g/Y722jDI1PuMdLLSPvApVCPppAKKwfeBp3Ck=; b=V8
	d9toMTpUBmvt+vHYnTbwhxvZgiEOJhvHfNOTTviLM1z2StMv+PEpt93B7UJFlgG1
	p/UmSlDyPdBRcPT+wDrsvAiJ4G6AUr2SQ4RG/58rdj3oJVHFniVnQTTGlvuJg9Rx
	7+jE0gX6vP7Z3B/aXtgg2X5QE2oFYY46PybCKZ+e4HqUFZi1gWUPqKuq58zxkoku
	BXY/IMmow6CGSIbhia/ZlTn6fHPPCFQ3Hj1lKLNr+GpTpSQh97AKNnBSWIHtOW9F
	moRYkcTm1UjNug52wSH0FHFFt5f+uS6DoKgAi+U10lMZE+IEGgdXQ5s2oMBc5JzY
	7mexv8HHq2kCUNaUKllQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk18d1bwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:13:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CHDUQT022759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:13:31 GMT
Received: from [10.110.16.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 09:13:30 -0800
Message-ID: <2df85bd1-c171-4e94-ba3d-6840774105c3@quicinc.com>
Date: Fri, 12 Jan 2024 09:13:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] wifi: ath12k: scan statemachine changes for single
 wiphy
Content-Language: en-US
To: Sriram R <quic_srirrama@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <20240111045045.28377-6-quic_srirrama@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240111045045.28377-6-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AO9dk-A3YUqd6cCaHL0wwahX2fBsjkVb
X-Proofpoint-ORIG-GUID: AO9dk-A3YUqd6cCaHL0wwahX2fBsjkVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxlogscore=774
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120136

On 1/10/2024 8:50 PM, Sriram R wrote:
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
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



