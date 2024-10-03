Return-Path: <linux-wireless+bounces-13476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060EF98F1F3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 16:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C7A1C208D3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DB919F422;
	Thu,  3 Oct 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GyNnxFv2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FF19F428
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967486; cv=none; b=lm14m95ksHT6DO9mn/4/UvS0Flj4oaPnDRbJ8vmciOl8K3YHc5okuTiixB+2otBZNqsW/jChrUhcuxFyS4TK7yRrGvXOkdxTUjGQRYoRFH6d+1CdPfRtJ443RLpsn+qnTwXNnh2bAtDoSx5DcAGBfiWxB0rFXM+Xx7tYp3x6nH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967486; c=relaxed/simple;
	bh=JPPWG/4+QMRNjoVuNFYWUm2sSMnou04d4bPziVwrhV8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=DOVjDNst+tGxvlM7AOMPzGvv8DF3J3wxqNRZqns6N6DSNq/camsw52W7WB5yl8f//MK/LyeFOIAicuLXnk5gA+2pBdC7oUmXlKDo/i6h2ioFStBReJQ1JBFj7OwOpqR5+5CfWpq0edoe1yZ0vKkZqLaknyMqLPOhGuEnp0ivBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GyNnxFv2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4939P1IG026154;
	Thu, 3 Oct 2024 14:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Sfs91aRY7YF9hae0J7b41CutS2jWrxTYVg/PaxEf2Y=; b=GyNnxFv2G3tuFaxw
	Ns5XLU+vsXZ0qZd5Sa0kRNf/QlaQea4IntF4FHpB0xc5uMtY8Lq3WIYg2WE+O4im
	ajA8bkpiSotP9twpzJBj2kqpOtm1nKM6CU+W2mpkOpooV0wqiKordB2JfbGBd84j
	It3OCUKrJFSxVlNxJ6MZSvvy4+1oUiEjqRsvmoYMGbiu6aKeXrttLQCcD0E2rQEE
	UYWkMYdbNg6vqfOBSYb0qGLyhQxoacZaL0igLea+eN466RG1Q5t8yqTTAQckk6kS
	uJlyy6kKR9w2EhRm2VHttVdBQEJcQjBGvw6hQfqEKCvY/L56VzTo8RPSv3aMzaVn
	s0gjjQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x9vuepg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 14:56:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 493EuoNS008804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Oct 2024 14:56:50 GMT
Received: from [10.111.183.136] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 3 Oct 2024
 07:56:50 -0700
Message-ID: <1f1e74a7-3ab6-4a92-84a1-ee157b7cd11f@quicinc.com>
Date: Thu, 3 Oct 2024 07:56:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Modify print_array_to_buf() to support
 arrays with 1-based semantics
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240730035154.3723773-1-quic_rdevanat@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240730035154.3723773-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nLVq6cjk-qUfyimIBOrSjqZQV9bx8VKK
X-Proofpoint-ORIG-GUID: nLVq6cjk-qUfyimIBOrSjqZQV9bx8VKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=693
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410030108

On 7/29/2024 8:51 PM, Roopni Devanathan wrote:
> The API print_array_to_buf() currently supports printing
> arrays with 0 indexing. In some cases, a few arrays need
> to be printed with 1-based indexing, i.e., array should be
> printed, starting with 1.
> 
> Add a new version of print_array_to_buf(), named
> print_array_to_buf_v2(), which implements the functionality
> of print_array_to_buf(), but with an extra variable,
> pointing to the index starting with which the array should
> be printed. Modify print_array_to_buf() to call
> print_array_to_buf_v2() with 0 as the starting index.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

I'm in the process of pulling in this change and the dependent debugfs
patches, but was never quite happy with the naming of the new function.
Discussed with Kalle and suggest the new function be called something like
print_array_to_buf_index() so that the new name has some semantic guidance to
how it is different.

Can you update this patch and the dependent ones to use this name?

/jeff


