Return-Path: <linux-wireless+bounces-2744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37022841842
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8FA1F23476
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 01:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8400B29CF8;
	Tue, 30 Jan 2024 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Koct7IQv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80972E40E
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577994; cv=none; b=coe8QvnLqSyA8Z81QJtkxS1kGe23ZqZS0sVE9Xexpqq3sNVM/UCYXvQv0goniaw3SbI+lHt1Xei7jtvzjFeaBzHrPMJg0wAjZp9xutglRY7mmspT37lmQ2YvtJm53eg89s0bMbH5IqDgSpayptgERQ7WCnyiQnxSAVfVX7nTQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577994; c=relaxed/simple;
	bh=QqUFI26fLhjeB0k3uHNaooyt6u18LvfxV+VG/xLRCJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RCbjYDaScNE7iKq+UoXptI0q5sdHxVWudu/DDP4r36olOBQjGX83LsT8tmh1Zr9cVp7mhdg3iAiFKVe1hO0LU3ZH4iDujp+N6Akxa8HBMNb5VFnV8LpvEyjfq6GZ1I95Hyi2JD9tk7UeCU6jFhtGwLGAJcnNxLXdkbtgYnZQnL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Koct7IQv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U0S2Cp032573;
	Tue, 30 Jan 2024 01:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UnthoV+FLaLRlMzlMOPAddwBbqfsRDj47CGZuT3VJWk=; b=Ko
	ct7IQvjAYAe9Hl7AYSn1bA9ZW617kL3suF7JqQAZxBVw0L/4OE2RPa1ittOYF1G/
	VG7E3vOr0suN1G011NA8UpssUNNX1Q34YEA4vDKTDCPArfDwfqfLDcvKBzxAUTOH
	FEUMFmdAQ/DssxXHyPAr2N9EaL6YzjA5ZG5ac1jkBUoPEgREO8IUJ9Z2+cfIUjzF
	Ja9ZSMYdVKEWRvAVhne1D6JXqgkj3NuXqmXcjLccxAJYOydJ32Cx7TnGOd3VoqzI
	nMJbmab9H/kJq8OcwJDm+OyjI4mGyPttcoSMEU/D88P49XBq4wuV3b9RyZIarUyw
	I5kvygiVy6U6wykeIMOw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx9r8j4y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:26:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U1QSFp002943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 01:26:28 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 17:26:28 -0800
Message-ID: <30d8773a-03b7-4114-ad61-403a3bcc85e4@quicinc.com>
Date: Mon, 29 Jan 2024 17:26:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] wifi: mac80211: handle set csa/after_csa beacon on
 per link basis
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
 <20240129052832.905113-4-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129052832.905113-4-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TNqW9Fz5wnKvZVIJLkstbF3BWSH_QlX2
X-Proofpoint-ORIG-GUID: TNqW9Fz5wnKvZVIJLkstbF3BWSH_QlX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=517 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300007

On 1/28/2024 9:28 PM, Aditya Kumar Singh wrote:
> In order to support CSA with MLO, there is a need to handle the functions
> ieee80211_set_csa_beacon() and ieee80211_set_after_csa_beacon() on per
> link basis.
> 
> Add changes for the same.
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


