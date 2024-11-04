Return-Path: <linux-wireless+bounces-14890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A52B9BBB32
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 18:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB54128131A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727F71C07DA;
	Mon,  4 Nov 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iX2q3kly"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2D81BC063;
	Mon,  4 Nov 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740343; cv=none; b=N9gIxrcL1Gpk8rjkC+SJnmnQN3rDxUwZVxYwytbzIBii0ri6GEz+y5TOQ3bBzwzeP4hGcrsFjxUcnFTXBgAXp3jFmRTcHZunbKugzW3Yp8xc4FL8Q/6wg9v12Uhqhy5Iu/7CwgNaxTHGk2ZgVmST315Mkur7vBSXwDOKo7tRiXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740343; c=relaxed/simple;
	bh=hlW3nIWVL5Db3nxpqovS/7E3UEXnG0/pFjbnueckOcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MXQ9OforHKDeVArRxSvll9epuEiwAGBE1Zi+SCwY7RswG12sFxuAHej13DP4HugBSBrSYRHZLct4SCedfuNY27dTyUdOCx/kitDGoAayUftADEIMV71aiP5qAOmAqXlgPZypZJekCRIFRzlMGfu0sURN68JmdKw03D5NMQXbFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iX2q3kly; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BjYx4026443;
	Mon, 4 Nov 2024 17:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BeCnEGykaYEk4EgJ7ihgNRfZLqbRJA/d8HCeWrka304=; b=iX2q3kly++kBOFC7
	Rwdlsb5OD/MZVjWQtKmUncEAamlRvKnAMLtcgP2xrLRpRCLxTkIo2WwSGapb+aON
	t27rL2J2f4VTQmQ0EL60dN2GShRGYUpuenAnhtaLvtX7ItmP6giNNNdzZVOksHUn
	MZshh057akq54CeXWDjKOMbdKae9RQMuLyrdFK+J7Y5doG/F9XDMBFGKCUAhYrZl
	gZSneNADOLIRH6MVKD0ozc7B3jGJ/1mvhMPV/oUaLYSpy9oGbwdaLf64A4vR6ARE
	NlvreKcHCv0bnUhW3x5spO6UBwYEa3plO0kerWfeju7j/myVh1M3xFhmPXXt1Gtf
	N+Brxg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd1fmyra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 17:12:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4HCBSY009671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 17:12:11 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 09:12:10 -0800
Message-ID: <0bc2e4b0-4dad-4341-a41e-a98fbc4b1658@quicinc.com>
Date: Mon, 4 Nov 2024 09:12:09 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
To: Aleksei Vetrov <vvvvvv@google.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <stable@vger.kernel.org>
References: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rDFkmgpesmK2zhLKJ52g5uHr2cbaeixx
X-Proofpoint-ORIG-GUID: rDFkmgpesmK2zhLKJ52g5uHr2cbaeixx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=565 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040143

On 10/29/2024 6:22 AM, Aleksei Vetrov wrote:
> The channels array in the cfg80211_scan_request has a __counted_by
> attribute attached to it, which points to the n_channels variable. This
> attribute is used in bounds checking, and if it is not set before the
> array is filled, then the bounds sanitizer will issue a warning or a
> kernel panic if CONFIG_UBSAN_TRAP is set.
> 
> This patch sets the size of allocated memory as the initial value for
> n_channels. It is updated with the actual number of added elements after
> the array is filled.
> 
> Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

And it is exactly this kind of issue why I'm not accepting any __counted_by()
changes in ath.git without actually testing the code that is modified.

/jeff


