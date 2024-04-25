Return-Path: <linux-wireless+bounces-6860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A018B27B1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 19:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA641F2471A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5C14EC4A;
	Thu, 25 Apr 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SLk/3iHU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED214D717
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067129; cv=none; b=ZBTMB3ql/Nwl+GXFYsJGDSAT06esVtBldfSHmU7Nxo0TOuFRW6XvHqn/fVLmtPQfSMEeaIjYzFo1CZptFTR3YiXOOK/gXuUZY9J5Xs19k8bMdRBJicy5USY+SQSMehmIKff+hI+oOqtF0dtC0cLDl63Qfgk/YWWMarDtfWFUeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067129; c=relaxed/simple;
	bh=bJaSbFf8yQAxne27lJWH9tq5D4hRQKeTx/DvmUyZ0wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t1enrb7WOWmVrn7WUg+aV7csOrQD56N4W1SwlY8eO0YZTwoDkBNKF7WIOfC2OlmbBkyhKlPpAsePjsmwjClm5DXnynej04zT0YUHnYcShVMPptxCczqkzWpFad8JDz0j9YKE3pzw/MN/NmefKtd91MaePpEgZC6Xc0X1TTOZNTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SLk/3iHU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PHSYKo016817;
	Thu, 25 Apr 2024 17:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LcYG4I3SJlYJirkt3h/m2Js27K4Ck+QRy+tSEtKGSo8=; b=SL
	k/3iHUv4FXTJjcxt2cvmW71srZ1P3MMnO9svpJct6DtJ4gDQwd9psgoBMt0/hhTH
	JNSD4T1/aruqNeErkxG4Svhk5iWfOSdi+XVn/qiPSJKuMZV2ZCWWGj1gpkSz2DY2
	rVR4xHaRgPbgNuTjTnvaMHvxza9C08bw6D0d2F/lV/7cB1/ZnFG0exQmcB8fb5ZU
	3rIa2m+VnVA9Hks2OIZ5UipWHFMjY3xhitBuj4Q/Ae0MzV9l3Y3Aq9P1605Vcmia
	2eTMWk6GgFUQvAvzD9r2zCwtA1Gk0scCvCktB7jmWj/OApjwXEwoLpxRe8zpPEC4
	KqZazwgXwMSL4fjxP4rQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqengkbqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:45:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PHjMHW024846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:45:22 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 10:45:22 -0700
Message-ID: <6eda8fe4-bd89-425c-8717-65ab42e073ba@quicinc.com>
Date: Thu, 25 Apr 2024 10:45:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/6] bug fixes and enhancements to 6 GHz band support
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RTi-JLS00vmt2ImIWAUzDs0NO5V7dGwx
X-Proofpoint-ORIG-GUID: RTi-JLS00vmt2ImIWAUzDs0NO5V7dGwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250128

On 4/24/2024 12:11 PM, Pradeep Kumar Chitrapu wrote:
> In 6 GHz band, add support for
> 1. channel 2.
> 2. Fix packet drop issues.
> 3. AMPDU aggregation
> 4. SMPS configuration
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v3:
>  - address review comments for fixing ath12k-check issues.

this should be more specific. at a minimum it should indicate which patches in
the series have been modified

> 
> changes in v2:
>  - Disable smps for WCN7850 after review comment from Boachen
>  - Added Tested-on tag for WCN7850
> 
> Pradeep Kumar Chitrapu (6):
>   wifi: ath12k: add channel 2 into 6 GHz channel list
>   wifi: ath12k: Correct 6 GHz frequency value in rx status
>   wifi: ath12k: fix survey dump collection in 6 GHz
>   wifi: ath12k: add 6 GHz params in peer assoc command
>   wifi: ath12k: refactor smps configuration
>   wifi: ath12k: support SMPS configuration for 6 GHz
> 
>  drivers/net/wireless/ath/ath12k/core.h  |   2 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c |   9 +-
>  drivers/net/wireless/ath/ath12k/mac.c   | 121 ++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/wmi.c   |  10 +-
>  4 files changed, 117 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 326f8f68f28b0b831233acfabffb486a5b0f4717


