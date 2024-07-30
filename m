Return-Path: <linux-wireless+bounces-10690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D588D94197E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 18:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BCE1C2260C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09171A617E;
	Tue, 30 Jul 2024 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z2JCE9FV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284D8BE8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357181; cv=none; b=HsFH9f18YZuL/A07JiheK9p8Ps0GRF7oZHHdDWtSIQqFfrJYNy65mHfScpShHKN+piUrI6w6LzoquqFQrBH5KDK5XIlRSEQ3ng+mpMfNGethvSyAObRid6dxPNtTpBECimv6YgHqh03MZKcTBdn2IiblbPbF57U0lznYYLqcLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357181; c=relaxed/simple;
	bh=Vuts3bhL0cOdkOESfSaXoBJYekzhZIjRKsKrPAffG3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ITN073vZds15ki2jro+9Uzy5ixStKI2GD7RP9NgupkqnEO0oYDEkyVKmSTAtOQ8hR6nkxgGkeAv7XFHRhuT1+lr2fJFDHL2YXhDcUlRLX1uoGsr24/zj4vMJ1BaNMcuzClnE8AEki0dfmmV7BraGNh5zegpvhTS4Yrn27J0sfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z2JCE9FV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U9RKYv031664;
	Tue, 30 Jul 2024 16:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FouOIq3uzOBBbDI6uQ5oB+9PtLAeVTTorN0UvseMqIY=; b=Z2JCE9FVeydMKla4
	T/XFH8c3pLm2eRONzSgxupSa7Zgsnqb84LQy0QqWMA8M153qA3YCDJVlrbjnz+rn
	ZGuO0v4G0gBlbL5oTiPsBElH0nkeX/mZDD+OrI1mPj90OA5OMrv5nyZ1iTJW81es
	vKcgfJjGOgG5oac+kaAJrOsP9/a7bdmzzk6QmY9ZODH228A8uHwPDjbSk7BxfJiM
	ghqaWvGMgzmJ6iMgBMH0cLRxbgrPhm7YFf4jGg55bvmC1cyuaX7ByqzRnRQ/PnLR
	WJ/7wgOlPTCOPUWOHMuvxk97jOsNT5u2u+ecYOlyjGKNv1uLuZwWA44eGyWL0Zvf
	x+vCEg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms96rahy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 16:32:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46UGWsJE010641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 16:32:54 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 09:32:54 -0700
Message-ID: <069529b8-d4cf-4e4b-8474-06115ba7824c@quicinc.com>
Date: Tue, 30 Jul 2024 09:32:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Modify print_array_to_buf() to support
 arrays with 1-based semantics
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240730035154.3723773-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240730035154.3723773-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: caSxLkiW8R1wCEWbNfp4HoxYQM9p-Fvv
X-Proofpoint-GUID: caSxLkiW8R1wCEWbNfp4HoxYQM9p-Fvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_13,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=718 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300112

On 7/29/2024 8:51 PM, Roopni Devanathan wrote:
> The API print_array_to_buf() currently supports printing
> arrays with 0 indexing. In some cases, a few arrays need
> to be printed with 1-based indexing, i.e., array should be
> printed, starting with 1.
> 
> Add a new version of print_array_to_buf(), named
> print_array_to_buf_v2(), which implements the functionality
> of print_array_to_buf(), but with an extra variable,
> pointing to the index starting with which the array should
> be printed. Modify print_array_to_buf() to call
> print_array_to_buf_v2() with 0 as the starting index.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


