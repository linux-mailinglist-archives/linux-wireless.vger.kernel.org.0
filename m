Return-Path: <linux-wireless+bounces-18575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFDDA2A298
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 08:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C0B3A3866
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EC9156968;
	Thu,  6 Feb 2025 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j0prtUEZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7113AD18;
	Thu,  6 Feb 2025 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828000; cv=none; b=GgbbuBUB+WZU5pjk6Th8SSLIFdqy/r4/4Uc4Jx4Fi/6x8mwmT+8vLVc6tKPya7uwUkI8TbeZTCXtmVGTZC09RQHmKR8gZTUdxbuteleunIiTRgJyT4pw6BxKOKbXTgz4ME1V7xIw4mueYf5fS+5w67SIksXCxx0ZewCK7PntAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828000; c=relaxed/simple;
	bh=Yi9Uin22rnBvV+AbChLdnvx0g3ZnLrcBMeay5ZdCrsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EuRcjZ/hfiFGaK2xrYELENqC1aXJ24Ew+ZWpZX77xT5HBrG4qDTf1Dy4NdvanjsLwV+Sy1cJ1wxKVGunjzZc3/0AiBvMKD91JAY9B+Mmh/Ys+EvKqDoQOwcGu7iYAcT14Eo9bVrmeFs7xSGAzUa9kMRFMecpa9pcKcgqUZgQPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j0prtUEZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5165WgWa008340;
	Thu, 6 Feb 2025 07:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u8zAkc5/qP+ByAbXrbpXW3BsRNr6mwhyvhlUPAxusKI=; b=j0prtUEZOOZ5SZ61
	hTJHkLK7pGFWQu91EGxceFbkIzrrop6DHAvti9yK+Vy1f5JvDdbQGaMtr3KhFfP6
	RQ7RJC+4YEst19zzeMpTh37PTj42WLnDAfuLCPQcj7Eqgn9TrYJiBzNCaAbj65ch
	rlGcP4plwQBcEUwQP3CaPUWxlu973kvYOA+/W7/qOrgivT4DigQqx9JlCfVfoqSj
	nJj3jTu03H4+DCChiuQi5jNX9w4Np0wS50TEqOYE6b+/D8KkMfGdxtVOpwvIBb/p
	NDzXyUXct2kBznvFPcY3y5IkOVuY2JJrGLxuqnnAzeznPfRO2vbIGzJtJbxeO+f7
	ZoTfaA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mq1br9cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 07:46:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5167kXNL009139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 07:46:33 GMT
Received: from [10.231.195.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Feb 2025
 23:46:32 -0800
Message-ID: <e1c9b030-8a6c-4aba-8bdd-853113bef396@quicinc.com>
Date: Thu, 6 Feb 2025 15:46:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
References: <d410576f-2fc7-4de1-af51-29fbe8b14948@quicinc.com>
 <20250115130359.138890-1-jtornosm@redhat.com>
 <748a5a75-1385-4691-85c1-e9cc5eb4ffc2@oss.qualcomm.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <748a5a75-1385-4691-85c1-e9cc5eb4ffc2@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qHhCslNjS-S32Lq3iWcKAEj-ISPFHeXz
X-Proofpoint-ORIG-GUID: qHhCslNjS-S32Lq3iWcKAEj-ISPFHeXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=420
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502060063



On 1/16/2025 8:31 AM, Jeff Johnson wrote:

> Kalle, can you review? You currently have this deferred in patchwork:
> https://patchwork.kernel.org/project/linux-wireless/patch/20240829064420.3074140-1-quic_yuzha@quicinc.com/
> 
> /jeff
> 
Jeff, can you help with this because Kallo has stepped down?


/Yuriy

