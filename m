Return-Path: <linux-wireless+bounces-10688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C324C941527
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 17:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002191C237E2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6391A2C0F;
	Tue, 30 Jul 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z64rV9eE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D61A2C0B
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352251; cv=none; b=ZpRqp/rUmZ9CXwdDj/iwY82bxCnb/KWkuIlTW+vEiZnbHNBzxtR8I3k5LD6g+is0dCFRjCV7VVOHBDacFK5T2gTGbpjUo11v+R2L8x7hbLh2zAGxGUYeBtrhG53XHygf77wu2sZj5Boktne35YBho67PO9yE5Bax5lgBVGO6cGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352251; c=relaxed/simple;
	bh=pjNQjmEtQshjgupf7ubr+Q5otLoPs32n3uBz33/+FcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ExwuMJ2ykdCRVnzLoXEEcd577uARcTb/4ybbyLyMxRzzY4EkWup7FzWVSKBdDr6wbYAPv/DSbmHoUkXL9Ad1wdpXmjj5t1o9tAoRf2DPFeVgiz2WXMdcXSpQjFaZz+vLNYn9pK3iOd1sEJSyaxgr+qwRPpIupnTD2nhWGgqtBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z64rV9eE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U9NCJ1021139;
	Tue, 30 Jul 2024 15:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pjNQjmEtQshjgupf7ubr+Q5otLoPs32n3uBz33/+FcY=; b=Z64rV9eEmwUolICt
	cIQWXlwm8hI7hWr96ItX+zjymlwtd0wIINMz+sexEfqq3ThFER4nQQwr4/kkId8f
	nPkCoA+mTuqo3MRIndXsKW/vK8b18Zxgb1wQNImjK3fCzuvCZnK35/fRKnkZPubQ
	ok44cY20cCZgUKHEG3/CNhLhzzEjcbuikDZqOf/X4oErAZbpCLh2o1PEpCOaEgtj
	htJvfItBNFj5tvkq1NIRD+i0DZY9/ruf0PEnuoxJvbqBlfqXyTogeXlaTr8tLrz5
	l8Vtkp/NijjthTGL9pRPZ9QUwYpMX47dsb+L9dHFTdr/CnXdpVZmaTSLXiZ37GTX
	VDEDqQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mqw77y13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 15:10:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46UFAiwv032243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 15:10:44 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 08:10:44 -0700
Message-ID: <f7a78f85-db8a-4ce0-beb6-fb64d81bcc17@quicinc.com>
Date: Tue, 30 Jul 2024 08:10:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Modify print_array_to_buf() to support
 arrays with 1-based semantics
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240730035154.3723773-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240730035154.3723773-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zC1NvRSVq3ZniEpwyEoiO4uK7L2yCLyj
X-Proofpoint-GUID: zC1NvRSVq3ZniEpwyEoiO4uK7L2yCLyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_12,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=237 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300104

In the future if you need to repost a patch, please add a REPOST tag to the
subject, and below the "---" explain the reason for the repost.

Having duplicate subjects confuses the reviewers and perhaps some of the
automated tooling.

Also suggest you use scripts/get_maintainer.pl to properly populate the list
of recipients in the future:

% scripts/get_maintainer.pl --no-rolestats drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
Kalle Valo <kvalo@kernel.org>
Jeff Johnson <jjohnson@kernel.org>
linux-wireless@vger.kernel.org
ath12k@lists.infradead.org
linux-kernel@vger.kernel.org

(Normally you send To: the people and Cc: the lists)

/jeff

