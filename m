Return-Path: <linux-wireless+bounces-7437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10268C1E9E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 09:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965921F228EE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 07:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404B14F9DB;
	Fri, 10 May 2024 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LRd0SCbU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D815217A
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324619; cv=none; b=GI/OBoh/m+NzN5BdNEK81oM4AsDeDVCjEXRnWrPg3fhGPv99MnbKDOdU9UlCCOytXPCPm2ieK0ggp6+dz5ZtaCKIHrplbzCO9S86EnhsRZFUha/dBcvNve4CQgG/hequq00MkG3voaq/3RVwujq1DiAuHblmXHx1/ozS3lBfcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324619; c=relaxed/simple;
	bh=sS7Z+uBcn2WvMfdalHN56CV6i8ELQEN7R4DigxjY100=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=byvBPdey6U3s8dxHk35sMngYJtTL7MDQC9VyAwy7tl5d7IMarqUZ2nTv0mkfq0wcuxXpY9hHYDFfWMErX+hhpVfW5XDR/ToK9PLWgpFGetp+DvwPMJTEqBgWt7plb/YyssqLlg2M4owz3IRPa+TtqYiPAU/YXR7YOQNoHHPhmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LRd0SCbU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tnw0000881;
	Fri, 10 May 2024 07:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sS7Z+uBcn2WvMfdalHN56CV6i8ELQEN7R4DigxjY100=; b=LR
	d0SCbUEuKJbFTlfSko6kIJ8ZNHnQ4JGnpekOmVpFeYd8lvkhx0UgT8u7obyA6Ni6
	IbkG+nQEmRVRk70JrRQKZti9giCXzcvKBaIPXdr4fmniaUmiW8vo3P5tKuRs+Jpf
	L+7rBTI3HYbPyC0m3DA/rHT8stFAc6n/JTAvkbMGWXsVUnUNlRs7thgiHDt60CpV
	Cknd/z0EizDQ7gDtZNDIc65/jUVDWRIvrvJvEt2iAticx/jPlK8lA0vm7dsOGjuB
	2G1xyMYPISshZJLD1Z6KPXwTlqOYULzv4/l47G3O1YxNUUnExBoglNXg7dsTIlrq
	OIhp6CtBlEpuazebRsJA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16yt0tbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 07:03:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A73XF4013313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 07:03:33 GMT
Received: from [10.216.26.103] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 00:03:31 -0700
Message-ID: <7c486b27-fc3b-4f94-74af-bdee3bf905f1@quicinc.com>
Date: Fri, 10 May 2024 12:33:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup
 Failure
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240509161631.3520506-1-quic_nithp@quicinc.com>
 <7153876e-2270-4bca-a47a-d45ca165fa34@quicinc.com>
Content-Language: en-US
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
In-Reply-To: <7153876e-2270-4bca-a47a-d45ca165fa34@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PIv0irB3C5Xmjk_xY3xFIEjHGQy3sTdw
X-Proofpoint-GUID: PIv0irB3C5Xmjk_xY3xFIEjHGQy3sTdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0
 mlxlogscore=710 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100049

On 5/9/2024 11:02 PM, Jeff Johnson wrote:
> you need to version your patches
Sure Jeff. Resending the patch with v2

