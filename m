Return-Path: <linux-wireless+bounces-13277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD898929D
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 04:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AA32852CF
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2024 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD8DF5C;
	Sun, 29 Sep 2024 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k7r+Ql4C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D26B644
	for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2024 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727576075; cv=none; b=sQEH42H8fFmSyOjCHpgny4AMAW2zcEwq9IwkSCy66X3P5wb5ZYq8dRWenI6/lSUlsfCA5C0CKQizR84TJoXQqcKCLq4poIxFDUQDaago6VZ9ZMdsMEbPCpIDQc3rSsZTrC1f0hYGivijcrNrlI3oGL6zhsljd8LQsy3/3Ooblgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727576075; c=relaxed/simple;
	bh=gAU3NHTyAN8vfYuvjla9yWFz8hBCag5Dsmv8ocePQWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kLeA1Woir38cLtkM0xKW0xDfW1/lCuiDnY/y/2dzrpSIxCIj+WX1npizDGlClV8E7sudiipj5+J2FFoP6/ZjQYP8y39ewIi3wLfSe05YeipEhtguhtGtmQad7oiV4Ed2cTpXWW8erLtvdEyMo6G4zO/G/ie1VjGnDfcYDYMrsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k7r+Ql4C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48T0MaBS030754;
	Sun, 29 Sep 2024 02:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JLkpCZ7R9/QtqnBS4bmma4iZR6HHyNndeEZ9tYtpEAI=; b=k7r+Ql4CssBKQW1x
	MS8LLR5dvEJQpg5/T8k7MjhR9sHyRYGEnhM5U2IULl94cwkr0TU0WWGX1+4aZ2S0
	3DRo5LfNKz/QsqqlEFSpU3Q729FhAtLrE2V1S18zra/wfxRk8FeleO4BuYBr1Bie
	oj42Cb/C8CjlwjIdKjlgn3CXXTkTQN7pvI+yQQZG8QZs6keumhH8vlJ0/8WVz7Uw
	Du2joDg7UTEfCJcDx5J8c0H25Fw9eUpgAwvT7P6dF8d3Dc/QOu9qxX4usHVbjRTv
	k4EThwBsrm9yMPH6XqCy50iDpf68n+88RdIVs6uKwhzTQwNeW57baaUrdofqHXH+
	/D1D/Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x8t6hkje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 02:14:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48T2ELRN028095
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 02:14:21 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 28 Sep
 2024 19:14:20 -0700
Message-ID: <241fe825-991f-4dca-ad1c-e45f6a524edf@quicinc.com>
Date: Sun, 29 Sep 2024 10:14:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k/WCN6855 neighbor report request made immediately after
 connection gets no response (with MFP)
To: James Prestwood <prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>
CC: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
 <fd90d471-503b-4f58-ae11-bae2afab08c7@quicinc.com>
 <0d1dab88-66a0-48c1-bdbe-777d07c3132e@gmail.com>
 <70567137-dfb9-4896-9e6c-6c02a97228cb@quicinc.com>
 <15c909da-f01e-43ee-b486-f9b6d5bcc29c@gmail.com>
 <26302980-4cd8-466a-8de1-4be10a42536a@quicinc.com>
 <f65b609c-0813-414b-885d-24257e76e6d0@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <f65b609c-0813-414b-885d-24257e76e6d0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _sFH9HNdIdTBxBrvVpu1LicSMe1z8O0I
X-Proofpoint-ORIG-GUID: _sFH9HNdIdTBxBrvVpu1LicSMe1z8O0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=641 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409290016



On 9/27/2024 7:53 PM, James Prestwood wrote:
> I think what I saw here was because the capture was done through the AP vendor was automatically decrypted or something. The frame was still marked as protected, but I never had to add the PMK to get wireshark to parse it correctly.
this is exactly what I see. there is no automatic decryption here, it is only because the frame is NOT encrypted, though 'protected' bit set.

> 
> On my home network when I was referring to "always encrypted" it was because the frames always had the CCMP IV and the content of the frame itself was not visibly a neighbor report/request, just a string of hex values. Once I added the PMK and decrypted it wireshark could parse it.
is this tested still with IWD?


