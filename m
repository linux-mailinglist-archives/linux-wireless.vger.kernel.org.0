Return-Path: <linux-wireless+bounces-14482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2852A9AF65D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 02:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEFDB21E1C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 00:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DB04C8C;
	Fri, 25 Oct 2024 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BXjV+xdU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F510A0E;
	Fri, 25 Oct 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729817598; cv=none; b=gWtCfHxy4ZXCay+wnCPi/Mu2PBGaRH7PUgo4v5QyvLshrvw+5y1RpXV+8s3qIIPDYcvmdrIoILEXO9l7jEPv+lmg8REW1QuoQA0KBEpFry5eEs/Z2tjT7qJS+z3W1HTZh8m4nV67J3LgSiOOnnNM0zXzIdlMpIOjQ6oV9JsLX7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729817598; c=relaxed/simple;
	bh=c0PlFJjYjoyNj2knuv5wFRhx7BljeEh0XdLIETP8K28=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RaC8Py2C5G/5OSDBAbXtnbPZ+0XnE6chJie9JZUlbntXSjzJ6lyVCHguI5w5HOneXMB4aMFmcncjjvm2rmaIePsA+AaBUhJ7B5R1P9luF+Q3eGIYOzj0/EKAQOCEKnHD/50QneZr50uevyiRxXxrJgfhYE6eQTNmXmrTSFrvyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BXjV+xdU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OAgRaK027369;
	Fri, 25 Oct 2024 00:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c0PlFJjYjoyNj2knuv5wFRhx7BljeEh0XdLIETP8K28=; b=BXjV+xdUbSeJsHb4
	GNAS7vg8vQ6HSQliX0QZ/bF8Q1pf3yJ4EiDPZ+1bHDoZzncS9KW4JIwtx9lKc4wb
	yLp58oW4x3cX4G4WPeV12e+ZSWkWTOjgEG1QyIXeiEdRxLJvnqm9BZrQyrHkkKmn
	oYREKL+mXy0rjOtz8rGtqsLUFa0xVg1wiDHzEZOtV2MLVnMyPtQsKU/pEJZP13Li
	WFp1ujD70NbQOALZuSycSRMr8SLaXSAUb/3c2umRhkRKPGhCz9BnJyzfva+NF1El
	DOgGehUAB/qif7rpcwdYsxWnGopsadx0gMyRbCgIRn6w+bIoj5jannxgR6TsrodT
	DGewmg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em41y8pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 00:53:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P0r9Y8020823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 00:53:09 GMT
Received: from [10.48.242.80] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Oct
 2024 17:53:09 -0700
Message-ID: <8714e9ec-b519-488b-89f0-b181c79186c1@quicinc.com>
Date: Thu, 24 Oct 2024 17:53:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath12k: annotate skb of struct
 ath12k_ce_ring with __counted_by
To: Dmitry Antipov <dmantipov@yandex.ru>, Jeff Johnson <jjohnson@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A . R
 . Silva" <gustavoars@kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <20241024112912.106104-1-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241024112912.106104-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lhxww_qn36ZJJT2ceqf7aXj9_n--BIlI
X-Proofpoint-ORIG-GUID: lhxww_qn36ZJJT2ceqf7aXj9_n--BIlI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=500 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250006

Please use get_maintainer.pl to make sure all the affected lists are notified.
Your ath11k/ath12k patches aren't hitting the ath11k/ath12k lists so they
aren't on my immediate radar.

Also note I'm not taking any of these __counted_by() changes without actually
either 1) testing with running code or 2) documenting all cases where the
array is accessed and cross-referencing when the counting member is updated.

I don't want to introduce any new warnings with your changes.
"If the isn't broken, don't fix it."

/jeff


