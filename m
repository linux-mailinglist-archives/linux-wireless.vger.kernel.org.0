Return-Path: <linux-wireless+bounces-10309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBC09340CC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 18:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400BC281BFF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D621802AC;
	Wed, 17 Jul 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DQTPAB/1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435801822EB
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235178; cv=none; b=kXWSNlETljaVdvQlFFpw0lOmK7PkNLifVrqh8gW+4bS11BuOLmraLBKe/wqc6pek3WhfiRmPvL0StKKdkp8G+7K9G93Izv+GkQH/ToJrCasoaUDilKIkfw7tZG8JfkbWcjRA8HLs7/ngGQm3+jEzTzXx2Okb8My+fWmg9V5VROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235178; c=relaxed/simple;
	bh=4YAAeUJ0X4XhOo1PzqdO4ZVupnpx8Eybs7xvZRl6Myc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=paL7OXB0XDLv0OB1xzpjZB/gPZ8IqQXnZs5gt0pf+7RyvgWUeWiH/NTGS4QdsqFYru/lbGCol9qR3V/nIutDB7B7+xZXKviGp8wfeN1sYDhZmOfYi1Vz1zBk1cfhK8PR6ky1tFBDotnSW8KXyXxnNPrmckU/+B3i/V5myM5edEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DQTPAB/1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFU1Ms026964;
	Wed, 17 Jul 2024 16:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	45UmRJ7ZHy7SA4EUjFm8uA/DrWJ2ETjmEUjhHjfDFTI=; b=DQTPAB/15bAA0DY/
	CeA6MY1lj16gMiQBFTHG52e01Or6pclr5oio0XUwKAYymk+kN/e0Bz+5BSBjJ6Gd
	3lddAenIuGNlzHnxfrq1MASpUJwTDEhXDO9++aATxtiYGIGBzpPXeArOJowOfaia
	s2M83FtLX7ktYmzdjWNGW40jGbxXlHclgN/cVDIHy/EWd8m2jPgDJIos6ynbl+Ps
	gIAaCPyokTIpiSjGE3PbyV7qAmZGeMyDxaVBXqelQbS2hM3XH/c0qL1VR1zlTRAy
	kgthhLu7PFWN9mhX0joZR0XbsXbU+X7pqnSqXoKeyCkSA/ZAOehJhk1tiirHSMbU
	gqzvDQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs372w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 16:52:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HGqrwD009409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 16:52:53 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 09:52:53 -0700
Message-ID: <09528d9c-589a-470f-974a-b6f617a35d98@quicinc.com>
Date: Wed, 17 Jul 2024 09:52:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath12k: Add support for reading variant from
 ACPI to download board data file
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240717111023.78798-1-quic_lingbok@quicinc.com>
 <20240717111023.78798-5-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240717111023.78798-5-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -aezhsWpaP1GohegOT1WkokjjPDN96CF
X-Proofpoint-GUID: -aezhsWpaP1GohegOT1WkokjjPDN96CF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=991
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170128

On 7/17/2024 4:10 AM, Lingbo Kong wrote:
> Currently, ath12k does not support reading variant from ACPI board data
> filename extension for downloading board data file.
> 
> To address this issue, obtain the string of the ACPI data filename
> extension and use it as part of the string to search for the board data
> file from board-2.bin.
> 
> This patch will not affect QCN9274, because only WCN7850 supports ACPI.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


