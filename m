Return-Path: <linux-wireless+bounces-6336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33A8A5856
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 18:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD39B216B4
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6776982C6C;
	Mon, 15 Apr 2024 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JEhclrWF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19382C63
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200372; cv=none; b=lEsnS4kLI+hB8wjqYU+Dj9DVdVP12AdIA/vLVxYYmR6JDZaQRx4yaHDvnp3FXpe1XJZ1kukAQZBQAgkPSCzzwk4q6HRtlrcO2TW9yTLI6Udg0nVXrRY/MkeLlcINhQ3vn+Vpyv4iYLUFSp06BdjGIpuMajBUgDuriwuU6iM6bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200372; c=relaxed/simple;
	bh=e4T2IFq+zjf5uOy/FLDqaBs3bCNaVx0laIvj8VOx/K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AdCwl0LUDy8bGXAiHrhZ9Kj9Vz7VWV6tqSXGlpZvPFRlGdfBIiD+Th8Y9YmUHU/ec8L5TAoPmagy1dsK5/e/1i9BXwsKYebnDCQdGk8tg8NvTAblEi5ORNgXLuWy99eu9f9hxdRJT/pj76SO7MWjD7GBbPULGgzu1Xo5TFD4/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JEhclrWF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FDx8ZR030999;
	Mon, 15 Apr 2024 16:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3P/WF7aPI6S3uL6q4V3kjgIjsT6cD2PHvJ8GsHpmoBY=; b=JE
	hclrWFZ6wnH5HB3XTs/A0ANL1L/fD+h9i8aqwaHe5TmdeiC64IE3W7W6kiEenj/K
	S9kty8322bLI1ruEF6Xpy7S5eEwcjF6frhAExvJdVAfUBL6u+9a/ZCJwVLKl8NOn
	yAvdYQGMCyDmMi8VngAzgCsjJmOUAknwMYLTLqzUcKCg6X384QiUYXUu828+5O/5
	Lgo/Fw/seGHYPhq17o7Q2Yjq7DT9R16BVl/j9E3PM5VqxlYBDXudKcqFwI4jbHNi
	dVXNOlsOd1PNlrtyiRBUYwaeNn4xhfigQ385PGB9J755W1fnTT+Z2FGqO1YAgYrN
	BsZZ1kYJGMNbZb4JaSgA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh5jx8f65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 16:59:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FGxM1K012205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 16:59:22 GMT
Received: from [10.110.3.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 09:59:22 -0700
Message-ID: <c5080887-6d94-405d-a57b-dae5e6a57721@quicinc.com>
Date: Mon, 15 Apr 2024 09:59:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240411165645.4071238-1-kvalo@kernel.org>
 <e8618364-e547-41e1-b18f-4cddeafd3371@quicinc.com>
 <87h6g2y4jp.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87h6g2y4jp.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fVPRfGot8hFZXB0i8XiWls_e4E6A9yGd
X-Proofpoint-ORIG-GUID: fVPRfGot8hFZXB0i8XiWls_e4E6A9yGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_14,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=476 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404150111

On 4/15/2024 9:27 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> Is there a Ubuntu / Network Manager fix fir this?
> 
> I would hope that Network Manager doesn't use WEXT or especially run the
> iwconfig tool. This is why I suspect that you run iwconfig manually.
> 

I am not running iwconfig manually. I'm simply using the Ubuntu wifi settings
menu to enable Hotspot. So somewhere under the hood Ubuntu/NM is running iwconfig



