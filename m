Return-Path: <linux-wireless+bounces-7743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ABC8C784C
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251C8283E15
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721F414884E;
	Thu, 16 May 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a+F85Go7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4C147C6E;
	Thu, 16 May 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868705; cv=none; b=NP33OFXmlxwnzKr8WnK2MlJrz/XtwWCXAyFks7bJE68XDJZUsDTTV0Dc8LF9hj1tAxcYt4+KShMphLAYwL59SQgvg/kw8Hb5OY3mEE5cu1vP7LTfiZJ3fjxqWG/aMDGwSJpznNexZrGGJJG/oIAH27JoCg0zxbLFRhKgRB/XAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868705; c=relaxed/simple;
	bh=KGx3/2R9bI6rAZokzGjcl3x+hQr9GgBS1EfT72qcBWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D1sZHeudcNLNAp5GTUADItYNRyTVu//CluHl9kltHe1kZTZbDN+IijhHytMxmaH8SPCNrGtimljZbdyKWF9cf75VkWqAFDxUiSb2x+6G0Yp6o/EBdXIHUMXKsVryDV9w+gB4LgoQEsPq8lPW6TssuzQeSQpmMVXJz5fSUuRVv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a+F85Go7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G8W20D004133;
	Thu, 16 May 2024 14:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UZKnD66AxmoU604tuqeyGMWmKSfVPcdT20jTH9y2wuQ=; b=a+
	F85Go7VZjOnFCn20DUnDOs8/zXvfZBvWdIn3z4tAZr16QKbrjnmyELG+1++C5Zpb
	qtVSgkvllylinxOq2ovQ0Gi8Sm52jq0unrHX6+rsbMsuT3cNV6BwmeELBT5g7Y4y
	KcB/N37gSepqgVD9/M+Z2jX2yEFhp/qWXILbfXNOCth/Ast2AkEyNyiNtjE9t6da
	hmbG2b0MXCZJvHoW4nLwFSLU3bnqCljOiiGRFLBkDmFVBEVQcST8SCS6l5zcSGDT
	mFTKuS6U37RyWKFiMZaAKHhTle3PTPx8eNdbVZcTPC+/EPPujA5Wm89JU9YgDl6M
	U718UWfhjh1Igre/9i9w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y2125kxtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 14:11:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GEBXZH010908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 14:11:33 GMT
Received: from [10.110.4.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 07:11:32 -0700
Message-ID: <4d72f74a-b2eb-43d3-92a2-1311081ce72c@quicinc.com>
Date: Thu, 16 May 2024 07:11:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
        Carl Huang
	<quic_cjhuang@quicinc.com>
CC: Luca Weiss <luca.weiss@fairphone.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
 <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
 <871q69lqh5.fsf@kernel.org>
 <4e21e556-527f-4d1e-aa29-cacec14155af@quicinc.com>
 <a53e2188-b982-44b7-9dfe-f5dfd6b802ca@leemhuis.info>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <a53e2188-b982-44b7-9dfe-f5dfd6b802ca@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VeI4f2Xr1qfpcC9e30nCfGto7vYTYt0S
X-Proofpoint-ORIG-GUID: VeI4f2Xr1qfpcC9e30nCfGto7vYTYt0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=979 clxscore=1011 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160099

On 5/16/2024 4:45 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.05.24 05:12, Carl Huang wrote:
>> I'll send out the formal patch next week.
> 
> Hmmm, from here it looks like this did not happen. Did I miss something,
> is there some reason to reevaluate things again, or did this maybe
> simply fall through the cracks?

Formal patch is still under internal review

