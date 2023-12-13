Return-Path: <linux-wireless+bounces-762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF330811F03
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649BE28251F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B3768265;
	Wed, 13 Dec 2023 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g+78Cxxk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F0B9C;
	Wed, 13 Dec 2023 11:36:29 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDFU2FI010333;
	Wed, 13 Dec 2023 19:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=e10Quh6ypHocogNDj3DfFg/zcaIVq5u4rHnANYa2BMw=; b=g+
	78CxxkeX9aR2uTKkPX4FgP6zvmIuUCTt68g2hfvg4SfK1hK9lPsiQk0jSZYpBJPW
	02hndBm6IeNopLbiPTBFxd0Yn+ZA9NRyBjDRZAdzgyeRd8dAMFPUz9JgHqpdKige
	qY655OPAPuLoiHJ7lEupsI/mKEiLPWjOdzw4LHVbXKLg4q8sz+fNjdvlpdD6pitk
	9wki0m8DqCFbUeNpurTdaRKzy/Sz4oJRZPGWBF0zkivT+PMD/lKcy+cJr+CIZXoZ
	dBnHGLab1lrRipSv67V2viPRHOshRITA6Wcd+8bDorv8YHtce2itReiJjQJAlXWg
	x6hHJJam2BQt7V4VKCWg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy5tvj121-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 19:36:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDJa9VT029811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 19:36:09 GMT
Received: from [10.110.106.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 11:36:09 -0800
Message-ID: <bdabfb74-ea4f-4455-bb4c-1d93977393ea@quicinc.com>
Date: Wed, 13 Dec 2023 11:36:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] wifi: ath10k: remove duplicate memset() in 10.4 TDLS
 peer update
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>
 <202312131113.4C01D1DD5A@keescook>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <202312131113.4C01D1DD5A@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M2IxbTZn4GckO0QFKlvmZIGyxCcH9-HB
X-Proofpoint-GUID: M2IxbTZn4GckO0QFKlvmZIGyxCcH9-HB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=557 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130139

On 12/13/2023 11:16 AM, Kees Cook wrote:
> On Wed, Dec 13, 2023 at 09:06:44AM -0800, Jeff Johnson wrote:
>> In [1] it was identified that in ath10k_wmi_10_4_gen_tdls_peer_update()
>> the memset(skb->data, 0, sizeof(*cmd)) is unnecessary since function
>> ath10k_wmi_alloc_skb() already zeroes skb->data, so remove it.
> 
> Is .gen_tdls_peer_update only ever called after a fresh allocation? It
> wasn't obvious to me as I tried to follow the call paths. Is there harm
> in leaving this?

The only harm is a slight increase in code size and cpu cycles.

However note the skb allocation is done within
ath10k_wmi_10_4_gen_tdls_peer_update() itself, just before the code
being removed:
	skb = ath10k_wmi_alloc_skb(ar, len);
	if (!skb)
		return ERR_PTR(-ENOMEM);

And in ath10k_wmi_alloc_skb() we have:
	memset(skb->data, 0, round_len);

So the memset() being removed is always redundant.

/jeff

