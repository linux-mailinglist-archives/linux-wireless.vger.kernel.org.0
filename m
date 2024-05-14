Return-Path: <linux-wireless+bounces-7621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3818C4A50
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 02:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CC0283088
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 00:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA94428;
	Tue, 14 May 2024 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fU0f6hob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF24685
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644919; cv=none; b=OVKr6R6LL4jUr92ZG4Xh5RMqbErkoLRxtpt6sGuluZfTzp3RVBUo1fW5iJCiABBEQ5Kt+kkSBFPUk6dZjmjmekF9xkKOp9V2eEApNYbwT/1hN9FPvoh7DFlWPWjcYeOegrdDH+EmbUXxQvSdS2Q9JExZ2U3lu87+uqsJ1W1/Ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644919; c=relaxed/simple;
	bh=FHbor0MxlqBOQ2rtIVJI+r44wmGb+puNxvziw7yAjWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lOMkuxjQkyRBOOMTMwv3xAqYLav0ckeGnrAgxhrqDY6p6a1zRui8lQjxXt5MnEPNdazzlOibn/qehWnHoovXGB2GURjE7dhu6CY/dbSogx6mkXqYbSQxvYlqt4AkPYvrIvGZGWAjVD0qF5KAQNV9Ctw42wpOHMn96/q3IeoP3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fU0f6hob; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8dj4028184;
	Tue, 14 May 2024 00:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0p+3L3wuKLgo0Zg9c+NoQ8x9UGkQvWYzBrSdRn4wVtw=; b=fU
	0f6hobg1Dfu4SLH53UyR+WF2QNkQE7lt14sjVR2HldNFGtwPUCH3e529fnXLXqzM
	NiHVctjW5kPJws6fVDzfEK5l6GuAG0KGTOCEPhdbo7cnTri1Ql8gaHP9yTkcgrBo
	BsIdz8jDmkiqGx0xJU0awwWZZkzxAss6Aws8F10Yn1XHjltDh2NH659erJC5aB+p
	FsDYRlw37bdiHQk5V/YD5kh1Jy8gFbyB/+NOUiKmrpt4nk+M78aeJGwrlGvEzMYC
	rYWRN4g/QWN572uJTfJ1iUpSzDwtHEW9tFRQ7NdyNmeHTnmtCwwMhjMmE2UopCCc
	dHzVZasohTuxChG1ACgA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1yp5cusx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 00:01:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44E01nhk028044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 00:01:50 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 17:01:49 -0700
Message-ID: <41dd47b4-a1cc-48f5-a91a-1d64150d8c98@quicinc.com>
Date: Mon, 13 May 2024 17:01:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix the issue that calculation of ack
 signal strength
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240511030917.65811-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240511030917.65811-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r-CuHeEwXgR3_csFCe2Yj6cDOOKU46OC
X-Proofpoint-ORIG-GUID: r-CuHeEwXgR3_csFCe2Yj6cDOOKU46OC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130165

On 5/10/2024 8:09 PM, Lingbo Kong wrote:

Your subject doesn't quite make sense.

Perhaps something like: fix ack signal strength calculation

> Currently, the calculation of ack signal strength is incorrect.
> 
> This is because before calculating the ack signal strength, ath12k need
> to determine whether the hardware and firmware support db2dbm, if the

please split this run-on sentence, s/, if/. If/

> hardware and firmware support db2dbm, do not need to add noise floor,
> otherwise, need to add noise floor.
> 
> Besides, the value of ack_rssi passed by firmware to ath12k should be a
> signed number, so change its type to s8.
> 
> This patch affects QCN9274 and WCN7850 because they have the same issue.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

Code LGTM & Kalle can fix my comments in pending so don't respin unless there
are additional comments.

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


