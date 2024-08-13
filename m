Return-Path: <linux-wireless+bounces-11367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2838E950B22
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7381F234D2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D671A2575;
	Tue, 13 Aug 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QkI07sgh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC201F959
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568758; cv=none; b=Nlbx99R080MCPeMGBKSJncghXWoO55zqVtA48CPDuYbxzE6q8dkURaiMB6X/4ENM/K9tLokDFe/gbJGb53e8D8jJraSYtrXSegkNM/buMhHP5aSuGdWKFP8ArAbgtI09c7GFeljS9LvdjVIE4Ce/uH9LkWpxwG9iQ72zsD0opcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568758; c=relaxed/simple;
	bh=p1NVT6nCxpHzkGkDjRiPmxqgd1Vk3IFMjCHasdXrTBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nb6BOSJuhg5fsM9nPFfBXK2flNDtfHRsqesFFvKHlApOV9WXrvs8XOLkQWmm4sCfYcgbN1VX5uGCKB/jed5P2ZrbbMEYsMNvMZ16eZMyDMaCh6UM84QculqP8WsgOzhUAAPGEYOvJMiKbkfCzrqVOIN03lBTM2x5mkJlP9bwnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QkI07sgh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DH1crP026758;
	Tue, 13 Aug 2024 17:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7DPn4V7xZH3wDuP8mYPCm8T5/CIOvrFsoU8orG75UZY=; b=QkI07sghUWuVcVEB
	KXRJkdFYFMeH/FeQQfpx/ChEZT9bHkz/yd/Bsl3pveilc+4lq4t6PAYE1xx60oZJ
	1gsb+WxV/ZwTTymKoZQzBwqEKPmAry2HV3KWFhWm0uLTbfs+E8sljTOCpiPWkXKF
	pEwQDD5Yk/BGzm3SkkgrvZeMFckrG0/gTX1Rr6dPhrClDcd1d3VubWXR9Ftsi3AE
	jsakImaAbPPAYJH7WJDsTu/gPI/IJ6qMDyV4MCTj75+PO8dM27HGQVhV43+DWFeT
	9cHajJMbMkuIkcTAanMUD1Cs4q9sL3tX+xiaYsMKaKdPaGdRNagQMw+zTqDuYxEP
	spgmqQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410437ss93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 17:05:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DH5qhd008050
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 17:05:52 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 10:05:52 -0700
Message-ID: <53e9f797-5db2-4ab3-9d06-6ae9bf6df29a@quicinc.com>
Date: Tue, 13 Aug 2024 10:05:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: ath12k: Add support for reading variant from
 ACPI to download board data file
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240809025055.6495-1-quic_lingbok@quicinc.com>
 <20240809025055.6495-5-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240809025055.6495-5-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ud8s9hkVFV-8ZVe_QGhhMPqoLvoP17gj
X-Proofpoint-GUID: Ud8s9hkVFV-8ZVe_QGhhMPqoLvoP17gj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130124

On 8/8/2024 7:50 PM, Lingbo Kong wrote:
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


