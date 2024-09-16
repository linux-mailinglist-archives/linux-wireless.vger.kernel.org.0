Return-Path: <linux-wireless+bounces-12896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA0097A82B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 22:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B323F281D15
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D815B122;
	Mon, 16 Sep 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fYscjDsX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BAA5258;
	Mon, 16 Sep 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517627; cv=none; b=tbSY/aJ3O1XMrQm0/K09rqPfy+9OMKM/ZFKQXaVEgRJ3HKmhlY8DnZAt3QWhd3HIf1q6dK6nWj80f0kCG9TWkH958Ey9vWgPi+4Pdk8RuOKnkzREcdK4Zwq41DmuGh1jCP9Axqca3zLoKJbmMfAHnGoshAPot4oXVkeerjQbK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517627; c=relaxed/simple;
	bh=EL2GC+EVnH4hG0TVJqU9Xm6YeNRmTuxF8OIy2Gbj43g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ui7J+X04pqs+W4jz65fuvgTXD2cFyQwTNu625gidTuDK/Gt84vIo0ZlHu0yGYIzKEEdGESNKDzfqF1lMVC45BIVtCk76FlCZiAItybTIostG8opIVAYM/+jtBQQ0ogfsxOTrpkXJ+Oljsx1yiwjIo+vbsXAakx8M1NtARbVPWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fYscjDsX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCrcJK021686;
	Mon, 16 Sep 2024 20:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/6yALasju2uq3je/QLaKeykXUSA0Q3NbSVO1huNH8ik=; b=fYscjDsXYd5abmlt
	vPNy/hwRAaNrEXqIE6xNJeH3KtrlXCvN7ft4POEg+AaPoFBXc556+2/ytPUY/nUk
	FnzXFT1N0qDVJaqBkDuF5w4hKJ2V1FBh/r2twRsRpsoFtUwo+Rvowe7/zRWOdfOP
	FuoSt+TF5eBn0KQ4SgYikjdlOkVw22EzpVeldR5fAKBsDzLX/W6lEIp10r1AAtVv
	U5c7UvgqnjpOpYUqpRlVABZiUt4f8i+f94l1PZZsCeItmDnrZZE9pZakYuLsfuNA
	2/UvHrgjuz1vOi60Pff94hrIkzfhHzAGc4FwgBzrDVyZvyeKgnTEL9VUI2393IaD
	RUSK4Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hfd3q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 20:13:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48GKDe2e027823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 20:13:40 GMT
Received: from [10.111.182.118] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Sep
 2024 13:13:39 -0700
Message-ID: <137975fe-7ae9-4cc3-8871-abd632ff4800@quicinc.com>
Date: Mon, 16 Sep 2024 13:13:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: mac80211: make read-only array svc_id static
 const
To: Colin Ian King <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240912144456.591494-1-colin.i.king@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240912144456.591494-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vedNDR5-6EA31g_RG3RYgMZ-Kd3m0yLQ
X-Proofpoint-ORIG-GUID: vedNDR5-6EA31g_RG3RYgMZ-Kd3m0yLQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 phishscore=0 malwarescore=0 mlxlogscore=714 mlxscore=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160137

On 9/12/2024 7:44 AM, Colin Ian King wrote:

subject prefix should be wifi: ath12k:

but no need to re-send; Kalle can fix this in the pending branch

> Don't populate the read-only array svc_id on the stack at run time,
> instead make it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


