Return-Path: <linux-wireless+bounces-1184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753481C22C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 01:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576691C2388C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 00:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974718E;
	Fri, 22 Dec 2023 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B4MhGLEY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6A1844
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLMlq6h005438;
	Fri, 22 Dec 2023 00:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YzpSahJebBeFnfxT6xxdN+zLRHqhDWWWvNYVVTQE1U8=; b=B4
	MhGLEYVXVScQ+7Mn7j9VBZcuulx6N+W9tkhzi3mAdUrz/nNAPI0k8+7Vb9jKLfx5
	BqT17smnxjuCARbLRfVEB/iPLd0w+lz+1WbPmzhT4Ja5UGQdAyrTmT7qcKlVJRl0
	Df9f/XfH1p2/rxR7EB85upNBceEb5Y/rfzklQI5RFaUf/2QxQZgdNH3REeiCNGhD
	0OK7CSA4NaExBgNmhZDy6uwToXlwU4YWE2cW8ov6zTBkHYlGzqt/O11ltjYO7RuD
	b0BDFdCwDbhpOSGqKx2d9lRcHl+612nBq6CKjsLjYbmnpWwyMVS8hrSkGoPQSyY/
	FPUsamh38AWjtf83IY/Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4gvh2pk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 00:01:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM01iwq002521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 00:01:44 GMT
Received: from [10.110.5.151] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 16:01:43 -0800
Message-ID: <33c2105b-8dd6-4dee-949f-7ced7078f197@quicinc.com>
Date: Thu, 21 Dec 2023 16:01:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()
Content-Language: en-US
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20231219091022.70861-1-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231219091022.70861-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: giT7jNSZCtMuVkONSIRQD8uT4yVO3pzJ
X-Proofpoint-GUID: giT7jNSZCtMuVkONSIRQD8uT4yVO3pzJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=559 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210182

On 12/19/2023 1:10 AM, Dmitry Antipov wrote:
> Since 'ath12k_wmi_tlv_parse_alloc()' always operates on 'skb->data,
> skb->len' tuple, it may be simplified to pass the only 'skb' argument
> instead (which implies refactoring of 'ath12k_pull_bcn_tx_status_ev()',
> 'ath12k_pull_chan_info_ev()' and 'ath12k_pull_pdev_temp_ev()' in the
> same way). This is an ath12k counterpart of the recently submitted
> ath11k patch and compile tested only as well.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


