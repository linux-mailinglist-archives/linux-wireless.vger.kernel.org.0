Return-Path: <linux-wireless+bounces-8805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DAA904236
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 19:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35602B24A25
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8CF4207A;
	Tue, 11 Jun 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ItfPAEjJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3340C03
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126048; cv=none; b=T4CplYyNotAIDqA6ygVbWSfSc8WAqdB7h/n62kk914aLc6GPZlO6BLxXwfkSxZXgGHWD/yCqBOm6VhKvYeemm8kBmF9d7MYVxkMSz5oAqaNJIDKi0hOg+3901RU/uchUoSplnyVoQiCse+BtarX6KEhHGBr7zy0MCcwVtUzhIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126048; c=relaxed/simple;
	bh=EorPrFsmXR219LVxhsI82XAjT/nA88Gye3vKyGsSps8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bE+hJAtyaktotzbWf40wXqOaQTPv0q1xeYkrl+tU5TnQRuzGI/n9txpCOP+oNjkWlSrnh1Rn2pJr/g56J5GHRd5GUDytb99NWyQ+XGpu4jb2T1699GhBRXFZdNeOPRETWngfdDi2l9LjpHrlKTyGn56/JuWj9KfigMgo3gv9eec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ItfPAEjJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B9bSmv012356;
	Tue, 11 Jun 2024 17:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wPIOMg+8Ni/e1WHiurLDQPppp2nzp6bXSCsbyFa49Bc=; b=ItfPAEjJ4ZMp0dtQ
	6bR3bVt8SQc3JLXdEykeWsXQE1ncZFxABvLycjatQqBehSo9vGX1JK5n4MEfHsiw
	GXilUe+h5mSOopTpcmQ0ghKR/iF6WFAIHJwGFQVFrBZKPVtwjnqTeCtlDId5juUr
	WlfzSrhrhZ+G1CgGGSf24H/ku66Bfvct2xG4SGDLNudIfQ/G+RSTxwatfGrxsFNB
	V4SqyQRbv6ppmgWEnanz4ayC4bqAhgOW7ls8YiCfWQ2onMAlnOxwSUbmClTtaqF7
	AQp6hw/Q7vLYD2w/cV5MeTWl5ifBTgDVRZGxjCkfloUhedpM6rsDwc42J+nk5r68
	RCObmA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypm459691-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 17:14:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BHDxgi027778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 17:13:59 GMT
Received: from [10.48.243.20] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 10:13:58 -0700
Message-ID: <1a7c7a49-f6e2-46c8-b198-e9f764b26003@quicinc.com>
Date: Tue, 11 Jun 2024 10:13:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix pdev id sent to firmware for single phy
 devices
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Lingbo Kong <quic_lingbok@quicinc.com>
References: <20240611043342.2672998-1-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240611043342.2672998-1-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UpYQlgRrel3RwRdSDJ1jN_fhrm5Oj3VS
X-Proofpoint-ORIG-GUID: UpYQlgRrel3RwRdSDJ1jN_fhrm5Oj3VS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=954 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110119

On 6/10/2024 9:33 PM, Ramya Gnanasekar wrote:
> From: Lingbo Kong <quic_lingbok@quicinc.com>
> 
> Pdev id from mac phy capabilities will be sent as a part of
> HTT/WMI command to firmware. This causes issue with single pdev
> devices where firmware does not respond to the WMI/HTT request
> sent from host.
> 
> For single pdev devices firmware expects pdev id as 1 for 5 GHz/6 GHz
> phy and 2 for 2 GHz band. Add wrapper ath12k_mac_get_target_pdev_id()
> to help fetch right pdev for single pdev devices.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


