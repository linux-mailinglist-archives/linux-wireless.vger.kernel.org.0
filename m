Return-Path: <linux-wireless+bounces-5718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550DB8942B2
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107002834F4
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F1433DA;
	Mon,  1 Apr 2024 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V8ycbgtE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C747A6B
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990513; cv=none; b=jSQ6XQtGBqkZiBVL84A4cQ6A41XXXK2XKLhWNVvcrSCd0OPAIPcNlRu8JRrc+F2ABlVcVJuL4JoiyxqOp5xaOCeOOkoIhKT5OEotBUqpWJ1spq1SQTcBbSz9+wYK6EQLJAcq+fCcXtf/C2Md7wTCX0PSL1vfbhD6LJ59ZT+IGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990513; c=relaxed/simple;
	bh=sgAmGH0zpExkDhXZSifth2AQja4dhW6MeDK+S5ryObg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=efDxcnnnyV4onK6pS5AeTZLPMpH5nWp86E6CaRndAF60Qh2CR6vutBXlny8nGNFxwVG2aCbO0a5s1m81RfnwjiVcSjzeNnMkJzi2ElRWCXD0iNZrGx8Y9wsuYcZaqRr3hF1TJT0nNhHlivCmvtzpyisoOiy6Hvx8WauVy3VBPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V8ycbgtE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431EUNEo014622;
	Mon, 1 Apr 2024 16:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PpQJmMRKfh+QzPsk0u/o9f0HYEYPHnrdCl/XGINJWAo=; b=V8
	ycbgtEuygKT6/lp2w1gbg49PB1wP4DDyG7BTU7Z3zjOGHsK9pqGLYyIMrpcEJy3W
	F9eH+PCvFyA5bITAY1Sv+oFE9WxQhHJBwZasEYxXg3RHTQ+1LVUH9GfxMnlNXvxd
	T10W49dc8Fcvd1rSFobFM9d5OBWwYSVp0pbCp+yuMnSwXl9o/AGUo0UWwVjKD+Ri
	kZ6T+nSd2CDdpp37WsDcmHQ6cs+w11D6JdgeqVcbOJcipq+Nqg+2NUQ/i2pVi0kw
	JsZd+ZDZGYbxWEpDAV7zKmQUWtxqNR0/6oArA172g6A3pRbzlrUeGSF/O79D++K/
	CkoFOvQ/XS71THUoKC/A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7nbq1fes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 16:55:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431Gt0Zh032512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 16:55:00 GMT
Received: from [10.110.126.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 09:54:59 -0700
Message-ID: <f17ab010-5874-495a-8bd8-3e18e85cc327@quicinc.com>
Date: Mon, 1 Apr 2024 09:54:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: extend the link capable flag
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240329012358.2242354-1-quic_periyasa@quicinc.com>
 <20240329012358.2242354-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329012358.2242354-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r0buV9fgo2rzxWOZxcPBrrILLDrkVjui
X-Proofpoint-GUID: r0buV9fgo2rzxWOZxcPBrrILLDrkVjui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_11,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxlogscore=691 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010117

On 3/28/2024 6:23 PM, Karthikeyan Periyasamy wrote:
> Link capability categorized as Single Link Operation (SLO) and Multi Link
> Operation (MLO).
> 
> 	* Intra-chip SLO/MLO refers to links present within a chip
> 	* Inter-chip SLO/MLO refers to links present across multiple chips

Is "chip" the correct term?

I'm thinking that this should be called "device" since that is the unit of
hardware that is detected by a bus probe function and which is handled by a
*device* driver.

Doesn't this make more sense if the references to chip and SoC are changed to
device?


