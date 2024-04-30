Return-Path: <linux-wireless+bounces-7016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEAF8B67B7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 03:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1709CB20C93
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 01:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6120EB;
	Tue, 30 Apr 2024 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A6ruFCLQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4061FB2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441987; cv=none; b=rUuO2Ge26CZujlw3+NgMSPSlrHRtrAIjpYcrnLzaEZQ+L5ztKjXw69dyfHhgWJbZKRuj1tBE+wqMP/n394/doY+4QedONuhvzvebyGtrJFy6ZcoP5bOWy+V+XJvjdMjwN4W0lM+jCPweGNy9hCi+LdqVshb/nZiEdra5iptSavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441987; c=relaxed/simple;
	bh=Lc5IZ4891kf8LASJYASviRH5VNwaczBpSaY7oHkPOkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gP2uoKebpSXQ2Nmn+z71ZtzR3IGPSLVIVWwOG/l66lLGY3S5v0gj09qNRo/yFKFm1VQcqlOEnCmlqtZXKZexw3h2l+fP/UNvr0DjhV3qjO+5YF78BUkuhvzgIZuN+1j6Pw7ryBFXcZczFvsPy2rmQ380QhhF8dMMVuluQza47W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A6ruFCLQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U1mfga017845;
	Tue, 30 Apr 2024 01:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xSH4dJxmE7k6ybyGom73diyPlwqDfNiBHOuHjbUEFvE=; b=A6
	ruFCLQgQuBsSx6gaSw5ooKAT226PY3LWz7zVt1NBE1K5v+62eOZMty52BW0BJj1b
	qNLu6gsWnx4/8a7wIW5AmzQRGj2C1+adbE6RxtnLY0Y9bxmNdyMniH2j+dDQgfZA
	MidedsPt4VD2AZ6TFiQdcpb1hvOYv8icYfaOUs4um1ngTqqLsOoRwz8UuOpz/zXb
	6E/l2rqVZ3KxzalD/4xV3/bBtWMwXS6DB59LzCePBcEanRR6n50S6lXzk6Atf34A
	AYvt9dOscvrGBzwD5PqGjar59Fy5rDKSLeJf6UHnYaeMPbzakVdaSm56+ZZquREl
	yqaoS9BuuinZK1gWsC0w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt5xkcu18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 01:53:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U1r1So003075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 01:53:01 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 18:53:00 -0700
Message-ID: <25474ec7-5302-4db9-a10e-90cedca22b6b@quicinc.com>
Date: Mon, 29 Apr 2024 18:53:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] wifi: ath12k: remove redundant peer delete
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240429081525.983-1-quic_kangyang@quicinc.com>
 <20240429081525.983-5-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240429081525.983-5-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A5p7DKxNvN5VgZvyP0xHwWCGrEl_zJs_
X-Proofpoint-GUID: A5p7DKxNvN5VgZvyP0xHwWCGrEl_zJs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_22,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=753
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300012

On 4/29/2024 1:15 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> Firmware will create internal peer for monitor mode. For host no need to
> do peer create and peer delete.
> 
> So remove related code.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


