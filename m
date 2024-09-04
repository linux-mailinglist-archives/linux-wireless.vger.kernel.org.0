Return-Path: <linux-wireless+bounces-12501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3195B96C564
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 19:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937E4B25A8C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCFC1CF7AE;
	Wed,  4 Sep 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZPSkJ05f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B61E0B71
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470748; cv=none; b=LnrIXKX/wH84SP2NWUJD0FnKBYwCPR0WHXOgkTXlX/vpCeFK7foGQd5oFyVJDK86i2+yxHG/wy9oOtbSC+pGv15lkEYPCdGdqgUNfRueYDA9eFnOlNhT9Sgfujr4F3Djm1yaNO7k+LHhxCj3OBUy87A457r3NNHvigFvD2mFzpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470748; c=relaxed/simple;
	bh=k57oRq5+R4R6M8b3P3/LtDhls7RWI+McAOmY7ACxhIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y+a2BDcBWJ02zYEv8Irhqsnj2MO6NS+/hJdrWsd+H0u5LTYkGohA7RLLm+yYsX31iWSAwhIaSExZsF251Dj4AJiCJ4+WgzWUSxLMBjWaz2mnew2sk1p/5B/RaCJuNqrutdKHuZyHi/XUs91takTe4FVEBbGOsSRjZL+9xQm3jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZPSkJ05f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484GrcNG009456;
	Wed, 4 Sep 2024 17:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Bj2HbcZXap5syD9Q36/e0lxxNvZ5e1PnmHqzPrYGwI=; b=ZPSkJ05fHozzavvv
	TxcEsTJBSSEZXP+WxxRT5LatpZb/VU3tJq1bmdoUxLUYNe4OIggqqDPRwh0K1J//
	IULFDEH2pcPO0B2n2nAketqCRIobUGSP91c1bosmt6W9XSa03DlGmO0U3MTuYua9
	Qfg+PnKgSGRoMNwmkxCv50xchvA5h8uEQHqDSkhaoN1tOTB76ytNashV+/p2QAMB
	UXeXdcKnLul6qWaC9L1VFYxcQBBHsBH78b7YEBSswW3c+nFH/V7rjD6OAVWglzk0
	s58ES6K5qtHKjWoRqTdmwCoWVFF/qhlQnPvaB2mnW+KWREMxSFjfKRywnXlegMqG
	qcM9LA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41e0bhmtkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:25:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HPeZW024045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:25:40 GMT
Received: from [10.111.180.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 10:25:39 -0700
Message-ID: <6a0571bc-2c7c-4c5c-bc69-c5d9b648c3f8@quicinc.com>
Date: Wed, 4 Sep 2024 10:25:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: fix the stack frame size warning in
 ath10k_hw_scan
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240830015649.1083758-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240830015649.1083758-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bUSoHtXbvdz-T-gaBUGYT77PTKk2Voca
X-Proofpoint-GUID: bUSoHtXbvdz-T-gaBUGYT77PTKk2Voca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=660
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040133

On 8/29/2024 6:56 PM, Miaoqing Pan wrote:
> Fix the following W=1 kernel build warning:
> 
> drivers/net/wireless/ath/ath10k/mac.c: In function ‘ath10k_hw_scan’:
> drivers/net/wireless/ath/ath10k/mac.c:6468:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Compile tested only.
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


