Return-Path: <linux-wireless+bounces-9558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D9091707C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 20:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C2528CBE4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009717D88F;
	Tue, 25 Jun 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WfvZmR8n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FF17D353
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341056; cv=none; b=YgVgXf6KgV1q0ebElt1P+zjM1EyzgomzwfaFBtEKXwFa9wNHuFhsAMVeof9en8baPzgkSdzFenDAYjHoHfCBOrCBdefMXdRttZXqqPj0xsgRVWLaWHbEclqfEuKwWTDGLrMFI6epzimV8NJRIGmR53mwXSzqt+SYp1IQnOeUu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341056; c=relaxed/simple;
	bh=CzwwoIHtvI08U824K/bVbJtYhBcm8mtgOcj+tQZRtXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YdgD6JQrBwOhVdyHTCAOmDq++5TgF2NoiWcUTEFPsqxphIVEYXJtrG/gYB9zZTcw9iZZxTQKZGCY3lrw9PywFFINLlTRzNx5pqyk/CWVWxxLab/+CK+mvXXZ9MQOb0WH0LrQFRG8QytdmHOi0PFSRuNlqJtg/lhBeHEj+hEuIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WfvZmR8n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PHHGCV017130;
	Tue, 25 Jun 2024 18:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5wto6Ot276M0oKXTURzqde1PZPMYIsTHzdlXH02mi14=; b=WfvZmR8niIAe6nai
	bXUfTPv8CtxCFUHoqVcyCboHR3YddoQxBEl77fIFu0qEnR7gFLfa/t4d0GlCu3/9
	RqhCmWeA/BWklTMIxwz3Qw0KqwwhWELAVzTeDcGgCSYpfNsQk4GNV+Scffigwhbh
	hn4XCXrFA9V7M5lWPdV5TEPkD8y3WfIbtd09MKNMKeEZxy6Nq9T8PrW0vKopLAnZ
	/D9tkxYlrEr608cS+3EIrTyA4OU5AvFH62YpAG7iKxnzehKmPnTff4fvIuHFI3rR
	lSpJmq6hX6b3RxMd5pPmvnPMJoYIGIGFJJKsE6/OE+DltO8WkqWkvJFBlUVSZTtr
	OCIt5Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqw9f56e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 18:44:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PIi8NT002735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 18:44:08 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 11:44:07 -0700
Message-ID: <9ff83230-6ce0-497d-9427-56036471d648@quicinc.com>
Date: Tue, 25 Jun 2024 11:44:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] wifi: ath12k: Fill pdev id for fw test cmd
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
 <20240624095305.37189-5-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240624095305.37189-5-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NOuBdDpv1qCW_VC321xD7x5eih0XU4ZV
X-Proofpoint-GUID: NOuBdDpv1qCW_VC321xD7x5eih0XU4ZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_13,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=845 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250137

On 6/24/2024 2:53 AM, Aaradhana Sahu wrote:
> From: Rajat Soni <quic_rajson@quicinc.com>
> 
> Currently pdev id is not set properly. That can cause a crash
> if pdev id is not equal to the pdev id when firmware test
> command is run during AP bring up or ping.
> 
> Set pdev id in function ath12k_tm_cmd_wmi to resolve this
> issue.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Co-developed-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


