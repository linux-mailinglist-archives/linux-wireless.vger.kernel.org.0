Return-Path: <linux-wireless+bounces-5120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EAF8861B0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D63B21E2E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 20:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C74134CD3;
	Thu, 21 Mar 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kUVEFUUZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F3134CF2
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052959; cv=none; b=uXGVLMb3Y/ZQwz7WstS4bC+dY1xbTC7Oi+0PO19KOfkZkPze+kl5SjQiqw7kKlf4aPz8E/ckmaFGKbG80v/hLqXRj9hVkMk70N6fCBmpini6c727FlvpZKqLQujGOsKa920rLDy6dNHMPZ/J1PWprdk47GKAGxhDuaqtPu7fmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052959; c=relaxed/simple;
	bh=Ox23ESJz/eQsWStM9A1QBxBSeU4hdqta6b6AcbzgtbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=np1BLyMe8bQKQbod1L5ILmUHAqnXmCV0vz3mreFrlHBptWlgUyUeydV6SMRXLWw+S52tRxzxP3ptlEufm6TRwLYLcWIAKQd2ryEB649mIHw8SmjXl3R0/oY+gnQocy6DD1KO8xlEe5Y10zz3C9Gu6sVGRgsf2LYZlctpdSZTRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kUVEFUUZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LJvjIT005793;
	Thu, 21 Mar 2024 20:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=n8xCkISWKUCgDTW2fprQv0fu0jqVzU00L5QUJjN+1jk=; b=kU
	VEFUUZEaQGCXVmdUUn+w3ydR2+A/iV5sXPTWf4X81h5KPcqmUUiKzk/z/4mKN1Ar
	rkCxlipmgxy2YcM8+p2oBYaRo8DaekALPza2mQU+r3eaN1BWkpExjhmzZveWwLUo
	rGI+VCY8j+T74Ud6ikrA9v3+/A6PEbhcBGLJvMKWX1HKnP+Ru/Msv0IqUQR8MmrE
	2apRzChkoaYUjzjYNhmcZKVVMgGl9CWWDnlAUFnbUHVw9gTDG1a4oXE6K3YLpau8
	T8Agn3Tw/zb+NIHiuFWkto6dCkioDsQTfR+fuXA+zENC49aCeWw5cACMvr831VWw
	5orRgR7uord1QPnpCQhQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0pe2ryhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:29:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LKTDNc022444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 20:29:13 GMT
Received: from [10.110.74.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 13:29:12 -0700
Message-ID: <8addfd55-e2cd-4c53-b4c9-025a385a97c6@quicinc.com>
Date: Thu, 21 Mar 2024 13:29:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Add support to rx retry stats
Content-Language: en-US
To: Hari Chandrakanthan <quic_haric@quicinc.com>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
 <20240319134522.4021062-3-quic_haric@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240319134522.4021062-3-quic_haric@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QjffbKZ-uAaaZCdZgGj61dBXHuFKNyHl
X-Proofpoint-ORIG-GUID: QjffbKZ-uAaaZCdZgGj61dBXHuFKNyHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=804 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210152

On 3/19/2024 6:45 AM, Hari Chandrakanthan wrote:
> Add support to count station level rx retries.
> It denotes the number of data frames(MPDUs) received with rx retry bit
> set.
> 
> The rx retry stats helps in understanding the medium during
> UL transmission.
> 
> Tested-on: QCN9274 hw1.0 PCI WLAN.WBE.1.2.1-00148-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


