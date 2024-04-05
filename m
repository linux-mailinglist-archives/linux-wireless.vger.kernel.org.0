Return-Path: <linux-wireless+bounces-5916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6188E89A16A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC497B246C6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E331616FF4C;
	Fri,  5 Apr 2024 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZOr7K0bJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599216FF28
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331436; cv=none; b=cEUCMrxkaHTm8zvHcnKIH8aW++fEGlMUIyfTsy1osTAHcdf6J2Q9fdjFr5N3NOxyMJsgFtfEKAXkA7O6MZ4jR5GvW+6pwvlQjbbrX3gtjX/IdYrY8bGVB/dXUwRsE/li6DneHqic8Nm2xiEzZhyFhCDGPy2ti9ULxSPt/DKtlIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331436; c=relaxed/simple;
	bh=BEnZ8N7ZupxZmpm6o8O+dHpeIDryUlX06ufs5RpWiZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b4tDzCZyLBtSMxys7MOMUYqbvvgz2wN+J/F/SXlyrAc6Z8CZuRylTDoQQw59PzkP9BSRPXyKGiRFiD2Y5nKlRBAj2pOraedLUqr+Xx8EoMcVeWRGolZgnbcJPLnXHL37juT7FmaAFm/JNtkMExI77VFWFCSDHAHwV1RNx5pAuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZOr7K0bJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435CMjVe004415;
	Fri, 5 Apr 2024 15:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hIvaDDBe4T71c84HBV+HAl/sAOvFVjIISX4mFQoPsv0=; b=ZO
	r7K0bJ/Cru0HOWtJDxqzHy/ITN0NdGdnsHoFQMvUkL9bACeXMbitg9zJRFb9F4x1
	kOUqyUei+mIJ3jY03gHn1qGZWGCTCgrGOXIkdlUy5zETXC5rCH21pw/frox9lOMy
	cyh8vS0kxz/OWcRAeasC0FeAS2dPADmuq6I2fWYU+llCOhZCkKuFjLZPk9lejUwo
	3s5VoXwjyG7isAePT7Y7/XFoTf00MZn4bwTgPuWxX01NtZbYc81I0aN2BRd5d0iE
	b1EsqnlWVmZWCD+OGpQEcMohnQQTeXI+AMO5jc+896mfG/Ls1Y0eYAf3rVJzKN5y
	eDFXuxh/mCmJRXBRzRgg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xad7h0yt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:37:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435FbAb6029145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:37:10 GMT
Received: from [10.110.127.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 08:37:10 -0700
Message-ID: <9a740e75-9a4e-4f1f-8e34-529f19835e77@quicinc.com>
Date: Fri, 5 Apr 2024 08:37:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: correct the capital word typo
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240405144524.1157122-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240405144524.1157122-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CoiyUbHWbPLPiBccN9Ze4Q1eRrtVc45m
X-Proofpoint-ORIG-GUID: CoiyUbHWbPLPiBccN9Ze4Q1eRrtVc45m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=681 clxscore=1015 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050112

On 4/5/2024 7:45 AM, Karthikeyan Periyasamy wrote:
> Rename the "ATH12k" word to "ATH12K" for consistent capitalization in the
> word.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


