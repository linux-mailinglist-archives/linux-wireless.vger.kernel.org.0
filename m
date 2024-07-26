Return-Path: <linux-wireless+bounces-10532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3593CBFF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 02:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05B5281E86
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF3563C;
	Fri, 26 Jul 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eCKR4Qwc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE247F8
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953075; cv=none; b=AnOfVJ4pLOFcWTqIy09TqEfXNCGv6zdg8t8JLDz9sh0HzsDWOhgarTJTj+iUoE7iaNjFvilKakeEG5JbcBUPLV9Cnb1N4Xx5uaLYHtl786ADoj6Qs7bag7zIJ2+4VTgfzoMsXu0HtPu2kMB5eYp/DcNYNGE9bs8y3nMECkJXJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953075; c=relaxed/simple;
	bh=OR7bSpivgcW8IEc2izBNWkT1xOnD6c0+eoiWPERcfHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HT16fQSTm/Fn74oWk7ctN+WRG7SoOvAq2fHNKvgXrwZ69FlGCJSL8qMcOM5ila5So3lfAnQRc9c0OiGhArSBJA10Fdwf/tyJueDHrlGXfj29Sw3trLTZ8oU0nQJv+i8XTdPEbiLAq9HGsk4ntPvX9veWAbmdTKZyynj55e5Rjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eCKR4Qwc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PIT9vF009618;
	Fri, 26 Jul 2024 00:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cG9KWa1wdQLaC5sCJvbaWfturi+BCPkIuJYi/Z9JCx8=; b=eCKR4QwcVTw3Sm4u
	MRoBPy5IWJxdFO7emOD/XTYMhOLftJhfu/zAtoQG97gzBz4gJlWapNsyJ00xiTHR
	fI9xOBOEG6r26hj6z5eLtb892r54Bp0UVbGeEAmMZK8GYKPgIfvXZECBMYze9rvX
	OfoYItLcjcqG/tDczXAGTUtOyCMxF35qSuY7aJaeafDykvGhAS8F1iZ91OsZgUc/
	3d1We58ShBjxvsJ9gXUvGTqt97YkRazF8sOVFNAwW1BW2vnTST6CXwe7vOo+AcLB
	SWN42fEgzsLFf/9qafIVUYwWlmW5BMSYQqlij7w7ZESXb4ioIDqUQiNCrywJyFvh
	IrNOvw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g2xepnsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:17:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q0HoZE031071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:17:50 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 17:17:50 -0700
Message-ID: <aa2b6791-9d18-479b-a80d-722b99592cb8@quicinc.com>
Date: Thu, 25 Jul 2024 17:17:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] wifi: ath12k: fix struct hal_rx_ppdu_start
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-5-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240725120035.493-5-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8b83TGouQIE3PiZEexulhNdkTd8HQUPJ
X-Proofpoint-ORIG-GUID: 8b83TGouQIE3PiZEexulhNdkTd8HQUPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_26,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=564 mlxscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260000

On 7/25/2024 5:00 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> Current struct hal_rx_ppdu_start in hal_rx.h is not matched with
> hardware descriptor definition.
> 
> So update this structure and related code.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>


