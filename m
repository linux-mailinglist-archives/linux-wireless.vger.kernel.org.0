Return-Path: <linux-wireless+bounces-8444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B488FA57F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 00:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED704285D20
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CEF13C67C;
	Mon,  3 Jun 2024 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yq6yzZqL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF4522E
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453487; cv=none; b=mo0hs/H8uYhZHX0UY4VtP07qwX2eAdN3XlAZk5zA7D8/fufIZ2pJfO1C+WDVYULT3clCHfQ6KiYjCC126H8tBKfLbPX57L6zhW7gmK/tsLAtiP8FE5srsB4IaSwfa5rzDYD873WAeoG5wF/BjnR5a21H1act/jzdVfN9cQQ+e94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453487; c=relaxed/simple;
	bh=N8e/yMkwlNbq08iUVbSkIeUZeGxAR/o+lESvv783AHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I7/k41Xy/G9LVS0yo1lNgmuH5Dbvs5UfcLUintu5rBMAGIEowp/n0o3c0ROHBcptQK0Nrw9CLsR6NDPzPGXBl89KHALm3QweiCerlY2ro0D0IUJZwmK02I2fIq3KNS7PAMVEIe8Kvm2zMcVOW0SbUo/6P5jD6fFVhSqNODXhQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yq6yzZqL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4539idHX001552;
	Mon, 3 Jun 2024 22:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uV/FB74EP5eG4K3nGtvG1ZTzcf1gJqClFk0MjUwpj9Q=; b=Yq6yzZqLUi5h3MWY
	0Bt2Ftz6Jt/1r5Q9bXCsCKsPdLSsLFLi70hKjjFNmI7/sJocxT45EgzGzQz7Uhc3
	jTZneduhWUWxjSG7jAXoECIwmZLX4B6wzcDIlt2OJQH929jru8EiFWMW6+V1dUzs
	gBD+BF2eJrzCRT73deu6rgiF7j1Mh4jcAQzbiIho+6Rt/qb94lWc70adBQLUNMRN
	jFTCQ6gh+KXY06n+KqI381YycPvE7Df7Nx2aXVR3QsxF0cx3nrH2S4KXW3qjHHdK
	W1EX1sA/6rRXn5S7FJwaW2TG+XE9vWUjTVxALWcjw2Gg40W0TjzDZOCikIcpu/lm
	4DVU7A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6v59va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 22:24:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453MOg0p002995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 22:24:42 GMT
Received: from [10.48.241.139] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 15:24:42 -0700
Message-ID: <e1bb894a-d324-4c84-9d5b-9ee3282251d6@quicinc.com>
Date: Mon, 3 Jun 2024 15:24:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] wifi: ath12k: Fix Pdev id in HTT stats request for
 WCN7850
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Lingbo Kong <quic_lingbok@quicinc.com>
References: <20240603044214.960261-1-quic_rgnanase@quicinc.com>
 <20240603044214.960261-4-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240603044214.960261-4-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sQLwg2_6MttpmyN78bQ_NB1U_5kz9NJN
X-Proofpoint-ORIG-GUID: sQLwg2_6MttpmyN78bQ_NB1U_5kz9NJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxlogscore=950 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406030181

On 6/2/2024 9:42 PM, Ramya Gnanasekar wrote:
> From: Lingbo Kong <quic_lingbok@quicinc.com>
> 
> Pdev id from mac phy capabilities will be sent as a part of
> HTT stats request to firmware. This causes issue with single pdev
> devices where fimrware does not respond to the stats request
> sent from host.
> 
> Single pdev devices firmware expects pdev id as 1 for 5GHz/6GHz
> phy and 2 for 2GHz band. Handle pdev id for single phy device
> while sending HTT stats request message to firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



