Return-Path: <linux-wireless+bounces-15494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D679D1FE2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 07:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF81281747
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 06:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDBB2A1B2;
	Tue, 19 Nov 2024 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XyhX0yJr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A24E571
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996235; cv=none; b=RO3LDc8r9QbdUXToTLmXksFCrM7rK7YVbEw9KmuAW2SkHryNxTzj8yg0fN1v0aVSpRgOK7YUX3ukwpycx0Cv3Fi94Mdzrfe3coFnq2hWCJ1/W4btuWF5xYY7yUYmYXYWOgOeWSQHTNBnDFmRcVXGXbqFfB58emLcyvgEgina1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996235; c=relaxed/simple;
	bh=WFtv3S2Rg68JR/cUwK/IMaE5VWECjD4K1favobAaTYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hDC3jbb8sPy6xmAthzf/WMGC0EZZw4MuVLsWANDRNxlU1Dohpd5S7yl5js1RMMqxEoUey3SgnacTNBPdOHFhlgdrb80nBBs/1jQc90CLCT0k1WbjHZgsLd8Qd0xeKBynV/1nAi6dvaHfLW5BwKdeRHAGzhyZ84dHHuA4PimnLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XyhX0yJr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGmpQ022573;
	Tue, 19 Nov 2024 06:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vd2i0mc7oHmZtB2xS+vFO942LWpCGp6OskiHtaEXutw=; b=XyhX0yJrDM+0ATUE
	cFDUTNGhV7CJG4rixT42pngVSQDo5szUOQBTLUTg9k//4qB6saTM8IEm3pUSB1D8
	gpeX+Yl3Jm0Wt3bWKyBy2NepK9PiL/669M5NcjNOEYNUq1AtBMfMr2HnTB8NcaS4
	ZP0+X/D5V4lhM2p8Xukhfgk2ZgAEb5yKahiYJug6rTRNBz77QSK0W1G68W5CsCjO
	ebbh9bPD+Q+n2xBIuo0XhUgN4KC/dz9DIBmuBBoOu8xPWSrebM+xh9dXmtnhNLWy
	zdUmz4VbxCHhMJFxTmSfp3nmVAknqVhKvc5w3koK/lsIf4lEwE2Y5IeWlYOuRlrr
	Cw+DOw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y61j1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ63pZM001691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 06:03:51 GMT
Received: from [10.111.176.82] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 22:03:51 -0800
Message-ID: <59a3c17c-2262-4276-bb5b-a1432956fd98@quicinc.com>
Date: Mon, 18 Nov 2024 22:03:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] wifi: ath12k: fix incorrect TID updation in DP
 monitor status path
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
 <20241119003248.1579567-6-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241119003248.1579567-6-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LW6bK29596fo58N_P3AZagWCDg15tiyB
X-Proofpoint-ORIG-GUID: LW6bK29596fo58N_P3AZagWCDg15tiyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=575 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190044

On 11/18/2024 4:32 PM, Karthikeyan Periyasamy wrote:
> Currently, an incorrect TID value gets populated in the monitor status Rx
> path due to an incorrect bitmap value given to the ffs() built-in helper
> function. Therefore, avoid the decrement and directly provide the TID
> bitmap to the ffs() built-in helper function for the correct TID update
> in the monitor status Rx path.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


