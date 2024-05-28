Return-Path: <linux-wireless+bounces-8211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500368D215C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811071C235B2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5A3171E76;
	Tue, 28 May 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RpqnIhvJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B644171E60
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912781; cv=none; b=rVJ/+cBYckH1M1nYXx07smk6CJouCVQDyJLDB3IpN3nQ5WuB9DFLjiwGl+TDUZAIpF6aa3OyUhWdg0MeS0sIXGaVUMlnVR8rObmBS2oDh2mrMg9ybwx4KYxO9Y+Y3wr/DGBo/kVr4wBgJ4XpmCCIZUOKSOXYuaGW7Sw3E81lGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912781; c=relaxed/simple;
	bh=tpyH5fLTaFxpKx1xKyPTy4rPBD5QtqfOC2bfVESdW7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WvCIu78KGUa05j5fauSfrGnKTcRANLrQLJKoDpmx3vY3ah6IkykirCGqSki7loEkp3q3TR4878qts9Y87/reJIqS4cT9TDpPD6Ex/nqwxlQO3WYGlFcw1SI6LOpm/M7MyMHz7bOnwn/sc1lw9Ma5kz3LlCnDEbIxJhSRWR/4UdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RpqnIhvJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SBk9mh020271;
	Tue, 28 May 2024 16:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ioWE+gCmPaeniIEWWwHT9GMhHpQSa3vrXzI9uT0XGG8=; b=RpqnIhvJake9D5MO
	mEoaYGElhBXD4hIhOYPg6d+K2Drre7l+/OroCIUkqqPJI2zugiHtXjlenWEjVjIB
	H72R+GnzmE3UQzIvLr+gq0+PwouUnaSNPTfkWd11lDQ9AOsu9HLSimTgNDsCzlRB
	+TQm/kWVdymv8bljruWtF8MmMvjd7XMjB9uL2FAvadhOp2TwHb68PyR5NPHyOoqZ
	8aP0unwYDdQdrLD7R5qabCopyeUwuRQPh0MPsJdoTUhQ+jj82ymk+mbGTibTT8Ft
	6tGAFBCEM2rhPO8ax0nAv8imGmPLwtMhcdzDaHuepA9nUGhBntf2sq5WHnkoDmrv
	PGGiog==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h6kbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 16:12:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SGCm6G017150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 16:12:48 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 09:12:47 -0700
Message-ID: <8aebb28f-a4f0-43e8-8b55-a55d7cb1bdc4@quicinc.com>
Date: Tue, 28 May 2024 09:12:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix memory leak in
 ath12k_dp_rx_peer_frag_setup()
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240526124226.24661-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240526124226.24661-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rzJGbeBv73G30Q_d1g2xv7v2ZjToo4PH
X-Proofpoint-ORIG-GUID: rzJGbeBv73G30Q_d1g2xv7v2ZjToo4PH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=763 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280121

On 5/26/2024 5:42 AM, Baochen Qiang wrote:
> Currently the resource allocated by crypto_alloc_shash() is not
> freed in case ath12k_peer_find() fails, resulting in memory leak.
> 
> Add crypto_free_shash() to fix it.
> 
> This is found during code review, compile tested only.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


