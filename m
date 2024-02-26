Return-Path: <linux-wireless+bounces-4022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC0867FF4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 19:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63291C235E0
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1344B12DDAB;
	Mon, 26 Feb 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cZ0Buhji"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B512E1D5
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973091; cv=none; b=XPeLzsFUpyJUxssoAP3Tp/VzgObknmEe4Ga+PHhhARKEaUrSxKJ26VJqp0fwcfX7s53smemKR2PzuoOCbMGyV7nlMwfXHtq2U1CJdE3cWpq7cOv+2rMMv+JfhPb8owwDZSY82z+ZxgKChJz0U1DqW0Dt3L0QDW4b9Up37I/Le94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973091; c=relaxed/simple;
	bh=Vjf5eqiZ4ijVjlvsDTj2J0lU+TYGtq73GMkXoyEfypk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sxvv5ljlXFQwuNhH/S+cJ8x+g0oK17A48MESbW6MQiaHKCsucbA/bkdDt+hBl/iMgp5dDtE0XOmFzXzg7wue/ALlWFZIOWfaHhRoMaA0W2k+c1OzXse5AgWT9AXuNEGWYPwreS5LgSttBXNUiJKzss1vUO0NcvwWFuhC9Bk65yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cZ0Buhji; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QFgxuW026239;
	Mon, 26 Feb 2024 18:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8y56Vqz7EzQFsk6AFROBHk0EWX4p6Ci4GcFeTw74m7g=; b=cZ
	0Buhji/+tgGawZPPK7ByiysF+6uj9nJgBqYwoLVLwaOo+rMRmHm0fZTKL8yJrjLc
	i3KfWVK7TeIUVFbbL7Yojnd7knUElLs1FhT34ktQFs2WV9U/9+S8+g4r8pEphNGH
	LDtCkLfOT4K2PVbsX3Lmift3BF2l3TqlpOYqA523Q/okA+PscyIpiy+fndZWOGwG
	bY/2RTxIVac1UWuZrW3G5GYMJR/7qtdBBHlG2x6I/3y70k7mpom8l/c8lfPvzsi9
	02yIg6hxr3G4cHgS8UYaccLsdUuqBtsUI06zW00rBhBPdFIvW4iOMdly/wuUUmZq
	njebSSsFwz9WaGxrnBOg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxm1sv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:44:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QIiiDd011665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:44:44 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 10:44:43 -0800
Message-ID: <dd70cb66-48fd-4574-997f-60825b46a7ff@quicinc.com>
Date: Mon, 26 Feb 2024 10:44:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath12k: Optimize the lock contention of used
 list in Rx data path
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240226162310.629162-1-quic_periyasa@quicinc.com>
 <20240226162310.629162-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240226162310.629162-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2EX0QoOS-f9ux9be-gZV4tm_hLGVKwfJ
X-Proofpoint-GUID: 2EX0QoOS-f9ux9be-gZV4tm_hLGVKwfJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=455 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260142

On 2/26/2024 8:23 AM, Karthikeyan Periyasamy wrote:
> When a packet arrives in Rx rings, the RX descriptor moves from the used
> list to the free list. Then, the rxdma ring gets replenished, where the Rx
> descriptor again moves from the free list to the used list. At the end, the
> descriptor came to the used list with unnecessary list movement. The
> descriptor used list is maintained in the Rxdma ring structure, which
> creates lock contention for the list operations (add, delete) in the Rx
> data path. Optimize the Rx data path by removing the used list from the
> common Rxdma ring and maintain as a local variable in the Rx ring handler
> itself, which avoid lock contention. Now, to find the used list descriptor
> during descriptor cleanup, we need to check the in_use flag for each Rx
> descriptor.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


