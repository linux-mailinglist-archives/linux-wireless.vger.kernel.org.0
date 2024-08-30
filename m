Return-Path: <linux-wireless+bounces-12266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C2966636
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E604282B02
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB131B652F;
	Fri, 30 Aug 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A1xgzGDy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA491B4C49
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033366; cv=none; b=Y8TVs1ZjCaSj95Km9KOc+vbO9dScawUKQPtxRVbnjvKxsOxKl2M6YC42ZevKspxlT/fsoVCEt4INhFCNoZGzOxjiSpFvmQOF2TEQQtkeu99Fc/TmL/f5o9KkopKwsLakoZCoEgXRXc+F9pgGmkchmUnkQ7/plrr/2k4rptuzOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033366; c=relaxed/simple;
	bh=FArlvJnz1S3cLNkEThGimZi7dWFj4q69TA29qfOEBe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=He1Ac8wY6t3T0kNfqDCxOR1tg5O2NCXi6H+QmZaMOppzmJNZXvL00m0Pf+W5RkJD3syjspdIORjLtKO/1ch3G18ZpZ4Ph5EArNlzCsgtUqi6+Wux04uiaVv1F62hmMKx4wydQzBw+0FdDx5EuE3hzGJ52GrffWVarUCiJvYjpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A1xgzGDy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UANtrq026847;
	Fri, 30 Aug 2024 15:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sImSkeVueTgwZdggCrB1NZaYobr3QQ/PyuKf/vHJWuo=; b=A1xgzGDyKzgRqmk3
	S8GFAxUoPdW54sk0kHYKDMCVrMTLXwmlVLtjbxoOhOA4DwWBMiiIqrISaOSIOOry
	mRO2lMsx0pNqX5GfpFgxIJ631V7q9c84m/oNFWo15qgGgNvC51pT1Shhgd9PAxiw
	n1ItwtaQrrFw2MRUB0MJiSieiUsjm6RLl4QKno8+dZIYDsBUQm1ZzjTqIbazjLbj
	+nCT9MIp1k/ytfxFbu/gd06AWdgK+q09witawm3GfprgSZjvCXYgXDigZwQgfb6Q
	/cqJHGxZwqbTFyVOb42NfD6u3sNLIkjGbFkR+sqnTaa/qtOxpFe1KZFy94pMtitj
	56eufA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41arax4cgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:55:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47UFtwAI004774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:55:58 GMT
Received: from [10.111.180.95] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 08:55:57 -0700
Message-ID: <8c764643-5af0-4752-acec-9ae23ea33171@quicinc.com>
Date: Fri, 30 Aug 2024 08:55:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current 1/2] Revert "wifi: ath11k: restore country
 code during resume"
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240830073420.5790-1-quic_bqiang@quicinc.com>
 <20240830073420.5790-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240830073420.5790-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sNxIhQCohVUxG9y8jPnBj7A9YGX6r4Xk
X-Proofpoint-GUID: sNxIhQCohVUxG9y8jPnBj7A9YGX6r4Xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=902 malwarescore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300122

On 8/30/2024 12:34 AM, Baochen Qiang wrote:
> This reverts commit 7f0343b7b8710436c1e6355c71782d32ada47e0c.
> 
> We are going to revert commit 166a490f59ac ("wifi: ath11k: support hibernation"), on
> which this commit depends. With that commit reverted, this one is not needed any
> more, so revert this commit first.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



