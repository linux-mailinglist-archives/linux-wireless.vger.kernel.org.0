Return-Path: <linux-wireless+bounces-4103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E698699D9
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 16:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1D81C23339
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA6613DBBC;
	Tue, 27 Feb 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RDJhPLyd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042CC7A72E
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046336; cv=none; b=EtDnsFuJI3KF1FaNa8UGmI8j99yu1xYHvBrBnw6GOQPqs/dxXN4Qevf06tbUESEeM5O2ojzcUB2nnn6hxMco+nNsJD/OWJBClvgP1Wrd29ohQp+TxMzdayuw+Q4Ak7v+A/1vuMW6gfQ5tUdX3arITR5wmRg6jOCqbTuMajVB/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046336; c=relaxed/simple;
	bh=vpVgRMSMlQRj+WP4mF4tBQ/yRLOhdJnYVw7U1Oh6gMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PFWYjAGEu/y/KE70qn8f0Oz5ugXpiqZdthkL3lx4LAAk0FJSUrNP0M8ZftHlQ0h1ki0siy4eFbcGdqfB/mzmtZ17vBi0eqnCnlwxPlEmSvVixLKeTjl9GB+fWIBPfAJbAQ9kyLJ/uTTvinqzEgLfnYUJZCiB7uFQHFa88A9RDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RDJhPLyd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9ZEYN022683;
	Tue, 27 Feb 2024 15:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vpVgRMSMlQRj+WP4mF4tBQ/yRLOhdJnYVw7U1Oh6gMw=; b=RD
	JhPLyd+yOaZldEpRKKVf4GIPxT6ZrQOfVn645/LRGX9IWi9oikHCtV7+v6T3QRBg
	rpshX0ih9i5MDLb5K+vMxPDvCCJovcLkJ/Dm0Udhc8u3+Jd0Kc6JJaXFtABZAwSU
	6WNrht+TN7cGhDhXElrf4gbV3jRwagmT8mwgvFnnJMfF3SKeCCfius6n7wXSQOAl
	ijPqQWDwrbEFPpoWuSr7XF+cpcVyC3O14zfAMPreuh4AOKp55NW+vOXu4sm5ckoy
	TjHdRXF2CcBINfxyOyHPLmnAvI/dS0L9jFP5iiRPzxSDGS7TuDIg6XcSyiwOjY6o
	Di38cV72kfptziGUGH/w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh5079sbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:05:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RF5LV3020645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:05:21 GMT
Received: from [10.110.113.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 07:05:21 -0800
Message-ID: <3582b1ea-e103-4b7f-b34e-6457964bdb93@quicinc.com>
Date: Tue, 27 Feb 2024 07:05:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] wifi: ath11k: add P2P IE in beacon template
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Kang Yang
	<quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
 <20240226060203.2040444-3-quic_kangyang@quicinc.com>
 <42652a06-33f3-445a-bd8a-da4633fa52f8@quicinc.com>
 <b20fc717-654d-4e64-920f-699fe3ec5598@quicinc.com>
 <5c5ad99d3c2f3b9915b440057eab6618639cd31f.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <5c5ad99d3c2f3b9915b440057eab6618639cd31f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g7dK2wgPmioZGgYP5nwA5cqJsddRUQNw
X-Proofpoint-GUID: g7dK2wgPmioZGgYP5nwA5cqJsddRUQNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=735 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270116

On 2/26/2024 11:32 PM, Johannes Berg wrote:
> @Jeff: NL80211_IFTYPE_P2P_GO is not used by mac80211 internally, it
> translates that to vif->type==NL80211_IFTYPE_AP && vif->p2p==true.

Yesterday I was looking at another patch and while doing so noticed this
as well. Too many years of working with our downstream Android driver
where we use the P2P iftypes directly...

/jeff


