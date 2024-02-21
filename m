Return-Path: <linux-wireless+bounces-3865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1885E2E1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 17:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEDA1F2570A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986E8061A;
	Wed, 21 Feb 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hGEmeeAd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3807CF0F
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532278; cv=none; b=idgCrfKC59PcVAeouja3G0cgvsxei57/P5w6BJNMH3ODPPTavWL8k5RNWJpK7YiCWjUulQWaELugd8Y0XA9MQS4Ivs0/c5pBoKu5MjoM7TlwNE4m666aIhAaWsIaA9tZ9m9lZaQknQzw3wk+TQPn7kpCGYr0qRHdUDQeWT0j7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532278; c=relaxed/simple;
	bh=i1+fsmKeLXBz1NmSofkiKFOo+G/xzTx6f7QFa2/36IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LgqGP2nNOnK1mfTpIgVxVRbVmCh84phx8LnDdnVRkwcBseJ06+qWwEL/4Bv6jwZaOddlQ7ywpe0dWQWLYgG1guiHSetX4sc/+phtRf0txzEFyScWClQyKHoAksPBf7wpUdGRyefMxFbFVG86T25s1ZUkYVJ5NxDRKuhs7OCs/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hGEmeeAd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LCTQn9023911;
	Wed, 21 Feb 2024 16:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=E9x7Uwhdmnd48TDUfR/CdE7qrVONSVhDZQKKQRCQd8E=; b=hG
	EmeeAdw9P2yHpwqtLv7o/jcUmKH7TE6A+EWeF+GvZGdb00/TxYm6heccr5iKS4mi
	AUZzoKOTmwcrPeE1FcgC1Z447Seecctn0KDnD0jFh3GXJib9B3UBFu1H7b6tnmTm
	uG12KSpoa9GeHsJrrQK2hr0lSiGq34lgcyrYcaid/LL0UQA1z8mfkN9wHHqty4ZA
	GwBPSIwsgCdk5hsk/I2ksh+9LPR7SrecNM5KRnIb2A5aP/g2+fiImiDCkaW6Kkhv
	1PCaDC4unJvnu7FImti80CqZQwxudJelTGhesDj8AhB66oFdqihDjxuV+fGYdSj7
	h4Qz0CxM5KRWy77kt/aQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21s2fgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 16:17:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LGHsX0017171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 16:17:54 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 08:17:54 -0800
Message-ID: <cdec81ec-0ae1-4bb2-90f4-25a4a4c2b54d@quicinc.com>
Date: Wed, 21 Feb 2024 08:17:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: report signal for iw dev xxx station dump
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240219111417.1185-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240219111417.1185-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yFgbsa2aWVR9MsVkvyiFeUwAd61bmIKU
X-Proofpoint-GUID: yFgbsa2aWVR9MsVkvyiFeUwAd61bmIKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_03,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=925 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210126

On 2/19/2024 3:14 AM, Lingbo Kong wrote:
> The signal of "iw dev xxx station dump" always show 0 dBm. This is because
> currently signal is only set in ath12k_mgmt_rx_event function, and not set
> for rx data packet. So, change to get signal from firmware and report to
> mac80211.
> 
> After that, "iw dev xxx station dump" show the correct signal such as:
> signal: -50 dBm
> signal: -49 dBm
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


