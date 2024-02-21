Return-Path: <linux-wireless+bounces-3870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB985E442
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCCCB2191D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C136483CA5;
	Wed, 21 Feb 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L9ZHkSVc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE11DA32
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535692; cv=none; b=A0YjMGV7+mw5KuuPKiEGB6KqiRHkKBcvg91d8xmsQV/+d19mDLktfMpvedUuviCJilEFKJI7RDbjg8XG7XirSbSoJFEwmrpEWQYlD5oipTEPKfbHP8fadyXMFRhvtqo94DBeLDGO41PMRJ1C1yUCH/2H7Qv2T6VfIfEOHgszEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535692; c=relaxed/simple;
	bh=AJlFFfY3u8DyuvU3su8ldNsT3RQdQ6QvRpUTI0+BMu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ac9YNCICeK0kft4Vl0ZQHsp552JE6qxq1f1MwinzAw4C1cmUQSdgBDP6XJ46li2ZpFa70QjbmvUtdKM41RJmbGVyVZnrOcT53ufWCWgAyFP5mDH5pT3Cpcxlxh8V68TiKRci5oh2VUerHFq67X5SkhKKjNrHAr0aImgmkk3LheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L9ZHkSVc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LFt2Tj003738;
	Wed, 21 Feb 2024 17:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=l4L37gak8Q3i8cF//A+HSasZokgjhuDXTT2sxETvcuE=; b=L9
	ZHkSVctqgywMBMDs86FbydWsAhjLl41wG7RXDPDZWKMMdVWmdHbMcyuZg3izRPgC
	CioAY/uiD2CZAA8RC1qbOY6fzX5rwQ15KfB04WZtiOw7RS5FI5oglqmXcD2X6tDW
	fiBQR6jjQaZvRsjINISFuw1w3gB+5cLksoFFVaAxF3oCPV4nll8NhVzG7Os4NNfr
	HpNTK4cyX9tc99MSaTZBbaSrJzH4Nxq0MU8k3MLFKA9AjyJa/t0e2J1KeuzD9tGn
	ndJ15ucfK7x1hGywIP7C5YfxYSgfz8jhf0ufFdJhtVu12iZojcaZuWeJMzMNJq7c
	uaHwD/HdiotnglXdeNiw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd22u2m6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:14:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LHEeOq006685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:14:40 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 09:14:39 -0800
Message-ID: <08d975f3-7b5a-49eb-9ae1-070221aec86c@quicinc.com>
Date: Wed, 21 Feb 2024 09:14:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] wifi: ath11k: fix warning on DMA ring capabilities
 event
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
 <20240221024725.10057-5-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240221024725.10057-5-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E9tGocf_UwyNmcJHYZmw3ufgz9M6fWGZ
X-Proofpoint-ORIG-GUID: E9tGocf_UwyNmcJHYZmw3ufgz9M6fWGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 mlxlogscore=476 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402210133

On 2/20/2024 6:47 PM, Baochen Qiang wrote:
> We are seeing below warning in both reset and suspend/resume scenarios:
> 
> [69663.691847] ath11k_pci 0000:02:00.0: Already processed, so ignoring dma ring caps
> 
> This is because ab->num_db_cap is not cleared in
> ath11k_wmi_free_dbring_caps(), so clear it to avoid such
> warnings.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


