Return-Path: <linux-wireless+bounces-8485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB938FB65B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 16:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2D11C236E7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3AA846D;
	Tue,  4 Jun 2024 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GFG1IXDL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A3131BDF
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513080; cv=none; b=niBInWcx4FaFrjjlEQ7Ert0/TG9T4mD/cUR9+Y21nodzZt51jJ2vX7z8/Cchs7+uj7Gx+lWZr5O6kF4oFWEQoqpGHv6ZjObLlEYtkyKYbqXlhopgmRNzAYaFAK8NYF9STG7GUNAefRm0Ex1oFAX8sbMLytlcR4iGu02RLNJCcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513080; c=relaxed/simple;
	bh=AkkiSX3gszoEU0pI1IBmk+Z5bgGzlLdv+9+XnZrhd58=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eKgbIBN6JvzsiMrXBjkJScclxzzc3i4nt3J2WwphXqyNgmPJJQYlcZpf7uE3ik6VEU4gLo9tyKba6mfV7keM3nXQF+rwUPxvHDSQBycXnWClDTH6G+nbdoFD9s31kyt+M8AGok3FH4jfzpXLwLKO3WBf9onZ4S5KqgDdINnBJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GFG1IXDL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4549vCWR010196;
	Tue, 4 Jun 2024 14:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vDspf0p2k5q7bRCR/liptApO+/U415+F420jvBbe6lk=; b=GFG1IXDLqsjAgBOk
	iTQuG8k4bE8Ya8oROFEpFz6GMw3WiHHLGKjcpAE5vSLT0qLkvGjmRA2FEGm63Jtm
	lZ+rcAjKv7ydEjokY7FXKkx9lKZMbtC1hk3bYwdmb0JsiqTG0EvkQys3fFQpR7BY
	ooteNyOIWsVrvT8toOAr3jsgslvJ8CK1qwm478sfcnI/dEPAs8wHmFZnZOsHRou5
	fpmvSYzhDRIWC5fnNWz8asnbUShKLI2Ahg8qinY39rhA/sq8Pr2kKfaD5OyfBl9Z
	+4Rd/Bt9BnkIEqrYEItmw8GIGBJuRT0Xu3Y/glf4ojKLN/eGTFQjyUCqRynHyvVq
	ZzxjIQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6v779x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 14:57:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 454EvtnK022802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 14:57:55 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 07:57:55 -0700
Message-ID: <cfea843e-be05-48eb-9a84-c58bdb3b77b1@quicinc.com>
Date: Tue, 4 Jun 2024 07:57:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] wifi: ath12k: support GTK rekey offload
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240604055407.12506-1-quic_bqiang@quicinc.com>
 <20240604055407.12506-8-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240604055407.12506-8-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z4TWxwmAg-W0NAhX5Sm5FIpzPnZZ4cnF
X-Proofpoint-ORIG-GUID: Z4TWxwmAg-W0NAhX5Sm5FIpzPnZZ4cnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxlogscore=662 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406040119

On 6/3/2024 10:54 PM, Baochen Qiang wrote:
> Host sets GTK related info to firmware before WoW is enabled, and
> gets rekey replay_count and then disables GTK rekey when WoW quits.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


