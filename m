Return-Path: <linux-wireless+bounces-25246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8731B0126B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 06:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEDE4852C4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 04:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD278C91;
	Fri, 11 Jul 2025 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EQX2MHRU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3683FFD
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752209649; cv=none; b=mDueQQd2owihLvmBYlX4tOS+LV1doaTr2jKPmsJtSH7Jg1iqVKmypK+VbZIYJ+l0jtGPTDNrDf/zM/TTKYRUQu2a/EuzSFwDkJ+b8DlNtKDC19MtLhF4NPDRaONXcLcRadm4iMSGDWlY+2neAvJcNIbMP9nyNRYRdmxdRAdx3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752209649; c=relaxed/simple;
	bh=lCRy9buydG1gBLisJ4q3nYIJ836JpgB+/cctXNLrah8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RdQE70dSNZZaqoUts1agsJxVPqeNTV/XbfRq8yaJIafTUGwXuMpgc3YXPT4gYumZlCkfJi7/UCCSKZyFeY/qavbNmaCxsyX3v9kxJ7MIBQuHvir3hcP/C/+cF93E+pnytJGZKE1OJkjxM421z2Lw/H90FDlyUs4cwBE9k0r9FvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EQX2MHRU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B3H0tx017065;
	Fri, 11 Jul 2025 04:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2NGnsBP5CqshXNv+cPv+R/WuRwIErWSfoRCEPx1w4SE=; b=EQX2MHRUmpH4H46N
	ri9bzWh7k2pC3PT/ye5j51+oTaRcDqh2CcVTxUcoe7sBDWZ7X6eU1vL3awJhcU6X
	c2jREGhf5XfKV4yzNUn0QpAtwyAScLNtqTCGjmvLJmUM/o53RgB13tjoEUH0Spq2
	1wrrBY4z61d2LxMJ7gnl69RBP/AOIBLUxXZgnyNl9k8EfdG29oCYXoGxl0KvYe9E
	tEiDGeBUd2kM3LUeU5psVYCDBt+l93tczRjjWOtwZ+DopqwPu/HDuEe6m8+Vk41m
	3mlUIAYa8m6ZyIVnE0rmvzBzLiSG11cnR8GA172yeKO1fsacAh8ThqwKy/a7IIhV
	egJvbw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ttj9r6ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 04:54:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56B4s2i3006913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 04:54:02 GMT
Received: from [10.216.58.181] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 10 Jul
 2025 21:54:00 -0700
Message-ID: <c14abd0b-9f07-50b0-29c2-b7b74892e7d2@quicinc.com>
Date: Fri, 11 Jul 2025 10:23:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Add support to enqueue
 management frame at MLD level
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20250709151954.2601052-1-quic_rdevanat@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250709151954.2601052-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAzMSBTYWx0ZWRfX3rOCVEqYVSxR
 dPXijnhE4eNHkGVdWn/cIGXTKbkNk2leZHb5lxOTPKwGmyeBpbirwAxu8lwpdxetZFMSUqsoLpX
 H18MUlGKr4cBN53qOO5HYVqqYJNVNp3+cl+CDxX95/8gFGcJsr26gwOUvoSiBqhBo8C0LPkgi4l
 ssHh2bbmVRbGmw7FMZ1WyiQdH8TzDhAamU9BIVt5yjhkHtx0PDnqNgG/WE8bNSpNuB+lwafOdDo
 TynaTcAwH2wNDVNa91+rsnjH/ZS85HOa2yaCIieLrXQcMTSL504Qt7NM2CPg7FeDBgDTLgNAzIQ
 ROo4De4bXb/U5L1hC7Qe8O8XbvRNJv6pvD21n/8hdaBZq07kmk73uJX+QuFPBbvy9ROEs3lqi0N
 pEzHvKqxTZXChqq2uqBSgrk3mGK8B33AucnCHH408FQ2eNa9s5JJuubguqC0WDxNrr92FnwN
X-Proofpoint-ORIG-GUID: m8P6F7q_b18XyCYKW3FDMFVSTshuI7Mi
X-Authority-Analysis: v=2.4 cv=Gu1C+l1C c=1 sm=1 tr=0 ts=687098eb cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=7ZWk5FXIFxzhtYbW22wA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: m8P6F7q_b18XyCYKW3FDMFVSTshuI7Mi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110031



On 7/9/2025 8:49 PM, Roopni Devanathan wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> A multi-link client can use any link for transmissions. It can decide to
> put one link in power save mode for longer periods while listening on the
> other links as per MLD listen interval. Unicast management frames sent to
> that link station might get dropped if that link station is in power save
> mode or inactive. In such cases, firmware can take decision on which link
> to use.
> 
> Allow the firmware to decide on which link management frame should be
> sent on, by filling the hardware link with maximum value of u32, so that
> the firmware will not have a specific link to transmit data on and so
> the management frames will be link agnostic. For QCN devices, all action
> frames are marked as link agnostic. For WCN devices, if the device is
> configured as an AP, then all frames other than probe response frames,
> authentication frames, association response frames, re-association response
> frames and ADDBA request frames are marked as link agnostic and if the

As per the code, it looks like ADDBA response is excluded from the list
of link agnostic frames, no?

> device is configured as a station, then all frames other than probe request
> frames, authentication frames and ADDBA request frames are marked as link
> agnostic.

deauth frame is not mnetioned, here also it is ADDBA resp in the excluded list
not ADDBA req as per the logic.

> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---

Pls include version log


Vasanth

