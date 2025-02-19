Return-Path: <linux-wireless+bounces-19119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C673A3B078
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 05:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAEF1897927
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 04:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787F1A7046;
	Wed, 19 Feb 2025 04:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ENtYfQER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604E19AD89
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739940627; cv=none; b=LJZKDGj9GsIbkE3HFmeS/Vh4hFsukuIZgnkVOQRtdZlHQ9/0g/E1YHY+fZ831McjIV5am66In01ftzFv448WMprOFxN/Jw/p20qonO4tHqn14x9xZwif8P1yv7MEiNIFcbDFt3+hBh03mTFaOUiLcctKlmPprqpDph+HANfaNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739940627; c=relaxed/simple;
	bh=w9VHkpfReh8HoHFPgWZsTgsYsyAr+8rLurET5NwJxnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qpll5jjqF1ix4i41AJuZPQobfom4Cr65AGXLiv36Y3LKve3+vpkYYbiHgmh2OZmvZJX2QmCVmot2iqQ0IDHAlRcnaH5H4tcxjUp2Wqa4k3kRMHr2mGTOAT6st+dnotXsCIs6qRAl9Xs7iBybRLyM9SyWQDhBlmfiGQai66iZQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ENtYfQER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIwai8011654;
	Wed, 19 Feb 2025 04:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lLiWWXFslGBx9r4UiWosh5LFHlx3fy9YWoZjc5WRmAo=; b=ENtYfQERCWOgUBKo
	5D6TiYAaE+U76bf8+YrhfHsebe/a9ZT2lzPi3Nd5WmfPUQ3PygITcBZi01bb19OE
	x6lgpg0wb46KCd1xpoAL//lA51+WBK32tZ5HLeZUpp3xwjzLlgKHI2E0lI1daPx4
	ArusGk2/j7D3n7iJlQEah+Ix/kNslj6NoPU/w47YHQ2rb2tfHAq9MpM2iZBd9EPZ
	UXOEqzz3KV+f4vDWTxaYPS/yepr7Xirkj+ka7jWOnmprvuxkNuFp8/YP+xiMcN45
	QSse3QvMKfQpkYPaxK9Ct6fmr7Q0XUVXrCR9v499+a8pMGgLKGD16z/Pg9dC5GBe
	oljHsA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3h76w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 04:50:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51J4oL46005206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 04:50:21 GMT
Received: from [10.216.26.155] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Feb
 2025 20:50:19 -0800
Message-ID: <cc0e1b77-8015-e699-a7db-93b01b0c28d9@quicinc.com>
Date: Wed, 19 Feb 2025 10:20:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 3/4] wifi: ath12k: use correct WMI command to set
 country code for WCN7850
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250212063200.1631-1-quic_kangyang@quicinc.com>
 <20250212063200.1631-4-quic_kangyang@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250212063200.1631-4-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0UqblyqdKoM6qxXzKWu9eFXnR7Db4wwu
X-Proofpoint-GUID: 0UqblyqdKoM6qxXzKWu9eFXnR7Db4wwu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_02,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502190033



On 2/12/2025 12:01 PM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> When userspace try to set country code by NL80211_REGDOM_SET_BY_USER
> hint(like iw reg set XX), it will pass new country code to ath12k.
> Then ath12k will set this new country code to firmware by
> WMI_SET_INIT_COUNTRY_CMDID. But for WCN7850, this WMI command won't
> take effect.
> 
> For AP based chips(QCN92xx), WMI_SET_INIT_COUNTRY_CMDID is the correct
> command. However, for STATION based chips(WCN7850), it need to use
> WMI_SET_CURRENT_COUNTRY_CMDID.
> 
> Add flag current_cc_support in hardware parameters. It is used to
> distinguish AP/STA platform. After that, the firmware will work
> normal and the regulatory feature works well for WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

