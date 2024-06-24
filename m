Return-Path: <linux-wireless+bounces-9513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB02915780
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 22:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887A51C227EB
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 20:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E2199B9;
	Mon, 24 Jun 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gI6k1ka2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480FFBEF
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259263; cv=none; b=iBQKCJ3DO1caq1FA+CQgjfhodmmRWpRCFhcL5V3fGCxMc/1e0ctElAiMcb9+RkUbPQbjQ/eN892DFwyWkeUgJYqmA8W50Fl7iD/xQhg4jYp38PtWEzmPqJ2btubTCEiUwJT/zqEOIB7WKKy58yQN28nJx2kPI9xEulgQ9dM0ixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259263; c=relaxed/simple;
	bh=OHs3Gm1WMOeUkblEr3D6MWltx7g1VneAXWAOn0AD8vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JlOmdmFavU48k2/aF/uJe20y8f3qGXvWjHNq8cxu6dES6jFjRQ459wRf6OffKhYoNgJTp/rqv42tVlPJ4vrV+rJaXdIKYprUV908WTilHqReVj2N/mXcOfN1WldH9pqJZixje2Q2/I7KeCZGBSGKgTUBXGttEEKlc8txPPiFPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gI6k1ka2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OJEacm018148;
	Mon, 24 Jun 2024 20:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IyqqiYuinaN9EB0MoJSw2cwgc/qRU8wbQElz9Dkde+0=; b=gI6k1ka2Cm1hhvY8
	ItaTXhEQYnbtbjQWbZxR5NNVB+wNAnuPxsFRH/obWOELbH5RbUtb2WE5/jiFUhzc
	TPOjTfTqGjeqOznhslmLy2tQSFCeyMyxgJ05wEzb8UGqpt+qMb2w9JcwfM0GpkvW
	yZQfGcz575LiO+43e6r7GGpgq3c4w6mRg2gDSn3kQpFDdVQKC1b9sNn7FXvrVK97
	cmtWDyVslXcq7r+rx6rHSCrySId3dMMRPZZ1uMoajRhMMCq5zd2RFNgr1rtpQOqn
	fCedKq3BnWsFQ1rTkv1NIw3oJVmahzMQCtXyLexDzGUjLzOLddkk3AKdTbwqUrKR
	E9j/AA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6mk4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 20:00:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45OK0t0I008896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 20:00:55 GMT
Received: from [10.48.244.142] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 13:00:54 -0700
Message-ID: <ca3ad77b-3662-4d8e-9721-bc4faa8dc9f1@quicinc.com>
Date: Mon, 24 Jun 2024 13:00:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] wifi: ath12k: Add support to enable
 debugfs_htt_stats
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240624043845.3502520-1-quic_rgnanase@quicinc.com>
 <20240624043845.3502520-2-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240624043845.3502520-2-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: es2wqGNOW7idV710qKSV_E98QWZkGgEF
X-Proofpoint-ORIG-GUID: es2wqGNOW7idV710qKSV_E98QWZkGgEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_16,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=619 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240159

On 6/23/2024 9:38 PM, Ramya Gnanasekar wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Create debugfs_htt_stats file when ath12k debugfs support is enabled.
> Add basic ath12k_debugfs_htt_stats_register and handle htt_stats_type
> file operations.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


