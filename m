Return-Path: <linux-wireless+bounces-7398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3004F8C131C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF57A281684
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F84C96;
	Thu,  9 May 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QvVu4Bjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9C2900;
	Thu,  9 May 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272692; cv=none; b=Hx8NnH5Otlogn5E7/4eZ/zhqDnv3SbQV9JwuLHLqIbBhdDnuelQM7WQvR2qY1rVq1L+LVuYXO+I0ikS/cbK/Tw82Lp0cyJGNQSNQbWvWZNmTjbShQo1jHvyqZGl8dvrZOVYEpGEuGNWJaZ6U4jPzBna5lW6laJyEEpo4hX2LFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272692; c=relaxed/simple;
	bh=sOhjZFnypN1XTJbaFPeXUnMQpwSjzja/mDc4CieZf4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J8ZC5nj6X1Uf5hfYUxoI94idp+Ft5XnlUMqF3AYynQzsS3UHGk9SdzdvCL9kjSxDBhamNg0gaWGd0RFAoq4MAIMl9DCbLF4P05fOnljamu9LNvgmLgXfzXTZnIKEEZ41lYqXU1XuwdkakRVgwXgXE829LRJDgaCxFh4s07zWMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QvVu4Bjy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4497ACA9017606;
	Thu, 9 May 2024 16:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7TgmoF4hGSnJ9kxu1Fi469y6EC4D8Gzv53rmllVgiKc=; b=Qv
	Vu4BjymSxowaLJFf1mGjwxzTIgKmAhulizXiYsHM5KrbUlQL03UsjS0KXj8Ou7Vg
	BM8KWyEM4dRH+4uSGDnFP1LZ0pcphxhtOjLAsaKCvOf73AJf6T/qDmu562/c2s1F
	3hD8EO8CBvurCWALP8E33YOowM84fg38nLzQMBnbbX9tPzMOJcXGktDsmcqxPKHa
	cgvoBC2/8FMKOFCUXla72xdZNxHGk3gZPnAglthnIjI7fwIBlAKBF6Nh6nOPZnwZ
	3+qeoVxVjOpacOOec1VuwYhzoCzsIYhJDBTN5YL0hG9A1eQpVPcHZmkNSZx8Llvi
	WZPFBfBQkYmiWl7Grm7Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y0930u6eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 16:37:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449GboI4007284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 16:37:50 GMT
Received: from [10.110.102.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 09:37:49 -0700
Message-ID: <7585e7c3-8be6-45a6-96b3-ecb4b98b12d8@quicinc.com>
Date: Thu, 9 May 2024 09:37:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Ansuel Smith <ansuelsmth@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Steve deRosier <derosier@cal-sierra.com>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
 <878rcjbaqs.fsf@kernel.org> <648cdebb.5d0a0220.be7f8.a096@mx.google.com>
 <648ded2a.df0a0220.b78de.4603@mx.google.com>
 <CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
 <87v83nlhb3.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87v83nlhb3.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zI1g3U8i8YG86Rx_t8ttPuKuOHSMWjw7
X-Proofpoint-ORIG-GUID: zI1g3U8i8YG86Rx_t8ttPuKuOHSMWjw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_08,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=805 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405090114

On 5/8/2024 9:50 PM, Kalle Valo wrote:
> Sorry for the delay but finally I looked at this again. I decided to
> just remove the fixme and otherwise it looks good for me. Please check
> my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
> 

I have a question about the copyrights in the two new files:
+ * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.

My understanding is that Qualcomm's affiliation with Linux Foundation via Code
Aurora ended in December 2021, and hence any contributions in 2022-2023 should
be the copyright of Qualcomm Innovation Center, Inc.


