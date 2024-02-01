Return-Path: <linux-wireless+bounces-2967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76B845D15
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B080F1C2C5FF
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3A15F315;
	Thu,  1 Feb 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PA6yKEoa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA177A10
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804245; cv=none; b=GDzHlakCPNiVkbzx9kSiZaa+8S2tWcN/xGWcS2on4AhPLOsYjgJ5jZCT80E5BCC8aQtikPYkxDHyueNNstn5R7CHOU19LMKfPhUA4ow8geiFVrVJSP3PEOGjMjiiw0/sPdLEOUUgg1pcyRXlsx1kDLLIGzHhr9APpwK1ti86zKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804245; c=relaxed/simple;
	bh=WqH3PpKxonNwhoAYs9sKL5aLAjNXfkcVfpwYo3qy6eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ifD2NFFnjZ6vflv2rcwxPonIG3/4QIPEK7wGQ8hpx/BZbzm/OY23bZrNTfgNbvtQCnELmvX3NxCZqEfXg+biT6Yz3US79XJ4/+hrsYQCmE0KA3Xq7oCCmPD8b2ZnfgFmd7yRnBe9XhWXwdnq7wiUttajC4C1QqfpAl8B093hw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PA6yKEoa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411BVYiv021333;
	Thu, 1 Feb 2024 16:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xf1hWCpDlCPsC4cC0Yjtd+wigIFNlIVOexl3L1Ebsqc=; b=PA
	6yKEoa6QLXdPmIohdsveUXzEQQf5c63Yc/PQmkySRjcEGJcb+qyrX77QqJEkgYBz
	ksFeH/W32CFIB3uK1IjmgwG/pLqjsFk4k/X1kHmZQiXEpdbu4dAimn61B0/4iovg
	sg8gOp9yTe5fzbcuU/zTLqNA+jqa8GZbHQOdZ1X1OO4dBAcKrbvo70Ub67/ZTM4r
	cwNpN+usXdCmxKjfAulPkrqO7LAqHUmTN/kYwQ2Vf23df5pchO/NTb4N2XZAY8Nn
	egbVfbLgUkdoW/kyZ5EUW26HpULydsAVgl89oDQlVSrakAKz6qh9k+TYwdecwao7
	RuBY2Jo+W5siBte/OKaw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyvb5jpvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 16:17:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411GHHjH022880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 16:17:17 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 08:17:16 -0800
Message-ID: <cf2e8671-cd12-495a-859d-731be00e84fd@quicinc.com>
Date: Thu, 1 Feb 2024 08:17:16 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Aloka Dixit
	<quic_alokad@quicinc.com>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
 <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w38RHxSOK3nJuLQ45eiBMPdWvu_Pq7Fj
X-Proofpoint-ORIG-GUID: w38RHxSOK3nJuLQ45eiBMPdWvu_Pq7Fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=439 adultscore=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010127

On 1/29/2024 10:34 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Aloka originally suggested that puncturing should be part of
> the chandef, so that it's treated correctly. At the time, I
> disagreed and it ended up not part of the chandef, but I've
> now realized that this was wrong. Even for clients, the RX,
> and perhaps more importantly, CCA configuration needs to take
> puncturing into account.
> 
> Move puncturing into the chandef, and adjust all the code
> accordingly. Also add a few tests for puncturing in chandef
> compatibility checking.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Perhaps add:
+ Suggested-by: Aloka Dixit <quic_alokad@quicinc.com>
+ Link:
https://lore.kernel.org/linux-wireless/20220214223051.3610-1-quic_alokad@quicinc.com/


