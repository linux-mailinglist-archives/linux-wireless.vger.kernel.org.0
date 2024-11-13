Return-Path: <linux-wireless+bounces-15274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CCD9C7803
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 16:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9B11F24C89
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FF115B987;
	Wed, 13 Nov 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jVvNg0OW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64089156C5F
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513527; cv=none; b=PQJnHn3FCbVrgGc8f4BWXxfDTds+dm1gPfekVVwxaLZPJxvsisN5jhYupZNzVw7I4sNJnY4yrBVPuY6I7Dw7fiGqqjmhQnYhyPo/bpSWpAknR4/b10FMyLqWsrHh7mlHbMOa0oenLxM8Z1wBygYatY3HrAs0XHebE4rkZToSFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513527; c=relaxed/simple;
	bh=HmJoY+ntPjmWdc/w7kCIiXQsQT3cQCdetcJKvfEJzGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GEEr91mZgh1o7sAwrw/uQG5x+sPVO6h2Mi9SATwDcbnbXCBn5DXsTX4eeYvD2EFCzxRoqyjPaxV2kxOqNmPlDm3FZtgZBT/SDXRA/4QdmzchU9H1PDLIKCRhPrDvXDsR8lTYEfbQ1szShB5IgIgfmLwTuMsyfYV49HSEh76eK6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jVvNg0OW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD7usAc030530;
	Wed, 13 Nov 2024 15:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HmJoY+ntPjmWdc/w7kCIiXQsQT3cQCdetcJKvfEJzGE=; b=jVvNg0OWOofayIfh
	SO0qa/Wi+J9GtYEA0+uzVsfbF47u3U5LBTm1zBJWK0zY6ufuJATgN4ZOPcHyq18b
	2hwn6Dgi3HVP0WFFodndAYal4JA5IAAAU4as0naGsb6fhzKQ18QQjEuKg9GzbteB
	dM/hj7VpbkRb0MVAIdW5EincfpiNZpUhSy1hcV3WZuAvAGf/B1DsXlhergOObtOt
	NtBJ8GbtHA7L7gL2tW5Fzt3qD4vt5F5VJFICly49eI9JepWyYUOQIzLj6JONyNPO
	6UklhqgZFm3wrs29aTSpkUyV9IKadGoP5pJgcxe7CG/K3k8sRGI1Rwpv60gLI8v0
	qj6yjQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vr5y1757-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:58:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADFwdP8028237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 15:58:39 GMT
Received: from [10.48.243.207] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 07:58:38 -0800
Message-ID: <7f3454c0-9105-47ef-b450-5d1db3b84c82@quicinc.com>
Date: Wed, 13 Nov 2024 07:58:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] wifi: ath12k: Support Pager, Counter, SoC,
 Transmit Rate Stats
To: Kalle Valo <kvalo@kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241113072707.3377341-1-quic_rdevanat@quicinc.com>
 <87cyiz2y3z.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <87cyiz2y3z.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vIbXnIFtrXGz2amDidPBYz2wPD64fTZ8
X-Proofpoint-GUID: vIbXnIFtrXGz2amDidPBYz2wPD64fTZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=926 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130133

On 11/13/2024 3:04 AM, Kalle Valo wrote:
> Jeff, does b4 pick up Acked-by from the cover letter or should I ack
> individual patches?

IDK. I know that patchwork doesn't pick it up unless you ack the individual
patches, so that is what I do.



