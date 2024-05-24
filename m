Return-Path: <linux-wireless+bounces-8045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 667498CE838
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA80FB22057
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75581383A0;
	Fri, 24 May 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cq/Gx+/+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1438394
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565559; cv=none; b=D8ts+A7qJMmHik3cFxwBsW8kkf+D12Ie3AvhZBuEmoR5METx/L2qprIVnkbeg/l+6/Mg1Ro00DLbu4RQBFHPRWimoK5GSDWik0hIJ1mOW0AbJbgf7e588yom9WfJpoXrALwFpt1ypH7VSUhAqM1XxJuZuWUrYuqZEbTHbYOF+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565559; c=relaxed/simple;
	bh=CigjIRDuxsY7WwSR2IwD/pQ3+o4ypz83GNjoYeI2pIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y8ekDvEbZWgXRlg7s/146dgP8ReqRrGyqyNIK5jiGm0O1WEj58hMtEnmvNYAibTalhtVD4FOKMmbUJ16JzkukVMh78fxmTEWu/s7zajMyQCdNFJdI8qqmr56FSThn2x2qU3CkkBj5kNqR4coLskj81D2441vHXcDKqFxs8Q2838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cq/Gx+/+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O9bZ6l004810;
	Fri, 24 May 2024 15:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SRZUb0LNGsVkw193dO+orMMhKDRa1njIH0iDD8XFj5E=; b=cq/Gx+/+6MZe3IOG
	t70DOg2O6rJq/z2Nq/OyOVM2UnLp0XvG4RLZmLHG0WWmAtAU2XpgcYSNYax7qDjg
	GivN73Jf1sFe9OeupFMCjjUbi01i8fqaV1kByA/rv7ZnDbMVpRqVvMt51hgbKKyO
	U/VdYA6cQD4lve7SmpnEYu92wR4U8hVqnHTdf9LbEg0+2E9eRWc1KxDGGpZvy8du
	qq5ixClgCxBJning8JBprE488vi6jzfrZVXryIpvof9JtnWlTV8F0QYQHbP8fSgD
	KceryerA2ecUyT1Tlxjo3c6uzFKTjGYXI8kTo3Bie5qfsGG6iyjlz1bEMrnIPjV6
	vvgd9Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa96jwjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 15:45:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OFjonf026573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 15:45:50 GMT
Received: from [10.110.127.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 08:45:49 -0700
Message-ID: <1501fbb9-7be3-4b6f-8d9a-177805d91e9d@quicinc.com>
Date: Fri, 24 May 2024 08:45:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix wrong definition of CE ring's base
 address
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240524021558.34452-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240524021558.34452-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oEqEnN1qnUZHM2nLX6hpz6bJJNxnd5Np
X-Proofpoint-ORIG-GUID: oEqEnN1qnUZHM2nLX6hpz6bJJNxnd5Np
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=729 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405240110

On 5/23/2024 7:15 PM, Baochen Qiang wrote:
> Base address of CE ring is defined as u32, currently this works
> because coherent DMA mask configured as 32 bit:
> 
> 	#define ATH11K_PCI_COHERENT_DMA_MASK	32
> 
> However this mask could be changed once firmware bugs are fixed
> to fully support 36 bit DMA addressing. So to protect against any
> future changes to the DMA mask, change the type of the fields that
> are dependent upon it.
> 
> This is found during code review. Compile tested only.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


