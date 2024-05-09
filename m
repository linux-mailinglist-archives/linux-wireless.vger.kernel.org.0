Return-Path: <linux-wireless+bounces-7399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E38C133D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 18:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DB01F21B02
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B16AD7;
	Thu,  9 May 2024 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dwcwM9n0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9B6AA7;
	Thu,  9 May 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273307; cv=none; b=pnWGvZHrrONxcO5UGgwzCEPKR+MZoI+lMWBrh60k8D3dr3zToicZ57YNiUFI7tMKEb6Xa58WXwNUAbTfxZFzYFi1q1x0ROCHJSEL49mELx/+7yjs6K7puxLs9wRv0DZv4p++AbZcHxqryYkPphGNXhFRKtlxJPBen0gdSKhYAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273307; c=relaxed/simple;
	bh=h36iGJJBvEgG28rH8yKUSckDC0mHU4sY/hhGRXKQj+c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=qZCJh5AgO6hdu0mkTfLF1mQFIzAMJPeo6d+ZJz42Qe79nOg9HndvJD3gIqzphVYAsB7uog/Vm8ZqNo2BuejHKDb64b6wwmkOYD+gya2RZlUbk9wiC32UfBQwNhDPkysQpCEdaDUHF8mj/nEBknvcIHBuqRJ7OUqUn/vbopQ8HyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dwcwM9n0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449E4Pbf013876;
	Thu, 9 May 2024 16:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KucazwigOhRELkLRJ2ZpAYiuznyNg1d47XpT9D55Xk8=; b=dw
	cwM9n0t/5aPZMdoNkb+4TmDYFPB4irqJd82WF3iZ9hR/9uPVaWwxABAN7hi/HCly
	KpcJKzk5Bc8tJpoJQ8zosqQG4+vTRxGLiBk3XYTUet6/31Dx3cIms1P2BP3CDxK1
	rKlfJvo1k0jg705h9eIn2dTD+mBmif8v3sC1zbnwO6ma5qcYiGXQsi7GzgPYxT1r
	nxgZjvfD9apOmY6tB7SewJJW4V63PpSwCIZmkzm0DSQX4FX3tJ1u3hGT5jgk0bFX
	7dAfxMOfSb4uZ2ITXTfdyEaDILUUdca/nqaPyHkLODh16PY+mezB9wcW3ZuHrdVH
	xF8hfuLS4grmVxIId5kA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09frb5dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 16:48:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449Gm9ej032744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 16:48:09 GMT
Received: from [10.110.102.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 09:48:09 -0700
Message-ID: <cce2700c-e54f-4a50-b3f0-0b8a82b961a4@quicinc.com>
Date: Thu, 9 May 2024 09:48:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Ansuel Smith <ansuelsmth@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Steve deRosier <derosier@cal-sierra.com>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
 <878rcjbaqs.fsf@kernel.org> <648cdebb.5d0a0220.be7f8.a096@mx.google.com>
 <648ded2a.df0a0220.b78de.4603@mx.google.com>
 <CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
 <87v83nlhb3.fsf@kernel.org>
 <7585e7c3-8be6-45a6-96b3-ecb4b98b12d8@quicinc.com>
In-Reply-To: <7585e7c3-8be6-45a6-96b3-ecb4b98b12d8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KwxcFyIjNFarDSGjaqhZq-3C4SM7LnTF
X-Proofpoint-GUID: KwxcFyIjNFarDSGjaqhZq-3C4SM7LnTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_08,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=783 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090114

On 5/9/2024 9:37 AM, Jeff Johnson wrote:
> On 5/8/2024 9:50 PM, Kalle Valo wrote:
>> Sorry for the delay but finally I looked at this again. I decided to
>> just remove the fixme and otherwise it looks good for me. Please check
>> my changes:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
>>
> 
> I have a question about the copyrights in the two new files:
> + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.
> 
> My understanding is that Qualcomm's affiliation with Linux Foundation via Code
> Aurora ended in December 2021, and hence any contributions in 2022-2023 should
> be the copyright of Qualcomm Innovation Center, Inc.
> 
> 

ok it seems like Kalle's v13 had:
 + * Copyright (c) 2018, The Linux Foundation. All rights reserved.

and Ansuel's v14 has:
 + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.

So Ansuel, is your work on behalf of The Linux Foundation?


