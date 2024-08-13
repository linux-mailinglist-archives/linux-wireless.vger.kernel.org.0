Return-Path: <linux-wireless+bounces-11363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31108950AC4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 18:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0C528344C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086E54918;
	Tue, 13 Aug 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oIYqKGWY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225E1A0AF8
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567851; cv=none; b=V//8oIoRJIX4oSlNHEzmRPDr/k3dxsXmAPFHDkoyzR6HIkaIxtkPK8obH2Ae+Et0cO1JnbUbC113IqC2s7oAVVrs0lupTaqesAAcQ/z16YD4K+MjNJigJ0npsZ+me9JeZG6suzylSESss2mKgK/Wz9nEGl0mZcXEiht5FVO7oX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567851; c=relaxed/simple;
	bh=RAJfX7VYMNlM7hkp91e6Z3t31twcdZsHwNm21QsuusI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ns0C4Wv7OZKYDkWkhEpikIfbdmaLrZrJDpMLtkqA7TLTCWoh53NKC6aOMe96R5CDReUPqh+MXvEHA2xN1GOnkR4glVA43bRitpsBd8iKG6roC7hcpQV7JuCpr5SPOhxSpI7KwNL7f/WbdXAaSiKoPLYRLMPacjmJOfYUiSZOOME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oIYqKGWY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D8XcEG026755;
	Tue, 13 Aug 2024 16:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yZyl0ss7hN0dncjsV7SHeskTqvKebsx4Y75PnvEeqgY=; b=oIYqKGWYioHSQq13
	8bzPJTAgbjm2AUiUZx4EM0aT/q4C44qMZEBXObqBVcrnY/RvyaUPhWf5JoVQN72J
	6pzUXW9z5GbvpyAyjAUu1jeffsMj/h6WxsqOwmQ6EBSq9yeKsHAOhfNRsSKWDOhM
	sPsA26IMMNKMWGSnfHlE20LcFevHqnijLvhxxLsO/VGDmYeUJVppkEbAyvNJxS8G
	g2pmIPI/tEKA7FDyP9dBIIqKiHX+E3ZgsGkqOm+KRgLY61tgOVkhrTvzJlSoapnX
	DVH8dJ7afUovIMiHEmHHSR4E26CWRWC9zteRKe5Xv+JzFFdW5uBeWafbunLgqlWy
	8q+ysQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410437sq5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 16:50:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DGogiY008191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 16:50:42 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 09:50:42 -0700
Message-ID: <a56cc437-ace0-4121-93be-528d11c1f670@quicinc.com>
Date: Tue, 13 Aug 2024 09:50:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wifi: ath12k: Add support for obtaining the buffer
 type ACPI function bitmap
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240809025055.6495-1-quic_lingbok@quicinc.com>
 <20240809025055.6495-2-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240809025055.6495-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nUQ9X8rmny5keBIgVsCKSfA7VQjlATX7
X-Proofpoint-GUID: nUQ9X8rmny5keBIgVsCKSfA7VQjlATX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=629 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130123

On 8/8/2024 7:50 PM, Lingbo Kong wrote:
> Currently, ath12k does not support obtaining the buffer type ACPI function
> bitmap.
> 
> To solve this issue, change the code to support obtaining the buffer type
> ACPI function bitmap.
> 
> This patch will not affect QCN9274, because only WCN7850 supports ACPI.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
> v2:
> no change

I acked v1 and since there were no changes you should have carried forward my
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


