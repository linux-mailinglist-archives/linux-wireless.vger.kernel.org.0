Return-Path: <linux-wireless+bounces-4032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C686824B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 21:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6EC28AC56
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131B130E39;
	Mon, 26 Feb 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hOUJEOl0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61E12F388
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981191; cv=none; b=SipWtccKzeZ2D0v6mzhz+1x3ZlNWcIt7lxG4zDkpZnjiAw5szAOP3UeQ2GEyfODqb/Ri2MmosqL12nioNeLd1IGNkY94jaAV46Wt2bAbUPhxEMipLw1RZCWnUYP7FE5nitDKP42i5CZfY+CvoPFZl7IjETPfY/xkAqj8nTr/KZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981191; c=relaxed/simple;
	bh=gVG390S5pmeG+wu3bVB3cDVxa+f8ra68h1QAgCQxpn0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=V5Xh9qdLDcgzug06mk2AN7+pwUW9CV8sSPG7pHhvYB5Nc/Q5HVYLukpZXAzKk414lOXCoxhgJs/Wtxu6RKA4y2d5MDekhhpe2637YU8BTal3fuS9QE6PdvJJBWF0wyTjakvPipWJfx3gGsEIKVIBP0wdeN2ZjK+rgTWcPqy7/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hOUJEOl0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF9bcq011111;
	Mon, 26 Feb 2024 20:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1Yj6uYUdFw1Hs2GXdSk1k/LtHQyQ3uk6ImZy/Jd9Yik=; b=hO
	UJEOl0zJ82Fn9ioQwgBI5M3n+wgD6wCihJ15/OBV0mU2wMm9Y1o8jQSIipLp2Rq6
	6366K+36iv6k/ffFVFlkbq0ytrhypmuUUUhTRQ2Q22vx6y2kt6IKsJaY/DNAYwLT
	JHIOBjI5CHDthE36s0iSRSHpN3DnLf1IGfebMyfxQeqxXU2ZtD5r3tyspLeXFMgi
	/unSdTFHd3FfXiE5iZYmSRg6gEMgfkgPFc557xXyMzSK7rnsxpi3ZSTobmhUwS6q
	iqhyEh2dEfYfkTfX6G054RxOvDRzKjEfX3BI9JkqvmHaA5x83d8ndYkhceA8iI77
	AzbRfrOQMLMxAZylkfAQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxna34x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 20:59:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QKxiDN006909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 20:59:44 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 12:59:44 -0800
Message-ID: <c445dd39-5d41-46b1-8dd8-6a086f65d481@quicinc.com>
Date: Mon, 26 Feb 2024 12:59:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] wifi: ath11k: implement handling of P2P NoA event
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
 <20240226060203.2040444-4-quic_kangyang@quicinc.com>
 <032375ce-7dc0-4d93-9f26-12a6bb89dbe0@quicinc.com>
In-Reply-To: <032375ce-7dc0-4d93-9f26-12a6bb89dbe0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Boo3V8Pr4n2FKA3SaNSqgld_Qrejbpjz
X-Proofpoint-GUID: Boo3V8Pr4n2FKA3SaNSqgld_Qrejbpjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=758 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260161

On 2/26/2024 11:53 AM, Jeff Johnson wrote:
> On 2/25/2024 10:02 PM, Kang Yang wrote:
>> diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
>> index 4c20202947c7..564f4a9ac8ce 100644
>> --- a/drivers/net/wireless/ath/ath11k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> 
> drivers/net/wireless/ath/ath11k/wmi.h QuIC copyright missing 2024

I just posted the following patch (spotted while reviewing your series):
wifi: ath11k: remove obsolete struct wmi_start_scan_arg

My patch is updating this copyright so you don't need to.

/jeff


