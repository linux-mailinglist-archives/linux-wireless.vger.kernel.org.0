Return-Path: <linux-wireless+bounces-14929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708C19BD234
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 17:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36201283036
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB901D0942;
	Tue,  5 Nov 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WfCgrUbP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508D17C7CE
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823731; cv=none; b=Bj7rjB4fu92eyi3Dvo7FL8IljxVUCVLrr4LY6V/jd/8unETHEaa2KTSlbwssxWCWaFlLMfYWJv+SaaIAXInHux+w2kvlg5qtYxOR2cTfjbrOEivNC1n3NSyAJLFsM94eBxApQ/srHirwYjr6bNCDw6oERpKPiP+9leksyZ3yMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823731; c=relaxed/simple;
	bh=JPprsrgH3Qb6ezOxsZkAeg6YORA4JzZGQTG2BXB0Rfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a93i4sePuMbgiDTrZPcKz+09FlQUDlwkKpuAwyLVLrs72lJSMb9mjbpUTTEyJUlf05okVArTkKMFG+QaaWm2VmDSWI+1uKfKzcQSyrRJP+77QI0syruZEDdXv3SDh3ygnKFMxOW4wptGT+RnXmLMvrxUCa170nXYCnucyFTU4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WfCgrUbP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A57uhZV003812;
	Tue, 5 Nov 2024 16:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lM5XAn49qqEcxbv18WcxzMxxWzjJEqXkvrMV5HImGEw=; b=WfCgrUbPbUaRn4/4
	11zsl8lj6C8jlMUsiqiVwn2mN3nkSbrOIAG7AY5GjmSKp6cDN+fGPlL++483SmLb
	fF5bJlexSbDVFcE14OFBtXnGS89dCn/jH/Lw0U4ciXcZHujca8p0MCbCqVjLlnSa
	pmUWwCwpqLA9UlE4rIEsj3esw0Um0u8/10qm1kRmxqWgYRmvGYwUQGPtZX0pbkly
	kPpXC9QcQrZnvAq3NKfvjipWded2A7pKaTyJWMbA0vaeT6tEu7vR5HACR6tbN0UW
	ZwirCC5dDPgJQC7+JGzit0t6+U8HiiN0Wm90uGbYKr+bqlQ4fnTK6C72r8Nl/f+N
	5UjH7Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qfdx1env-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 16:21:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A5GLhS6004749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 16:21:43 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 5 Nov 2024
 08:21:43 -0800
Message-ID: <06bf90a5-db29-46b4-b983-439c2b32b143@quicinc.com>
Date: Tue, 5 Nov 2024 08:21:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath10k: add support for QCA9379 hw1.0 SDIO
To: Felix Kaechele <felix@kaechele.ca>, <ath10k@lists.infradead.org>,
        Kalle
 Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240908013244.496382-1-felix@kaechele.ca>
 <20240908013244.496382-3-felix@kaechele.ca>
 <c1385aa1-0d41-4ed7-a00c-e40c69bafeaa@kaechele.ca>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <c1385aa1-0d41-4ed7-a00c-e40c69bafeaa@kaechele.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qBlgNPive5_8K0ijYrftMOa1xhRdKigy
X-Proofpoint-ORIG-GUID: qBlgNPive5_8K0ijYrftMOa1xhRdKigy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=690
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050126

On 11/5/2024 7:39 AM, Felix Kaechele wrote:
> Gentle ping on this one.
> 
> It still applies cleanly against the ath/master branch as of today.
> 
> If there's no chance of this going in please let me know and I'll stop 
> re-sending this patch.
> 
> I understand that bandwidth for ath10k related requests is minimal these 
> days and there may not be an interest in fixing what are possibly 
> firmware related issues for this rather obscure IoT/Automotive (SDIO, no 
> less!) chipset.
> I unfortunately don't have the information, documentation and latest 
> firmware images available on my side to help with this either.
> I am, however, always willing to work with someone on fixing any of the 
> outstanding issues.
> 
> Thanks!
> Felix

Kalle has this in his 'deferred' queue in patchwork which means it's still on
his radar, but low priority.

https://patchwork.kernel.org/project/linux-wireless/list/?series=888058&state=*

