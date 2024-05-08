Return-Path: <linux-wireless+bounces-7344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE8E8C0246
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 18:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2AD1F244E0
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364AC65C;
	Wed,  8 May 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dcwqOH04"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2A79E1
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187104; cv=none; b=Oc6R9ZZNVPI13fX1oYa+Cu77WIZcNquuNBs5Y/Yir4jArbztvVmNF9HGGwBWH9vnpf5A9O8RcF3E7ZqjPqOIjNDZMB4BQBx0266gB9A/ckyYoZLik9stonJQQs+vvTu5094nONCXg2fhApQuaavQMAlwGZr/G8rSMFZEqKqjtFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187104; c=relaxed/simple;
	bh=mMK8yO7Vbp28PE+0J3OPC8tCDVG8IGp+T8N0714nnzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gZpEqsCXeF1RI0Rv5jgJ2Uh1WC36EnHD91bHdgMy92SVBMGCxf5hDLbPjhRIuiXJxKnygVwJ+304bP05xsLuWiNtJb+vYqPtS9bfsxiHiQgfH2b1YVq+2iAWGl9cTkhkYeJiK05JfbVOBRE6MnCHSMy1CXXUQBtQp/QzFN7pgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dcwqOH04; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448AeMZY006086;
	Wed, 8 May 2024 16:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1R0YHWRIbid3UatuffJOb2wb1+ZWpN0IrHIGT83GgxY=; b=dc
	wqOH04RFfmTt94Lczc01X+qLyxNER9rpuB2zVlKU6BhVXumLcV3vHTGSQUJ2Z1Ca
	rBd37RpUebQgKIwZupw50k4sqEOp+3aFiTFDonRF4BkKBsdsFcr1A9uskykxIz3t
	Q8OqhPqeLFXv9QwodwwuX7RuBKexxYVYKFS1AAC4la7FeXsUCKhw1/r8fibnNBr6
	HAx8ayeBFGQ4t7qzXtcvszVxoAtJ+uPCQPeOkbIcQO6XDqpVvAXaDFbj1ioBrAWH
	fVVPuIjqnQag32lFdMv1KjFTH2Zm16Sdv6iMGqslzxJLSlDRbr9wuyBoTOXXU6Cf
	p6wFkUFl3j93+pJyqzoA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y07u8rv7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 16:51:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448GpYOm005717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 16:51:34 GMT
Received: from [10.110.84.74] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 May 2024
 09:51:33 -0700
Message-ID: <1abbdd0c-d4cf-4e24-9b68-d732b07300ff@quicinc.com>
Date: Wed, 8 May 2024 09:51:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] wifi: ath12k: flush all packets before suspend
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, <quic_bqiang@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <7a96ca11-80b5-4751-8cfc-fa637f3aa63a@moroto.mountain>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <7a96ca11-80b5-4751-8cfc-fa637f3aa63a@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 39TB-UrMienNoIhDKQmKZG7RBB_KERC5
X-Proofpoint-ORIG-GUID: 39TB-UrMienNoIhDKQmKZG7RBB_KERC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=612 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080122

On 5/8/2024 5:29 AM, Dan Carpenter wrote:
> Hello Baochen Qiang,
> 
> Commit 692921ead832 ("wifi: ath12k: flush all packets before
> suspend") from Apr 22, 2024 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/net/wireless/ath/ath12k/core.c:58 ath12k_core_suspend()
> 	warn: sleeping in atomic context

Hi Dan,
I'm not seeing this as part of my standard make W=1 C=1

What do I need to do in order to see this?
build_kernel_data.sh ??



