Return-Path: <linux-wireless+bounces-17286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7AFA08718
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 06:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82CC3A6D31
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3C746E;
	Fri, 10 Jan 2025 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hFLXBVNy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E32066E8
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488744; cv=none; b=eUPt2g4YKQ1nkgy/uTPWMmieZDrxlX3kFTqaz7AlJr9wfwCx6A2UghBhB10Nac5uanLdz0tEyLE3Rti5uBVxfUHFinO7sZdCJ78aakt/2tx5thdCkr1shrhMbcr5YxJfWYIiZ6YU5i96a52CW8bZNaIb2HKPGRH84Dc4X+JkHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488744; c=relaxed/simple;
	bh=aza7kyBwbBCdjoC943yJlin/q2ds1xJIVmd7zulcqFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JzQ6pz8tKkvKT0PfAZw/05eELb92FpYATyNexH7mGWsftFeBxecJRnsDN5ck6cMPRam5lrOFk/qgYF79SlcdBFH15xy71VbUXDzyq3v0Tgclfa1eTwuPV3ovcjwJz/AK8HPbWXa7y8H7bVjVuJ3JF/YGW+fT4SEUFGzvEO7wq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hFLXBVNy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509JqgMn009189;
	Fri, 10 Jan 2025 05:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LChIw8KttW8ns5e7/XjPKfY98d85EMV7RattVzpNTN0=; b=hFLXBVNyrL6eWlAZ
	XWG+U+uEGeJdly7fSVqACFtSElqtGN3FTMzuLwrpt5C+4Ro/O10f0cXY4YqLEqnz
	Q64XniHLnoQXktrT/w6cLS1lzNuHZNFVai9SEJwKbiOHJti++YZwDQPDrczjt/l/
	ip+KkCgg+CRFawSvSAaXo94RRYoibN61zRoesqHf4rjY9eqoQCnBThqCHSLjzSm7
	wPiWq6U5RSYQXEEqFBigoefVU+0uv+HRbkoOe7XLnahCWx7qRbKfkIf4mSHjXgy7
	SIrkmQmpVgD01nKtXsE448FXKO4htjK2m9izAM35RuIX4cckwLiQDXcUB4EL7peA
	J3W/aw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442n0gh46c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 05:58:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A5wvee026173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 05:58:57 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 Jan 2025
 21:58:55 -0800
Message-ID: <2db99d33-039b-4a71-9bc3-29d15d8c602e@quicinc.com>
Date: Fri, 10 Jan 2025 11:28:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] wifi: ath12k: Disable MLO in Factory Test Mode
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
 <20250109183551.1028791-6-quic_aarasahu@quicinc.com>
 <dea8d952-92df-4a7c-9622-288921b23332@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <dea8d952-92df-4a7c-9622-288921b23332@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YxW2J94IB-yf9s9f0degfV5VgYoJzJi8
X-Proofpoint-GUID: YxW2J94IB-yf9s9f0degfV5VgYoJzJi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=685 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100047



On 1/10/2025 2:30 AM, Jeff Johnson wrote:
> On 1/9/2025 10:35 AM, Aaradhana Sahu wrote:
>> Factory test mode(FTM) is supported only non-mlo(multi-link operation)
> 
> only *in* non-mlo...?
> 
> and s/-mlo/-MLO/
> 
Sure, will address in the next version.

>> mode. Therefore, disable MLO when driver boots in FTM mode.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> 


