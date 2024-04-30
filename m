Return-Path: <linux-wireless+bounces-7073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC50E8B80A7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 21:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276331C22198
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC31836D0;
	Tue, 30 Apr 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vy15H6Hm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298A1836C7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505815; cv=none; b=XD1EijBt7+yIRVgWJJIZ5KXCPVeNPOtYeNoOLD3EUO0h4QMwHhdOMMe2Ltweg+JUb+cul0ESXqjDFyYqp2qep+XK5ajeWIem4H2nxHTgdkxpVu8Ibw/ZkfHYrEq1D2y/SKFB1CGwUIz+ZjTrt8rAAdg/gc82PscOygDNeBZewsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505815; c=relaxed/simple;
	bh=yu811VDEsTMsjX12nzouaaYCvScMiLb+vPu54+PtbMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qmec52WIcd7oyNclXNMVrpscWBGEI+G8fIgMp//RlIX91xBWRrkE1vdLVq5ne1xNB2JzlF9QwYxgWopX7xPWAm0MUw8HgbUrLz1qa2ispurj1kwqVVCznK4OwbIwcrLvu3b+OQxbRS1u9D+rvdusJnlCgFnwzP90aGDqdV+uRj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vy15H6Hm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UHSR4N024955;
	Tue, 30 Apr 2024 19:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MiA6yAP2ZH9bA23s6qYO+VlIsqhXzEKnRQSGeJeXGG8=; b=Vy
	15H6Hm18jqWWxrcwv9oCmEjYd0Yyk5JjlnVpCOwYTRBE271ynaxpLN2moU93vxaz
	0KvR0qagb5c2lgGL0NL+7MUEaLvbCv3lH8QuEjeuLLyikR1+ZcEdM7Q9WKRlKr8r
	WEDSXfBV+IcwEg1j74CQ4ICbPyrxeXDDxFjbX/WJowix71PIj9/mhUbe4NEvkoSI
	DLNh0Ggyz8dNWC7X80JDk4r/LUdZ1xoyGXWi9zOpLzASSQTWAYTnHcm0hlWUjS6S
	0MdjFiDq0CWIbhsaughoTsoJg1ls4mZ6ycbtYtKE06qUSEDJXzLvXzZKbPHQuLzA
	oOiLxija3qhoClAWUNNQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu19912gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:36:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UJajIE001529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:36:45 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 12:36:45 -0700
Message-ID: <d0549b85-bc6e-4732-9558-cc407c876b08@quicinc.com>
Date: Tue, 30 Apr 2024 12:36:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 2/3] wifi: ath12k: Remove unsupported tx monitor
 handling
Content-Language: en-US
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430091414.2486196-1-quic_tamizhr@quicinc.com>
 <20240430091414.2486196-3-quic_tamizhr@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430091414.2486196-3-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ekG29wHsLL51jdL5aOqOVYzyRCXehKT5
X-Proofpoint-GUID: ekG29wHsLL51jdL5aOqOVYzyRCXehKT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=987
 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300140

On 4/30/2024 2:14 AM, Tamizh Chelvam Raja wrote:
> Currently tx monitor is not supported in driver.So remove

nit: add space after .
Kalle can fix this in pending if there isn't a re-spin

> the tx monitor ring configuration, allocation and handling.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


